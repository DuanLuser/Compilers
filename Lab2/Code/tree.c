#include "tree.h"

bool ErrorLex;
bool ErrorSyn;
TreeNode* root;

TreeNode* newNode(int line,enum NodeType tp,char name[],char value[])
{
	TreeNode *newone=(TreeNode*)malloc(sizeof(TreeNode));
	newone->line=line;
	newone->nodetype = tp;
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
	if(cur!=NULL&&p!=NULL)// "p!=NULL" is important !
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
		while(p!=NULL)
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
		if(p->nodetype >= TYPE_INDEX)
			printf("%s (%d)\n", p->name,p->line);
		else if(p->nodetype > TOKEN_TYPE)
			printf("%s\n", p->name);
		else
		{
			if(p->nodetype == TOKEN_INT)
				printf("%s: %d\n", p->name, atoi(p->value));
			else if(p->nodetype == TOKEN_FLOAT)
				printf("%s: %lf\n", p->name, atof(p->value));
			else
				printf("%s: %s\n", p->name, p->value);
		}
		printTree(p->firstChild);
		p=p->next;
	}
	return;	
}

/*void deleteTree(TreeNode* root)
{
	if(root!=NULL)
	{
		deleteTree(root->next);
		deleteTree(root->firstChild);
		free(root);
	}
	return;
}*/

void deleteTree(TreeNode* root)
{
	if(root == NULL)
		return;
	while(root->firstChild != NULL)
	{
		TreeNode* p = root->firstChild;
		root->firstChild = root->firstChild->next;
		deleteTree(p);
	}
	free(root);
	//printf("TO DO Delete Tree\n");
}

