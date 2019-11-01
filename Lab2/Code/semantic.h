#ifndef SEMANTIC_H
#define SEMANTIC_H
#include "vectorList.h"
#include "symboltable.h"

extern void traverseTree(TreeNode* root);
extern void ErrorGenerator(char* str);

extern void Program(TreeNode* root);
extern void ExtDefList(TreeNode* p);
extern void ExtDef(TreeNode* p);
extern void ExtDecList(TreeNode* p, Type specifier, vector *extdeclist);
extern Type Specifier(TreeNode* p);
extern Type StructSpecifier(TreeNode* p);
extern void VarDec(TreeNode* p, Type specifier, vector *list, Type Array, Type ArrayNext);
extern void FunDec(TreeNode* p, FuncObject *fundec);
extern void VarList(TreeNode* p, FuncObject *fundec, int index);
extern void ParamDec(TreeNode* p, vector* vars, int index);
extern void CompSt(TreeNode* p, Type rtype);
extern void StmtList(TreeNode* p, Type rtype);
extern void Stmt(TreeNode* p, Type rtype);
extern void DefList(TreeNode* p, FieldList st);
extern void Def(TreeNode* p, FieldList st);
extern void DecList(TreeNode* p, Type specifier, vector *declist);
extern void Dec(TreeNode* p, Type specifier, vector *declist);
extern VarObject* Exp(TreeNode* p);
extern void Args(TreeNode* p, vector* args, int index);


#endif


