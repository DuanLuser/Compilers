%{
    	#include "syntax.tab.h"
	#include "tree.h"
	
	int yycolumn=1;
	#define YY_USER_ACTION \
		yylloc.first_line=yylloc.last_line=yylineno; \
		yylloc.first_column=yycolumn; \
		yylloc.last_column=yycolumn+yyleng-1; \
		yycolumn+=yyleng;
%}

%option yylineno

digit  [0-9]
integer  0|[1-9][0-9]*
letter  [_a-zA-Z]
SEMI  ";"
COMMA  ","
ASSIGNOP  "="
RELOP  ">"|"<"|">="|"<="|"=="|"!="
PLUS  "+"
MINUS  "-"
STAR  "*"
DIV  "/"
AND  "&&"
OR  "||"
DOT  "."
NOT  "!"
LP  "("
RP  ")"
LB  "["
RB  "]"
LC  "{"
RC  "}"
SPACE  " "
TAB  "\t"|"\v"   //
LINEBREAK  "\n"|"\r"|"\f" //
STRUCT  struct
RETURN  return
IF  if
ELSE  else
WHILE  while
TYPE  int|float
INT  [+-]?{integer}
FLOAT  [+-]?(({integer}\.?)|({integer}?\.{digit}+))f?
ID  {letter}({letter}|{digit})*

%%
{SEMI}	{ yylval.tree_node=newNode(yylineno,TOKEN_SEMI,"SEMI",yytext); return SEMI; }
{COMMA}	{ yylval.tree_node=newNode(yylineno,TOKEN_COMMA,"COMMA",yytext); return COMMA; }
{ASSIGNOP}	{ yylval.tree_node=newNode(yylineno,TOKEN_ASSIGNOP,"ASSIGNOP",yytext); return ASSIGNOP; }
{RELOP}	{ yylval.tree_node=newNode(yylineno,TOKEN_RELOP,"RELOP",yytext); return RELOP; }
{PLUS}	{ yylval.tree_node=newNode(yylineno,TOKEN_PLUS,"PLUS",yytext); return PLUS; }
{MINUS}	{ yylval.tree_node=newNode(yylineno,TOKEN_MINUS,"MINUS",yytext); return MINUS; }
{STAR}	{ yylval.tree_node=newNode(yylineno,TOKEN_STAR,"STAR",yytext); return STAR; }
{DIV}	{ yylval.tree_node=newNode(yylineno,TOKEN_DIV,"DIV",yytext); return DIV; }
{AND}	{ yylval.tree_node=newNode(yylineno,TOKEN_AND,"AND",yytext); return AND; }
{OR}	{ yylval.tree_node=newNode(yylineno,TOKEN_OR,"OR",yytext); return OR; }
{DOT}	{ yylval.tree_node=newNode(yylineno,TOKEN_DOT,"DOT",yytext); return DOT; }
{NOT}	{ yylval.tree_node=newNode(yylineno,TOKEN_NOT,"NOT",yytext); return NOT; }
{LP}	{ yylval.tree_node=newNode(yylineno,TOKEN_LP,"LP",yytext); return LP; }
{RP}	{ yylval.tree_node=newNode(yylineno,TOKEN_RP,"RP",yytext); return RP; }
{LB}	{ yylval.tree_node=newNode(yylineno,TOKEN_LB,"LB",yytext); return LB; }
{RB}	{ yylval.tree_node=newNode(yylineno,TOKEN_RB,"RB",yytext); return RB; }
{LC}	{ yylval.tree_node=newNode(yylineno,TOKEN_LC,"LC",yytext); return LC; }
{RC}	{ yylval.tree_node=newNode(yylineno,TOKEN_RC,"RC",yytext); return RC; }
{STRUCT}	{ yylval.tree_node=newNode(yylineno,TOKEN_STRUCT,"STRUCT",yytext); return STRUCT; }
{RETURN}	{ yylval.tree_node=newNode(yylineno,TOKEN_RETURN,"RETURN",yytext); return RETURN; }
{IF}	{ yylval.tree_node=newNode(yylineno,TOKEN_IF,"IF",yytext); return IF; }
{ELSE}	{ yylval.tree_node=newNode(yylineno,TOKEN_ELSE,"ELSE",yytext); return ELSE; }
{WHILE}	{ yylval.tree_node=newNode(yylineno,TOKEN_WHILE,"WHILE",yytext); return WHILE; }
{TYPE}	{ yylval.tree_node=newNode(yylineno,TOKEN_TYPE,"TYPE",yytext); return TYPE; }
{INT}	{ yylval.tree_node=newNode(yylineno,TOKEN_INT,"INT",yytext); return INT; }
{FLOAT}	{ yylval.tree_node=newNode(yylineno,TOKEN_FLOAT,"FLOAT",yytext); return FLOAT; }
{ID}	{ yylval.tree_node=newNode(yylineno,TOKEN_ID,"ID",yytext); return ID; }
{SPACE}|{TAB}	{}
{LINEBREAK}	{ yycolumn=1; }
.	{ Error=true; printf("Error type A at line %d: Mysterious character \"%s\"\n",yylineno,yytext); }

%%

