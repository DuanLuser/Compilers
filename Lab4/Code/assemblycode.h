#ifndef ASSEMBLYCODE_H
#define ASSEMBLYCODE_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>
#include <string.h>

#include "const.h"
#include"intermediateCode.h"

typedef struct VarDescriptor{
	char* key;  //变量名
	int offset;  //内存中的值 
    int reg_no; //在reg中的编号
    int type; // type=0表示未使用; type=1表示在寄存器中且未溢出到内存过; type=2表示在内存中;type=3,表示在寄存器中且溢出到内存过
    struct VarDescriptor* next;
}VarDescriptor; 

extern VarDescriptor* OperandInfor[tsize];
void putVarDescriptor(VarDescriptor* item);//加入或者更新
VarDescriptor* getItemFromVarDescriptor(char* keychar);//返回找到的


typedef struct RegDescriptor
{
    bool used;
    int lastest_line_number;
    Operand varOperand;
}RegDescriptor;

extern RegDescriptor Regs[REG_SIZE];//REG_SIZE 18
extern int regs_Current;//表示已经在使用的有多少个
extern int line_Count;

void initReg();
void printAssemblyCodes(FILE *fw);

int replaceReg(FILE *fw);
char* RegName(int reg_no);
void putVarDescriptor(VarDescriptor* item);
VarDescriptor* getItemFromVarDescriptor(char* keychar);
char* get_reg(Operand op, FILE *fw);

#endif
