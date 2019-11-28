#include "tree.h"
#include "semantic.h"

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
	FILE* fw=fopen(argv[2],"w");
	if(!fw)
	{
		perror(argv[2]);
		return 1;
	}
	//initialize
	ErrorLex=false;
	ErrorSyn=false;
	root=NULL;
	yylineno=1;

	yyrestart(f);
	yyparse();
	if(!ErrorLex&&!ErrorSyn) //no error, output the syntax tree
	{
		computeDepth(root);
		//initHashTable(); 
		traverseTree(root);
		printInterCodes(fw);
	}
	//printTree(root);
	deleteTree(root);
	return 0;
}
