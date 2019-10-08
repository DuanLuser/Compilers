#include "tree.h"

TreeNode* newNode(int line,char name[],char value[])
{
	TreeNode *newone=(TreeNode*)malloc(sizeof(TreeNode));
	newone->line=line;
	strcpy(newone->name,name);
	strcpy(newone->value,value);
	newone->parent=NULL;
	newone->firstChild=NULL;
	newone->next=NULL;
	newone->lastChild=NULL;
	return newone;
}

void insertTree(TreeNode* cur,TreeNode* p)
{
	if(cur!=NULL&&p!=NULL)
	{
	/*
		printf("%s ,%d \n",cur->Name,cur->Depth);
		p->Depth=cur->Depth+1;
		printf("%s ,%d ",p->Name,p->Depth);
	*/
		if(cur->firstChild==NULL)
		{
			cur->firstChild=p;
			cur->lastChild=p;
		}
		else
		{
			cur->lastChild->next=p;
			cur->lastChild=p;
		}
		p->parent=cur;
	}
	return;
}

void computeDepth(TreeNode* node)
{
	if(node!=NULL)
	{
		TreeNode* p=node->firstChild;
		while(p)
		{
			p->depth=node->depth+1;
			computeDepth(p);
			p=p->next;
		}	
	}
	return;
}

void printTree(TreeNode* node)
{
	TreeNode* p=node;
	while(p!=NULL)
	{
		for(int i=0;i<p->depth;i++)
			printf("  ");
		if(!strcmp(p->value,""))
			printf("%s (%d)\n",p->name,p->line);
		else if(!strcmp(p->name,"TYPE")||!strcmp(p->name,"ID")||!strcmp(p->name,"INT")||!strcmp(p->name,"FLOAT"))
			printf("%s: %s\n",p->name,p->value);
		else
			printf("%s\n",p->name);
		printTree(p->firstChild);
		p=p->next;
	}
	return;	
}

void deleteTree(TreeNode* root)
{
	if(root!=NULL)
	{
		deleteTree(root->next);
		deleteTree(root->firstChild);
		free(root);
	}
	return;
}

