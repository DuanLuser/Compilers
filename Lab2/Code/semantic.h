#ifndef SEMANTIC_H
#define SEMANTIC_H

typedef struct Type_* Type;
typedef struct FieldList_* FieldList;

struct Type_
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
};

struct FieldList_
{
	char *name;	// name of the field
	Type type;	// type of the field
	FieldList tail;	// next field
};

typedef struct ValHashTable
{
	int depth;
	char *name;	// char name[33];
	Type type;	// variable-type (pointer-level 1)
	// for linking
	struct ValHashTable *indexNext;	// same index after hashing
	struct ValHashTable *fieldNext;	// same field in the syntax tree
} ValHashTable;

typedef struct FuncHashTable
{
	char *name;	// char name[33];
	Type rtype;	// function-return type (pointer-level 1)
	// for parameter
	int num;	// number of function parameters
	Type *vtype;	// types of parameters (pointer-level 2); name doesn't matter
	// for linking
	struct FuncHashTable *indexNext;	// same index after hashing
} FuncHashTable;

#endif


