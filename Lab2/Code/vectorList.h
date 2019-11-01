#ifndef VECTORLIST_H
#define VECTORLIST_H
#include "symboltable.h"
#include <malloc.h>

typedef struct vector
{
	int index;//指示函数参数下标的变量，最后一个参数的下标即为总个数
	struct VarObject* val;
	struct vector* next;
	struct vector* last;
} vector;

/*
//建议使用接口，不要自己访问里面的成员
vector* CreateVector();
void FreeVector(vector* vt);
VarObject* GetFirstItem(vector* vt){if(vt->index > 0) return vt->var;else return NULL;}
//void GetLastItem(vector* vt){return vt->last;}
void AddItem(vector* vt, VarObject* item);
VarObject* GetItemByIndex(vector* vt, int index);
bool RemoveItemByIndex(vector* vt, int index);
*/

#endif
