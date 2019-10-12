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

#endif 
