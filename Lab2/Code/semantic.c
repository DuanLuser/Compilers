#include "tree.h"
#include "semantic.h"
#include <assert.h>

#define Length 40

int globalDepth=0;
//FieldList structure中的structure需要提前分配空间

void traverseTree(TreeNode* root)
{
	initHashTable();
	globalDepth=0;
	Program(root);
}

void ErrorGenerator(char* str)
{
	printf("%s", str);
	assert(0);
}


/*(1) High-level Definitions*/
void Program(TreeNode* root) //Done
{
	if(root==NULL)	return;
	ExtDefList(root->firstChild);
}

void ExtDefList(TreeNode* p) //Done
{
	if(p==NULL)	return;
	ExtDef(p->firstChild);
	ExtDefList(p->firstChild->next);
}

void ExtDef(TreeNode* p) //not Done-> the last "CompSt(q->next->next);"
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	if(!q || q->nodetype != TYPE_Specifier) return; //the first must be "Specifier"

	Type specifier=Specifier(q);
	vector *extdeclist=NULL;
	FuncObject *fundec=NULL;
	if(q->next && q->next->nodetype == TYPE_ExtDecList)
	{
		ExtDecList(q->next,specifier, extdeclist);//这样可以修改extdeclist
		//specifier + extdeclist 插入vtable--while循环,depth为globalDepth
		//此情况若specifier为结构体，OptTag可以为NULL
		while(extdeclist)
		{
			ValHashTable *vitem=(ValHashTable*)malloc(sizeof(ValHashTable));
			vitem->depth=globalDepth;
			vitem->val=extdeclist->val;// !会不会有指针副作用
			vitem->indexNext=NULL;
			vitem->fieldNext=NULL;
			AddToValHashTable(vitem);//insert
			extdeclist=extdeclist->next;
		}
	}
	else if(q->next && q->next->nodetype == TOKEN_SEMI)
	{
		//结构体，估计为StructSpecifier的返回；不过对于"int;" "float;"需要判断处理
		//插入vtable，depth为globalDepth
		//此情况OptTag一定存在
		ValHashTable *vitem=(ValHashTable*)malloc(sizeof(ValHashTable));
		vitem->depth=globalDepth;
		vitem->val=(VarObject*)malloc(sizeof(VarObject));
		if(specifier->kind!=STRUCTURE)	return; //排除 "int;"  "float;"
		vitem->val->name=(char*)malloc(Length*sizeof(char));
		strcpy(vitem->val->name,specifier->u.structure->name);//赋值结构体名称；则判断结构体是否相同时--名等价
		vitem->val->type=specifier;
		vitem->indexNext=NULL;
		vitem->fieldNext=NULL;
		AddToValHashTable(vitem);//insert
	}
	else if(q->next && q->next->nodetype == TYPE_FuncDec)
	{
		fundec=(FuncObject*)malloc(sizeof(FuncObject));
		fundec->rtype=specifier;
		fundec->args=NULL;
		FunDec(q->next, fundec);
		if(fundec!=NULL)//若重复定义，则会将fundec置NULL
		{
			FuncHashTable* fitem=(FuncHashTable*)malloc(sizeof(FuncHashTable));
			fitem->func=fundec;//!会不会有指针副作用
			fitem->indexNext=NULL;
			AddToFuncHashTable(fitem);//insert
		}
		else
			return;
		if(!q->next->next ||  q->next->next->nodetype != TYPE_CompSt)	return;
		CompSt(q->next->next, specifier);//注意globalDepth的变化，遇到LC则+1,遇到RC则-1，并删除; specifier--rtype
	}
	
	return;
}

void ExtDecList(TreeNode* p, Type specifier, vector *extdeclist)//Done
{
	if(p == NULL) return;
	TreeNode* child = p->firstChild;
	if(child == NULL)
	{
		ErrorGenerator("Find ExtDecList -> NULL");
	}
	if(child->nodetype == TYPE_VarDec)
	{
		Type Array=NULL, ArrayNext=NULL;//用于判断VarDec层，是否第一个便为ID；否则需按照数组处理
		//ExtDecList -> VarDec ExtDecList, and check VarDec all in symbol table
		VarDec(child, specifier, extdeclist, Array, ArrayNext);
	}
	//if ExtDecList-> VarDec COMMA ExtDecList
	if(p->lastChild != NULL && p->lastChild->nodetype == TYPE_ExtDecList)
		ExtDecList(p->lastChild, specifier, extdeclist);
}


/*(2) Specifiers*/  //
Type Specifier(TreeNode* p)//Done
{
	if(p==NULL) return NULL;
	TreeNode* q=p->firstChild;
	if(q && q->nodetype==TOKEN_TYPE)
	{
		Type type=(Type)malloc(sizeof(Type_));
		type->kind=BASIC;
		if(strcmp(q->value,"int")==0)
			type->u.basic=0;
		else
			type->u.basic=1;
		return type;
	}
	else if(q && q->nodetype==TYPE_StructSpecifier)
	{
		return StructSpecifier(q);	
	}
}

Type StructSpecifier(TreeNode* p)//Done
{
	if(p==NULL) return NULL;
	TreeNode* q=p->firstChild;
	if(!q || q->nodetype!=TOKEN_STRUCT) return NULL;
	if(q->next && q->next->nodetype!=TYPE_Tag)
	{
		FieldList st=(FieldList)malloc(sizeof(FieldList_));
		TreeNode* r=NULL;
		if(q->next->nodetype==TYPE_OptTag)
		{
			VarObject* vexist=CheckInValHashTable(q->next->firstChild->value, false);
			FuncObject* fexist = CheckInFuncHashTable(q->next->firstChild->value);
			if(vexist==NULL&&fexist==NULL)
			{
				st->name=(char*)malloc(Length*sizeof(char));
				strcpy(st->name,q->next->firstChild->value);//将OptTag的ID赋给结构体名称
				if(!q->next->next || q->next->next->nodetype!=TOKEN_LC)	return NULL;
				r=q->next->next->next;
			}
			else
			{
				//报错重复定义,可以return ?
				return NULL;
			}
			
		}
		else if(q->next->nodetype==TOKEN_LC)//TYPE_OptTag可以为空，则q->next->nodetype=TOKEN_LC，此时结构体没有名称；则大概率后面为ExtDecList
		{
			st->name=NULL;
			r=q->next->next;
		}
		//经过上述语句，表明已经遇到一个{： 
		globalDepth+=1;
		if(r && r->nodetype==TYPE_DefList)//DefList可能为空 
		{
			st->type==NULL;
			DefList(r, st);	//st为结构体的头
		}
		//if(!r->next || strcmp(r->next->name,"RC")!=0)	return NULL;
		//表明已经遇到一个}： 
		globalDepth-=1;
		
		Type typ=(Type)malloc(sizeof(Type_));
		typ->kind=STRUCTURE;
		typ->u.structure= st;
		return typ;
	}
	else if(q->next && q->next->nodetype==TYPE_Tag) //define variables WITH the defined structure, find
	{
		char name[Length];
		strcpy(name,q->next->firstChild->value);
		//"find type with the name in the vtable"; check error 17
		VarObject* structure=CheckInValHashTable(name, false);//strict先赋值false
		if(structure==NULL)
		{
			//报错结构体未定义
			return NULL;
		}
		return structure->type; 
	}
}

/*(3) Declarators*/

//TODO：传入变量类型，向符号表中加入该变量
//注意这里的VarDec有可能是需要加入，有可能是不用加入而是需要检测的
//总结来说这个实现的是关于VarDec的自动检测加入或自动报错  
void VarDec(TreeNode* p, Type specifier, vector *list, Type Array, Type ArrayNext)//VarDec表示对一个变量的定义,不用考虑index问题 //Done
{
	if(p == NULL) return;
	TreeNode* q = p->firstChild;
	if(q == NULL) return;
	if(q->nodetype == TOKEN_ID)
	{
		//TODO: check TOKEN_ID is in symbol table
		//Add or report error
		//首先check 该变量在同一深度是否已经存在，错误3
		VarObject* exist=CheckInValHashTable(q->value, false);//strict 先赋值为false
		
		VarObject* vexist=CheckInValHashTable(q->value, false);
		FuncObject* fexist = CheckInFuncHashTable(q->value);
		if(vexist==NULL&&fexist==NULL)
		{
			//如果不存在错误，则
			vector* vardec=(vector*)malloc(sizeof(vector));
			vardec->val=(VarObject*)malloc(sizeof(VarObject));
			vardec->val->name=(char*)malloc(Length*sizeof(char));
			strcpy(vardec->val->name,q->value);
			vardec->next=vardec->last=NULL;
			if(Array==NULL)//not array
				vardec->val->type=specifier;
			else
			{
				ArrayNext=specifier;
				vardec->val->type=Array;
			}
			//插入 list
			if(list==NULL)
			{
				list=vardec;
				list->last=vardec;
			}
			else
			{
				list->last->next=vardec;
				list->last=vardec;
			}
		}
		else
		{
			//报错重复定义	,可以return
		}
	}
	else if(q->nodetype == TYPE_VarDec)//类似于数组类型的处理
	{
		//这里可能出现错误 12
		if(q->next->next->nodetype==TOKEN_FLOAT)
		{
			//报错12
			return;
		}
		//如果不存在错误，则	
		int size=atoi(q->next->next->value);
		if(Array==NULL)
		{
			Array=(Type)malloc(sizeof(Type_));
			Array->kind=ARRAY;
			Array->u.array.size=size;
			VarDec(q, specifier, list, Array, Array->u.array.elem);
		}
		else if(ArrayNext==NULL)
		{
			ArrayNext=(Type)malloc(sizeof(Type_));
			ArrayNext->kind=ARRAY;
			ArrayNext->u.array.size=size;
			VarDec(q, specifier, list, Array, ArrayNext->u.array.elem);
		}
	}
	else
	{
		ErrorGenerator("error VarDec-> ?\n");
	}
	
}
//功能：将这个函数声明加入到符号表中。
void FunDec(TreeNode* p, FuncObject *fundec)//Done
{
	if(p == NULL) return;
	TreeNode* funcName = p->firstChild;
	if(funcName == NULL)
	{
		ErrorGenerator("Wrong in FunDec! No children!");
		return;
	}
	fundec->name=(char*)malloc(Length*sizeof(char));
	strcpy(fundec->name,funcName->value);//确定函数名
	VarObject* vexist=CheckInValHashTable(q->next->firstChild->value, false);
	FuncObject* fexist = CheckInFuncHashTable(q->next->firstChild->value);
	if(vexist!=NULL&&fexist!=NULL)
	{
		//报错重复定义
		free(fundec);
		fundec=NULL;
		return;
	}
	TreeNode* funcVars = funcName->next->next;
	if(funcVars->nodetype == TYPE_VarList)
	{
		//说明出现多个参数，将加入符号表的功能要求在VarList中实现
		int index=1; //!
		VarList(funcVars, fundec, index);
	}
}

//实现功能：填充参数列表
void VarList(TreeNode* p, FuncObject *fundec, int index)//Done
{
	if(p == NULL) return;
	if(p->firstChild == p->lastChild)
	{
		//说明是Varist->ParamDec
		ParamDec(p->firstChild, fundec->args, index);
	}
	else
	{
		//说明是VarList->ParamDec COMMA VarList
		ParamDec(p->firstChild, fundec->args, index);
		VarList(p->lastChild, fundec->args, index+1);
	}
	
}

void ParamDec(TreeNode* p, vector* vars, int index)//Done
{
	if(p == NULL) return;
	//TODO:将参数填入vector中
	//主要保存参数的类型，可以不用调用VarDec
	Type specifier=Specifier(p->firstChild);
	Type Array=NULL, ArrayNext=NULL; // 对于函数参数为 int[][]? 按语法表应该是不会出现
	VarDec(p->lastChild, specifier, vars, Array, ArrayNext);
	vars->last->index=index;//对于函数参数：每次都是 单个Specifier + 单个VarDec
}


/*(4) Statements*/ //TO BE CONTINUE
//TODO：在函数块中的{}包围部分，需要考虑作用域的问题
void CompSt(TreeNode* p, Type rtype)
{
	if(p == NULL) return;
	//初步想法：有记录作用域的栈，这个记录作用域的为全局变量，在{}中的作用域就push到最上面
	//这期间调用VarDec之类新加的局部变量都挂在这个作用域上，和书上的图一样
	TreeNode* q = p->firstChild;
	if(q && q->nodetype==TOKEN_LC)
		globalDepth+=1;
	if(q->next && q->next->nodetype==TYPE_DefList)
	{
		DefList(defList);
		TreeNode* stmtList = q->next->next;
		if(stmtList && stmtList->nodetype==TYPE_StmtList)
			StmtList(stmtList, rtype);
	}
	else if(q->next && q->next->nodetype==TYPE_StmtList)
		StmtList(stmtList, rtype);
	
	if(p->lastChild && p->lastChild->nodetype==TOKEN_RC)
		globalDepth-=1;
	
	//TODO：在结束是释放局部变量，pop作用域栈
}

void StmtList(TreeNode* p, Type rtype)
{
	if(p == NULL) return;
	Stmt(p->firstChild, rtype);
	StmtList(p->firstChild->next, rtype);//为null则表明StmtList->Stmt
}

void Stmt(TreeNode* p, Type rtype)
{
	if(p == NULL) return;
	TreeNode* q = p->firstChild;
	VarObject* exp=NULL;
	switch (q->nodetype)
	{
	case TYPE_Exp:
		{ 
			exp=Exp(q); 
		}
		break;
	case TYPE_CompSt:
		{ 
			CompSt(q);
		}
		break;
	case TOKEN_RETURN:
		{/*检查有关return返回值的问题？作用域栈也要保存返回值*/
			exp=Exp(q->next);//获得返回的表达式的值，判断类型是否符合rtype
			if(exp->type->kind!=rtype->kind)//对于数组是不是需要判断维数？结构体采用名等价
			{
				//报错,返回值类型不一致
				return;
			}
			else//进一步确定是否一致
			{
				switch(exp->type->kind)
				{	
				case BASIC:
					{
						
					}break;
				case ARRAY:
					{
						
					}break;
				case STRUCTURE:
					{
						
					}break;
				default:break;
				}
			}
		} 
		break;
	case TOKEN_IF:
		{/*检查有关if的问题？作用域栈也要保存返回值*/
			TreeNode* r=q->next->next;
			exp=Exp(r);
			if(exp->type->kind!=BASIC||exp->type->u.basic!=0)
			{
				//错误7 操作符类型不匹配
			}
			//提取后续的Stmt
			TreeNode* s=r->next->next;
			Stmt(s, rtype);
			if(s->next && s->next->nodetype==TOKEN_ELSE)
				Stmt(s->next->next, rtype)
		
		} 
		break;
	case TOKEN_WHILE:
		{/*检查有关while的问题？作用域栈也要保存返回值*/
			TreeNode* r=q->next->next;
			exp=Exp(r);
			if(exp->type->kind!=BASIC||exp->type->u.basic!=0)
			{
				//错误7 操作符类型不匹配
			}
			//提取后续的Stmt
			Stmt(r->next->next, rtype);
		} 
		break;
	default:
		break;
	}
}


/*(5) Local Definitions*/ 
void DefList(TreeNode* p, FieldList st)// Done
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	if(q==NULL)	return;
	if(q->nodetype==TYPE_Def)
		Def(q, st);
	if(q->next && q->next->nodetype==TYPE_DefList) 
		DefList(q->next, st);
	
}

void Def(TreeNode* p, FieldList st)
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	Type specifier = NULL;
	if(q && q->nodetype==TYPE_Specifier)
		specifier=Specifier(q);
	else
	{
		ErrorGenerator("Wrong in Def-> not Speicifier");
		return;
	}
	if(q->next && q->next->nodetype==TYPE_DecList)
	{
		vector *declist=NULL;
		DecList(q->next,specifier,declist);
		while(declist)//对于类似 int x=5; ?
		{
			ValHashTable *vitem=(ValHashTable*)malloc(sizeof(ValHashTable));
			vitem->depth=globalDepth;
			vitem->val=declist->val;// !会不会有指针副作用
			vitem->indexNext=NULL;
			vitem->fieldNext=NULL;
			AddToValHashTable(vitem);//insert
						
			FieldList field=(FieldList)malloc(sizeof(FieldList_));
			field->name=(char*)malloc(Length*sizeof(char));
			strcpy(field->name, declist->val->name);
			field->type=declist->val->type;
			field->tail=NULL;
			if(st->type==NULL)
			{
				st->type=(Type)malloc(sizeof(Type_));
				st->type->kind=STRUCTURE;
				st->type->u.structure=field;
			}
			else
			{
				FieldList f=st->type->u.structure;
				while(f->tail) f=f->tail;
				f->tail=field;		
			}			
			declist=declist->next;
		}
	}
	//if(!q->next->next || strcmp(q->next->next->name,"SEMI")!=0)	return;
}

void DecList(TreeNode* p, Type specifier, vector *declist)
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	if(q && q->nodetype == TYPE_Dec)
	{
		Dec(q, specifier, declist);
		if(!q->next || q->next->nodetype!=TOKEN_COMMA)	return; 
		if(q->next->next && q->next->next->nodetype==TYPE_DecList) 
			DecList(q->next->next, specifier, declist);
	}
	else
	{
		ErrorGenerator("Wrong in DecList-> Not Dec");
	}
}
//Exp应该返回VarObject类型
void Dec(TreeNode* p, Type specifier, vector *declist)
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	if(q && q->nodetype == TYPE_VarDec)
	{
		Type Array=NULL, ArrayNext=NULL;
		VarDec(q, specifier, declist, Array, ArrayNext);
		if(q->next && q->next->nodetype==TOKEN_ASSIGNOP) 
		{
			/* need to record both sides of the "=" */  //check error 5;
			;
			VarObject* exp=NULL;
			if(q->next->next && q->next->next->nodetype==TYPE_Exp)
			{
				exp=Exp(q->next->next);
				//将exp与declist的最后一个进行类型判断，并可以考虑赋值等操作
			}	
		}
	}	
}


/*(6) Expressions*/  //TO BE CONTINUE
VarObject* Exp(TreeNode* p)//!
{
	if(p==NULL)	return;
	TreeNode* q=p->firstChild;
	if(q==NULL)	return;
	if(q->nodetype == TYPE_Exp)
	{
		VarObject* exp = Exp(q);
		VarObject* exp1=NULL;
		if(q->next==NULL)	return;
		TreeNode* r=q->next->next;
		switch(q->next->nodetype)//match or not, important
		{
		case TOKEN_ASSIGNOP:{
						if(r==NULL)	return;
						exp1=Exp(r);
			}break;
		case TOKEN_AND:		{
						if(r==NULL)	return;
						exp1=Exp(r);					
			}break;
		case TOKEN_OR:		{
						if(r==NULL)	return;
						exp1=Exp(r);
			}break;
		case TOKEN_RELOP:	{
						if(r==NULL)	return;
						exp1=Exp(r);
			}break;
		case TOKEN_PLUS:	{
						if(r==NULL)	return;
						exp1=Exp(r);						
			}break;
		case TOKEN_MINUS:	{
						if(r==NULL)	return;
						exp1=Exp(r);				
			}break;
		case TOKEN_STAR:	{
						if(r==NULL)	return;
						exp1=Exp(r);					
			}break;
		case TOKEN_DIV:		{
						if(r==NULL)	return;
						exp1=Exp(r);					
			}break;
		case TOKEN_LB:		{
						if(r==NULL)	return;
						exp1=Exp(r);		
						if(r->next==NULL)	return;	//RB
			}break;		
		case TOKEN_DOT:		{
						char name[Length];
						if(r->nodetype==TOKEN_ID)
							strcpy(name,r->value);		
			}break;
		default:printf("error!\n");
		}			
	}
	else if(q->nodetype == TOKEN_LP)
	{
		//表示（exp）
		return Exp(q->next);
	}
	else if(q->nodetype == TOKEN_MINUS)
	{
		//表示exp-> -exp
		VarObject* right = Exp(q->next);
		//转成负号返回即可
		//TODO:对right 值操作
		return right;
	}
	else if(q->nodetype == TOKEN_NOT)
	{
		//表示exp-> ！exp
		VarObject* right = Exp(q->next);
		//转成正确的类型返回即可
		//TODO:对right 值操作
		return right;
	}
	else if(q->nodetype == TOKEN_ID)
	{
		char name[Length];
		strcpy(name, q->value);
		VarObject* tmp=NULL;
		//构建常量ID
		//TODO：检查符号表中是否有该ID，是否已经定义
		//接下来可能是ID(Args)或者ID()
		if(q->next)
		{
			//从函数表中获取该name(函数名)对应的信息，利用返回值构建tmp
			
			if(q->next->next->nodetype == TYPE_Args)
			{
				//ID（Args）,得到参数列表
				int index=1;
				vector* args = NULL;
				Args(q->next->next, args, index);
				//检查参数列表类型是否符合符号表
			}
			else
			{
				//ID(), 检查ID是否是函数以及参数是否正确
				
			}
		}
		else //从变量表中获取该name(变量名)对应的信息, 构建tmp
		{
			
		}
		return tmp;
	}
	else if(q->nodetype == TOKEN_INT||q->nodetype == TOKEN_FLOAT)
	{
		VarObject* tmp=(VarObject*)malloc(sizeof(VarObject));
		//构建常量int或float
		tmp->name=NULL;   //没名字
		tmp->type=(Type)malloc(sizeof(Type_));
		tmp->type->kind=BASIC;
		if(q->nodetype == TOKEN_INT)
		{
			tmp->type->u.basic=0;
			//tmp->type->value.intValue=atoi(q->value);
		}
		else
		{
			tmp->type->u.basic=1;
			//tmp->type->value.floatValue=atof(q->value);
		}
		return tmp;
	}
}

void Args(TreeNode* p, vector* args, int index)
{
	if(p->firstChild && p->firstChild->nodetype==TYPE_Exp)
	{
		VarObject* arg = Exp(p->firstChild);
		vector* vitem=(vector*)malloc(sizeof(vector));
		vitem->index=index;
		vitem->val=arg;
		vitem->next=vitem->last=NULL;
		//将arg加入到args中
		if(args==NULL)
		{
			args=vitem;
			args->last=vitem;
		}
		else
		{
			args->last->next=vitem;
			args->last=vitem;
		}
	}
	if(p->lastChild && p->lastChild->nodetype==TYPE_Args)
	{
		Args(p->lastChild, args, index+1);//接着添加下一个参数
	}
	
}


                                   

