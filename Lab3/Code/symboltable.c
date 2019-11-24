#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include"symboltable.h"

#define Length 40

ValHashTable* vtable[tsize];
FuncHashTable* ftable[tsize];

void initSymbolTable()
{
	initHashTable();
	initNameSpace();
}

void initHashTable()
{
	for(int i=0; i<tsize; i++)
	{
		vtable[i] = NULL;
		ftable[i] = NULL;
	}
	//insert the function read() 
	FuncObject *rfunc = (FuncObject*)malloc(sizeof(FuncObject));
	rfunc->name=(char*)malloc(5);
	strcpy(rfunc->name,"read");
	Type type = (Type)malloc(sizeof(Type_));
	type->kind = BASIC;
	type->u.basic = 0;
	rfunc->rtype = type;
	rfunc->args = CreateVector();//CreateVector  头指针
	rfunc->args->last = rfunc->args;//不含参数，标志为 rfunc->args->last->val为NULL
	//insert
	FuncHashTable* fitem = (FuncHashTable*)malloc(sizeof(FuncHashTable));
	fitem->func = rfunc;
	fitem->indexNext = NULL;
	AddToFuncHashTable(fitem);

	//insert write(int x)
	FuncObject *wfunc = (FuncObject*)malloc(sizeof(FuncObject));
	wfunc->name=(char*)malloc(6);
	strcpy(wfunc->name,"write");
	wfunc->rtype = NULL; //写一个整型变量到控制台  or 返回int
	wfunc->args = CreateVector();//CreateVector  头指针
	wfunc->args->last = wfunc->args;
	//构建整型函数参数
	vector* arg1 = (vector*)malloc(sizeof(vector));
	arg1->val = (VarObject*)malloc(sizeof(VarObject));
	arg1->val->name = (char*)malloc(Length * sizeof(char));
	strcpy(arg1->val->name, "arg1");//参数名
	arg1->val->type=type;//参数类型
	arg1->next = arg1->last = NULL;
	wfunc->args->last->next=arg1;
	wfunc->args->last=arg1;
	//insert
	FuncHashTable* fitem1 = (FuncHashTable*)malloc(sizeof(FuncHashTable));
	fitem1->func = wfunc;
	fitem1->indexNext = NULL;
	AddToFuncHashTable(fitem1);
	
}

void freeHashTable()
{
	for(int i=0; i<tsize; i++)
	{
		while(vtable[i] != NULL)
		{
			ValHashTable* cur=vtable[i];
			vtable[i]=vtable[i]->indexNext;
			free(cur);
		}
		while(ftable[i] != NULL)
		{
			FuncHashTable* cur=ftable[i];
			ftable[i]=ftable[i]->indexNext;
			free(cur);
		}
	}
}

unsigned int pjwhash(char *name)
{
	if(name==NULL) return 0;//
	unsigned int val=0, i;
	for(; *name; ++name)
	{
		val = (val<<2) + *name;
		if(i = val & ~0x7fff)
			val = (val ^ (i>>13)) & 0x7fff;
	}
	return val;
}
/*向vtable加入ValHashTable*/
void AddToValHashTable(ValHashTable* item)
{
	if(item == NULL) return;
	unsigned int key = pjwhash(item->val->name);
	ValHashTable* queue = vtable[key];
	if(queue == NULL)
	{
		//插入的位置目前还没有
		item->indexNext = NULL; 
	}
	else
	{
		//插入队首
		item->indexNext = queue;
	}
	vtable[key] = item;
}

/*向Func表中加入fun*/
void AddToFuncHashTable(FuncHashTable* item)
{
	if(item == NULL) return;
	unsigned int key = pjwhash(item->func->name);
	FuncHashTable* queue = ftable[key];
	if(queue == NULL)
		item->indexNext = NULL;
	else
	{
		item->indexNext = queue;
	}
	ftable[key] = item;
}
/*检查是否符号表中已经有了这个变量,true用于定义位置检查，false用于使用位置检查； return NULL表示没找到*/
VarObject* CheckInValHashTable(char* name, bool strict)
{
	unsigned int key = pjwhash(name);
	ValHashTable* queue = vtable[key];
	if(queue == NULL)
		return NULL;
	while(queue != NULL)
	{
		char* find = queue->val->name;
		if(find && strcmp(name, find) == 0)
		{
			if(strict)
			{
				//printf("depth:%d, CurDept:%d\n",queue->depth, CurrentDept);
				if(queue->depth == CurrentDept)
					return queue->val;
				else
					return NULL;
			}
			else
			{
				return queue->val;
			}
		}
		queue = queue->indexNext;
	}
	return NULL;
}

/*检查变量是否与结构体名相同*/
VarObject* CheckInVtableForStruct(char* name)
{
	unsigned int key = pjwhash(name);
	ValHashTable* queue = vtable[key];
	if(queue == NULL)
		return NULL;
	while(queue != NULL)
	{
		char* find = queue->val->name;
		if(find && strcmp(name, find) == 0)
		{
			if(queue->val->type->kind==STRUCTURE)
			{
				char *stname=queue->val->type->u.structure->name;
				if(stname && strcmp(find, stname) == 0)
					return queue->val;
			}
		}
		queue = queue->indexNext;
	}
	return NULL;
}

FuncObject* CheckInFuncHashTable(char* name)
{
	unsigned int key = pjwhash(name);
	FuncHashTable* queue = ftable[key];
	if(queue == NULL)
		return NULL;
	while(queue != NULL)
	{
		char* find = queue->func->name;
		if(strcmp(name, find) == 0)
		{
			return queue->func;
		}
		queue = queue->indexNext;
	}
	return NULL;
}

void initNameSpace()
{
	NameSpace = (NameFieldStruct*)malloc(sizeof(NameFieldStruct));
	NameSpace->deep = 0;
	NameSpace->size = 0;
	NameSpace->items = NULL;
	NameSpace->next = NULL;
	CurrentDept = 0;
}

/*展开新的作用域*/
void CreateNewSpace()
{
	CurrentDept++;
	NameFieldStruct* newSpace = (NameFieldStruct*)malloc(sizeof(NameFieldStruct));
	newSpace->deep = CurrentDept;
	newSpace->size = 0;
	newSpace->items = NULL;
	//添加到首部
	newSpace->next = NameSpace;
	NameSpace = newSpace;
}

void AddToNameSpace(ValHashTable* item)
{
	if(item == NULL) return;
	NameSpace->size++;
	item->fieldNext = NameSpace->items;
	NameSpace->items = item;
}

/*将语句块中的变量名全部去掉*/
void FreeThisNameSpace()
{
	if(CurrentDept == 0)
		return;/*printf("Wrong! delete the first namespace in FreeThisNameSpace in symboltable.c\n");*/

	NameFieldStruct* p = NameSpace;
	NameSpace = NameSpace->next;
	ValHashTable* items = p->items;
	for(int i = 0; i < p->size; i++)
	{
		ValHashTable* tmp = items;
		items = items->fieldNext;
		ToolDeleteValHashTable(tmp);
	}
	free(p);
	CurrentDept--;
}

void AddToSymbolTable(VarObject* item)
{
	if(item == NULL) return;
	ValHashTable* table_item = (ValHashTable*)malloc(sizeof(ValHashTable));
	table_item->val = item;
	table_item->depth = CurrentDept;
	AddToValHashTable(table_item);
	AddToNameSpace(table_item);
}




/*Tool开头是工具*/
void ToolDeleteValHashTable(ValHashTable* item)
{
	char* name = item->val->name;
	unsigned int key = pjwhash(name);
	ValHashTable *queue = vtable[key];
	if(queue == item)
	{	/*第一个*/
		if(CurrentDept != item->depth)
			return;/*;printf("Wrong in ToolDeleteValHashTable in symboltable.c");*/
		free(item);//.
		vtable[key] = NULL;
	}
	else
	{	/*不在第一个*/
		while(queue != NULL && queue->indexNext != item)
		{
			queue = queue->indexNext;
		}
		if(queue == NULL)
			return;/*printf("Can't Find！Wrong in ToolDeleteValHashTable in symboltable.c");*/
		queue->indexNext = item->indexNext;
		free(item);//.
	}
	/*printf("Begin Delete ValHashTable!");*/

}

/*
void ToolFreeType(Type type)
{
	switch (type->kind)
	{
	case BASIC:
		free(type);
		break;
	case ARRAY:
		{ToolFreeType(type->u.array.elem); free(type);}
		break;
	case STRUCTURE:
		{ToolFreeFieldList(type->u.structure); free(type);}
		break;
	default:
		return;//printf("Wrong in FreeType in symboltable.c");
		break;
	}
}

void ToolFreeFieldList(FieldList flist)
{
	Type type = flist->type;
	char* name = flist->name;
	free(name);
	free(type);
	ToolFreeFieldList(flist->tail);
}

void ToolFreeVarObject(VarObject* item)
{
	char*name = item->name;
	free(name);
	ToolFreeType(item->type);
	free(item);
}*/
