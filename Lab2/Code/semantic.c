#include "tree.h"
#include "semantic.h"

#define tsize 16384

ValHashTable* vtable[tsize];
FuncHashTable* ftable[tsize];

void initHashTable()
{
	for(int i=0; i<tsize; i++)
	{
		vtable[i]=NULL;
		ftable[i]=NULL;
	}
}

void freeHashTable()
{
	for(int i=0; i<tsize; i++)
	{
		while(vtable[i]!=NULL)
		{
			ValHashTalbe* cur=vtable[i];
			vtable[i]=vtable[i]->indexNext;
			free(cur);
		}
		while(ftable[i]!=NULL)
		{
			FuncHashTalbe* cur=ftable[i];
			ftable[i]=ftable[i]->indexNext;
			free(cur);
		}
	}
}

unsigned int pjwhash(char *name)
{
	unsigned int val=0, i;
	for(; *name; ++name)
	{
		val = (val<<2) + *name;
		if(i = val & ~0x3fff)
			val = (val ^ (i>>12)) & 0x3fff;
	}
	return val;
}

void traverseTree(TreeNode* root)
{
	
}




