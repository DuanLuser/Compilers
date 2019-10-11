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
	char name[33];  // 32+1
	char value[40]; // 39+1
	struct TreeNode* parent;
	struct TreeNode* firstChild;
	struct TreeNode* next;
	struct TreeNode* lastChild;

}TreeNode;

extern bool Error;

extern TreeNode* root;
extern TreeNode* newNode(int line,enum NodeType tp,char name[],char value[]);
extern void insertTree(TreeNode* cur,TreeNode* p);
extern void computeDepth(TreeNode* node);
extern void printTree(TreeNode* node);
extern void deleteTree(TreeNode* root);

#endif


