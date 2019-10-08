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
TYPE  int|float
LP  "("
RP  ")"
LB  "["
RB  "]"
LC  "{"
RC  "}"
SPACE  " "
TAB  "\t"
LINEBREAK  "\n"|"\r"
STRUCT  struct
RETURN  return
IF  if
ELSE  else
WHILE  while
INT  [+-]?{integer}
FLOAT  [+-]?(({integer}\.?)|({integer}?\.{digit}+))f?
ID  {letter}({letter}|{digit})*

%%
{SEMI}	{ yylval.tree_node=newNode(yylineno,"SEMI",yytext); return SEMI; }
{COMMA}	{ yylval.tree_node=newNode(yylineno,"COMMA",yytext); return COMMA; }
{ASSIGNOP}	{ yylval.tree_node=newNode(yylineno,"ASSIGNOP",yytext); return ASSIGNOP; }
{RELOP}	{ yylval.tree_node=newNode(yylineno,"RELOP",yytext); return RELOP; }
{PLUS}	{ yylval.tree_node=newNode(yylineno,"PLUS",yytext); return PLUS; }
{MINUS}	{ yylval.tree_node=newNode(yylineno,"MINUS",yytext); return MINUS; }
{STAR}	{ yylval.tree_node=newNode(yylineno,"STAR",yytext); return STAR; }
{DIV}	{ yylval.tree_node=newNode(yylineno,"DIV",yytext); return DIV; }
{AND}	{ yylval.tree_node=newNode(yylineno,"AND",yytext); return AND; }
{OR}	{ yylval.tree_node=newNode(yylineno,"OR",yytext); return OR; }
{DOT}	{ yylval.tree_node=newNode(yylineno,"DOT",yytext); return DOT; }
{NOT}	{ yylval.tree_node=newNode(yylineno,"NOT",yytext); return NOT; }
{TYPE}	{ yylval.tree_node=newNode(yylineno,"TYPE",yytext); return TYPE; }
{LP}	{ yylval.tree_node=newNode(yylineno,"LP",yytext); return LP; }
{RP}	{ yylval.tree_node=newNode(yylineno,"RP",yytext); return RP; }
{LB}	{ yylval.tree_node=newNode(yylineno,"LB",yytext); return LB; }
{RB}	{ yylval.tree_node=newNode(yylineno,"RB",yytext); return RB; }
{LC}	{ yylval.tree_node=newNode(yylineno,"LC",yytext); return LC; }
{RC}	{ yylval.tree_node=newNode(yylineno,"RC",yytext); return RC; }
{STRUCT}	{ yylval.tree_node=newNode(yylineno,"STRUCT",yytext); return STRUCT; }
{RETURN}	{ yylval.tree_node=newNode(yylineno,"RETURN",yytext); return RETURN; }
{IF}	{ yylval.tree_node=newNode(yylineno,"IF",yytext); return IF; }
{ELSE}	{ yylval.tree_node=newNode(yylineno,"ELSE",yytext); return ELSE; }
{WHILE}	{ yylval.tree_node=newNode(yylineno,"WHILE",yytext); return WHILE; }
{INT}	{ yylval.tree_node=newNode(yylineno,"INT",yytext); return INT; }
{FLOAT}	{ yylval.tree_node=newNode(yylineno,"FLOAT",yytext); return FLOAT; }
{ID}	{ yylval.tree_node=newNode(yylineno,"ID",yytext); return ID; }
{SPACE}|{TAB}	{}
{LINEBREAK}	{ yycolumn=1; }
.	{Error=true; printf("Error type A at line %d: Mysterious character \"%s\"\n",yylineno,yytext); }

%%

