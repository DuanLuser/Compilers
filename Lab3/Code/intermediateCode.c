#include"symboltable.h"
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

void deleteInterCode(InterCodes *code)
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





