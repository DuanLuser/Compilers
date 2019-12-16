#pragma once 
#ifndef SYMBOLTABLE_H
#define STMBOLTABLE_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "vectorList.h"

typedef struct Type_* Type;
typedef struct FieldList_* FieldList;

typedef struct VarObject
{
	char* name;
	Type type; // variable-type (pointer-level 1)
	bool lvalue;
	bool isParam;
} VarObject;

typedef struct FuncObject
{
	char* name;
	Type rtype; // function-return type (pointer-level 1)
	// for parameter, name isn't important
	struct vector* args;
} FuncObject;

typedef struct Type_
{
	enum { BASIC, ARRAY, STRUCTURE } kind;
	union
	{
		// BASIC
		int basic;	// 0-int, 1-float
		// ARRAY
		struct { Type elem; int size; } array;
		// STRUCTURE
		FieldList structure;
	} u;
	//record value of a variable
	/*union
	{
		int intValue;
		float floatValue;
		int* intArray;
		float* floatArray;
	} value;*/
}Type_;

typedef struct FieldList_
{
	char *name;	// name of the field
	Type type;	// type of the field
	FieldList tail;	// next field
}FieldList_;

typedef struct ValHashTable
{
	int depth;
	VarObject* val;
	// for linking
	struct ValHashTable *indexNext;	// same index after hashing
	struct ValHashTable *fieldNext;	// same field in the syntax tree
} ValHashTable;

typedef struct FuncHashTable
{
	FuncObject* func;
	// for linking
	struct FuncHashTable *indexNext;	// same index after hashing
} FuncHashTable;


#define tsize 32768
extern ValHashTable* vtable[tsize];
extern FuncHashTable* ftable[tsize];

extern void initHashTable();
extern void freeHashTable();
extern void AddToValHashTable(ValHashTable* item);
extern void AddToFuncHashTable(FuncHashTable* item);
extern VarObject* CheckInValHashTable(char* name, bool strict);
extern VarObject* CheckInVtableForStruct(char* name);
extern FuncObject* CheckInFuncHashTable(char* name);
extern unsigned int pjwhash(char *name);

//namespace
typedef struct NameFieldStruct NameFieldStruct;
typedef struct NameFieldStruct 
{
	int deep;
	int size;
	ValHashTable*items;
	NameFieldStruct* next;
} namesfield;

/*这里负责有关命名空间的处理*/
//作用域
NameFieldStruct* NameSpace;
unsigned int CurrentDept;
//初始化
extern void initNameSpace();
//展开新的作用域
extern void CreateNewSpace();
//和加入符号表结合使用
extern void AddToSymbolTable(VarObject* item);
//将语句块中的变量名全部去掉
extern void FreeThisNameSpace();
extern void initSymbolTable();


//Tool工具，不重要可不看
extern void ToolDeleteValHashTable(ValHashTable* item);
/*extern void ToolFreeValHashTable(ValHashTable*item);
extern void ToolFreeType(Type type);
extern void ToolFreeFieldList(FieldList flist);
extern void ToolFreeVarObject(VarObject* item);
*/
#endif


