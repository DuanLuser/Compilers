#include "intermediateCode.h"

InterCodes *head=NULL, *tail=NULL;

void insertInterCode(InterCodes *code)
{
	if(code==NULL) return;
	if(tail==NULL)
	{
		head=tail=code;
	}
	else
	{
		tail->next=code;
		code->prev=tail;
		tail=code;
	}
}

void deleteCode(InterCodes *code)
{
	if(code==NULL || head==NULL) return;
	if(code==head && code==tail)
	{
		head=tail=NULL;
	}
	else if(code==head)
	{
		head=head->next;
		head->prev=NULL;
	}
	else
	{
		InterCodes *p = code->prev;
		p->next=code->next;
		if(code->next!=NULL)
			code->next->prev=p;
	}
	free(code);
}

void FindtoDelete(InterCodes *Code, int tempno)
{
	InterCodes *p=Code->prev;
	while(p!=NULL)
	{
		if(p->code.kind==9)
		{
			Operand l1=	p->code.u.assign.left;
			if(l1->kind==3&&l1->u.no==tempno)
				deleteInterCode(p);// tempvar := op1
		}
		else if(p->code.kind>10&&p->code.kind<15)
		{
			Operand l1=	p->code.u.binop.result;
			if(l1->kind==3&&l1->u.no==tempno)				
				deleteInterCode(p);// tempvar := op1 [+-*/] op2 
		}
		p=p->prev;
	}
}

void deleteInterCode(InterCodes *Code)
{
	InterCodes *p=NULL;
	if(Code->code.kind==9)
	{
		Operand l=Code->code.u.assign.left;
		Operand r=Code->code.u.assign.right;
		if(l->kind==0&&r->kind==3)//var := tempvar
		{
			int tempno=r->u.no;
			FindtoDelete(Code, tempno);
		}
	}
	else if((Code->code.kind>10&&Code->code.kind<15))
	{
		Operand result=Code->code.u.binop.result;
		Operand o1=Code->code.u.binop.op1;
		Operand o2=Code->code.u.binop.op2;
		if(result->kind!=3) return;
		if(o1->kind==3)
		{
			int tempno=o1->u.no;
			FindtoDelete(Code, tempno);	
		}	
		if(o2->kind==3)
		{
			int tempno=o2->u.no;
			FindtoDelete(Code, tempno);	
		}	
	}
	deleteCode(Code);
}


void deleteInterCodes()
{
	while(head!=NULL)
	{
		InterCodes *p = head;
		head=head->next;
		free(p);
	}
}

Operand newLabel(int no)
{
	Operand label=(Operand)malloc(sizeof(struct Operand_));
	label->kind=LABEL;
	label->u.no=no;
	return label;
}

Operand newTemp(int no)
{
	Operand temp=(Operand)malloc(sizeof(struct Operand_));
	temp->kind=TEMPVAR;
	temp->u.no=no;
	return temp;
}

int sizeofString(char *str)
{
	int len=0;
	while(str[len]!='\0')
		len++;
	return len;
}

int computeSize(Type type)
{
	if(type->kind==BASIC) 
		return 4;
	else if(type->kind==ARRAY)
		return type->u.array.size * computeSize(type->u.array.elem);
	else if(type->kind==STRUCTURE)
	{
		int size=0;
		FieldList field=type->u.structure;
		while(field)
		{
			size+=computeSize(field->type);
			field=field->tail;
		}
		return size;
	}
	return 0;
}


void insertFuncName(char* funcName)
{
	Operand func = (Operand)malloc(sizeof(Operand_));
	func->kind = FUNC;
	func->u.val=funcName;
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=FUNCTION;
	Code->code.u.single.op=func;
	insertInterCode(Code);
}

void insertFuncParam(char* paramName)
{
	Operand param = (Operand)malloc(sizeof(Operand_));
	param->kind = VAR;
	param->u.val=paramName;
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=PARAM;
	Code->code.u.single.op=param;
	insertInterCode(Code);
}

void insertFields(char* name,int size)//for array and structure
{
	Operand op = (Operand)malloc(sizeof(Operand_));
	op->kind = VAR;
	op->u.val=name;
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=DEC;
	Code->code.u.dec.op=op;
	Code->code.u.dec.size=size;
	insertInterCode(Code);
}

void insertReturn(Operand op)
{
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=RETURN;
	Code->code.u.single.op=op;
	insertInterCode(Code);
}

void insertAssignLID(char *leftName, Operand right)
{
	Operand left = (Operand)malloc(sizeof(Operand_));
	left->kind=VAR;
	left->u.val=leftName;
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=ASSIGN;
	Code->code.u.assign.left=left;
	Code->code.u.assign.right=right;
	insertInterCode(Code);
}

void insertAssignLOP(Operand left, Operand right)
{
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=ASSIGN;
	Code->code.u.assign.left=left;
	Code->code.u.assign.right=right;
	insertInterCode(Code);
}

void insertGotoLabelTrue(Operand op1, Operand op2, Operand labelTrue, char relop[])
{
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=IFGOTO;
	Code->code.u.triop.op1=op1;
	Code->code.u.triop.op2=op2;
	Code->code.u.triop.label=labelTrue;
	strcpy(Code->code.u.triop.relop, relop);
	insertInterCode(Code);
}

void insertGotoLabel(Operand label)
{
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=GOTO;
	Code->code.u.single.op=label;
	insertInterCode(Code);
}

void insertLabel(Operand label)
{
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=CLABEL;
	Code->code.u.single.op=label;
	insertInterCode(Code);
}

void insertBinop(Operand result, Operand op1, Operand op2, int kind)
{
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=kind;//
	Code->code.u.binop.result=result;
	Code->code.u.binop.op1=op1;
	Code->code.u.binop.op2=op2;
	insertInterCode(Code);
}

void insertReadfunc(Operand place)
{
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=READ;//
	Code->code.u.single.op=place;
	if(place)
		insertInterCode(Code);
}

void insertCall(Operand place, char* funcName)
{
	Operand func = (Operand)malloc(sizeof(Operand_));
	func->kind = FUNC;
	func->u.val=funcName;
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=CALL;
	Code->code.u.assign.left=place;//NULL时输出需要额外处理
	Code->code.u.assign.right=func;
	insertInterCode(Code);
}

void insertWritefunc(Operand op)
{
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=WRITE;//
	Code->code.u.single.op=op;
	insertInterCode(Code);
}

void insertFuncArgs(Operand arg)
{
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=ARG;
	Code->code.u.single.op=arg;
	insertInterCode(Code);
}

void insertGetAddrOrPointer(Operand result, Operand op1, int kind)
{
	InterCodes *Code = (InterCodes*)malloc(sizeof(InterCodes));
	Code->prev=Code->next=NULL;
	Code->code.kind=kind;//
	Code->code.u.assign.left=result;
	Code->code.u.assign.right=op1;
	insertInterCode(Code);
}

char* trans(Operand op)
{
	switch (op->kind)
	{
		case 0:{return op->u.val;};break;
		case 1:{int len=sizeofString(op->u.val);
				char* result=malloc(len+2);
				strcpy(result, "#");
				strcat(result, op->u.val);
				return result;};break;
		case 2:
		case 3:{char* result=malloc(30);
				strcpy(result, "myvar");
				char* buffer = malloc(sizeof(char) * 30);
				sprintf(buffer,"%d",op->u.no);
				strcat(result, buffer);
				return result;};break;
		case 4:{char* result=malloc(30);
				strcpy(result, "mylabel");
				char* buffer = malloc(sizeof(char) * 30);
				sprintf(buffer,"%d",op->u.no);
				strcat(result, buffer);
				//printf("\n\n%s\n\n\n", result);
				return result;};break;
		case 5:{return op->u.val;};break;
		case 6:{char* result=malloc(30);
				strcpy(result, "*myvar");
				char* buffer = malloc(sizeof(char) * 30);
				sprintf(buffer,"%d",op->u.no);
				strcat(result, buffer);
				return result;};break;//AddrVarNo加上*
		case 7:{char* result=malloc(30);
				strcpy(result, "&");
				strcat(result, op->u.val);
				return result;};break;//加上&
		case 8:{return op->u.val;};break;
		case 9:{char* result=malloc(30);
				strcpy(result, "*");
				strcat(result, op->u.val);
				return result;};break;//AddrVarName加上*
	default:
		break;
	}
}

void printInterCodes(FILE *fw)
{
	InterCodes* tmp = head;
	while(tmp != NULL)
	{
		//printf("\nline code\n");
		InterCode code = tmp->code;
		switch (code.kind)
		{
		case DEC:{fprintf(fw,"DEC %s %d\n", trans(code.u.dec.op), code.u.dec.size);};break;
		case CLABEL:{fprintf(fw,"LABEL %s :\n", trans(code.u.single.op));};break;
		case FUNCTION:{fprintf(fw,"FUNCTION %s :\n",trans(code.u.single.op));};break;
		case GOTO:{fprintf(fw,"GOTO %s\n",trans(code.u.single.op));};break;
		case RETURN:{fprintf(fw,"RETURN %s\n",trans(code.u.single.op));};break;
		case ARG:{fprintf(fw,"ARG %s\n",trans(code.u.single.op));};break;
		case PARAM:{fprintf(fw,"PARAM %s\n",trans(code.u.single.op));};break;
		case READ:{fprintf(fw,"READ %s\n",trans(code.u.single.op));};break;
		case WRITE:{fprintf(fw,"WRITE %s\n",trans(code.u.single.op));};break;
		case ASSIGN:{if(code.u.assign.left == NULL || code.u.assign.right ==NULL)printf("now begin\n\n");
			//printf("kind=%d, kind=%d\n", code.u.assign.left->kind, code.u.assign.right->kind);
			fprintf(fw,"%s := %s\n",trans(code.u.assign.left), trans(code.u.assign.right));};break;
		case CALL:{fprintf(fw,"%s := CALL %s\n",trans(code.u.assign.left), trans(code.u.assign.right));};break;
		case ADD:{fprintf(fw,"%s := %s + %s\n",trans(code.u.binop.result),trans(code.u.binop.op1), trans(code.u.binop.op2));};break;
		case SUB:{fprintf(fw,"%s := %s - %s\n",trans(code.u.binop.result),trans(code.u.binop.op1), trans(code.u.binop.op2));};break;
		case MUL:{fprintf(fw,"%s := %s * %s\n",trans(code.u.binop.result),trans(code.u.binop.op1), trans(code.u.binop.op2));};break;
		case DIV:{fprintf(fw,"%s := %s / %s\n",trans(code.u.binop.result),trans(code.u.binop.op1), trans(code.u.binop.op2));};break;
		case IFGOTO:{fprintf(fw,"IF %s %s %s GOTO %s\n",trans(code.u.triop.op1),code.u.triop.relop,trans(code.u.triop.op2),trans(code.u.triop.label));};break;
		case getaddr:{fprintf(fw,"%s = &%s\n", trans(code.u.assign.left), trans(code.u.assign.right));};break;
		case getpointer:{fprintf(fw,"%s = *%s\n", trans(code.u.assign.left), trans(code.u.assign.right));};break;//16, 17,represent result=&op1, result=*op1
		case pointto:{fprintf(fw,"*%s = %s\n", trans(code.u.assign.left), trans(code.u.assign.right));};break;
		
		default:
			break;
		}
		tmp = tmp->next;
	}
}


//优化  删除没用到的赋值语句，直接计算常数
bool valEqual(char *name, Operand x)
{
	if((x->kind>1&&x->kind<5)||x->kind==6)
		return false;
	if(!strcmp(name,x->u.val))
		return true;
	return false;
}

void deleteRedundantAssign()
{
	InterCodes *p=head;
	while(p!=NULL)
	{
		if(p->code.kind!=ASSIGN&&(p->code.kind<11||p->code.kind>14))// var := ...
		{
			p=p->next;continue;
		}
		char* varName=NULL;
		if(p->code.kind==ASSIGN&&p->code.u.assign.left->kind==0)
			varName=p->code.u.assign.left->u.val;
		else if(p->code.u.binop.result->kind==0)
			varName=p->code.u.binop.result->u.val;
		if(varName==NULL)
		{	
			p=p->next;continue;	
		}
		InterCodes *q=p->next;
		int flag=0;	//是否用到了该变量名
		while(q!=NULL)
		{
			if(q->code.kind>0&&q->code.kind<9)
			{
				flag=1;break;
			}
			else if((q->code.kind>8&&q->code.kind<11)||q->code.kind>15)
			{
				if(q->code.kind==10||valEqual(varName,q->code.u.assign.right))
				{
					flag=1;break;
				}
				else if(valEqual(varName,q->code.u.assign.left)&&flag==0)
				{
					InterCodes *r=p;
					p=p->next;
					deleteInterCode(r);
					flag=2;break;
				}
			}
			else if(q->code.kind>10&&q->code.kind<15)
			{
				if(valEqual(varName,q->code.u.binop.op1)||valEqual(varName,q->code.u.binop.op2))
				{
					flag=1;break;
				}
				else if(valEqual(varName,q->code.u.binop.result)&&flag==0)
				{
					InterCodes *r=p;
					p=p->next;
					deleteInterCode(r);
					flag=2;break;
				}
			}
			else if(q->code.kind==15)
			{
					flag=1;break;
			}
			q=q->next;
		}
		if(flag==0)
		{
			InterCodes *r=p;
			p=p->next;
			deleteInterCode(r);
		}
		else if(flag==1)
			p=p->next;
		else if(flag==2)
			p=head;
	}
}















