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


/*(1) High-level Definitions*/
void Program(TreeNode* root)
{
	if(root==NULL)	return;
	ExtDefList(root->firstChild);
}

void ExtDefList(TreeNode* p)
{
	if(p==NULL)	return;
	ExtDef(p->firstChild);
	ExtDefList(p->firstChild->next);
}

void ExtDef(TreeNode* p)
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	if(!q || strcmp(q->name,"Specifier")!=0) return; //the first must be "Specifier"
	Specifier(q);
	
	if(q->next && strcmp(q->next->name,"ExtDecList")==0)
		ExtDecList(q->next);
	else if(q->next && strcmp(q->next->name,"FunDec")==0)
	{
		FunDec(q->next);
		if(!q->next->next || strcmp(q->next->next->name,"CompSt")!=0)	return;
		CompSt(q->next->next);
	}
	return;
}


/*(2) Specifiers*/
Type Specifier(TreeNode* p)
{
	if(p==NULL) return NULL;
	TreeNode* q=p->firstChild;
	if(q && strcmp(q->name,"TYPE")==0)
	{
		Type type=(Type)malloc(sizeof(Type_));
		type->kind=BASIC;
		if(strcmp(q->value,"int")==0)
			type->u.basic=0;
		else
			type->u.basic=1;
		return type;
	}
	else if(q && strcmp(q->name,"StructSpecifier")==0)
	{
		return StructSpecifier(q);	
	}
}

Type StructSpecifier(TreeNode* p)
{
	if(p==NULL) return NULL;
	TreeNode* q=p->firstChild;
	if(!q || strcmp(q->name,"STRUCT")!=0) return NULL;
	if(q->next && strcmp(q->next->name,"OptTag")==0) //definition, insert
	{
		Type type=(Type)malloc(sizeof(Type_));
		type->kind=STRUCTURE;
		char name[33]="";
		if(q->next->firstChild!=NULL)//firstChild could be empty
			strcpy(name,q->next->firstChild->value);

		if(!q->next->next || strcmp(q->next->next->name,"LC")!=0)	return NULL;
		TreeNode* r=q->next->next->next;
		if(r && strcmp(r->name,"DefList")==0)
			type=DefList(r,type);
		//if(!r->next || strcmp(r->next->name,"RC")!=0)	return NULL;
		return type;
	}
	else if(q->next && strcmp(q->next->name,"Tag")==0) //define variables WITH the defined structure, find
	{
		char name[33];
		strcpy(name,q->next->firstChild->value);
		Type type= "find type with the name in the vtable";
		return type; 
	}
	
}


/*(3) Declarators*/


/*(4) Statements*/


/*(5) Local Definitions*/
void DefList(TreeNode* p,Type type)
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	if(q==NULL)	return;
	if(strcmp(q->name,"Def")==0)
		Def(q);
	if(q->next && strcmp(q->next->name,"DefList")==0)
		DefList(q->next);
	
}

void Def(TreeNode* p)
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	if(q && strcmp(q->name,"Specifier")==0)
		Specifier(q);
	if(q->next && strcmp(q->next->name,"DecList")==0)
		DecList(q->next);
	//if(!q->next->next || strcmp(q->next->next->name,"SEMI")!=0)	return;
}

void DecList(TreeNode* p)
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	if(q && strcmp(q->name,"Dec")==0)
	{
		Dec(q);
		if(!q->next || strcmp(q->next->name,"COMMA")!=0)	return;
		if(q->next->next && strcmp(q->next->next->name,"DecList")==0)
			DecList(q->next->next);
	}
}

void Dec(TreeNode* p)
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	if(q && strcmp(q->name,"VarDec")==0)
	{
		VarDec(q);
		if(q->next && strcmp(q->next->name,"ASSIGNOP")==0)
		{
			/* need to record both sides of the "=" */
			;
		}
		if(q->next->next && strcmp(q->next->next->name,"Exp")==0)
			Exp(q->next->next);
	}	
}


/*(6) Expressions*/
void Exp(TreeNode* p)//!
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	if(q==NULL)	return;
	if(strcmp(q->name,"Exp")==0)
	{
		Exp(q);
		if(q->next==NULL)	return;
		TreeNode* r=q->next->next;
		switch(q->next->name)//match or not   important
		{
		case "ASSIGNOP":{
						if(r==NULL)	return;
						Exp(r);
			}break;
		case "AND":		{
						if(r==NULL)	return;
						Exp(r);					
			}break;
		case "OR":		{
						if(r==NULL)	return;
						Exp(r);
			}break;
		case "RELOP":	{
						if(r==NULL)	return;
						Exp(r);
			}break;
		case "PLUS":	{
						if(r==NULL)	return;
						Exp(r);						
			}break;
		case "MINUS":	{
						if(r==NULL)	return;
						Exp(r);				
			}break;
		case "STAR":	{
						if(r==NULL)	return;
						Exp(r);					
			}break;
		case "DIV":		{
						if(r==NULL)	return;
						Exp(r);					
			}break;
		case "LB":		{
						if(r==NULL)	return;
						Exp(r);		
						if(r->next==NULL)	return;	//RB
			}break;		
		case "DOT":		{
						char name[33];
						if(strcmp(r->name,"ID"))
							strcpy(name,r->value);		
			}break;
		default:printf("error!\n");
		}			
	}
	else if(strcmp(q->name,"LP")==0)
	{
	
	}
	else if(strcmp(q->name,"MINUS")==0)
	{
	
	}
	else if(strcmp(q->name,"NOT")==0)
	{
	
	}
	else if(strcmp(q->name,"ID")==0)
	{
	
	}
	else if(strcmp(q->name,"INT")==0)
	{
	
	}
	else if(strcmp(q->name,"FLOAT")==0)
	{
	
	}
}

void Args(TreeNode* p)
{

}


void traverseTree(TreeNode* root)
{
	
}


                                   

