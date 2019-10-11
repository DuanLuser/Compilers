#include "tree.h"
//extern FILE* yyin;

extern int yylineno;
extern int yyparse();
extern void yyrestart(FILE*);

int main(int argc, char** argv)
{
	if(argc<=1)  return 1;
	FILE* f=fopen(argv[1],"r");
	if(!f)
	{
		perror(argv[1]);
		return 1;
	}
	//initialize
	Error=false;
	root=NULL;
	yylineno=1;

	yyrestart(f);
	yyparse();
	if(!Error) //no error, output the syntax tree
	{
		computeDepth(root);
		printTree(root);
	}
	deleteTree(root);
	return 0;
}
