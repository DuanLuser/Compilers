#ifndef INTERMEDIATECODE_H
#define INTERMEDIATECODE_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct Operand_* Operand;

typedef struct Operand_
{
	enum { VAR, CONST, ADDR, TEMPVAR, LABEL, FUNC } kind;
	union {
		int no;
		char *val;//func, const, var
		Operand addr;
	} u;
} Operand_;

typedef struct InterCode
{
	enum { DEC, //0
		   CLABEL, FUNCTION, GOTO, RETURN, ARG, PARAM, READ, WRITE,
		   ASSIGN, CALL,
		   ADD, SUB, MUL, DIV, //11, 12, 13, 14
		   IFGOTO
	} kind;
	union {
		struct { Operand op; int size; } dec;
		struct { Operand op; } single;
		struct { Operand right, left; } assign;
		struct { Operand result, op1, op2; } binop;
		struct { 
				 Operand op1,op2,label; 
				 char relop[3];
		} triop;
	} u;
} InterCode;

typedef struct InterCodes
{
	InterCode code;
	struct InterCodes *prev, *next;
} InterCodes;

typedef struct OperandList
{
	Operand op;
	struct OperandList *next;
} OperandList;

void insertInterCode(InterCodes *code);
void deleteInterCode(InterCodes *code);
void deleteInterCodes();
Operand newLabel(int no);
Operand newTemp(int no);
int computeSize(Type type);
void insertFuncName(char* funcName);
void insertFuncParam(char* paramName);
void insertFields(char* name,int size);
void insertReturn(Operand op);
void insertAssignLID(char *leftName, Operand right);
void insertAssignLOP(Operand left, Operand right);
void insertGotoLabelTrue(Operand op1, Operand op2, Operand labelTrue, char relop[]);
void insertGotoLabel(Operand label);
void insertLabel(Operand label);
void insertBinop(Operand result, Operand op1, Operand op2, int kind);
void insertReadfunc(Operand place);
void insertCall(Operand place, char* funcName);
void insertWritefunc(Operand op);
void insertFuncArgs(Operand arg);

#endif

