#include "assemblycode.h"

extern InterCodes* head;

VarDescriptor* OperandInfor[tsize];
RegDescriptor Regs[REG_SIZE];//REG_SIZE 18
int regs_Current;//表示已经在使用的有多少个
int line_Count;
int sp_Offset;

int param_Count;
int arg_Count;
Operand func_Args[1000];//允许的最大参数个数，暂定

void initReg()
{
	for(int i = 0; i < REG_SIZE; i++)
	{
		Regs[i].used = false;
		Regs[i].lastest_line_number = -1;
		Regs[i].varOperand = 0;
	}
	for(int i=0; i<tsize; i++)
		OperandInfor[i] = NULL;

	regs_Current = 0;
}

int replaceReg(FILE *fw)
{
	int index = -1, line = line_Count+1;
	for(int i=0; i<REG_SIZE; i++)
	{
		//补充
		if(Regs[i].used == false)
		{
			return i;
		}
		if(Regs[i].lastest_line_number<line)
		{
			index=i;
			line=Regs[i].lastest_line_number;
		}
	}
	//补充
	if(Regs[index].varOperand->kind == CONST || Regs[index].varOperand->kind == 6 || Regs[index].varOperand->kind == 9)
		return index;
	char *regName=RegName(index);
	char *keychar=trans(Regs[index].varOperand);
	VarDescriptor* val = getItemFromVarDescriptor(keychar);
	if(val==NULL) return  index;//理论上val不为NULL
	if(val->type==1)
	{
		//需要获取栈中的一定区域
		fprintf(fw,"\taddi $sp, $sp, -4 \n"); sp_Offset-=4;
		val->offset=sp_Offset;
		fprintf(fw,"\tsw %s, %d($fp)\n", regName, val->offset);//溢出到内存
		val->type=2;
	}
	else if(val->type==3)
	{
		//fprintf(fw,"\tsw %s, %d($fp)\n", regName, val->offset);//溢出到内存
		val->type=2;
	}
	return index;
}

char* RegName(int reg_no)
{
	char*result = (char*)malloc(10);
	strcpy(result, "$t0");
	if(reg_no < 0)
		strcpy(result, "???Wrong in reg_no");
	else if(reg_no < 10)
		result[2] = result[2] + reg_no;
	else if(reg_no < REG_SIZE)
	{
		result[1] = 's';
		result[2] = result[2] + (reg_no-10);
	}
	else
		strcpy(result, "???Wrong in reg_no>reg_size");
	return result;
}
//除了*a=...之外都可以
void SaveToStack(Operand op, FILE* fw)
{
	VarDescriptor* val = getItemFromVarDescriptor(trans(op));
	if(val == NULL || op->kind == CONST)
	{
		return ;
	}
	if(val->type==1)
	{
		//需要获取栈中的一定区域
		fprintf(fw,"\taddi $sp, $sp, -4 \n"); sp_Offset-=4;
		val->offset=sp_Offset;
		fprintf(fw,"\tsw %s, %d($fp)\n", RegName(val->reg_no), val->offset);//溢出到内存
		val->type=2;
		//清理寄存器
		Regs[val->reg_no].used = false;
	}
	else if(val->type==3)
	{
		fprintf(fw,"\tsw %s, %d($fp)\n", RegName(val->reg_no), val->offset);//溢出到内存
		val->type=2;
		//清理寄存器
		Regs[val->reg_no].used = false;
	}
	
}

void ChangeType(Operand op, FILE* fw)
{
	VarDescriptor* val = getItemFromVarDescriptor(trans(op));
	if(val == NULL || op->kind == CONST)
	{
		return ;
	}
	if(val->type==3)
	{
		//fprintf(fw,"\tsw %s, %d($fp)\n", RegName(val->reg_no), val->offset);//溢出到内存
		val->type=2;
		Regs[val->reg_no].used = false;
	}
	
}


//加入或者更新,注意item里面的key必须是新建的（保证正确）
//变量从寄存器溢出时
void putVarDescriptor(VarDescriptor* item)
{
	if(item == NULL) return;   
	unsigned int key = pjwhash(item->key);
	VarDescriptor* queue = OperandInfor[key];
	//先找是不是已经在表里
	VarDescriptor* beginlook = queue;      	
	while(beginlook != NULL)
	{
		if(strcmp(beginlook->key,item->key) == 0)
		{
			//更新并返回
			beginlook->offset = item->offset;
			beginlook->reg_no = item->reg_no;
			beginlook->type = item->type;
			return;
		}
		beginlook = beginlook->next;
	}
	//加入到开头
	item->next = queue;
	OperandInfor[key] = item;
}
//返回找到的
VarDescriptor* getItemFromVarDescriptor(char* keychar)
{
	unsigned int key = pjwhash(keychar);
	VarDescriptor* queue = OperandInfor[key];
	if(queue == NULL)
		return NULL;
	else
	{
		//是否在表里
		VarDescriptor* beginlook = queue;
		while(beginlook != NULL)
		{
			if(strcmp(beginlook->key,keychar) == 0)
				return beginlook;//找到并返回
			beginlook = beginlook->next;
		}
	}
	return NULL;
}

//fw传入的好处是可以当op第一次在汇编中出现时，需要补充lw来加载的一行才能使用，以及寄存器与栈交换的代码也需要在这里完成
char* get_reg(Operand op, FILE *fw)
{
    //TODO:实现找到对应的寄存器，在这里可以继续向文件中写入寄存器存取操作; 只能使用t0-t9， s0-s8
	VarDescriptor* result = getItemFromVarDescriptor(trans(op));
	
	//printf("find %s\n", trans(op));
	char* regName = NULL;
	if(result != NULL)//说明已经找到相关的
	{
		switch (result->type)
		{
		case 0:{
				/*没有保存的情况：理论上不存在*/
		} break;
		case 1:{//表示在寄存器中,未溢出到内存过
			
			//补充部分
			Regs[result->reg_no].lastest_line_number = line_Count;
			return RegName(result->reg_no);
		} break;
		case 2:{//只存在在offset中
			int regIndex = -1;
			if(regs_Current >= REG_SIZE)//说明没有有空闲可用
				regIndex=replaceReg(fw);
			else
			{
				regIndex=regs_Current;
				regs_Current++;
			}
			//修正变量对应信息的值
			result->type = 3;
			result->reg_no = regIndex;
			//修正寄存器保存的值
			Regs[regIndex].used = true;
			Regs[regIndex].lastest_line_number = line_Count;//记录行数
			Regs[regIndex].varOperand = op;
			regName=RegName(regIndex);
			fprintf(fw,"\tlw %s, %d($fp)\n", regName, result->offset);//加载到寄存器中
			return regName;
		} break;
		case 3:{//表示在寄存器中,溢出到内存过
			Regs[result->reg_no].lastest_line_number = line_Count;
			return RegName(result->reg_no);
		} break;
		default: return "???Wrong in get_reg";
		}
	}
	else//变量第一次出现,补充：直接填入栈中
	{
		int regIndex = -1;

		if(regs_Current >= REG_SIZE)//说明没有空闲可用
			regIndex=replaceReg(fw);
		else
		{
			regIndex=regs_Current;
			regs_Current++;
		}

		//补充：某些情况下是需要初始值的，比如*myvar之类的
		if(op->kind == 1)
		{
			//说明是const
			char* re = (char*)malloc(30);
			re[0] = '#';re[1] = '\0';
			strcat(re, op->u.val);
			fprintf(fw, "\tli %s, %s\n", RegName(regIndex), re+1);
			Regs[regIndex].used = true;
			Regs[regIndex].lastest_line_number = line_Count;//记录行数
			Regs[regIndex].varOperand = op;
			return  RegName(regIndex);
		}
		//修正变量对应信息的值
		result = (VarDescriptor*)malloc(sizeof(VarDescriptor));
		result->key = trans(op);
		result->type = 3;
		result->reg_no = regIndex;
		result->offset = 0;
		//需要获取栈中的一定区域
		fprintf(fw,"\taddi $sp, $sp, -4 \n"); sp_Offset-=4;
		result->offset=sp_Offset;
		//fprintf(fw,"\tsw %s, %d($fp)\n", regName, result->offset);//溢出到内存

		//补充：特殊情况下不需要添加！！
		if(op->kind != 1 )//&& op->kind != 6 && op->kind != 7 && op->kind != 9)
			putVarDescriptor(result);
		
		//修正寄存器保存的值
		Regs[regIndex].used = true;
		Regs[regIndex].lastest_line_number = line_Count;//记录行数
		Regs[regIndex].varOperand = op;
		
		
		
		if(op->kind == 6)//*myvar
		{
			char* tmpvarkey =malloc(30);
			strcpy(tmpvarkey, "myvar");
			char* buffer = malloc(sizeof(char) * 30);
			sprintf(buffer,"%d",op->u.no);
			strcat(tmpvarkey, buffer);
			VarDescriptor* tmpvar = getItemFromVarDescriptor(tmpvarkey);
			if(tmpvar == NULL)
			{//出错
				char* str = (char*)malloc(30);
				strcpy(str, "Wrong in op->kind = 6 in getr_reg function");
				printf("%s", str);
    			return str;			
			}
			if(tmpvar->type == 1 || tmpvar->type == 3)//在寄存器中
			{
				fprintf(fw, "\tlw %s, 0(%s)\n", RegName(regIndex), RegName(tmpvar->reg_no));
			}
			else if(tmpvar->type == 2)//在栈中
			{
				fprintf(fw, "\tmove %s, $fp\n", RegName(regIndex));
				fprintf(fw, "\taddi %s, %s, %d\n", RegName(regIndex), RegName(regIndex), tmpvar->offset);//先存栈的地址
				fprintf(fw, "\tlw %s, 0(%s)\n", RegName(regIndex), RegName(regIndex));//再取栈中内容
				fprintf(fw, "\tlw %s, 0(%s)\n", RegName(regIndex), RegName(regIndex));//再次取之对应
			}
				
		}
		else if(op->kind == 7)//&a
		{
			char* tmpvarkey = op->u.val;//直接获得
			VarDescriptor* tmpvar = getItemFromVarDescriptor(tmpvarkey);
			if(tmpvar == NULL || tmpvar->type == 1)
			{//出错
				char* str = (char*)malloc(30);
				strcpy(str, "Wrong in op->kind = 7 in getr_reg function");
				printf("%s", str);
    			return str;			
			}
			if(tmpvar->type == 2 || tmpvar->type == 3)//在寄存器中
			{
				fprintf(fw, "\tmove %s, $fp\n", RegName(regIndex));
				fprintf(fw, "\taddi %s, %s, %d\n", RegName(regIndex), RegName(regIndex), tmpvar->offset);
				SaveToStack(op,fw);
			}
		}
		else if(op->kind == 9)//*a
		{
			char* tmpvarkey = op->u.val;//直接获得
			VarDescriptor* tmpvar = getItemFromVarDescriptor(tmpvarkey);
			if(tmpvar == NULL)
			{//出错
				char* str = (char*)malloc(30);
				strcpy(str, "Wrong in op->kind = 6 in getr_reg function");
				printf("%s", str);
    			return str;			
			}
			if(tmpvar->type == 1 || tmpvar->type == 3)//在寄存器中
			{
				fprintf(fw, "\tlw %s, 0(%s)\n", RegName(regIndex), RegName(tmpvar->reg_no));
			}
			else if(tmpvar->type == 2)//在栈中
			{
				fprintf(fw, "\tmove %s, $fp\n", RegName(regIndex));
				fprintf(fw, "\taddi %s, %s, %d\n", RegName(regIndex), RegName(regIndex), tmpvar->offset);//先存栈的地址
				fprintf(fw, "\tlw %s, 0(%s)\n", RegName(regIndex), RegName(regIndex));//再取栈中内容
				fprintf(fw, "\tlw %s, 0(%s)\n", RegName(regIndex), RegName(regIndex));//再次取之对应
			}
		}
		
		return RegName(regIndex);
	}
    char* str = (char*)malloc(30);
	strcpy(str, "no init in get_reg");
    return str;
}
char* pointer_get_reg(Operand op, FILE *fw)//用于*a=...的情况，接下来需要用sw，所以这里寄存器保存的是地址
{
	//当作变量第一次出现
	{
		int regIndex = -1;
		if(regs_Current >= REG_SIZE)//说明没有空闲可用
			regIndex=replaceReg(fw);
		else
		{
			regIndex=regs_Current;
			regs_Current++;
		}

		//补充：特殊情况下不需要添加！！
		//修正寄存器保存的值
		Regs[regIndex].used = true;
		Regs[regIndex].lastest_line_number = line_Count;//记录行数
		Regs[regIndex].varOperand = op;
		
		if(op->kind == 6)//*myvar
		{
			char* tmpvarkey =malloc(30);
			strcpy(tmpvarkey, "myvar");
			char* buffer = malloc(sizeof(char) * 30);
			sprintf(buffer,"%d",op->u.no);
			strcat(tmpvarkey, buffer);
			VarDescriptor* tmpvar = getItemFromVarDescriptor(tmpvarkey);
			if(tmpvar == NULL)
			{//出错
				char* str = (char*)malloc(30);
				strcpy(str, "Wrong in op->kind = 6 in getr_reg function");
				printf("%s", str);
    			return str;			
			}
			if(tmpvar->type == 1 || tmpvar->type == 3)//在寄存器中
			{
				fprintf(fw, "\tmove %s, %s\n", RegName(regIndex), RegName(tmpvar->reg_no));
			}
			else if(tmpvar->type == 2)//在栈中
			{
				fprintf(fw, "\tmove %s, $fp\n", RegName(regIndex));
				fprintf(fw, "\taddi %s, %s, %d\n", RegName(regIndex), RegName(regIndex), tmpvar->offset);//先存栈的地址
				fprintf(fw, "\tlw %s, 0(%s)\n", RegName(regIndex), RegName(regIndex));//再取栈中内容
			}
		}
		else if(op->kind == 9)//*a
		{
			char* tmpvarkey = op->u.val;//直接获得
			VarDescriptor* tmpvar = getItemFromVarDescriptor(tmpvarkey);
			if(tmpvar == NULL)
			{//出错
				char* str = (char*)malloc(30);
				strcpy(str, "Wrong in op->kind = 6 in getr_reg function");
				printf("%s", str);
    			return str;			
			}
			if(tmpvar->type == 1 || tmpvar->type == 3)//在寄存器中
			{
				fprintf(fw, "\tmove %s, %s\n", RegName(regIndex), RegName(tmpvar->reg_no));
			}
			else if(tmpvar->type == 2)//在栈中
			{
				fprintf(fw, "\tmove %s, $fp\n", RegName(regIndex));
				fprintf(fw, "\taddi %s, %s, %d\n", RegName(regIndex), RegName(regIndex), tmpvar->offset);//先存栈的地址
				fprintf(fw, "\tlw %s, 0(%s)\n", RegName(regIndex), RegName(regIndex));//再取栈中内容
			}
			
			
		}
		
		return RegName(regIndex);
	}
    char* str = (char*)malloc(30);
	strcpy(str, "no init in get_reg");
    return str;
}

//
void forDec(FILE *fw, InterCode code)
{
	//DEC 变量 变量大小, 开辟空间在栈区
	//fprintf(fw,"\taddi $sp, $sp, -4 \n"); sp_Offset-=4;
	fprintf(fw,"\taddi $sp, $sp, %d \n", -code.u.dec.size); sp_Offset-=code.u.dec.size;
	VarDescriptor* array = (VarDescriptor*)malloc(sizeof(VarDescriptor));
	array->key=trans(code.u.dec.op);
	array->offset=sp_Offset;
	array->reg_no=-1;
	array->type=2;
	putVarDescriptor(array);
	//fprintf(fw,"\taddi $sp, $sp, %d \n", -code.u.dec.size); sp_Offset-=code.u.dec.size;
	//char* regName=get_reg(code.u.dec.op, fw);
	//fprintf(fw,"\tli %s, %d \n", regName, code.u.dec.size);//记录数组大小
	//fprintf(fw,"\tsw %s, %d($fp) \n", regName, array->offset);
}

void forCLabel(FILE *fw, InterCode code)
{
	fprintf(fw,"%s:\n", trans(code.u.single.op));
}

void forFunction(FILE *fw, InterCode code)
{
	param_Count = -1;
	fprintf(fw,"%s:\n",trans(code.u.single.op));
	fprintf(fw,"\taddi $sp, $sp, -4 \n");
	fprintf(fw,"\tsw $fp, 0($sp) \n");  sp_Offset = 0;
	fprintf(fw,"\tmove $fp, $sp \n");	//$fp指向旧的$fp, sp_Offset是相对于$fp而言的

	fprintf(fw, "\taddi $sp, $sp, -40\n");
	
}

void forGoto(FILE *fw, InterCode code)
{
	fprintf(fw,"\tj %s\n",trans(code.u.single.op));
}

void forReturn(FILE *fw, InterCode code)
{

	if(code.u.single.op->kind==CONST)	
		fprintf(fw,"\tli $v0, %s \n", code.u.single.op->u.val);
	else
		fprintf(fw,"\tmove $v0, %s \n",get_reg(code.u.single.op, fw));
	fprintf(fw,"\tmove $sp, $fp \n");
	fprintf(fw,"\tlw $fp, 0($sp) \n");
	fprintf(fw,"\taddi $sp, $sp, 4 \n");
	fprintf(fw,"\tjr $ra\n");

	//补充：
	VarDescriptor* item = getItemFromVarDescriptor(trans(code.u.single.op));
	if(item != NULL)
	{
		if(item->type == 1)
			printf("Exception1 in ifgoto\n");
		item->type = 2;
	}

}

void forArg(FILE *fw, InterCode code)
{
	arg_Count++;
	func_Args[arg_Count]=code.u.single.op;
}

void forParam(FILE *fw, InterCode code)
{
	param_Count++;
	char* keychar = trans(code.u.single.op);
	VarDescriptor* p = (VarDescriptor*)malloc(sizeof(VarDescriptor));
	p->key = keychar;
	p->type = 2;
	p->reg_no = -1;

	fprintf(fw,"\taddi $sp, $sp, -4 \n");  sp_Offset -= 4;
	p->offset=sp_Offset;
	if(param_Count<4)
		fprintf(fw,"\tsw $a%d, %d($fp) \n", param_Count, p->offset);
	else
	{
		fprintf(fw,"\tlw $a3, %d($fp) \n", (param_Count-3)*4 + 4);//隔了一个返回地址
		fprintf(fw,"\tsw $a3, %d($fp) \n", p->offset);
	}
	putVarDescriptor(p);
}

void forRead(FILE *fw, InterCode code)
{
	//这里只考虑了v0（本来存返回值的寄存器）未被使用
	fprintf(fw,"\taddi $sp, $sp, -4\n");
	fprintf(fw,"\tsw $ra, 0($sp)\n");
	fprintf(fw,"\tjal read\n");
	fprintf(fw,"\tlw $ra, 0($sp)\n");
	fprintf(fw,"\taddi $sp, $sp, 4\n");
	fprintf(fw,"\tmove %s, $v0\n", get_reg(code.u.single.op, fw));//把v0更新到原来的寄存器中
	SaveToStack(code.u.single.op, fw);
}

void forWrite(FILE *fw, InterCode code)
{
	fprintf(fw,"\tmove $a0, %s\n",get_reg(code.u.single.op, fw));//保存参数
	ChangeType(code.u.single.op, fw);//
	fprintf(fw,"\taddi $sp, $sp, -4\n");
	fprintf(fw,"\tsw $ra, 0($sp)\n");
	fprintf(fw,"\tjal write\n");
	fprintf(fw,"\tlw $ra, 0($sp)\n");
	fprintf(fw,"\taddi $sp, $sp, 4\n");
}

void forAssign(FILE *fw, InterCode code)
{
	if(code.u.assign.right->kind == CONST)
	{
		if(code.u.assign.left->kind == 9 || code.u.assign.left->kind == 6)
		{//*a = 9
			fprintf(fw, "\tsw %s, 0(%s)\n", get_reg(code.u.assign.right, fw), pointer_get_reg(code.u.assign.left, fw));
		}
		else
		{
			fprintf(fw, "\tli %s, %s\n", get_reg(code.u.assign.left, fw), code.u.assign.right->u.val);
			SaveToStack(code.u.assign.left, fw);
		}
	}
	else if(code.u.assign.left->kind == 9 || code.u.assign.left->kind == 6)//*a = ...
	{
		//补充额外处理
		fprintf(fw, "\tsw %s, 0(%s)\n", get_reg(code.u.assign.right, fw), pointer_get_reg(code.u.assign.left, fw));
	}
	else
	{
		fprintf(fw, "\tmove %s, %s\n", get_reg(code.u.assign.left, fw), get_reg(code.u.assign.right, fw));
		SaveToStack(code.u.assign.left, fw);
		ChangeType(code.u.assign.right, fw);
	}
}

void forCall(FILE *fw, InterCode code)
{
	//存储寄存器中的变量，都在此处保存
	for(int i=0; i<REG_SIZE; i++)
	{
		if(Regs[i].used==true)
		{
			char* regName = RegName(i);
			char *keychar=trans(Regs[i].varOperand);
			VarDescriptor* val = getItemFromVarDescriptor(keychar);
			if(val==NULL || Regs[i].varOperand->kind == 6 || Regs[i].varOperand->kind == 9) ;//补充可能遇到这类情况
			else if(val->type==1)
			{
				fprintf(fw,"\taddi $sp, $sp, -4 \n"); sp_Offset-=4;
				val->offset=sp_Offset;
				fprintf(fw,"\tsw %s, %d($fp)\n", regName, val->offset);//溢出到内存
				val->type=2;
			}
			else if(val->type==3)
			{
				//fprintf(fw,"\tsw %s, %d($fp)\n", regName, val->offset);//溢出到内存
				val->type=2;
			}
		}
	}
	//清零寄存器
	for(int i = 0; i < REG_SIZE; i++)
	{
		Regs[i].used = false;
		Regs[i].lastest_line_number = -1;
		Regs[i].varOperand = 0;
	}
	regs_Current=0;

	for(int i=arg_Count; i>=0 && i>arg_Count-4; i--)
	{
		VarDescriptor* arg = getItemFromVarDescriptor(trans(func_Args[i]));
		if(arg==NULL)
		{
			//补充：可能出现这种情况！因为我们没有存放常数之类的
			char*tmpreg = get_reg(func_Args[i], fw);//放入寄存器
			fprintf(fw,"\tmove $a%d, %s \n", arg_Count-i, tmpreg);
		}
		else if(arg->type==1||arg->type==3)
			fprintf(fw,"\tmove $a%d, %s \n", arg_Count-i, RegName(arg->reg_no));
		else if(arg->type==2)
			fprintf(fw,"\tlw $a%d, %d($fp) \n", arg_Count-i, arg->offset);
	}

	for(int i = 0; i < REG_SIZE; i++)
	{
		Regs[i].used = false;
		Regs[i].lastest_line_number = -1;
		Regs[i].varOperand = 0;
	}

	for(int i=0; i<=arg_Count-4; i++)
	{
		VarDescriptor* arg = getItemFromVarDescriptor(trans(func_Args[i]));
		if(arg==NULL)
		{
			char*tmpreg = get_reg(func_Args[i], fw);//放入寄存器
			fprintf(fw,"\taddi $sp, $sp, -4 \n"); sp_Offset-=4;
			fprintf(fw,"\tsw %s, 0($sp) \n", tmpreg);
			for(int i = 0; i < REG_SIZE; i++)
			{
				Regs[i].used = false;
				Regs[i].lastest_line_number = -1;
				Regs[i].varOperand = 0;
			}
		}
		else
		{
			fprintf(fw,"\taddi $sp, $sp, -4 \n"); sp_Offset-=4;//补充
			if(arg->type==1||arg->type==3)
				fprintf(fw,"\tsw %s, 0($sp) \n", RegName(arg->reg_no));
			else if(arg->type==2)
			{
				char* regName = get_reg(code.u.single.op, fw);
				fprintf(fw,"\tlw %s, %d($fp) \n", regName, arg->offset);
				fprintf(fw,"\tsw %s, 0($sp) \n", regName);
			}
		}
	}

	arg_Count = -1;
	
	//函数调用时不用管后续sp的sp_Offset
	fprintf(fw,"\taddi $sp, $sp, -4 \n");
	fprintf(fw,"\tsw $ra, 0($sp) \n"); 

	fprintf(fw,"\tjal %s\n", trans(code.u.assign.right));
	fprintf(fw,"\tlw $ra, 0($sp)\n");
	fprintf(fw,"\taddi $sp, $sp, 4\n");
	//补充
	if(code.u.assign.left->kind == 9 || code.u.assign.left->kind == 6)
	{
		fprintf(fw,"\tsw $v0, 0(%s)\n", pointer_get_reg(code.u.assign.left, fw));
	}
	else
	{
		fprintf(fw,"\tmove %s, $v0\n", get_reg(code.u.assign.left, fw));
		SaveToStack(code.u.assign.left, fw);
	}
}

void forAdd(FILE *fw, InterCode code)
{
	//分类考虑出现常数的情况，这时用addi
	if(code.u.binop.op1->kind == CONST)
	{
		if(code.u.binop.op2->kind == CONST)
		{
			//两个常数
			if(code.u.binop.result->kind == 9 || code.u.binop.result->kind == 6)//*a
			{
				char* op2 = get_reg(code.u.binop.op2, fw);
				fprintf(fw, "addi %s, %s, %s\n", op2, op2, get_reg(code.u.binop.op1, fw));
				fprintf(fw, "sw, %s, 0(%s)\n", op2, pointer_get_reg(code.u.binop.result, fw));
			}
			else
			{

				fprintf(fw,"\taddi %s, %s, %s\n", get_reg(code.u.binop.result,fw),get_reg(code.u.binop.op2, fw), get_reg(code.u.binop.op1, fw));
				SaveToStack(code.u.binop.result,fw);
				return;
			}
		}
		else if(code.u.binop.result->kind == 9 || code.u.binop.result->kind == 6)//*a
		{
			//一个常数 ，*a = 1 + k;
			char* op1 = get_reg(code.u.binop.op1, fw);//和放在常数部分
			fprintf(fw, "addi %s, %s, %s\n", op1, op1, get_reg(code.u.binop.op2, fw)); 
			fprintf(fw, "sw, %s, 0(%s)\n", op1, pointer_get_reg(code.u.binop.result, fw));
			ChangeType(code.u.binop.op2,fw);
		}
		else
		{
			fprintf(fw,"\taddi %s, %s, %s\n", get_reg(code.u.binop.result,fw),get_reg(code.u.binop.op2, fw), code.u.binop.op1->u.val);
			SaveToStack(code.u.binop.result,fw);
			ChangeType(code.u.binop.op2,fw);
			return;
		}
	}
	else if(code.u.binop.op2->kind == CONST)
	{
		if(code.u.binop.result->kind == 9 || code.u.binop.result->kind == 6)//*a = k + 1
		{
			char* op2 = get_reg(code.u.binop.op2, fw);
			fprintf(fw, "addi %s, %s, %s\n", op2, op2, get_reg(code.u.binop.op1, fw));
			fprintf(fw, "sw, %s, 0(%s)\n", op2, pointer_get_reg(code.u.binop.result, fw));
			ChangeType(code.u.binop.op1,fw);
		}
		else
		{
			fprintf(fw,"\taddi %s, %s, %s\n", get_reg(code.u.binop.result,fw),get_reg(code.u.binop.op1, fw), code.u.binop.op2->u.val);
			SaveToStack(code.u.binop.result,fw);
			ChangeType(code.u.binop.op1,fw);
			return;
		}
	}	
	else if(code.u.binop.result->kind == 9 || code.u.binop.result->kind == 6)//*a = ...
	{
		//补充额外处理
		//将*a的值放到寄存器中，相当于更新了
		char* tmppointer = get_reg(code.u.binop.result,fw);//这里借用了*a的位置
		//由于借用了，所以要将*a还原
		VarDescriptor* val = getItemFromVarDescriptor(trans(code.u.binop.result));
		if(val->type == 1 || val->type == 2)//仅在内存中是不可能的
			printf("Wrong in For Add\n");

		else if(val->type == 3)
			val->type = 2;//由于每行都保存，所以直接覆盖

		fprintf(fw,"\tadd %s, %s, %s\n", tmppointer, get_reg(code.u.binop.op1,fw), get_reg(code.u.binop.op2, fw));
		fprintf(fw, "\tsw %s, 0(%s)\n", tmppointer, pointer_get_reg(code.u.binop.result, fw));//接着更新到内存中

		ChangeType(code.u.binop.op1,fw);ChangeType(code.u.binop.op2, fw);
		return;
	}
	else
	{
		fprintf(fw,"\tadd %s, %s, %s\n", get_reg(code.u.binop.result,fw), get_reg(code.u.binop.op1,fw), get_reg(code.u.binop.op2, fw));
		SaveToStack(code.u.binop.result,fw);ChangeType(code.u.binop.op1,fw);ChangeType(code.u.binop.op2, fw);
		return;
	}
}

void forSub(FILE *fw, InterCode code)
{
	if(code.u.assign.left->kind == 9 || code.u.assign.left->kind == 6)//*a = ...
	{
		//补充额外处理
		char* tmppointer = get_reg(code.u.binop.result,fw);
		fprintf(fw,"\tsub %s, %s, %s\n", tmppointer, get_reg(code.u.binop.op1,fw), get_reg(code.u.binop.op2, fw));
		fprintf(fw, "\tsw %s, 0(%s)\n", tmppointer, pointer_get_reg(code.u.binop.result, fw));

		ChangeType(code.u.binop.op1,fw);ChangeType(code.u.binop.op2, fw);
		return;
	}else 
	{
		fprintf(fw,"\tsub %s, %s, %s\n", get_reg(code.u.binop.result,fw), get_reg(code.u.binop.op1,fw), get_reg(code.u.binop.op2, fw));
		SaveToStack(code.u.binop.result,fw);ChangeType(code.u.binop.op1,fw);ChangeType(code.u.binop.op2, fw);
		return;
	}
}

void forMul(FILE *fw, InterCode code)
{
	if(code.u.assign.left->kind == 9 || code.u.assign.left->kind == 6)//*a = ...
	{
		//补充额外处理
		char* tmppointer = get_reg(code.u.binop.result,fw);
		//由于借用了，所以要将*a还原
		VarDescriptor* val = getItemFromVarDescriptor(trans(code.u.binop.result));
		if(val->type == 1 || val->type == 2)//仅在内存中是不可能的
		{
			printf("Wrong in For Add\n");
		}
		else if(val->type == 3)
		{
			val->type = 2;//由于每行都保存，所以直接覆盖
		}
		fprintf(fw,"\tmul %s, %s, %s\n", tmppointer, get_reg(code.u.binop.op1,fw), get_reg(code.u.binop.op2, fw));
		fprintf(fw, "\tsw %s, 0(%s)\n", tmppointer, pointer_get_reg(code.u.binop.result, fw));
		
		ChangeType(code.u.binop.op1,fw);ChangeType(code.u.binop.op2, fw);
		return;
	}else 
	{
		fprintf(fw,"\tmul %s, %s, %s\n", get_reg(code.u.binop.result,fw), get_reg(code.u.binop.op1,fw), get_reg(code.u.binop.op2, fw));
		SaveToStack(code.u.binop.result,fw);ChangeType(code.u.binop.op1,fw);ChangeType(code.u.binop.op2, fw);
		return;
	}
}

void forDiv(FILE *fw, InterCode code)
{
	if(code.u.assign.left->kind == 9 || code.u.assign.left->kind == 6)//*a = ...
	{
		//补充额外处理
		char* tmppointer = get_reg(code.u.binop.result,fw);
		//由于借用了，所以要将*a还原
		VarDescriptor* val = getItemFromVarDescriptor(trans(code.u.binop.result));
		if(val->type == 1 || val->type == 2)//仅在内存中是不可能的
		{
			printf("Wrong in For Add\n");
		}
		else if(val->type == 3)
		{
			val->type = 2;//由于每行都保存，所以直接覆盖
		}
		fprintf(fw,"\tdiv %s, %s\n",get_reg(code.u.binop.op1,fw), get_reg(code.u.binop.op2, fw));
		fprintf(fw,"\tmflo %s\n", tmppointer);
		fprintf(fw, "\tsw %s, 0(%s)\n", tmppointer, pointer_get_reg(code.u.binop.result, fw));

		ChangeType(code.u.binop.op1,fw);ChangeType(code.u.binop.op2, fw);
		return;
	}else 
	{
		fprintf(fw,"\tdiv %s, %s\n",get_reg(code.u.binop.op1,fw), get_reg(code.u.binop.op2, fw));
		fprintf(fw,"\tmflo %s\n", get_reg(code.u.binop.result,fw));

		SaveToStack(code.u.binop.result,fw);ChangeType(code.u.binop.op1,fw);ChangeType(code.u.binop.op2, fw);
		return;
	}
}

void forIfGoto(FILE *fw, InterCode code)
{
	if(strcmp(code.u.triop.relop, "==") == 0)
	{
		fprintf(fw,"\tbeq %s, %s, %s\n",get_reg(code.u.triop.op1, fw),get_reg(code.u.triop.op2, fw),trans(code.u.triop.label));
	}
	else if(strcmp(code.u.triop.relop, "!=") == 0)
	{
		fprintf(fw,"\tbne %s, %s, %s\n",get_reg(code.u.triop.op1, fw),get_reg(code.u.triop.op2, fw),trans(code.u.triop.label));
	}
	else if(strcmp(code.u.triop.relop, ">") == 0)
	{
		fprintf(fw,"\tbgt %s, %s, %s\n",get_reg(code.u.triop.op1, fw),get_reg(code.u.triop.op2, fw),trans(code.u.triop.label));
	}
	else if(strcmp(code.u.triop.relop, "<") == 0)
	{
		fprintf(fw,"\tblt %s, %s, %s\n",get_reg(code.u.triop.op1, fw),get_reg(code.u.triop.op2, fw),trans(code.u.triop.label));
	}
	else if(strcmp(code.u.triop.relop, ">=") == 0)
	{
		fprintf(fw,"\tbge %s, %s, %s\n",get_reg(code.u.triop.op1, fw),get_reg(code.u.triop.op2, fw),trans(code.u.triop.label));
	}
	else if(strcmp(code.u.triop.relop, "<=") == 0)
	{
		fprintf(fw,"\tble %s, %s, %s\n",get_reg(code.u.triop.op1, fw),get_reg(code.u.triop.op2, fw),trans(code.u.triop.label));
	}
	else//理论上不存在
		fprintf(fw,"IF %s %s %s GOTO %s\n",trans(code.u.triop.op1),code.u.triop.relop,trans(code.u.triop.op2),trans(code.u.triop.label));
	

	//补充
	VarDescriptor* item = getItemFromVarDescriptor(trans(code.u.triop.op1));
	if(item != NULL)
	{
		if(item->type == 1)
			printf("Exception1 in ifgoto\n");
		item->type = 2;
	}
	item = getItemFromVarDescriptor(trans(code.u.triop.op2));
	if(item != NULL)
	{
		if(item->type == 1)
			printf("Exception2 in ifgoto\n");
		item->type = 2;
	}
}

void forGetaddr(FILE *fw, InterCode code)
{
	printf("show forGetaddr\n");
	VarDescriptor* right = getItemFromVarDescriptor(trans(code.u.assign.right));
	if(right == NULL)
	{
		fprintf(fw,"%s = &%s\n", trans(code.u.assign.left), trans(code.u.assign.right));
		fprintf(fw,"wrong in forGetaddr, can't find right operand\n");
	}
	if(right->type == 2 || right->type == 3)
	{
		//成功
		char *regName=get_reg(code.u.assign.left, fw);
		fprintf(fw,"\tmove %s, $fp", get_reg(code.u.assign.left, fw));
		fprintf(fw,"\taddi %s, %s, %d", regName, regName, right->offset);
	}
	else
	{
		/* 出现错误 */
		fprintf(fw,"%s = &%s\n", trans(code.u.assign.left), trans(code.u.assign.right));
		fprintf(fw,"wrong in forGetaddr, can't find right operand and type = %d\n", right->type);
	}
}

void forGetpointer(FILE *fw, InterCode code)
{
	printf("show forPointer\n");
	//表示 x = *y
	fprintf(fw,"\tlw %s, 0(%s)\n", get_reg(code.u.assign.left, fw), get_reg(code.u.assign.right, fw));
}

void forPointto(FILE *fw, InterCode code)
{
	printf("show forPointerto\n");
	//表示 *x = y
	fprintf(fw,"\tsw %s, 0(%s)\n", get_reg(code.u.assign.right, fw), get_reg(code.u.assign.left, fw));
}


void printAssemblyCodes(FILE *fw)
{
	fprintf(fw, ".data\n");
	fprintf(fw, "_prompt: .asciiz \"Enter an integer:\"\n");
	fprintf(fw, "_ret: .asciiz \"\\n\" \n");
	fprintf(fw, ".globl main\n");
	fprintf(fw, ".text\n");
	fprintf(fw, "read:\n");
	fprintf(fw, "\tli $v0, 4 \n\tla $a0, _prompt \n\tsyscall\n");
	fprintf(fw, "\tli $v0, 5 \n\tsyscall \n\tjr $ra \n\n");
	fprintf(fw, "write:\n");
	fprintf(fw, "\tli $v0, 1 \n\tsyscall \n\tli $v0, 4 \n");
	fprintf(fw, "\tla $a0, _ret \n\tsyscall \n\tmove $v0, $0 \n\tjr $ra \n\n");

	
	sp_Offset = 0;
	line_Count = 0;
	InterCodes* tmp = head;

	arg_Count = -1;
	while(tmp != NULL)
	{
		line_Count++;
		InterCode code = tmp->code;
		switch (code.kind)
		{
		case DEC: forDec(fw, code); break;
		case CLABEL: forCLabel(fw, code); break;
		case FUNCTION: forFunction(fw, code); break;
		case GOTO: forGoto(fw, code); break;
		case RETURN: forReturn(fw, code); break;
		case ARG: forArg(fw, code); break;
		case PARAM: forParam(fw, code); break;
		case READ: forRead(fw, code); break;
		case WRITE:forWrite(fw, code); break;
		case ASSIGN:forAssign(fw, code); break;
		case CALL: forCall(fw, code); break;
		case ADD: forAdd(fw, code); break;
		case SUB: forSub(fw, code); break;
		case MUL: forMul(fw, code); break;
		case DIV: forDiv(fw, code); break;
		case IFGOTO:forIfGoto(fw, code); break;
		case getaddr: forGetaddr(fw, code); break;
		case getpointer: forGetpointer(fw, code); break;//16, 17,represent result=&op1, result=*op1
		case pointto: forPointto(fw, code); break;
		default: break;
		}
		tmp = tmp->next;
	}
}

