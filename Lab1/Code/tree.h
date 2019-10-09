#ifndef TREE_H
#define TREE_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include "const.h"

typedef struct TreeNode
{
	int line;
	int depth;
	enum NodeType nodetype;
	char name[33];
	char value[33];
	struct TreeNode* parent;
	struct TreeNode* firstChild;
	struct TreeNode* next;
	struct TreeNode* lastChild;

}TreeNode;

bool Error;

TreeNode* root;
TreeNode* newNode(int line,enum NodeType tp,char name[],char value[]);
void insertTree(TreeNode* cur,TreeNode* p);
void computeDepth(TreeNode* node);
void printTree(TreeNode* node);
void deleteTree(TreeNode* root);

#endif


