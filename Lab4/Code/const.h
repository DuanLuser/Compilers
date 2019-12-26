#ifndef CONST_H
#define CONST_H
/*
non-terminater begin with "TYPE_"
token begin with "TOKEN_"
*/
enum NodeType{
	TOKEN_INT, TOKEN_FLOAT, TOKEN_ID, TOKEN_TYPE,
	TOKEN_SEMI,TOKEN_COMMA, TOKEN_ASSIGNOP,
	TOKEN_RELOP,TOKEN_PLUS, TOKEN_MINUS,
	TOKEN_STAR, TOKEN_DIV, TOKEN_AND,
	TOKEN_OR, TOKEN_NOT, TOKEN_DOT,
	TOKEN_LP, TOKEN_RP, TOKEN_LB, TOKEN_RB,
	TOKEN_LC, TOKEN_RC, 
	TOKEN_WHILE, TOKEN_IF, TOKEN_ELSE,
	TOKEN_RETURN, TOKEN_STRUCT,

	TYPE_Program, TYPE_ExtDefList, TYPE_ExtDef,
	TYPE_ExtDecList, TYPE_Specifier, TYPE_StructSpecifier,
	TYPE_OptTag, TYPE_Tag,
	TYPE_VarDec, TYPE_FuncDec,
	TYPE_VarList, TYPE_ParamDec,
	TYPE_CompSt, TYPE_StmtList, TYPE_Stmt,
	TYPE_DefList, TYPE_Def,
	TYPE_DecList, TYPE_Dec,
	TYPE_Exp, TYPE_Args
};
/*the follow TYPE_INDEX used to seperate different way to print tree*/
#define TYPE_INDEX 27

/*define the length of float--the value range of float is -3.4e38~3.4e38*/
#define FLOAT_LENGTH 39

/*define the reg descriptor,使用的时候直接用这个作为下标就行*/
#define REG_SIZE 18
enum RegIdentity{
	/*调用者负责保存的栈，函数调用时负责保存*/
	REG_t0, REG_t1, REG_t2, REG_t3,
	REG_t4,REG_t5, REG_t6,
	REG_t7,REG_t8, REG_t9,
	/*被调用者负责保存的栈，使用前须先push保存*/
	REG_s0, REG_s1, REG_s2, REG_s3,
	REG_s4,REG_s5, REG_s6, REG_s7,
	REG_fp,//REG_s8
	REG_a0, REG_a1, REG_a2, REG_a3
};

#endif 
