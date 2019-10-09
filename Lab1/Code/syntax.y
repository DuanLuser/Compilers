%{
	#include "lex.yy.c"
	#include "tree.h"

	extern bool Error;
	extern TreeNode* root;
	//extern int yylineno;
%}

//declared types
%union{
	struct TreeNode* tree_node; //!
}

//declared tokens
%token <tree_node> digit integer letter
%token <tree_node> SPACE TAB LINEBREAK
%token <tree_node> INT FLOAT ID TYPE
%token <tree_node> ASSIGNOP
%token <tree_node> AND OR RELOP PLUS MINUS STAR DIV NOT DOT
%token <tree_node> LP RP LB RB LC RC
%token <tree_node> COMMA SEMI
%token <tree_node> WHILE IF ELSE STRUCT RETURN

//associative property
%right ASSIGNOP
%left OR
%left AND
%left RELOP
%left PLUS MINUS
%left STAR DIV
%right NOT    //MINUS
%left LP RP LB RB DOT
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

//declared non-terminals
%type <tree_node> Program ExtDefList ExtDef
%type <tree_node> Specifier ExtDecList FunDec
%type <tree_node> CompSt VarDec StructSpecifier
%type <tree_node> OptTag DefList Tag
%type <tree_node> VarList ParamDec StmtList
%type <tree_node> Stmt Exp Def
%type <tree_node> DecList Dec Args

%start Program


%%
//High-level Definition
Program	:	ExtDefList 
				{ $$=newNode(@$.first_line,TYPE_Program,"Program","");
		 		root=$$;root->depth=0;insertTree(root,$1); }
	;
ExtDefList	:	ExtDef ExtDefList 
					{ $$=newNode(@$.first_line,TYPE_ExtDefList,"ExtDefList","");
					insertTree($$,$1);insertTree($$,$2); }
	|	/*empty*/ { $$=NULL; }
	;
ExtDef	:	Specifier ExtDecList SEMI 
				{ $$=newNode(@$.first_line,TYPE_ExtDef,"ExtDef","");
				insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	Specifier SEMI 
			{ $$=newNode(@$.first_line,TYPE_ExtDef,"ExtDef","");
			insertTree($$,$1);insertTree($$,$2); }
	|	Specifier FunDec CompSt 
			{ $$=newNode(@$.first_line,TYPE_ExtDef,"ExtDef","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	error SEMI { Error=true; }
	;
ExtDecList	:	VarDec 
					{ $$=newNode(@$.first_line,TYPE_ExtDecList,"ExtDecList","");
					insertTree($$,$1); }
	|	VarDec COMMA ExtDecList 
			{ $$=newNode(@$.first_line,TYPE_ExtDecList,"ExtDecList","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	;

//Specifiers
Specifier	:	TYPE 
					{ $$=newNode(@$.first_line,TYPE_Specifier,"Specifier","");
					insertTree($$,$1); }
	|	StructSpecifier 
			{ $$=newNode(@$.first_line,TYPE_Specifier,"Specifier","");
			insertTree($$,$1); }
	;
StructSpecifier	:	STRUCT OptTag LC DefList RC 
			{ $$=newNode(@$.first_line,TYPE_StructSpecifier,"StructSpecifier","");
						insertTree($$,$1);insertTree($$,$2);insertTree($$,$3);insertTree($$,$4);insertTree($$,$5); }
	|	STRUCT Tag 
			{ $$=newNode(@$.first_line,TYPE_StructSpecifier,"StructSpecifier","");
			insertTree($$,$1);insertTree($$,$2); }
	|	error RC { Error=true; }
	;
OptTag	:	ID 
				{ $$=newNode(@$.first_line,TYPE_OptTag,"OptTag","");
				insertTree($$,$1); }
	|	/*empty*/ { $$=NULL; }
	;
Tag	:	ID 
			{ $$=newNode(@$.first_line,TYPE_Tag,"Tag","");
			insertTree($$,$1); }
	;

//Declarators
VarDec	:	ID 
				{ $$=newNode(@$.first_line,TYPE_VarDec,"VarDec","");
				insertTree($$,$1); }
	|	VarDec LB INT RB 
			{ $$=newNode(@$.first_line,TYPE_VarDec,"VarDec","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3);insertTree($$,$4); }
	|	error RB { Error=true; }
	;
FunDec	:	ID LP VarList RP 
				{ $$=newNode(@$.first_line,TYPE_FuncDec,"FunDec","");
				insertTree($$,$1);insertTree($$,$2);insertTree($$,$3);insertTree($$,$4); }
	|	ID LP RP 
			{ $$=newNode(@$.first_line,TYPE_FuncDec,"FunDec","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	error RP { Error=true; }
	;
VarList	:	ParamDec COMMA VarList 
				{ $$=newNode(@$.first_line,TYPE_VarList,"VarList","");
				insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	ParamDec 
			{ $$=newNode(@$.first_line,TYPE_VarList,"VarList","");
			insertTree($$,$1); }
	;
ParamDec	:	Specifier VarDec 
					{ $$=newNode(@$.first_line,TYPE_ParamDec,"ParamDec","");
					insertTree($$,$1);insertTree($$,$2); }
	;

//Statements
CompSt	:	LC DefList StmtList RC 
				{ $$=newNode(@$.first_line,TYPE_CompSt,"CompSt","");
				insertTree($$,$1);insertTree($$,$2);insertTree($$,$3);insertTree($$,$4); }
	|	error RC { Error=true; }
	;
StmtList	:	Stmt StmtList 
					{ $$=newNode(@$.first_line,TYPE_StmtList,"StmtList","");
					insertTree($$,$1);insertTree($$,$2); }
	|	/*empty*/ { $$=NULL; }
	;
Stmt	:	Exp SEMI 
				{ $$=newNode(@$.first_line,TYPE_Stmt,"Stmt","");
				insertTree($$,$1);insertTree($$,$2); }
	|	CompSt 
			{ $$=newNode(@$.first_line,TYPE_Stmt,"Stmt","");
			insertTree($$,$1); }
	|	RETURN Exp SEMI 
			{ $$=newNode(@$.first_line,TYPE_Stmt,"Stmt","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	IF LP Exp RP Stmt %prec LOWER_THAN_ELSE 
			{ $$=newNode(@$.first_line,TYPE_Stmt,"Stmt","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3);insertTree($$,$4);insertTree($$,$5); }
	|	IF LP Exp RP Stmt ELSE Stmt 
			{ $$=newNode(@$.first_line,TYPE_Stmt,"Stmt","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3);insertTree($$,$4);insertTree($$,$5);insertTree($$,$6);insertTree($$,$7); }
	|	WHILE LP Exp RP Stmt
			{ $$=newNode(@$.first_line,TYPE_Stmt,"Stmt","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3);insertTree($$,$4);insertTree($$,$5); }
	|	error SEMI { Error=true; }
	|	error RP { Error=true; }
	;

//Local Definitions
DefList	:	Def DefList 
				{ $$=newNode(@$.first_line,TYPE_DefList,"DefList","");
				insertTree($$,$1);insertTree($$,$2); }
	|	/*empty*/ { $$=NULL; }
	;
Def	:	Specifier DecList SEMI 
			{ $$=newNode(@$.first_line,TYPE_Def,"Def","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	error SEMI { Error=true; }
	;
DecList	:	Dec 
				{ $$=newNode(@$.first_line,TYPE_DecList,"DecList","");
				insertTree($$,$1); }
	|	Dec COMMA DecList 
			{ $$=newNode(@$.first_line,TYPE_DecList,"DecList","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	;
Dec	:	VarDec 
			{ $$=newNode(@$.first_line,TYPE_Dec,"Dec","");
			insertTree($$,$1); }
	|	VarDec ASSIGNOP Exp 
			{ $$=newNode(@$.first_line,TYPE_Dec,"Dec","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	;

//Expressions
Exp	:	Exp ASSIGNOP Exp 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	Exp AND Exp 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	Exp OR Exp 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	Exp RELOP Exp 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	Exp PLUS Exp 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	Exp MINUS Exp 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	Exp STAR Exp 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	Exp DIV Exp 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	LP Exp RP 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	MINUS Exp 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2); }
	|	NOT Exp 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2); }
	|	ID LP Args RP 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3);insertTree($$,$4); }
	|	ID LP RP 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	Exp LB Exp RB 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3);insertTree($$,$4); }
	|	Exp DOT ID 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");
			insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	|	ID 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp",""); insertTree($$,$1); }
	|	INT 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp",""); insertTree($$,$1); }
	|	FLOAT 
			{ $$=newNode(@$.first_line,TYPE_Exp,"Exp","");insertTree($$,$1); }
	|	Exp LB error RB { Error=true; }
	|	error RP { Error=true; }
	;
Args	:	Exp COMMA Args 
				{ $$=newNode(@$.first_line,TYPE_Args,"Args","");
				insertTree($$,$1);insertTree($$,$2);insertTree($$,$3); }
	| 	Exp 
			{ $$=newNode(@$.first_line,TYPE_Args,"Args","");insertTree($$,$1); }
	;

%%
yyerror(char* msg)  //rewrite
{
	fprintf(stderr,"Error type B at Line %d: %s\n",yylineno,msg);
}	







