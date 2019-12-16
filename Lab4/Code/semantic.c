#include "tree.h"
#include "semantic.h"
#include <assert.h>

#define Length 40


char* int2char(int num)
{
	char* buffer = malloc(sizeof(char) * 40);
	sprintf(buffer,"%d",num);
	return buffer;
}

int Floor(float x)
{
	if(x>0) return (int)x;
	else
	{
		if(x-(int)x<-0.000001) return (int)x-1;
		else return (int)x;//负整数
	}
}

//FieldList structure中的structure需要提前分配空间
bool FuncRedefine;//函数重定义
int tempCount, labelCount;
bool fromVarList;//函数参数列表中的数组不用DEC

Type newType()
{
	Type type = (Type)malloc(sizeof(Type_));
	return type;
}

VarObject* newVar(bool lv)
{
	VarObject* var = (VarObject*)malloc(sizeof(VarObject));
	//lab3 数组
	var->isParam = false;

	var->type = newType();
	var->lvalue = lv;
	return var;
}

FuncObject* newFunc()
{
	FuncObject* func = (FuncObject*)malloc(sizeof(FuncObject));
	func->rtype = newType();
	return func;
}

bool typeEqual(Type t1, Type t2)
{
	int nonequal = 0;
	if (t1->kind != t2->kind)
		nonequal = 1;
	else//进一步确定是否一致
	{
		switch (t1->kind)
		{
		case BASIC://可以写函数来判断
		{
			if (t1->u.basic != t2->u.basic)
				nonequal = 1;
		}break;
		case ARRAY:
		{
			//判断维度和最后的类型是否同
			int dim1 = 0, dim2 = 0;
			//p1与p2while循环结束后指示最后的类型
			Type p1 = t1, p2 = t2;
			while (p1->kind == ARRAY)
			{
				dim1 += 1;
				p1 = p1->u.array.elem;
			}
			while (p2->kind == ARRAY)
			{
				dim2 += 1;
				p2 = p2->u.array.elem;
			}
			if (dim1 != dim2) nonequal = 1;
			else
			{
				bool equal = typeEqual(p1, p2);
				if (!equal) nonequal = 1;
			}
		}break;
		case STRUCTURE:
		{
			char *name1=t1->u.structure->name;
			char *name2=t2->u.structure->name;
			if(name1 != NULL || name2 != NULL)//至少有一个名字不为空，两个都为空时为等价
			{	
				if(name1!=NULL && name2!=NULL)//两个名字都不空，则进一步判断是否相等
				{
					if (strcmp(name1, name2) != 0)//名不等价
						nonequal = 1;
				}//必须有括号，貌似为就近匹配if-else
				else nonequal = 1;//一个为空，一个不为空，不等价
			}
		}break;
		default:break;
		}
	}
	if (nonequal == 1) return false;
	else return true;
}

VarObject* newVarObject(int kind)
{
	VarObject* newone = (VarObject*)malloc(sizeof(VarObject));
	//lab3 数组
	newone->isParam = false;

	newone->name = NULL;   //没名字
	newone->type = (Type)malloc(sizeof(Type_));
	switch (kind)
	{
	case 0: { newone->type->kind = BASIC; }break;
	case 1: { newone->type->kind = ARRAY; }break;
	case 2: { newone->type->kind = STRUCTURE; }break;
	default: break;
	}
	return newone;
}

Type CheckInStructure(Type st, char* name)
{
	if (st->kind != STRUCTURE) return NULL;
	FieldList field = st->u.structure->type->u.structure;
	while (field)
	{	
		if (strcmp(name, field->name) == 0)
			return field->type;
		field = field->tail;
	}
	return NULL;
}
//


void traverseTree(TreeNode* root)
{
	tempCount=0; 
	labelCount=0;
	fromVarList=false;
	initSymbolTable();
	Program(root);
	deleteRedundantAssign();
}

void ErrorGenerator(char* str)
{
	printf("%s", str);
	assert(0);
}

/*(1) High-level Definitions*/
void Program(TreeNode* root) //Done
{
	if (root == NULL)	return;
	ExtDefList(root->firstChild);
}

void ExtDefList(TreeNode* p) //Done
{
	if (p == NULL)	return;
	ExtDef(p->firstChild);
	ExtDefList(p->firstChild->next);
}

void ExtDef(TreeNode* p) //not Done-> the last "CompSt(q->next->next);"
{
	if (p == NULL)	return;
	TreeNode* q = p->firstChild;
	if (!q || q->nodetype != TYPE_Specifier) return; //the first must be "Specifier"

	Type specifier = Specifier(q);
	//CreateVector  头指针
	//extdeclist->index = -1;
	vector *extdeclist = CreateVector();
	extdeclist->last = extdeclist;

	FuncObject *fundec = NULL;
	if (q->next && q->next->nodetype == TYPE_ExtDecList)
	{
		ExtDecList(q->next, specifier, extdeclist);//此处extdeclist作用不大
		//此情况若specifier为结构体，OptTag可以为NULL
	}
	else if (q->next && q->next->nodetype == TOKEN_SEMI)
	{
		;//结构体，为StructSpecifier的返回在创建时已经插入vtable；对于"int;" "float;"不需要额外处理
	}
	else if (q->next && q->next->nodetype == TYPE_FuncDec)
	{
		fundec = (FuncObject*)malloc(sizeof(FuncObject));
		fundec->rtype = specifier;
		fundec->args = CreateVector();//CreateVector  头指针
		fundec->args->last = fundec->args;
		FuncRedefine=false;
	
		FunDec(q->next, fundec);
		if (FuncRedefine==false)//若重复定义，则会将FuncRedefine = true
		{
			FuncHashTable* fitem = (FuncHashTable*)malloc(sizeof(FuncHashTable));
			fitem->func = fundec;//!会不会有指针副作用
			fitem->indexNext = NULL;
			AddToFuncHashTable(fitem);//insert
			//lab3
			insertFuncName(fundec->name);
			vector *arg=fundec->args->next;
			while(arg)
			{
				if(arg->val)
				{
					insertFuncParam(arg->val->name);
					//printf("%s\n", arg->val->name);
					arg->val->isParam = true;
				}
				arg=arg->next;
			}			
		}
		//else	return; 函数重复定义，依旧建议继续处理
		
		if (!q->next->next || q->next->next->nodetype != TYPE_CompSt)	return;
		CompSt(q->next->next, specifier);//嵌套域； specifier--rtype
	}

	return;
}

void ExtDecList(TreeNode* p, Type specifier, vector *extdeclist)//Done
{
	if (p == NULL) return;
	TreeNode* child = p->firstChild;
	if (child == NULL)
	{
		ErrorGenerator("Find ExtDecList -> NULL");
	}
	if (child->nodetype == TYPE_VarDec)
	{
		Type Array = NULL;//用于判断VarDec层，是否第一个便为ID；否则需按照数组处理
		//ExtDecList -> VarDec ExtDecList
		VarDec(child, specifier, extdeclist, Array, NULL);//st=NULL
	}
	//if ExtDecList-> VarDec COMMA ExtDecList
	if (p->lastChild != NULL && p->lastChild->nodetype == TYPE_ExtDecList)
		ExtDecList(p->lastChild, specifier, extdeclist);
}


/*(2) Specifiers*/  //
Type Specifier(TreeNode* p)//Done
{
	if (p == NULL) return NULL;
	TreeNode* q = p->firstChild;
	if (q && q->nodetype == TOKEN_TYPE)
	{
		Type type = (Type)malloc(sizeof(Type_));
		type->kind = BASIC;
		if (strcmp(q->value, "int") == 0)
			type->u.basic = 0;
		else
			type->u.basic = 1;
		return type;
	}
	else if (q && q->nodetype == TYPE_StructSpecifier)
	{
		//lab3
		printf("Cannnot translate: Code contains variables or parameters of structure type.\n");
		exit(0);
		return StructSpecifier(q);
	}
}

Type StructSpecifier(TreeNode* p)//Done
{
	if (p == NULL) return NULL;
	TreeNode* q = p->firstChild;
	if (!q || q->nodetype != TOKEN_STRUCT) return NULL;
	if (q->next && q->next->nodetype != TYPE_Tag)
	{
		FieldList st = (FieldList)malloc(sizeof(FieldList_));
		TreeNode* r = NULL, *s = q->next->firstChild;
		VarObject* vexist = NULL;
		VarObject* sexist = NULL;
		if (q->next->nodetype == TYPE_OptTag)
		{
			vexist = CheckInValHashTable(q->next->firstChild->value, true);
			if (vexist == NULL)
			{
				st->name = s->value;
				sexist = CheckInVtableForStruct(st->name);//针对A_16.cmm的解读,检查变量是否与结构体名重复
				if (!q->next->next || q->next->next->nodetype != TOKEN_LC)	return NULL;
				r = q->next->next->next;
			}
		}
		else if (q->next->nodetype == TOKEN_LC)//TYPE_OptTag可以为空，则q->next->nodetype=TOKEN_LC，此时结构体没有名称；则大概率后面为ExtDecList
		{
			st->name = NULL;//TYPE_OptTag为空
			r = q->next->next;
		}
		//经过上述语句，表明已经遇到一个{： 
		CreateNewSpace();
		if (r && r->nodetype == TYPE_DefList)//DefList可能为空 
		{
			st->type = NULL;
			DefList(r, st);	//st为结构体的头
		}
		//if(!r->next || strcmp(r->next->name,"RC")!=0)	return NULL;
		//表明已经遇到一个}： 
		FreeThisNameSpace();

		Type type = (Type)malloc(sizeof(Type_));
		type->kind = STRUCTURE;
		type->u.structure = st;

		VarObject* val = (VarObject*)malloc(sizeof(VarObject));
		//lab3 数组
		val->isParam = false;

		val->name = type->u.structure->name;//赋值结构体名称；则判断结构体是否相同时--名字同
		val->type = type;
		if(vexist == NULL && sexist == NULL)
			AddToSymbolTable(val);//将结构体插入vtable
		else
		{
			//报错重复定义; return NULL ? 还是return哈希表中已有的类型
			printf("Error type %d at Line %d: Duplicated name \"%s\".\n", 16,s->line, s->value);
			return newType();//or type ?
		}
			
		return type;
	}
	else if (q->next && q->next->nodetype == TYPE_Tag) //define variables WITH the defined structure, find
	{
		VarObject* structure = CheckInValHashTable(q->next->firstChild->value, false);//strict先赋值false
		if (structure == NULL)
		{
			printf("Error type %d at Line %d: Undefined structure \"%s\".\n", 17, q->next->firstChild->line, q->next->firstChild->value);//check error 17:结构体未定义
			return newType();
		}
		return structure->type;
	}
}


/*(3) Declarators*/

//TODO：传入变量类型，向符号表中加入该变量
//总结来说这个实现的是关于VarDec的自动检测加入或自动报错  
void VarDec(TreeNode* p, Type specifier, vector *list, Type Array, FieldList st)//VarDec表示对一个变量的定义,不用考虑index问题 //Done
{
	if (p == NULL) return;
	TreeNode* q = p->firstChild;
	if (q == NULL) return;
	if (q->nodetype == TOKEN_ID)
	{
		//TODO: check TOKEN_ID is in symbol table, Add or report error
		//首先check 该变量在同一深度是否已经存在，错误3
		vector* vardec = (vector*)malloc(sizeof(vector));
		vardec->val = (VarObject*)malloc(sizeof(VarObject));
		//lab3 数组
		vardec->val->isParam = false;

		vardec->val->name = q->value;
		vardec->next = vardec->last = NULL;
		if (Array == NULL)//not array
			vardec->val->type = specifier;
		else
		{
			vardec->val->type = Array;
			//lab3  数组
			if(st==NULL&&fromVarList==false)//不是结构体内部的数组,且不是函数参数列表中的数组
				insertFields(q->value,computeSize(Array));
		}
		//插入 list
		list->last->next = vardec;
		list->last = vardec;
		VarObject* sexist = CheckInVtableForStruct(q->value);//针对A_3.cmm的解读,检查变量是否与结构体名重复
		VarObject* vexist = CheckInValHashTable(q->value, true);
		//如果不存在错误，则
		if (sexist == NULL &&vexist == NULL)
		{
			AddToSymbolTable(vardec->val);
			if (st != NULL)//结构体
			{
				FieldList field = (FieldList)malloc(sizeof(FieldList_));
				field->name = q->value;
				field->type = vardec->val->type;
				field->tail = NULL;
				if (st->type == NULL)
				{
					st->type = (Type)malloc(sizeof(Type_));
					st->type->kind = STRUCTURE;
					st->type->u.structure = field;
				}
				else
				{
					FieldList f = st->type->u.structure;
					while (f->tail) f = f->tail;
					f->tail = field;
				}
			}
		}
		else
		{
			//报错重复定义
			if (st == NULL)
				printf("Error type %d at Line %d: Redefined variable \"%s\".\n", 3, q->line, q->value);
			else
				printf("Error type %d at Line %d: Redefined field \"%s\".\n", 15, q->line, q->value);
			return;
		}
	}
	else if (q->nodetype == TYPE_VarDec)//类似于数组类型的处理
	{
		if (q->next->next->nodetype != TOKEN_INT)
		{
			printf("Error type %d at Line %d: \"%s\" is not an integer.\n", 12, q->next->next->line, q->next->next->value);//报错12
			return;
		}
		//如果不存在错误，则	
		int size = atoi(q->next->next->value);
		if (Array == NULL)
		{
			Array = (Type)malloc(sizeof(Type_));
			Array->kind = ARRAY;
			Array->u.array.size = size;
			Array->u.array.elem = specifier;
			VarDec(q, specifier, list, Array, st);
		}
		else
		{
			Type prior = (Type)malloc(sizeof(Type_));
			prior->kind = ARRAY;
			prior->u.array.size = size;
			prior->u.array.elem = Array;
			VarDec(q, specifier, list, prior, st);
		}
	}
	else
	{
		ErrorGenerator("error VarDec-> ?\n");
	}

}
//功能：将这个函数声明加入到符号表中。
void FunDec(TreeNode* p, FuncObject *fundec)//Done
{
	if (p == NULL) return;
	TreeNode* funcName = p->firstChild;
	if (funcName == NULL)
	{
		ErrorGenerator("Wrong in FunDec! No children!");
		return;
	}
	fundec->name = funcName->value;//确定函数名
	//VarObject* vexist=CheckInValHashTable(funcName->value, false);
	FuncObject* fexist = CheckInFuncHashTable(funcName->value);
	if (fexist != NULL)
	{
		//报错重复定义  函数重复定义；那与变量重复？<不会出现>
		printf("Error type %d at Line %d: Redefined function \"%s\".\n", 4, funcName->line, funcName->value);
		FuncRedefine = true;// 继续处理
	}
	TreeNode* funcVars = funcName->next->next;
	if (funcVars->nodetype == TYPE_VarList)
	{
		//说明出现多个参数，将加入符号表的功能要求在VarList中实现
		int index = 1; //!
		//lab3
		fromVarList=true;
		VarList(funcVars, fundec, index);
		//需要将函数形参列表插入哈希表？  需要！
		fromVarList=false;
	}
}

//实现功能：填充参数列表
void VarList(TreeNode* p, FuncObject *fundec, int index)//Done
{
	if (p == NULL) return;
	if (p->firstChild == p->lastChild)
	{
		ParamDec(p->firstChild, fundec->args, index);//Varist->ParamDec
	}
	else
	{
		ParamDec(p->firstChild, fundec->args, index);//VarList->ParamDec COMMA VarList
		VarList(p->lastChild, fundec, index + 1);
	}

}

void ParamDec(TreeNode* p, vector *vars, int index)//Done
{
	if (p == NULL) return;
	//TODO:将参数填入vector中
	Type specifier = Specifier(p->firstChild);
	Type Array = NULL; // 对于函数参数为 int[][]? 按语法表应该是不会出现
	VarDec(p->lastChild, specifier, vars, Array, NULL);
	vars->last->index = index;//对于函数参数：每次都是 单个Specifier + 单个VarDec
}


/*(4) Statements*/
//TODO：在函数块中的{}包围部分，需要考虑作用域的问题
void CompSt(TreeNode* p, Type rtype)
{
	if (p == NULL) return;
	//初步想法：有记录作用域的栈，这个记录作用域的为全局变量，在{}中的作用域就push到最上面
	//这期间调用VarDec之类新加的局部变量都挂在这个作用域上，和书上的图一样
	TreeNode* q = p->firstChild;
	if (q && q->nodetype == TOKEN_LC)
		CreateNewSpace();// globalDepth += 1;
	if (q->next && q->next->nodetype == TYPE_DefList)
	{
		DefList(q->next, NULL);//不是从结构体进入DefList
		TreeNode* stmtList = q->next->next;
		if (stmtList && stmtList->nodetype == TYPE_StmtList)
			StmtList(stmtList, rtype);
	}
	else if (q->next && q->next->nodetype == TYPE_StmtList)
		StmtList(q->next, rtype);

	if (p->lastChild && p->lastChild->nodetype == TOKEN_RC)
		FreeThisNameSpace();// globalDepth -= 1;

	//TODO：在结束是释放局部变量，pop作用域栈
}

void StmtList(TreeNode* p, Type rtype)
{
	if (p == NULL) return;
	Stmt(p->firstChild, rtype);
	StmtList(p->firstChild->next, rtype);//为null则表明StmtList->Stmt
}

void Stmt(TreeNode* p, Type rtype)
{
	if (p == NULL) return;
	TreeNode* q = p->firstChild;
	VarObject* exp = NULL;
	switch (q->nodetype)
	{
	case TYPE_Exp:
	{
		exp = Exp(q,NULL);
	}
	break;
	case TYPE_CompSt:
	{
		CompSt(q, rtype);//语句块没有返回值类型
	}
	break;
	case TOKEN_RETURN:
	{
		Operand t1= newTemp(tempCount++);
		exp = Exp(q->next, t1);//获得返回的表达式的值，判断类型是否符合rtype
		bool equal = typeEqual(exp->type, rtype);
		if (!equal)
		{
			printf("Error type %d at Line %d: Type mismatched for return.\n", 8, q->line);
			return;
		}
		insertReturn(t1);
	}
	break;
	case TOKEN_IF:
	{
		TreeNode* r = q->next->next;//Exp
		Operand label1=newLabel(labelCount++);
		Operand label2=newLabel(labelCount++);
		exp = translate_Cond(r, label1, label2);//code1
		insertLabel(label1);//label1
		//提取后续的Stmt
		TreeNode* s = r->next->next;
		Stmt(s, rtype);//code2
		if (s->next && s->next->nodetype == TOKEN_ELSE)
		{
			Operand label3=newLabel(labelCount++);
			insertGotoLabel(label3);//goto label3
			insertLabel(label2);//label2
			Stmt(s->next->next, rtype);//code3
			insertLabel(label3);//label3
		}
		else
			insertLabel(label2);//label2
	}
	break;
	case TOKEN_WHILE:
	{
		TreeNode* r = q->next->next;//Exp
		Operand label1=newLabel(labelCount++);
		Operand label2=newLabel(labelCount++);
		Operand label3=newLabel(labelCount++);
		insertLabel(label1);//label1
		exp=translate_Cond(r, label2, label3);//code1
		//提取后续的Stmt
		insertLabel(label2);//label2
		Stmt(r->next->next, rtype);//code2
		insertGotoLabel(label1);//goto label1
		insertLabel(label3);//label3
	}
	break;
	default:
		break;
	}
}


/*(5) Local Definitions*/
void DefList(TreeNode* p, FieldList st)// Done
{
	if (p == NULL)	return;
	TreeNode* q = p->firstChild;
	if (q == NULL)	return;
	if (q->nodetype == TYPE_Def)
		Def(q, st);
	if (q->next && q->next->nodetype == TYPE_DefList)
		DefList(q->next, st);

}

void Def(TreeNode* p, FieldList st)
{
	if (p == NULL)	return;
	TreeNode* q = p->firstChild;
	Type specifier = NULL;
	if (q && q->nodetype == TYPE_Specifier)
		specifier = Specifier(q);
	else
	{
		ErrorGenerator("Wrong in Def-> not Speicifier");
		return;
	}
	if (q->next && q->next->nodetype == TYPE_DecList)
	{
		vector *declist = (vector*)malloc(sizeof(vector));
		declist->val = NULL;
		declist->next = NULL;
		declist->last = declist;

		DecList(q->next, specifier, declist, st);
	}
	//if(!q->next->next || strcmp(q->next->next->name,"SEMI")!=0)	return;
}

void DecList(TreeNode* p, Type specifier, vector *declist, FieldList st)
{
	if (p == NULL)	return;
	TreeNode* q = p->firstChild;
	if (q && q->nodetype == TYPE_Dec)
	{
		Dec(q, specifier, declist, st);
		if (!q->next || q->next->nodetype != TOKEN_COMMA)	return;
		if (q->next->next && q->next->next->nodetype == TYPE_DecList)
			DecList(q->next->next, specifier, declist, st);
	}
	else
	{
		ErrorGenerator("Wrong in DecList-> Not Dec");
	}
}
//Exp应该返回VarObject类型
void Dec(TreeNode* p, Type specifier, vector *declist, FieldList st)
{
	if (p == NULL)	return;
	TreeNode* q = p->firstChild;
	if (q && q->nodetype == TYPE_VarDec)
	{
		Type Array = NULL;
		VarDec(q, specifier, declist, Array, st);
		if (q->next && q->next->nodetype == TOKEN_ASSIGNOP)
		{
			/* need to record both sides of the "=" */  //check error 5;
			VarObject* exp = NULL;
			if (q->next->next && q->next->next->nodetype == TYPE_Exp)
			{
				if (st != NULL)
				{
					printf("Error type %d at Line %d: Struct variables cannot be initialized.\n", 15, q->next->line);
					return;
				}
				//lab3				
				Operand right = newTemp(tempCount++);
				exp = Exp(q->next->next, right);
				//将exp与declist的最后一个进行类型判断，并可以考虑赋值等操作
				bool equal = typeEqual(declist->last->val->type, exp->type);
				if (!equal)
				{
					printf("Error type %d at Line %d: Type mismatched for assignment.\n", 5, q->next->line);
					return;
				}

				/*数组相关，确认是否需要添加这一项*/
				if(right->kind == ADDR)
				{
					Operand tmpl = newTemp(tempCount++);
					tmpl->kind = AddrVarNo;
					tmpl->u = right->u;
					right = tmpl;
				}
				insertAssignLID(declist->last->val->name, right);
			}
		}		
	}
}



/*(6) Expressions*/  //TO BE CONTINUE
VarObject* Exp(TreeNode* p, Operand place)//!
{
	if (p == NULL)	return NULL;
	TreeNode* q = p->firstChild;
	if (q == NULL)	return NULL;
	if (q->nodetype == TYPE_Exp)
	{
		VarObject* exp = NULL;//Exp(q);!!
		VarObject* exp1 = NULL;
		if (q->next == NULL)	return NULL;
		TreeNode* r = q->next->next;
		switch (q->next->nodetype)//match or not, important
		{
		case TOKEN_ASSIGNOP: {
			Operand leftExp = newTemp(tempCount++);
			exp = Exp(q, leftExp);
			//1. 判断exp是否为右值表达式
			if (exp->lvalue == false)
			{
				printf("Error type %d at Line %d: The left-hand side of an assignment must be a variable.\n", 6, q->next->line);
				return exp;
			}
			if (r == NULL)	return NULL;
			Operand rightExp = newTemp(tempCount++);
			exp1 = Exp(r, rightExp);
			//2. 判断exp与exp1的类型是否相同
			bool equal = typeEqual(exp->type, exp1->type);
			if (!equal)
			{
				printf("Error type %d at Line %d: Type mismatched for assignment.\n", 5, q->next->line);
				return newVar(false);
			}

			/*数组相关，确认是否需要添加这一项*/
			if(leftExp->kind == ADDR)
			{
				Operand tmpl = newTemp(tempCount++);
				tmpl->kind = AddrVarNo;
				tmpl->u = leftExp->u;
				leftExp = tmpl;
			}
			if(rightExp->kind == ADDR)
			{
				Operand tmpl = newTemp(tempCount++);
				tmpl->kind = AddrVarNo;
				tmpl->u = rightExp->u;
				rightExp = tmpl;
			}

			insertAssignLOP(leftExp, rightExp);


			if(place!=NULL)
				insertAssignLOP(place, rightExp);
			//printf("name = s, kind = %d\n",  place->kind);
			return exp1;//需要补充赋值过程
		}break;
		case TOKEN_AND:
		case TOKEN_OR: 
		case TOKEN_RELOP: {//to be !!
			Operand label1=newLabel(labelCount++);
			Operand label2=newLabel(labelCount++);
			Operand constant=(Operand)malloc(sizeof(struct Operand_));
			constant->kind=CONST;
			constant->u.val=(char*)malloc(2);
			strcpy(constant->u.val,"0");	
			if(place!=NULL)
				insertAssignLOP(place, constant);//code0
			exp=translate_Cond(p, label1, label2);//!
			insertLabel(label1);//label1
			Operand constant1=(Operand)malloc(sizeof(struct Operand_));
			constant1->kind=CONST;
			constant1->u.val=(char*)malloc(2);
			strcpy(constant1->u.val,"1");	
			if(place!=NULL)
				insertAssignLOP(place, constant1);	//code2		
			insertLabel(label2);//label2
			return exp;//!
		}break;
		case TOKEN_PLUS:
		case TOKEN_MINUS:
		case TOKEN_STAR:
		case TOKEN_DIV: {
			Operand t1= newTemp(tempCount++);
			Operand t2= newTemp(tempCount++);
			exp = Exp(q, t1);
			if (r == NULL)	return NULL;
			exp1 = Exp(r, t2);
			//判断exp与exp1是否都为int或float
			if (exp->type->kind != BASIC || exp1->type->kind != BASIC || exp->type->u.basic != exp1->type->u.basic)//!
			{
				printf("Error type %d at Line %d: Type mismatched for operands.\n", 7, q->next->line);
				return newVar(false);
			}

			/*数组相关，确认是否需要添加这一项*/
			if(t1->kind == ADDR)
			{
				Operand tmpl = newTemp(tempCount++);
				tmpl->kind = AddrVarNo;
				tmpl->u = t1->u;
				t1 = tmpl;
			}
			if(t2->kind == ADDR)
			{
				Operand tmpl = newTemp(tempCount++);
				tmpl->kind = AddrVarNo;
				tmpl->u = t2->u;
				t2 = tmpl;
			}
			int kind=-1;
			if(q->next->nodetype==TOKEN_PLUS)
				kind=11;//ADD
			else if(q->next->nodetype==TOKEN_MINUS)
				kind=12;//SUB
			else if(q->next->nodetype==TOKEN_STAR)
				kind=13;//MUL
			else if(q->next->nodetype==TOKEN_DIV)
				kind=14;//DIV
			
			if(place!=NULL&&kind!=-1)
			{
				if(t1->kind==CONST&&t2->kind==CONST)
				{	
					char *outcome=(char*)malloc(40);
					place->kind=CONST;
					if(exp->type->u.basic==0)
					{
						int out=atoi(t1->u.val);
						switch(kind)
						{
							case 11:out=out+atoi(t2->u.val);break;
							case 12:out=out-atoi(t2->u.val);break;
							case 13:out=out*atoi(t2->u.val);break;
							case 14:out=Floor(out/atof(t2->u.val));break;
							default: break;
						}
						outcome=int2char(out);
					}
					else if(exp->type->u.basic==1)
					{
						float out=atof(t1->u.val);
						switch(kind)
						{
							case 11:out=out+atof(t2->u.val);break;
							case 12:out=out-atof(t2->u.val);break;
							case 13:out=out*atof(t2->u.val);break;
							case 14:out=out/atof(t2->u.val);break;
							default: break;
						}
						sprintf(outcome,"lf",out);
					}
					place->u.val=outcome;
				}
				else
					insertBinop(place, t1, t2, kind);
			}
			VarObject* tmp = newVarObject(0);
			tmp->type->u.basic = exp->type->u.basic;//0或者1
			//tmp->u.value计算
			tmp->lvalue = false;
			return tmp;
		}break;
		case TOKEN_LB: {
			Operand leftExp = newTemp(tempCount++);
			Operand rightExp = newTemp(tempCount++);
			exp = exp = Exp(q, leftExp);
			if (exp->type->kind != ARRAY)//判断exp是否为数组型
			{
				printf("Error type %d at Line %d: \"%s\" is not an array.\n", 10, q->next->line, exp->name);
				return exp;//不为数组，直接返回该变量
			}
			if (r == NULL)	return NULL;
			exp1 = Exp(r,rightExp);
			if (exp1->type->kind != BASIC || exp1->type->u.basic != 0)//判断exp1是否为int型
			{
				printf("Error type %d at Line %d: The number in %s \"[]\" is not an integer.\n", 12, q->next->line, exp->name);//报错12
				//虽然不是整数，但还是要返回数组中的类型
			}
			if (r->next == NULL)	return NULL;	//RB
			VarObject* tmp = newVar(true);
			tmp->name = exp->name;//名字为多维数组的名字 ?; 用不用判断数组越界？
			tmp->type = exp->type->u.array.elem;
			tmp->lvalue = true;
			
			
			/*数组相关，确认是否需要添加这一项*/
			if(rightExp->kind == ADDR)
			{
				Operand tmpl = newTemp(tempCount++);
				tmpl->kind = AddrVarNo;
				tmpl->u = rightExp->u;
				rightExp = tmpl;
			}
			int sizelen = 4;
			if(exp->type->kind!=BASIC) 
				sizelen = computeSize(exp->type->u.array.elem);
			Operand constop = (Operand)malloc(sizeof(Operand_));
			constop->kind=1;//CONST
			//constop->u.val= itoa(sizelen);
			constop->u.val = int2char(sizelen);
			char* nameofplace = trans(place);
			//printf("place kind %d, no=%d", place->kind, place->u.no);
			//place->u.val=nameofplace;
			place->kind = ADDR;
			Operand newright = NULL;

			//优化：简化两个实数的情况
			if(rightExp->kind == 1)//CONST
			{
				newright = newTemp(tempCount);
				newright->kind = 1;
				newright->u.val = int2char(sizelen * atoi(rightExp->u.val));
			}
			else
			//原来
			{
				newright = newTemp(tempCount++);
				insertBinop(newright, constop, rightExp, 13);//MUL
			}
			
			//优化：如果是0就直接不加了
			if(leftExp->kind==ADDR || leftExp->kind == AddrParam)//表示前面已经是地址
			{
				/*if(newright->kind == 1 && atoi(newright->u.val) == 0)
				{
					place->u = leftExp->u;
					//place->kind=AddrVarName;//直接获取变量名
					
				}
				else//补充上place = leftExp + sizelen*exp1.val;
				{
					insertBinop(place, leftExp, newright, 11);//ADD
				}*/
				insertBinop(place, leftExp, newright, 11);//ADD
			}
			else
			{
				//补充上place=&leftExp + sizelen*exp1.val
				Operand tmpvar = newTemp(tempCount++);
				tmpvar->kind = PointVar;
				tmpvar->u.val = leftExp->u.val;
				//insertGetAddrOrPointer(tmpvar, leftExp, 17);//getaddr
				place->kind = ADDR;
				insertBinop(place, tmpvar, newright, 11);//ADD
				//printf("And still %d\n\n\n", place->u.no);
			}

			return tmp;
		}break;
		case TOKEN_DOT: {//要求3.1, 不予考虑
			//判断exp是否为结构体，是则返回该结构体中的域
			if (exp->type->kind != STRUCTURE)
			{
				printf("Error type %d at Line %d: Illegal use of \".\".\n", 13, q->next->line);
				return newVar(true);
			}
			//判断ID是否是该结构体中的域,写函数
			Type fieldType = NULL;
			fieldType=CheckInStructure(exp->type, r->value);
			if (fieldType == NULL)
			{
				printf("Error type %d at Line %d: Non-existent field of \"%s\".\n", 14, q->next->line, r->value);
				return newVar(true);
			}
			VarObject* tmp = newVar(true);
			tmp->name = r->value;
			tmp->type = fieldType;
			tmp->lvalue = true;
			return tmp;

		}break;
		default:break;//printf("error!\n");
		}
	}
	else if (q->nodetype == TOKEN_LP)
	{
		//表示（exp）
		return Exp(q->next, place);
	}
	else if (q->nodetype == TOKEN_MINUS)//需要判断是否为int或者float--未进行 11.16
	{
		//表示exp-> -exp
		Operand t1= newTemp(tempCount++);
		VarObject* right = Exp(q->next, t1);
		if (right->type->kind != BASIC)//!
		{
			printf("Error type %d at Line %d: Type mismatched for operands.\n", 7, q->line);
			return newVar(false);
		}
		Operand constant=(Operand)malloc(sizeof(struct Operand_));
		constant->kind=CONST;
		constant->u.val=(char*)malloc(2);
		strcpy(constant->u.val,"0");
		if(place!=NULL)
			insertBinop(place, constant, t1, 12);//SUB
		right->lvalue = false;
		return right;
	}
	else if (q->nodetype == TOKEN_NOT)//需要判断是否为int--未进行 11.16 
	{
		Operand label1=newLabel(labelCount++);
		Operand label2=newLabel(labelCount++);
		Operand constant=(Operand)malloc(sizeof(struct Operand_));
		constant->kind=CONST;
		constant->u.val=(char*)malloc(2);
		strcpy(constant->u.val,"0");	
		if(place!=NULL)
			insertAssignLOP(place, constant);//code0
		VarObject* right=translate_Cond(p, label1, label2);//!
		insertLabel(label1);//label1
		Operand constant1=(Operand)malloc(sizeof(struct Operand_));
		constant1->kind=CONST;
		constant1->u.val=(char*)malloc(2);
		strcpy(constant1->u.val,"1");	
		if(place!=NULL)
			insertAssignLOP(place, constant1);	//code2		
		insertLabel(label2);//label2
		//表示exp-> ！exp
		right->lvalue = false;
		return right;
	}
	else if (q->nodetype == TOKEN_ID)
	{
		VarObject* tmp = NULL;
		//TODO：检查符号表中是否有该ID，是否已经定义; 接下来可能是ID(Args)或者ID()
		if (q->next)
		{
			//从函数表中获取该name(函数名)对应的信息，利用返回值构建tmp
			VarObject* vexist = CheckInValHashTable(q->value, false);
			if (vexist != NULL)
			{
				printf("Error type %d at Line %d: \"%s\" is not a function.\n", 11, q->line, q->value);
				vexist->lvalue=true;
				return vexist;
			}
			FuncObject* fexist = CheckInFuncHashTable(q->value);
			if (fexist == NULL)
			{
				printf("Error type %d at Line %d: Undefined function \"%s\".\n", 2, q->line, q->value);
				return newVar(false);
			}
			if (q->next->next->nodetype == TYPE_Args)
			{
				//ID（Args）,得到参数列表
				int index = 1;
				vector *args = CreateVector();
				args->last = args;
				
				OperandList* Arg_list=(OperandList*)malloc(sizeof(OperandList));//头节点
				Arg_list->op=NULL;
				Arg_list->next=NULL;
				Args(q->next->next, args, index, Arg_list);//code1
				//检查参数列表类型是否符合符号表
				int nonequal = 0;
				if (args->last->index != fexist->args->last->index)
					nonequal = 1;
				else
				{
					vector* p = args->next;
					vector* pf = fexist->args->next;
					while (p && pf)
					{
						bool equal = typeEqual(p->val->type, pf->val->type);
						if (!equal)
						{
							nonequal = 1; break;
						}
						p=p->next; pf=pf->next;
					}
				}
				if (nonequal && strcmp(fexist->name,"write")==1)
				{
					printf("Error type %d at Line %d: Function \"%s\" is not applicable for arguments.\n", 9, q->line, q->value);
					//return newVar(false);  出错时还是返回原来函数的返回类型
				}
				if(strcmp(fexist->name,"write")==0)
				{
					insertWritefunc(Arg_list->next->op);//arg[1]
					//printf("%d\n", Arg_list->next->op->kind);
					//assert(false);
				}
				else
				{
					OperandList* p=Arg_list->next;
					while(p!=NULL)
					{
						Operand arg=p->op;
						if(arg!=NULL)
						{
							insertFuncArgs(arg);
						}
							
						p=p->next;
					}
					if(place == NULL)
						place = newTemp(tempCount++);
					insertCall(place, fexist->name);
				}
			}
			else
			{
				//ID(), 检查ID是否是函数以及参数是否正确
				if (fexist->args->last->val != NULL)
				{
					printf("Error type %d at Line %d: Function \"%s\" is not applicable for arguments.\n", 9, q->line, q->value);
					//return newVar(false);  出错时还是返回原来函数的返回类型
				}
				//lab3
				if(place == NULL)
					place = newTemp(tempCount++);
				if(strcmp(fexist->name,"read")==0)
					insertReadfunc(place);
				else
					insertCall(place, fexist->name);
			}
			tmp = (VarObject*)malloc(sizeof(VarObject));
			//lab3 数组
			tmp->isParam = false;

			//tmp->name=NULL;
			tmp->type = fexist->rtype;
			tmp->lvalue = false;
			return tmp;
		}
		else //从变量表中获取该name(变量名)对应的信息, 构建tmp
		{
			VarObject* vexist = CheckInValHashTable(q->value, false);
			if (vexist == NULL)
			{
				printf("Error type %d at Line %d: Undefined variable \"%s\".\n", 1, q->line, q->value);
				return newVar(true);;
			}
			place->kind=VAR;
			place->u.val=q->value;		
			if(vexist->isParam && vexist->type->kind != BASIC)
				place->kind=AddrParam;
			tmp = vexist;
			tmp->lvalue = true;
			return tmp;
		}
		return tmp;
	}
	else if (q->nodetype == TOKEN_INT || q->nodetype == TOKEN_FLOAT)
	{
		VarObject* tmp = newVarObject(0);
		if (q->nodetype == TOKEN_INT)
			tmp->type->u.basic = 0;
		else
			tmp->type->u.basic = 1;
		if(place!=NULL)
		{
			place->kind=CONST;
			place->u.val=q->value;
		}
		tmp->lvalue = false;
		return tmp;
	}
}

void Args(TreeNode* p, vector* args, int index, OperandList* Arg_list)
{
	if (p->firstChild && p->firstChild->nodetype == TYPE_Exp)
	{
		Operand t1= newTemp(tempCount++);
		VarObject* arg = Exp(p->firstChild, t1);
		vector* vitem = (vector*)malloc(sizeof(vector));
		vitem->index = index;
		vitem->val = arg;
		vitem->next = vitem->last = NULL;
		//将arg加入到args中
		args->last->next = vitem;
		args->last = vitem;
		
		OperandList* Arg=(OperandList*)malloc(sizeof(OperandList));

		/*数组相关，确认是否需要添加这一项*/
			if(t1->kind == ADDR)
			{
				Operand tmpl = newTemp(tempCount++);
				tmpl->kind = AddrVarNo;
				tmpl->u = t1->u;
				t1 = tmpl;
			}
			else if (t1->kind == AddrParam)
			{
				;
			}
			else if(arg->type->kind != BASIC)
			{
				Operand tmpl = newTemp(tempCount++);
				tmpl->kind = PointVar;
				tmpl->u = t1->u;
				t1 = tmpl;
			}

		Arg->op=t1;
		Arg->next=Arg_list->next;
		Arg_list->next=Arg;
	}
	if (p->lastChild && p->lastChild->nodetype == TYPE_Args)
	{
		Args(p->lastChild, args, index + 1, Arg_list);//接着添加下一个参数
	}

}

//lab3
VarObject* translate_Cond(TreeNode* p, Operand labelTrue, Operand labelFalse)
{
	if (p == NULL)	return NULL;
	TreeNode *q = p->firstChild;//Exp1
	if (q->nodetype == TYPE_Exp)
	{
		TreeNode *r=q->next, *s=q->next->next;//relop, Exp2
		switch (r->nodetype)//match or not, important
		{
		case TOKEN_RELOP: {
			Operand t1= newTemp(tempCount++);
			Operand t2= newTemp(tempCount++);
			VarObject* exp1=Exp(q,t1);
			VarObject* exp2=Exp(s,t2);	
			if(exp1==NULL||exp2==NULL) return NULL;

			/*数组相关，确认是否需要添加这一项*/
			if(t1->kind == ADDR)
			{
				Operand tmpl = newTemp(tempCount++);
				tmpl->kind = AddrVarNo;
				tmpl->u = t1->u;
				t1 = tmpl;
			}
			if(t2->kind == ADDR)
			{
				Operand tmpl = newTemp(tempCount++);
				tmpl->kind = AddrVarNo;
				tmpl->u = t2->u;
				t2 = tmpl;
			}
			
			insertGotoLabelTrue(t1, t2, labelTrue, r->value);
			insertGotoLabel(labelFalse);
			if (exp1->type->kind != BASIC || exp2->type->kind != BASIC || exp1->type->u.basic != exp2->type->u.basic)
			{
				//错误7 操作符类型不匹配
				printf("Error type %d at Line %d: Type mismatched for operands.\n", 7, r->line);
				return newVar(false);
			}
			VarObject* tmp = newVarObject(0);
			tmp->type->u.basic = 0;
			tmp->lvalue = false;
			return tmp;

		}break;
		case TOKEN_AND: {
			Operand label1=newLabel(labelCount++);
			VarObject* exp1=translate_Cond(q, label1, labelFalse);
			insertLabel(label1);
			VarObject* exp2=translate_Cond(s, labelTrue, labelFalse);
			if(exp1==NULL||exp2==NULL) return NULL;
			if ((exp1->type->kind != BASIC || exp1->type->u.basic != 0) || (exp2->type->kind != BASIC || exp2->type->u.basic != 0))
			{
				//错误7 操作符类型不匹配
				printf("Error type %d at Line %d: Type mismatched for operands.\n", 7, r->line);
				return newVar(false);
			}
			VarObject* tmp = newVarObject(0);
			tmp->type->u.basic = 0;
			tmp->lvalue = false;
			//计算tmp->value
			return tmp;

		}break;
		case TOKEN_OR: {
			Operand label1=newLabel(labelCount++);
			VarObject* exp1=translate_Cond(q, labelTrue, label1);
			insertLabel(label1);
			VarObject* exp2=translate_Cond(s, labelTrue, labelFalse);
			if(exp1==NULL||exp2==NULL) return NULL;
			if ((exp1->type->kind != BASIC || exp1->type->u.basic != 0) || (exp2->type->kind != BASIC || exp2->type->u.basic != 0))
			{
				//错误7 操作符类型不匹配
				printf("Error type %d at Line %d: Type mismatched for operands.\n", 7, r->line);
				return newVar(false);
			}
			VarObject* tmp = newVarObject(0);
			tmp->type->u.basic = 0;
			tmp->lvalue = false;
			//计算tmp->value
			return tmp;
		}break;
		default: break;
		}
	}
	else if(q->nodetype == TOKEN_NOT)
	{
		TreeNode* r=q->next;//Exp1
		VarObject* exp1=translate_Cond(r, labelFalse, labelTrue);
		if(exp1==NULL) return NULL;
		if(exp1->type->kind != BASIC || exp1->type->u.basic != 0)
		{
			//错误7 操作符类型不匹配
			printf("Error type %d at Line %d: Type mismatched for operands.\n", 7, q->line);
			return newVar(false);
		}
		exp1->lvalue = false;
		return exp1;
	}
	else
	{
		Operand t1= newTemp(tempCount++);

			/*数组相关，确认是否需要添加这一项*/
		if(t1->kind == ADDR)
		{
			Operand tmpl = newTemp(tempCount++);
			tmpl->kind = AddrVarNo;
			tmpl->u = t1->u;
			t1 = tmpl;
		}
			
		VarObject* object=Exp(p,t1);
		Operand constant=(Operand)malloc(sizeof(struct Operand_));
		constant->kind=CONST;
		constant->u.val=(char*)malloc(2);
		strcpy(constant->u.val,"0");
		insertGotoLabelTrue(t1, constant, labelTrue,"!=");
		insertGotoLabel(labelFalse);
		return object;
	}
}


