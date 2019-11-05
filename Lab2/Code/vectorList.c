#include "vectorList.h"
#include <malloc.h>
#include <assert.h>
void DebugAssert(char* a)
{
    printf("%s \n", a);
    assert(1 == 2);
}

vector* CreateVector()
{
    vector* p = (vector*)malloc(sizeof(vector));
    p->val = NULL;
    p->next = NULL;
	p->last = NULL;
    p->index = -1;
    return p;
}

void FreeVector(vector* vt)
{
    if(vt->index < 0)
    {
        free(vt);
        return;
    }
    while(vt != NULL)
    {
        vector* tmp = vt;
        vt = vt->next;
        ToolFreeVarObject(tmp->val);
        free(tmp);
    }
}

/*
void AddItem(vector* vt, VarObject* item)
{
    if(vt == NULL || item == NULL) return;
    if(vt->index < 0)
    {
        vt->index = 0;
        vt->val = item;
        vt->last = item;
    }
    else
    {
        vector* last = vt->last;
        vector* nvt = (vector*)malloc(sizeof(vector));
        nvt->val = item;
        nvt->index = last->index + 1;
        nvt->next = NULL;
        nvt->last = item;

        last->next = nvt;
        vt->last = item;
    }
}

VarObject* GetItemByIndex(vector* vt, int index)
{
    if(vt == NULL || index < 0) return NULL;
    for(int i = 0; i < index && vt != NULL; i++)
    {
        vt = vt->next;
    }
    if(vt == NULL)
        DebugAssert("Wrong in GetItemByIndex in vectorList.h");
    return vt->val;
}

bool RemoveItemByIndex(vector* vt, int index)
{
    DebugAssert("TODO: fill the RemoveItemByIndex in vectorList.h");
    if(vt == NULL || index < 0) return false;
    if(0 == index)
    {
        if(vt->index < 0)
            DebugAssert("Out of boundary in RemoveItemByIndex");
        vector* first = vt->next;
        if(first == NULL)
        {
            ;
        }
    }
    else
    {
        /*
	ValHashTable* before = vt->first;
        ValHashTable* current = before->indexNext;
        for(int i = 1; i < index; i++)
        {
            before = before->indexNext;
            current = current->indexNext;
        }
        before->indexNext = current->indexNext;
        if(vt->last == current)
        {
            vt->last = before;
        }
        free(p);///*
    }
    return true;
}*/
