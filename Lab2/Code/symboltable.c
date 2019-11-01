#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include"symboltable.h"

ValHashTable* vtable[tsize];
FuncHashTable* ftable[tsize];

void initHashTable()
{
	for(int i=0; i<tsize; i++)
	{
		vtable[i] = NULL;
		ftable[i] = NULL;
	}
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
	unsigned int val=0, i;
	for(; *name; ++name)
	{
		val = (val<<2) + *name;
		if(i = val & ~0x3fff)
			val = (val ^ (i>>12)) & 0x3fff;
	}
	return val;
}

//向vtable加入ValHashTable
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

//向Func表中加入fun
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
//检查是否符号表中已经有了这个变量,strict表示严格要求匹配当前深度 return NULL表示没找到
VarObject* CheckInValHashTable(char* name, bool strict)
{
	unsigned int key = pjwhash(name);
	ValHashTable* queue = vtable[key];
	if(queue == NULL)
		return NULL;
	while(queue != NULL)
	{
		char* find = queue->val->name;
		if(strcmp(name, find) == 0)
		{
			if(strict)
			{
				//if(queue->depth == CurrentDept)
				//	return queue->val;
				//else
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

FuncObject* CheckInFuncHashTable(char* name)
{
	unsigned int key = pjwhash(name);
	FuncHashTable* queue = vtable[key];
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

