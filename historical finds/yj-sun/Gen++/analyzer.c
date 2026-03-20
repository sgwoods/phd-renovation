


/*===================================================================================*/
/* This product produced by sgwoods on Thu Oct  9 14:51:49 1997 from file                     */
/*    /tmp_mnt/proj/seg/team/sgwoods/yj-sun/Gen++/myquery/compound-contain.query using   */
/* the gen++ applications generator, Unknown version                        */
/*                                                                                   */
/*  The cplang applications Generator was developed by Prem Devanbu,                 */
/* of the Artificial Intelligence principles Research Department,   11262            */
/* and Laura Eaves of the Object-Oriented something Group, 59112                     */
/*===================================================================================*/



/*---------------*/
/* FIXED  STUFF  */
/*---------------*/

#include  "Gmainheader.h"
#include  "glistops.h"


#include <malloc.h>

#include  "gexpand.h"
#include  "gunparse.h"

#define MAXDEPTH 1000     /* Max depth of search stack */

#define STRINLEN 512 /* Max length of input string */

#define SPUSH(X) ++pathpos > MAXDEPTH ? printf("\n *****ERROR !!! STACK OVERFLOW !!!!") : pathstack[pathpos] = X 
#define SPOP   --pathpos < 0 ? printf("\n *****ERRROR !! STACK UNDERFLOW !!!") : pathstack[pathpos]



extern char *_Cur_Constr;
extern int _Cur_SpecLine;
extern GNODE _Cur_Node;





extern AXS_HEAD NodeTable[];

/* PD *phead,ptmp;
VD *vtmp; */


typedef int INTEGER;
typedef char *STRING;
typedef float FLOAT;

#if __STDC__ || __cplusplus || c_plusplus
char *GenFixExt(char *fname,char *newend);
#else
char *GenFixExt();
#endif



/******************************************/
/****** Application Specific Stuff ********/
/******************************************/

extern GNODE fileName;

extern GNODE fname;

extern GNODE finish_stmt;

#if __STDC__ || __cplusplus
char * mystrconcat ( char *,char * ) ;
#else
char * mystrconcat ( ) ;
#endif

#if __STDC__ || __cplusplus
char * myitoa ( long int ) ;
#else
char * myitoa ( ) ;
#endif

#if __STDC__ || __cplusplus
char * newname ( char * ) ;
#else
char * newname ( ) ;
#endif

#if __STDC__ || __cplusplus
long int IsHeader ( char * ) ;
#else
long int IsHeader ( ) ;
#endif

#if __STDC__ || __cplusplus
char * newBlock (  ) ;
#else
char * newBlock ( ) ;
#endif

#if __STDC__ || __cplusplus
char * newElem ( char *,char * ) ;
#else
char * newElem ( ) ;
#endif

#if __STDC__ || __cplusplus
char * newFileName ( char * ) ;
#else
char * newFileName ( ) ;
#endif

#if __STDC__ || __cplusplus
char * newControlFileName ( char * ) ;
#else
char * newControlFileName ( ) ;
#endif

#if __STDC__ || __cplusplus
char * newComponentFileName ( char * ) ;
#else
char * newComponentFileName ( ) ;
#endif

#if __STDC__ || __cplusplus
char * newResult ( char * ) ;
#else
char * newResult ( ) ;
#endif

#if __STDC__ || __cplusplus
char * newConstraint (  ) ;
#else
char * newConstraint ( ) ;
#endif
#if __STDC__ || __cplusplus
GNODE DealWithExpression (GNODE TheRootNode);
#else
GNODE DealWithExpression ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithPrimaryExpr (GNODE TheRootNode);
#else
GNODE DealWithPrimaryExpr ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithQuestion (GNODE TheRootNode);
#else
GNODE DealWithQuestion ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithCcast (GNODE TheRootNode);
#else
GNODE DealWithCcast ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithSizeof_E (GNODE TheRootNode);
#else
GNODE DealWithSizeof_E ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithSizeof_T (GNODE TheRootNode);
#else
GNODE DealWithSizeof_T ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithIndex (GNODE TheRootNode);
#else
GNODE DealWithIndex ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithFunCall (GNODE TheRootNode);
#else
GNODE DealWithFunCall ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithUnaryExpr (GNODE TheRootNode);
#else
GNODE DealWithUnaryExpr ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithBinaryExpr (GNODE TheRootNode);
#else
GNODE DealWithBinaryExpr ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithLiteral (GNODE TheRootNode);
#else
GNODE DealWithLiteral ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithNameRef (GNODE TheRootNode);
#else
GNODE DealWithNameRef ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithUnaryCount (GNODE TheRootNode);
#else
GNODE DealWithUnaryCount ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithAssignment (GNODE TheRootNode);
#else
GNODE DealWithAssignment ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithPostInc (GNODE TheRootNode);
#else
GNODE DealWithPostInc ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithPostDec (GNODE TheRootNode);
#else
GNODE DealWithPostDec ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithPreInc (GNODE TheRootNode);
#else
GNODE DealWithPreInc ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithPreDec (GNODE TheRootNode);
#else
GNODE DealWithPreDec ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithStatement (GNODE TheRootNode);
#else
GNODE DealWithStatement ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithGoto (GNODE TheRootNode);
#else
GNODE DealWithGoto ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithLabelStmt (GNODE TheRootNode);
#else
GNODE DealWithLabelStmt ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithContinue (GNODE TheRootNode);
#else
GNODE DealWithContinue ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithBreak (GNODE TheRootNode);
#else
GNODE DealWithBreak ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithSwitch (GNODE TheRootNode);
#else
GNODE DealWithSwitch ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithDo (GNODE TheRootNode);
#else
GNODE DealWithDo ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithFor (GNODE TheRootNode);
#else
GNODE DealWithFor ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithWhile (GNODE TheRootNode);
#else
GNODE DealWithWhile ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithIf (GNODE TheRootNode);
#else
GNODE DealWithIf ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithBlock (GNODE TheRootNode);
#else
GNODE DealWithBlock ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithReturn (GNODE TheRootNode);
#else
GNODE DealWithReturn ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithNullStmt (GNODE TheRootNode);
#else
GNODE DealWithNullStmt ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithExprStmt (GNODE TheRootNode);
#else
GNODE DealWithExprStmt ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithCase (GNODE TheRootNode,GNODE testValue);
#else
GNODE DealWithCase ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithObjectDef (GNODE TheRootNode);
#else
GNODE DealWithObjectDef ();
#endif
#if __STDC__ || __cplusplus
void Transform (GNODE TheRootNode	);
#else
void Transform ();
#endif
#if __STDC__ || __cplusplus
void VariableReference (GNODE TheRootNode	);
#else
void VariableReference ();
#endif
#if __STDC__ || __cplusplus
GNODE LOCSTRING (GNODE TheRootNode,GNODE Suffix);
#else
GNODE LOCSTRING ();
#endif
#if __STDC__ || __cplusplus
void FileFlow (GNODE TheRootNode	);
#else
void FileFlow ();
#endif
#if __STDC__ || __cplusplus
GNODE BlockFirst (GNODE TheRootNode);
#else
GNODE BlockFirst ();
#endif
#if __STDC__ || __cplusplus
GNODE BlockEnd (GNODE TheRootNode);
#else
GNODE BlockEnd ();
#endif
#if __STDC__ || __cplusplus
GNODE FindNext (GNODE TheRootNode,GNODE GivenNext);
#else
GNODE FindNext ();
#endif
#if __STDC__ || __cplusplus
void CompoundFlow (GNODE TheRootNode,GNODE NextLoc,GNODE ContinueLoc,GNODE BreakLoc	);
#else
void CompoundFlow ();
#endif
#if __STDC__ || __cplusplus
void PrintNext (GNODE TheRootNode,GNODE GivenNext	);
#else
void PrintNext ();
#endif
#if __STDC__ || __cplusplus
GNODE DealWithCond (GNODE TheRootNode);
#else
GNODE DealWithCond ();
#endif
#if __STDC__ || __cplusplus
void CondFlow (GNODE TheRootNode,GNODE In,GNODE To,GNODE Fo	);
#else
void CondFlow ();
#endif
#if __STDC__ || __cplusplus
void GatherStatementsInBlock (GNODE TheRootNode	);
#else
void GatherStatementsInBlock ();
#endif
#if __STDC__ || __cplusplus
void GatherSingleStatement (GNODE TheRootNode	);
#else
void GatherSingleStatement ();
#endif
#if __STDC__ || __cplusplus
void GatherContainedStatements (GNODE TheRootNode	);
#else
void GatherContainedStatements ();
#endif
#if __STDC__ || __cplusplus
void StmtFlow (GNODE TheRootNode,GNODE GivenNext,GNODE ContinueLoc,GNODE BreakLoc	);
#else
void StmtFlow ();
#endif


extern GNODE slog;


extern GNODE control;


extern GNODE component;


#if __STDC__ || __cplusplus

GNODE  DealWithExpression (GNODE TheRootNode	)
#else

GNODE DealWithExpression ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, Expression))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithExpression called with node of type %s, not of type %d Expression",WhatType(TheRootNode->node_type),Expression);
	else printf("\n Procedure DealWithExpression called with invalid node  type %d, not of type %d Expression",TheRootNode->node_type,Expression);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(IF...";
_Cur_SpecLine = 64;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna1;
{

GNODE _gna2;
_gna2 = TheRootNode;



_gna1 =  OfType(_gna2,PrimaryExpr);
}

if (_gna1) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 65;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna3;
	_gna3 = DealWithPrimaryExpr (TheRootNode);




	





return (_gna3);
}

}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 68;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna4;
{

GNODE _gna5;
_gna5 = TheRootNode;



_gna4 =  OfType(_gna5,Question);
}

if (_gna4) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 69;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna6;
	_gna6 = DealWithQuestion (TheRootNode);




	





return (_gna6);
}

}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 72;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna7;
{

GNODE _gna8;
_gna8 = TheRootNode;



_gna7 =  OfType(_gna8,Ccast);
}

if (_gna7) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 73;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna9;
	_gna9 = DealWithCcast (TheRootNode);




	





return (_gna9);
}

}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 76;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna10;
{

GNODE _gna11;
_gna11 = TheRootNode;



_gna10 =  OfType(_gna11,Sizeof_T);
}

if (_gna10) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 77;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna12;
	_gna12 = DealWithSizeof_T (TheRootNode);




	





return (_gna12);
}

}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 80;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna13;
{

GNODE _gna14;
_gna14 = TheRootNode;



_gna13 =  OfType(_gna14,Sizeof_E);
}

if (_gna13) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 81;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna15;
	_gna15 = DealWithSizeof_E (TheRootNode);




	





return (_gna15);
}

}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 84;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna16;
{

GNODE _gna17;
_gna17 = TheRootNode;



_gna16 =  OfType(_gna17,Index);
}

if (_gna16) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 85;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna18;
	_gna18 = DealWithIndex (TheRootNode);




	





return (_gna18);
}

}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 88;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna19;
{

GNODE _gna20;
_gna20 = TheRootNode;



_gna19 =  OfType(_gna20,FunCall);
}

if (_gna19) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 89;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna21;
	_gna21 = DealWithFunCall (TheRootNode);




	





return (_gna21);
}

}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 92;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna22;
{

GNODE _gna23;
_gna23 = TheRootNode;



_gna22 =  OfType(_gna23,UnaryExpr);
}

if (_gna22) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 93;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna24;
	_gna24 = DealWithUnaryExpr (TheRootNode);




	





return (_gna24);
}

}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 96;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna25;
{

GNODE _gna26;
_gna26 = TheRootNode;



_gna25 =  OfType(_gna26,BinaryExpr);
}

if (_gna25) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 97;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna27;
	_gna27 = DealWithBinaryExpr (TheRootNode);




	





return (_gna27);
}

}

}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithPrimaryExpr (GNODE TheRootNode	)
#else

GNODE DealWithPrimaryExpr ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, PrimaryExpr))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithPrimaryExpr called with node of type %s, not of type %d PrimaryExpr",WhatType(TheRootNode->node_type),PrimaryExpr);
	else printf("\n Procedure DealWithPrimaryExpr called with invalid node  type %d, not of type %d PrimaryExpr",TheRootNode->node_type,PrimaryExpr);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(IF...";
_Cur_SpecLine = 114;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna28;
{

GNODE _gna29;
_gna29 = TheRootNode;



_gna28 =  OfType(_gna29,Literal);
}

if (_gna28) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 115;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna30;
	_gna30 = DealWithLiteral (TheRootNode);




	





return (_gna30);
}

}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 118;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna31;
{

GNODE _gna32;
_gna32 = TheRootNode;



_gna31 =  OfType(_gna32,NameRef);
}

if (_gna31) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 119;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna33;
	_gna33 = DealWithNameRef (TheRootNode);




	





return (_gna33);
}

}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 122;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna34;
{

GNODE _gna35;
_gna35 = TheRootNode;



_gna34 =  OfType(_gna35,FunCall);
}

if (_gna34) {

_Cur_Constr = "(...";
_Cur_SpecLine = 123;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna36;
	_gna36 = DealWithFunCall (TheRootNode);




	





return (_gna36);
}

}

}
}

}
}
}

}
}
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithQuestion (GNODE TheRootNode	)
#else

GNODE DealWithQuestion ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE testValue;
	GNODE oppositeTest;
	GNODE trueValue;
	GNODE falseValue;
	GNODE retResult;
	GNODE newblock;

  if (!(OfType(TheRootNode, Question))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithQuestion called with node of type %s, not of type %d Question",WhatType(TheRootNode->node_type),Question);
	else printf("\n Procedure DealWithQuestion called with invalid node  type %d, not of type %d Question",TheRootNode->node_type,Question);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<q_true...";
_Cur_SpecLine = 140;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  q_true */
{


GNODE _gna37;	

_gna37 = (GNODE) GetFillers(TheRootNode,"q_true");

 if (_gna37 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 140;
_Cur_Node = _gna37;

{				

  /* EXECUTE ITEM */
{


GNODE _gna38;
	_gna38 = DealWithExpression (_gna37);




	





if (_gna38 != (GNODE) NULL && (GSLOT(_gna38) != (AXS_ENTRY) NULL))
	MarkUsed(_gna38);


trueValue = _gna38;


}

}

 }	  /* Balances if (_gna37 != (GNODE) NULL )*/

} /* Balances GNODE _gna37; */

}

_Cur_Constr = "<q_false...";
_Cur_SpecLine = 141;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  q_false */
{


GNODE _gna39;	

_gna39 = (GNODE) GetFillers(TheRootNode,"q_false");

 if (_gna39 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 141;
_Cur_Node = _gna39;

{				

  /* EXECUTE ITEM */
{


GNODE _gna40;
	_gna40 = DealWithExpression (_gna39);




	





if (_gna40 != (GNODE) NULL && (GSLOT(_gna40) != (AXS_ENTRY) NULL))
	MarkUsed(_gna40);


falseValue = _gna40;


}

}

 }	  /* Balances if (_gna39 != (GNODE) NULL )*/

} /* Balances GNODE _gna39; */

}

_Cur_Constr = "<q_test...";
_Cur_SpecLine = 142;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  q_test */
{


GNODE _gna41;	

_gna41 = (GNODE) GetFillers(TheRootNode,"q_test");

 if (_gna41 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 142;
_Cur_Node = _gna41;

{				

  /* EXECUTE ITEM */
{


GNODE _gna42;
	_gna42 = DealWithExpression (_gna41);




	





if (_gna42 != (GNODE) NULL && (GSLOT(_gna42) != (AXS_ENTRY) NULL))
	MarkUsed(_gna42);


testValue = _gna42;


}

}

 }	  /* Balances if (_gna41 != (GNODE) NULL )*/

} /* Balances GNODE _gna41; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 144;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna43;

_gna43 = (GNODE) gmalloc ();
_gna43->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna43->node_type = 3;

_gna43->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna43 != (GNODE) NULL && (GSLOT(_gna43) != (AXS_ENTRY) NULL))
	MarkUsed(_gna43);


oppositeTest = _gna43;


}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 145;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna44;

_gna44 = (GNODE) gmalloc ();
_gna44->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna44->node_type = 3;

_gna44->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna44 != (GNODE) NULL && (GSLOT(_gna44) != (AXS_ENTRY) NULL))
	MarkUsed(_gna44);


retResult = _gna44;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 147;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna45;

_gna45 = (GNODE) gmalloc ();
_gna45->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna45->node_type = 3;

_gna45->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna45 != (GNODE) NULL)
  if (VALIDTYPE(_gna45->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna45,""); 
  else fprintf(stderr,"\n At line 148 attempt to unparse node of invalid type %d", _gna45->node_type);
else fprintf(stderr,"\n At line 148 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna45;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 149;
_Cur_Node = TheRootNode;
{

GNODE _gna46;


_gna46 = getlocnode(TheRootNode);

_gna45 = (GNODE) GetFillers(_gna46,"line");
}

if (_gna45 != (GNODE) NULL)
  if (VALIDTYPE(_gna45->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna45,""); 
  else fprintf(stderr,"\n At line 149 attempt to unparse node of invalid type %d", _gna45->node_type);
else fprintf(stderr,"\n At line 149 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Not "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna45;
_gna45 = (GNODE) testValue;

if (_gna45 != (GNODE) NULL)
  if (VALIDTYPE(_gna45->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna45,""); 
  else fprintf(stderr,"\n At line 150 attempt to unparse node of invalid type %d", _gna45->node_type);
else fprintf(stderr,"\n At line 150 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna45;
_gna45 = (GNODE) oppositeTest;

if (_gna45 != (GNODE) NULL)
  if (VALIDTYPE(_gna45->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna45,""); 
  else fprintf(stderr,"\n At line 151 attempt to unparse node of invalid type %d", _gna45->node_type);
else fprintf(stderr,"\n At line 151 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 153;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna47;

_gna47 = (GNODE) gmalloc ();
_gna47->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna47->node_type = 3;

_gna47->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna47 != (GNODE) NULL)
  if (VALIDTYPE(_gna47->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna47,""); 
  else fprintf(stderr,"\n At line 154 attempt to unparse node of invalid type %d", _gna47->node_type);
else fprintf(stderr,"\n At line 154 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna47;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 155;
_Cur_Node = TheRootNode;
{

GNODE _gna48;


_gna48 = getlocnode(TheRootNode);

_gna47 = (GNODE) GetFillers(_gna48,"line");
}

if (_gna47 != (GNODE) NULL)
  if (VALIDTYPE(_gna47->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna47,""); 
  else fprintf(stderr,"\n At line 155 attempt to unparse node of invalid type %d", _gna47->node_type);
else fprintf(stderr,"\n At line 155 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (If "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna47;
_gna47 = (GNODE) testValue;

if (_gna47 != (GNODE) NULL)
  if (VALIDTYPE(_gna47->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna47,""); 
  else fprintf(stderr,"\n At line 156 attempt to unparse node of invalid type %d", _gna47->node_type);
else fprintf(stderr,"\n At line 156 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 158;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna49;

_gna49 = (GNODE) gmalloc ();
_gna49->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna49->node_type = 3;

_gna49->node_data.l_dv = ( (char *)( (char *) newBlock())) ;

if (_gna49 != (GNODE) NULL && (GSLOT(_gna49) != (AXS_ENTRY) NULL))
	MarkUsed(_gna49);


newblock = _gna49;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 159;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna50;

_gna50 = (GNODE) gmalloc ();
_gna50->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna50->node_type = 3;

_gna50->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna50 != (GNODE) NULL)
  if (VALIDTYPE(_gna50->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna50,""); 
  else fprintf(stderr,"\n At line 160 attempt to unparse node of invalid type %d", _gna50->node_type);
else fprintf(stderr,"\n At line 160 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna50;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 161;
_Cur_Node = TheRootNode;
{

GNODE _gna51;


_gna51 = getlocnode(TheRootNode);

_gna50 = (GNODE) GetFillers(_gna51,"line");
}

if (_gna50 != (GNODE) NULL)
  if (VALIDTYPE(_gna50->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna50,""); 
  else fprintf(stderr,"\n At line 161 attempt to unparse node of invalid type %d", _gna50->node_type);
else fprintf(stderr,"\n At line 161 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Begin "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna50;
_gna50 = (GNODE) newblock;

if (_gna50 != (GNODE) NULL)
  if (VALIDTYPE(_gna50->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna50,""); 
  else fprintf(stderr,"\n At line 162 attempt to unparse node of invalid type %d", _gna50->node_type);
else fprintf(stderr,"\n At line 162 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 164;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna52;

_gna52 = (GNODE) gmalloc ();
_gna52->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna52->node_type = 3;

_gna52->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna52 != (GNODE) NULL)
  if (VALIDTYPE(_gna52->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna52,""); 
  else fprintf(stderr,"\n At line 165 attempt to unparse node of invalid type %d", _gna52->node_type);
else fprintf(stderr,"\n At line 165 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna52;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 166;
_Cur_Node = TheRootNode;
{

GNODE _gna53;


_gna53 = getlocnode(TheRootNode);

_gna52 = (GNODE) GetFillers(_gna53,"line");
}

if (_gna52 != (GNODE) NULL)
  if (VALIDTYPE(_gna52->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna52,""); 
  else fprintf(stderr,"\n At line 166 attempt to unparse node of invalid type %d", _gna52->node_type);
else fprintf(stderr,"\n At line 166 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Assign "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna52;
_gna52 = (GNODE) retResult;

if (_gna52 != (GNODE) NULL)
  if (VALIDTYPE(_gna52->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna52,""); 
  else fprintf(stderr,"\n At line 167 attempt to unparse node of invalid type %d", _gna52->node_type);
else fprintf(stderr,"\n At line 167 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna52;
_gna52 = (GNODE) trueValue;

if (_gna52 != (GNODE) NULL)
  if (VALIDTYPE(_gna52->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna52,""); 
  else fprintf(stderr,"\n At line 168 attempt to unparse node of invalid type %d", _gna52->node_type);
else fprintf(stderr,"\n At line 168 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 170;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna54;

_gna54 = (GNODE) gmalloc ();
_gna54->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna54->node_type = 3;

_gna54->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna54 != (GNODE) NULL)
  if (VALIDTYPE(_gna54->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna54,""); 
  else fprintf(stderr,"\n At line 171 attempt to unparse node of invalid type %d", _gna54->node_type);
else fprintf(stderr,"\n At line 171 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna54;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 172;
_Cur_Node = TheRootNode;
{

GNODE _gna55;


_gna55 = getlocnode(TheRootNode);

_gna54 = (GNODE) GetFillers(_gna55,"line");
}

if (_gna54 != (GNODE) NULL)
  if (VALIDTYPE(_gna54->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna54,""); 
  else fprintf(stderr,"\n At line 172 attempt to unparse node of invalid type %d", _gna54->node_type);
else fprintf(stderr,"\n At line 172 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (End "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna54;
_gna54 = (GNODE) newblock;

if (_gna54 != (GNODE) NULL)
  if (VALIDTYPE(_gna54->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna54,""); 
  else fprintf(stderr,"\n At line 173 attempt to unparse node of invalid type %d", _gna54->node_type);
else fprintf(stderr,"\n At line 173 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 175;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna56;

_gna56 = (GNODE) gmalloc ();
_gna56->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna56->node_type = 3;

_gna56->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna56 != (GNODE) NULL)
  if (VALIDTYPE(_gna56->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna56,""); 
  else fprintf(stderr,"\n At line 176 attempt to unparse node of invalid type %d", _gna56->node_type);
else fprintf(stderr,"\n At line 176 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna56;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 177;
_Cur_Node = TheRootNode;
{

GNODE _gna57;


_gna57 = getlocnode(TheRootNode);

_gna56 = (GNODE) GetFillers(_gna57,"line");
}

if (_gna56 != (GNODE) NULL)
  if (VALIDTYPE(_gna56->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna56,""); 
  else fprintf(stderr,"\n At line 177 attempt to unparse node of invalid type %d", _gna56->node_type);
else fprintf(stderr,"\n At line 177 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (If "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna56;
_gna56 = (GNODE) oppositeTest;

if (_gna56 != (GNODE) NULL)
  if (VALIDTYPE(_gna56->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna56,""); 
  else fprintf(stderr,"\n At line 178 attempt to unparse node of invalid type %d", _gna56->node_type);
else fprintf(stderr,"\n At line 178 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 180;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna58;

_gna58 = (GNODE) gmalloc ();
_gna58->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna58->node_type = 3;

_gna58->node_data.l_dv = ( (char *)( (char *) newBlock())) ;

if (_gna58 != (GNODE) NULL && (GSLOT(_gna58) != (AXS_ENTRY) NULL))
	MarkUsed(_gna58);


newblock = _gna58;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 181;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna59;

_gna59 = (GNODE) gmalloc ();
_gna59->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna59->node_type = 3;

_gna59->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna59 != (GNODE) NULL)
  if (VALIDTYPE(_gna59->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna59,""); 
  else fprintf(stderr,"\n At line 182 attempt to unparse node of invalid type %d", _gna59->node_type);
else fprintf(stderr,"\n At line 182 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna59;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 183;
_Cur_Node = TheRootNode;
{

GNODE _gna60;


_gna60 = getlocnode(TheRootNode);

_gna59 = (GNODE) GetFillers(_gna60,"line");
}

if (_gna59 != (GNODE) NULL)
  if (VALIDTYPE(_gna59->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna59,""); 
  else fprintf(stderr,"\n At line 183 attempt to unparse node of invalid type %d", _gna59->node_type);
else fprintf(stderr,"\n At line 183 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Begin "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna59;
_gna59 = (GNODE) newblock;

if (_gna59 != (GNODE) NULL)
  if (VALIDTYPE(_gna59->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna59,""); 
  else fprintf(stderr,"\n At line 184 attempt to unparse node of invalid type %d", _gna59->node_type);
else fprintf(stderr,"\n At line 184 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 186;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna61;

_gna61 = (GNODE) gmalloc ();
_gna61->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna61->node_type = 3;

_gna61->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna61 != (GNODE) NULL)
  if (VALIDTYPE(_gna61->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna61,""); 
  else fprintf(stderr,"\n At line 187 attempt to unparse node of invalid type %d", _gna61->node_type);
else fprintf(stderr,"\n At line 187 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna61;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 188;
_Cur_Node = TheRootNode;
{

GNODE _gna62;


_gna62 = getlocnode(TheRootNode);

_gna61 = (GNODE) GetFillers(_gna62,"line");
}

if (_gna61 != (GNODE) NULL)
  if (VALIDTYPE(_gna61->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna61,""); 
  else fprintf(stderr,"\n At line 188 attempt to unparse node of invalid type %d", _gna61->node_type);
else fprintf(stderr,"\n At line 188 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Assign "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna61;
_gna61 = (GNODE) retResult;

if (_gna61 != (GNODE) NULL)
  if (VALIDTYPE(_gna61->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna61,""); 
  else fprintf(stderr,"\n At line 189 attempt to unparse node of invalid type %d", _gna61->node_type);
else fprintf(stderr,"\n At line 189 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna61;
_gna61 = (GNODE) falseValue;

if (_gna61 != (GNODE) NULL)
  if (VALIDTYPE(_gna61->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna61,""); 
  else fprintf(stderr,"\n At line 190 attempt to unparse node of invalid type %d", _gna61->node_type);
else fprintf(stderr,"\n At line 190 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 192;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna63;

_gna63 = (GNODE) gmalloc ();
_gna63->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna63->node_type = 3;

_gna63->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna63 != (GNODE) NULL)
  if (VALIDTYPE(_gna63->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna63,""); 
  else fprintf(stderr,"\n At line 193 attempt to unparse node of invalid type %d", _gna63->node_type);
else fprintf(stderr,"\n At line 193 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna63;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 194;
_Cur_Node = TheRootNode;
{

GNODE _gna64;


_gna64 = getlocnode(TheRootNode);

_gna63 = (GNODE) GetFillers(_gna64,"line");
}

if (_gna63 != (GNODE) NULL)
  if (VALIDTYPE(_gna63->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna63,""); 
  else fprintf(stderr,"\n At line 194 attempt to unparse node of invalid type %d", _gna63->node_type);
else fprintf(stderr,"\n At line 194 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (End "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna63;
_gna63 = (GNODE) newblock;

if (_gna63 != (GNODE) NULL)
  if (VALIDTYPE(_gna63->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna63,""); 
  else fprintf(stderr,"\n At line 195 attempt to unparse node of invalid type %d", _gna63->node_type);
else fprintf(stderr,"\n At line 195 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 196;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna65;
_gna65 = gcopy((GNODE) retResult);

return (_gna65);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithCcast (GNODE TheRootNode	)
#else

GNODE DealWithCcast ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, Ccast))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithCcast called with node of type %s, not of type %d Ccast",WhatType(TheRootNode->node_type),Ccast);
	else printf("\n Procedure DealWithCcast called with invalid node  type %d, not of type %d Ccast",TheRootNode->node_type,Ccast);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<fromexpr...";
_Cur_SpecLine = 203;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  fromexpr */
{


GNODE _gna66;	

_gna66 = (GNODE) GetFillers(TheRootNode,"fromexpr");

 if (_gna66 != (GNODE) NULL) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 203;
_Cur_Node = _gna66;

{				

  /* EXECUTE ITEM */
{


GNODE _gna67;
	_gna67 = DealWithExpression (_gna66);




	





return (_gna67);
}

}

 }	  /* Balances if (_gna66 != (GNODE) NULL )*/

} /* Balances GNODE _gna66; */

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithSizeof_E (GNODE TheRootNode	)
#else

GNODE DealWithSizeof_E ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, Sizeof_E))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithSizeof_E called with node of type %s, not of type %d Sizeof_E",WhatType(TheRootNode->node_type),Sizeof_E);
	else printf("\n Procedure DealWithSizeof_E called with invalid node  type %d, not of type %d Sizeof_E",TheRootNode->node_type,Sizeof_E);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 210;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna68;

_gna68 = (GNODE) gmalloc ();
_gna68->node_flag = GBUILTIN | GSIMPLENODE;
_gna68->node_type = C_Integer;
_gna68->node_data.l_iv = 1;

return (_gna68);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithSizeof_T (GNODE TheRootNode	)
#else

GNODE DealWithSizeof_T ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, Sizeof_T))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithSizeof_T called with node of type %s, not of type %d Sizeof_T",WhatType(TheRootNode->node_type),Sizeof_T);
	else printf("\n Procedure DealWithSizeof_T called with invalid node  type %d, not of type %d Sizeof_T",TheRootNode->node_type,Sizeof_T);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 218;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna69;

_gna69 = (GNODE) gmalloc ();
_gna69->node_flag = GBUILTIN | GSIMPLENODE;
_gna69->node_type = C_Integer;
_gna69->node_data.l_iv = 1;

return (_gna69);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithIndex (GNODE TheRootNode	)
#else

GNODE DealWithIndex ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE IxLeft;
	GNODE IxSub;
	GNODE op;
	GNODE newValue;

  if (!(OfType(TheRootNode, Index))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithIndex called with node of type %s, not of type %d Index",WhatType(TheRootNode->node_type),Index);
	else printf("\n Procedure DealWithIndex called with invalid node  type %d, not of type %d Index",TheRootNode->node_type,Index);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 231;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna70;
_Cur_Constr = "(NODETYPE...";
_Cur_SpecLine = 231;
_Cur_Node = TheRootNode;
{

GNODE _gna71;
_gna71 = TheRootNode;
_gna70 = (GNODE) gmalloc ();
_gna70->node_flag = GBUILTIN | GSIMPLENODE;
_gna70->node_type = C_String;
_gna70->node_data.l_dv = NodeTable[_gna71->node_type]->nodename;
}

if (_gna70 != (GNODE) NULL && (GSLOT(_gna70) != (AXS_ENTRY) NULL))
	MarkUsed(_gna70);


op = _gna70;


}

}

_Cur_Constr = "<ix_subscript...";
_Cur_SpecLine = 232;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ix_subscript */
{


GNODE _gna72;	

_gna72 = (GNODE) GetFillers(TheRootNode,"ix_subscript");

 if (_gna72 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 232;
_Cur_Node = _gna72;

{				

  /* EXECUTE ITEM */
{


GNODE _gna73;
	_gna73 = DealWithExpression (_gna72);




	





if (_gna73 != (GNODE) NULL && (GSLOT(_gna73) != (AXS_ENTRY) NULL))
	MarkUsed(_gna73);


IxSub = _gna73;


}

}

 }	  /* Balances if (_gna72 != (GNODE) NULL )*/

} /* Balances GNODE _gna72; */

}

_Cur_Constr = "<ix_left...";
_Cur_SpecLine = 233;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ix_left */
{


GNODE _gna74;	

_gna74 = (GNODE) GetFillers(TheRootNode,"ix_left");

 if (_gna74 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 233;
_Cur_Node = _gna74;

{				

  /* EXECUTE ITEM */
{


GNODE _gna75;
	_gna75 = DealWithExpression (_gna74);




	





if (_gna75 != (GNODE) NULL && (GSLOT(_gna75) != (AXS_ENTRY) NULL))
	MarkUsed(_gna75);


IxLeft = _gna75;


}

}

 }	  /* Balances if (_gna74 != (GNODE) NULL )*/

} /* Balances GNODE _gna74; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 235;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna76;

_gna76 = (GNODE) gmalloc ();
_gna76->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna76->node_type = 3;

_gna76->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna76 != (GNODE) NULL && (GSLOT(_gna76) != (AXS_ENTRY) NULL))
	MarkUsed(_gna76);


newValue = _gna76;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 236;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna77;

_gna77 = (GNODE) gmalloc ();
_gna77->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna77->node_type = 3;

_gna77->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna77 != (GNODE) NULL)
  if (VALIDTYPE(_gna77->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna77,""); 
  else fprintf(stderr,"\n At line 237 attempt to unparse node of invalid type %d", _gna77->node_type);
else fprintf(stderr,"\n At line 237 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna77;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 238;
_Cur_Node = TheRootNode;
{

GNODE _gna78;


_gna78 = getlocnode(TheRootNode);

_gna77 = (GNODE) GetFillers(_gna78,"line");
}

if (_gna77 != (GNODE) NULL)
  if (VALIDTYPE(_gna77->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna77,""); 
  else fprintf(stderr,"\n At line 238 attempt to unparse node of invalid type %d", _gna77->node_type);
else fprintf(stderr,"\n At line 238 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna77;
_gna77 = (GNODE) op;

if (_gna77 != (GNODE) NULL)
  if (VALIDTYPE(_gna77->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna77,""); 
  else fprintf(stderr,"\n At line 239 attempt to unparse node of invalid type %d", _gna77->node_type);
else fprintf(stderr,"\n At line 239 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna77;
_gna77 = (GNODE) IxLeft;

if (_gna77 != (GNODE) NULL)
  if (VALIDTYPE(_gna77->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna77,""); 
  else fprintf(stderr,"\n At line 239 attempt to unparse node of invalid type %d", _gna77->node_type);
else fprintf(stderr,"\n At line 239 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna77;
_gna77 = (GNODE) IxSub;

if (_gna77 != (GNODE) NULL)
  if (VALIDTYPE(_gna77->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna77,""); 
  else fprintf(stderr,"\n At line 239 attempt to unparse node of invalid type %d", _gna77->node_type);
else fprintf(stderr,"\n At line 239 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna77;
_gna77 = (GNODE) newValue;

if (_gna77 != (GNODE) NULL)
  if (VALIDTYPE(_gna77->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna77,""); 
  else fprintf(stderr,"\n At line 239 attempt to unparse node of invalid type %d", _gna77->node_type);
else fprintf(stderr,"\n At line 239 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna77;
_gna77 = (GNODE) IxLeft;

if (_gna77 != (GNODE) NULL)
  if (VALIDTYPE(_gna77->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna77,""); 
  else fprintf(stderr,"\n At line 240 attempt to unparse node of invalid type %d", _gna77->node_type);
else fprintf(stderr,"\n At line 240 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna77;
_gna77 = (GNODE) IxSub;

if (_gna77 != (GNODE) NULL)
  if (VALIDTYPE(_gna77->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna77,""); 
  else fprintf(stderr,"\n At line 240 attempt to unparse node of invalid type %d", _gna77->node_type);
else fprintf(stderr,"\n At line 240 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna77;
_gna77 = (GNODE) newValue;

if (_gna77 != (GNODE) NULL)
  if (VALIDTYPE(_gna77->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna77,""); 
  else fprintf(stderr,"\n At line 240 attempt to unparse node of invalid type %d", _gna77->node_type);
else fprintf(stderr,"\n At line 240 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna77;
_gna77 = (GNODE) newValue;

if (_gna77 != (GNODE) NULL)
  if (VALIDTYPE(_gna77->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna77,""); 
  else fprintf(stderr,"\n At line 240 attempt to unparse node of invalid type %d", _gna77->node_type);
else fprintf(stderr,"\n At line 240 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 241;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna79;
_gna79 = gcopy((GNODE) newValue);

return (_gna79);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithFunCall (GNODE TheRootNode	)
#else

GNODE DealWithFunCall ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE newValue;
	GNODE argList;
	GNODE tmpList;
	GNODE tmp1List;

  if (!(OfType(TheRootNode, FunCall))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithFunCall called with node of type %s, not of type %d FunCall",WhatType(TheRootNode->node_type),FunCall);
	else printf("\n Procedure DealWithFunCall called with invalid node  type %d, not of type %d FunCall",TheRootNode->node_type,FunCall);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 257;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna80;

_gna80 = (GNODE)  gmalloc ();
_gna80->node_flag = GLIST_OF;
_gna80->node_data.l_dv = (GNODE) NULL;
_gna80->node_type = Expression;

if (_gna80 != (GNODE) NULL && (GSLOT(_gna80) != (AXS_ENTRY) NULL))
	MarkUsed(_gna80);


argList = _gna80;


}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 258;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna81;

_gna81 = (GNODE)  gmalloc ();
_gna81->node_flag = GLIST_OF;
_gna81->node_data.l_dv = (GNODE) NULL;
_gna81->node_type = Expression;

if (_gna81 != (GNODE) NULL && (GSLOT(_gna81) != (AXS_ENTRY) NULL))
	MarkUsed(_gna81);


tmpList = _gna81;


}

}

_Cur_Constr = "<callargs...";
_Cur_SpecLine = 260;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  callargs */
{


GNODE _gna82;	

_gna82 = (GNODE) GetFillers(TheRootNode,"callargs");

 if (_gna82 != (GNODE) NULL) {

_Cur_Constr = "{Expression\n\t\t\t(ASSI...";
_Cur_SpecLine = 261;
_Cur_Node = _gna82;

{

_Cur_Constr = "{Expression\n\t\t\t(ASSI...";
_Cur_SpecLine = 261;
_Cur_Node = _gna82;

{

GNODE _gna83;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Expression */
 
if (_gna82->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna83 = (GNODE)( _gna82->node_data.l_dv);
  for(;_gna83 != (GNODE) NULL;_gna83=_gna83->gnext) {
    if (OfType(_gna83,Expression)) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 262;
_Cur_Node = _gna83;

{				

  /* EXECUTE ITEM */
{

GNODE _gna85;
  {

GNODE _gna87;
_gna87 = (GNODE) argList;


GNODE _gna88;
	_gna88 = DealWithExpression (_gna83);




	





_gna85 = GCONS(_gna88,_gna87);
      }

if (_gna85 != (GNODE) NULL && (GSLOT(_gna85) != (AXS_ENTRY) NULL))
	MarkUsed(_gna85);


argList = _gna85;


}

}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 261 is %s not type %d---Expression",NodeTable[_gna83->node_type]->nodename,Expression);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 261- Parent NOT a LIST !");


}

}

 }	  /* Balances if (_gna82 != (GNODE) NULL )*/

} /* Balances GNODE _gna82; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 272;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna89;

_gna89 = (GNODE) gmalloc ();
_gna89->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna89->node_type = 3;

_gna89->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna89 != (GNODE) NULL)
  if (VALIDTYPE(_gna89->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna89,""); 
  else fprintf(stderr,"\n At line 273 attempt to unparse node of invalid type %d", _gna89->node_type);
else fprintf(stderr,"\n At line 273 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna89;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 274;
_Cur_Node = TheRootNode;
{

GNODE _gna90;


_gna90 = getlocnode(TheRootNode);

_gna89 = (GNODE) GetFillers(_gna90,"line");
}

if (_gna89 != (GNODE) NULL)
  if (VALIDTYPE(_gna89->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna89,""); 
  else fprintf(stderr,"\n At line 274 attempt to unparse node of invalid type %d", _gna89->node_type);
else fprintf(stderr,"\n At line 274 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ("); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna89;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 275;
_Cur_Node = TheRootNode;
{

GNODE _gna91;
_gna91 = TheRootNode;

_gna89 = (GNODE) GetFillers(_gna91,"callname");
}

if (_gna89 != (GNODE) NULL)
  if (VALIDTYPE(_gna89->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna89,""); 
  else fprintf(stderr,"\n At line 275 attempt to unparse node of invalid type %d", _gna89->node_type);
else fprintf(stderr,"\n At line 275 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," ");

}

_Cur_Constr = "(WHILE...";
_Cur_SpecLine = 277;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna92;

{

int _gna93;
{

GNODE _gna94;
_gna94 = gcopy((GNODE) argList);
_gna93 = gnull(_gna94);
}

_gna92 = !_gna93;
}

while(_gna92) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 278;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna95;
  {

GNODE _gna97;
_gna97 = (GNODE) tmpList;

GNODE _gna98;

{

GNODE _gna99;
_gna99 = (GNODE) argList;
if (IsList(_gna99))
	_gna98 = GCAR(_gna99);
else {
	fprintf(stderr,"\n ***ERROR*** Attempt to take CAR of non-list at %d", _Cur_SpecLine);
	exit(1);
}

}

_gna95 = GCONS(_gna98,_gna97);
      }

if (_gna95 != (GNODE) NULL && (GSLOT(_gna95) != (AXS_ENTRY) NULL))
	MarkUsed(_gna95);


tmpList = _gna95;


}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 279;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna100;

{

GNODE _gna101;
_gna101 = (GNODE) argList;
if (IsList(_gna101))
	_gna100 = gcopy(GDCDR((_gna101)));
 
else {
	fprintf(stderr,"\n ***ERROR*** Attempt to take CAR of non-list at %d", _Cur_SpecLine);
	exit(1);
}

}

if (_gna100 != (GNODE) NULL && (GSLOT(_gna100) != (AXS_ENTRY) NULL))
	MarkUsed(_gna100);


argList = _gna100;


}

}
{

int _gna102;

{

int _gna103;
{

GNODE _gna104;
_gna104 = gcopy((GNODE) argList);
_gna103 = gnull(_gna104);
}

_gna102 = !_gna103;
}
_gna92 = _gna102;
}
}
}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 281;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna105;
_gna105 = gcopy((GNODE) tmpList);

if (_gna105 != (GNODE) NULL && (GSLOT(_gna105) != (AXS_ENTRY) NULL))
	MarkUsed(_gna105);


tmp1List = _gna105;


}

}

_Cur_Constr = "(WHILE...";
_Cur_SpecLine = 283;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna106;

{

int _gna107;
{

GNODE _gna108;
_gna108 = gcopy((GNODE) tmpList);
_gna107 = gnull(_gna108);
}

_gna106 = !_gna107;
}

while(_gna106) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 285;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna109;

{

GNODE _gna110;
_gna110 = (GNODE) tmpList;
if (IsList(_gna110))
	_gna109 = GCAR(_gna110);
else {
	fprintf(stderr,"\n ***ERROR*** Attempt to take CAR of non-list at %d", _Cur_SpecLine);
	exit(1);
}

}

if (_gna109 != (GNODE) NULL)
  if (VALIDTYPE(_gna109->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna109,""); 
  else fprintf(stderr,"\n At line 285 attempt to unparse node of invalid type %d", _gna109->node_type);
else fprintf(stderr,"\n At line 285 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," ");

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 286;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna111;

{

GNODE _gna112;
_gna112 = (GNODE) tmpList;
if (IsList(_gna112))
	_gna111 = gcopy(GDCDR((_gna112)));
 
else {
	fprintf(stderr,"\n ***ERROR*** Attempt to take CAR of non-list at %d", _Cur_SpecLine);
	exit(1);
}

}

if (_gna111 != (GNODE) NULL && (GSLOT(_gna111) != (AXS_ENTRY) NULL))
	MarkUsed(_gna111);


tmpList = _gna111;


}

}
{

int _gna113;

{

int _gna114;
{

GNODE _gna115;
_gna115 = gcopy((GNODE) tmpList);
_gna114 = gnull(_gna115);
}

_gna113 = !_gna114;
}
_gna106 = _gna113;
}
}
}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 290;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna116;

_gna116 = (GNODE) gmalloc ();
_gna116->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna116->node_type = 3;

_gna116->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna116 != (GNODE) NULL && (GSLOT(_gna116) != (AXS_ENTRY) NULL))
	MarkUsed(_gna116);


newValue = _gna116;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 291;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna117;
_gna117 = (GNODE) newValue;

if (_gna117 != (GNODE) NULL)
  if (VALIDTYPE(_gna117->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna117,""); 
  else fprintf(stderr,"\n At line 292 attempt to unparse node of invalid type %d", _gna117->node_type);
else fprintf(stderr,"\n At line 292 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,") (");

}

_Cur_Constr = "(WHILE...";
_Cur_SpecLine = 294;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna118;

{

int _gna119;
{

GNODE _gna120;
_gna120 = gcopy((GNODE) tmp1List);
_gna119 = gnull(_gna120);
}

_gna118 = !_gna119;
}

while(_gna118) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 295;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna121;

{

GNODE _gna122;
_gna122 = (GNODE) tmp1List;
if (IsList(_gna122))
	_gna121 = GCAR(_gna122);
else {
	fprintf(stderr,"\n ***ERROR*** Attempt to take CAR of non-list at %d", _Cur_SpecLine);
	exit(1);
}

}

if (_gna121 != (GNODE) NULL)
  if (VALIDTYPE(_gna121->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna121,""); 
  else fprintf(stderr,"\n At line 295 attempt to unparse node of invalid type %d", _gna121->node_type);
else fprintf(stderr,"\n At line 295 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," ");

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 296;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna123;

{

GNODE _gna124;
_gna124 = (GNODE) tmp1List;
if (IsList(_gna124))
	_gna123 = gcopy(GDCDR((_gna124)));
 
else {
	fprintf(stderr,"\n ***ERROR*** Attempt to take CAR of non-list at %d", _Cur_SpecLine);
	exit(1);
}

}

if (_gna123 != (GNODE) NULL && (GSLOT(_gna123) != (AXS_ENTRY) NULL))
	MarkUsed(_gna123);


tmp1List = _gna123;


}

}
{

int _gna125;

{

int _gna126;
{

GNODE _gna127;
_gna127 = gcopy((GNODE) tmp1List);
_gna126 = gnull(_gna127);
}

_gna125 = !_gna126;
}
_gna118 = _gna125;
}
}
}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 298;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna128;
_gna128 = (GNODE) newValue;

if (_gna128 != (GNODE) NULL)
  if (VALIDTYPE(_gna128->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna128,""); 
  else fprintf(stderr,"\n At line 299 attempt to unparse node of invalid type %d", _gna128->node_type);
else fprintf(stderr,"\n At line 299 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna128;
_gna128 = (GNODE) newValue;

if (_gna128 != (GNODE) NULL)
  if (VALIDTYPE(_gna128->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna128,""); 
  else fprintf(stderr,"\n At line 299 attempt to unparse node of invalid type %d", _gna128->node_type);
else fprintf(stderr,"\n At line 299 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 301;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna129;
_gna129 = gcopy((GNODE) newValue);

return (_gna129);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithUnaryExpr (GNODE TheRootNode	)
#else

GNODE DealWithUnaryExpr ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE op;
	GNODE oldValue;
	GNODE newValue;

  if (!(OfType(TheRootNode, UnaryExpr))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithUnaryExpr called with node of type %s, not of type %d UnaryExpr",WhatType(TheRootNode->node_type),UnaryExpr);
	else printf("\n Procedure DealWithUnaryExpr called with invalid node  type %d, not of type %d UnaryExpr",TheRootNode->node_type,UnaryExpr);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(IF...";
_Cur_SpecLine = 312;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna130;
{

GNODE _gna131;
_gna131 = TheRootNode;



_gna130 =  OfType(_gna131,UnaryCount);
}

if (_gna130) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 313;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna132;
	_gna132 = DealWithUnaryCount (TheRootNode);




	





return (_gna132);
}

}

}
else {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 315;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna133;
_Cur_Constr = "(NODETYPE...";
_Cur_SpecLine = 315;
_Cur_Node = TheRootNode;
{

GNODE _gna134;
_gna134 = TheRootNode;
_gna133 = (GNODE) gmalloc ();
_gna133->node_flag = GBUILTIN | GSIMPLENODE;
_gna133->node_type = C_String;
_gna133->node_data.l_dv = NodeTable[_gna134->node_type]->nodename;
}

if (_gna133 != (GNODE) NULL && (GSLOT(_gna133) != (AXS_ENTRY) NULL))
	MarkUsed(_gna133);


op = _gna133;


}

}

_Cur_Constr = "<ue_arg...";
_Cur_SpecLine = 316;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ue_arg */
{


GNODE _gna135;	

_gna135 = (GNODE) GetFillers(TheRootNode,"ue_arg");

 if (_gna135 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 316;
_Cur_Node = _gna135;

{				

  /* EXECUTE ITEM */
{


GNODE _gna136;
	_gna136 = DealWithExpression (_gna135);




	





if (_gna136 != (GNODE) NULL && (GSLOT(_gna136) != (AXS_ENTRY) NULL))
	MarkUsed(_gna136);


oldValue = _gna136;


}

}

 }	  /* Balances if (_gna135 != (GNODE) NULL )*/

} /* Balances GNODE _gna135; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 318;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna137;

_gna137 = (GNODE) gmalloc ();
_gna137->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna137->node_type = 3;

_gna137->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna137 != (GNODE) NULL && (GSLOT(_gna137) != (AXS_ENTRY) NULL))
	MarkUsed(_gna137);


newValue = _gna137;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 319;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna138;

_gna138 = (GNODE) gmalloc ();
_gna138->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna138->node_type = 3;

_gna138->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna138 != (GNODE) NULL)
  if (VALIDTYPE(_gna138->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna138,""); 
  else fprintf(stderr,"\n At line 320 attempt to unparse node of invalid type %d", _gna138->node_type);
else fprintf(stderr,"\n At line 320 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna138;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 321;
_Cur_Node = TheRootNode;
{

GNODE _gna139;


_gna139 = getlocnode(TheRootNode);

_gna138 = (GNODE) GetFillers(_gna139,"line");
}

if (_gna138 != (GNODE) NULL)
  if (VALIDTYPE(_gna138->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna138,""); 
  else fprintf(stderr,"\n At line 321 attempt to unparse node of invalid type %d", _gna138->node_type);
else fprintf(stderr,"\n At line 321 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna138;
_gna138 = (GNODE) op;

if (_gna138 != (GNODE) NULL)
  if (VALIDTYPE(_gna138->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna138,""); 
  else fprintf(stderr,"\n At line 322 attempt to unparse node of invalid type %d", _gna138->node_type);
else fprintf(stderr,"\n At line 322 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna138;
_gna138 = (GNODE) oldValue;

if (_gna138 != (GNODE) NULL)
  if (VALIDTYPE(_gna138->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna138,""); 
  else fprintf(stderr,"\n At line 322 attempt to unparse node of invalid type %d", _gna138->node_type);
else fprintf(stderr,"\n At line 322 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna138;
_gna138 = (GNODE) newValue;

if (_gna138 != (GNODE) NULL)
  if (VALIDTYPE(_gna138->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna138,""); 
  else fprintf(stderr,"\n At line 322 attempt to unparse node of invalid type %d", _gna138->node_type);
else fprintf(stderr,"\n At line 322 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna138;
_gna138 = (GNODE) oldValue;

if (_gna138 != (GNODE) NULL)
  if (VALIDTYPE(_gna138->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna138,""); 
  else fprintf(stderr,"\n At line 323 attempt to unparse node of invalid type %d", _gna138->node_type);
else fprintf(stderr,"\n At line 323 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna138;
_gna138 = (GNODE) newValue;

if (_gna138 != (GNODE) NULL)
  if (VALIDTYPE(_gna138->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna138,""); 
  else fprintf(stderr,"\n At line 323 attempt to unparse node of invalid type %d", _gna138->node_type);
else fprintf(stderr,"\n At line 323 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna138;
_gna138 = (GNODE) newValue;

if (_gna138 != (GNODE) NULL)
  if (VALIDTYPE(_gna138->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna138,""); 
  else fprintf(stderr,"\n At line 323 attempt to unparse node of invalid type %d", _gna138->node_type);
else fprintf(stderr,"\n At line 323 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 325;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna140;
_gna140 = gcopy((GNODE) newValue);

return (_gna140);
}

}
}
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithBinaryExpr (GNODE TheRootNode	)
#else

GNODE DealWithBinaryExpr ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE op;
	GNODE lValue;
	GNODE rValue;
	GNODE newValue;

  if (!(OfType(TheRootNode, BinaryExpr))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithBinaryExpr called with node of type %s, not of type %d BinaryExpr",WhatType(TheRootNode->node_type),BinaryExpr);
	else printf("\n Procedure DealWithBinaryExpr called with invalid node  type %d, not of type %d BinaryExpr",TheRootNode->node_type,BinaryExpr);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(IF...";
_Cur_SpecLine = 341;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna141;
{

GNODE _gna142;
_gna142 = TheRootNode;



_gna141 =  OfType(_gna142,Assignment);
}

if (_gna141) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 342;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna143;
	_gna143 = DealWithAssignment (TheRootNode);




	





return (_gna143);
}

}

}
else {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 345;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna144;
_Cur_Constr = "(NODETYPE...";
_Cur_SpecLine = 345;
_Cur_Node = TheRootNode;
{

GNODE _gna145;
_gna145 = TheRootNode;
_gna144 = (GNODE) gmalloc ();
_gna144->node_flag = GBUILTIN | GSIMPLENODE;
_gna144->node_type = C_String;
_gna144->node_data.l_dv = NodeTable[_gna145->node_type]->nodename;
}

if (_gna144 != (GNODE) NULL && (GSLOT(_gna144) != (AXS_ENTRY) NULL))
	MarkUsed(_gna144);


op = _gna144;


}

}

_Cur_Constr = "<be_rhs...";
_Cur_SpecLine = 346;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  be_rhs */
{


GNODE _gna146;	

_gna146 = (GNODE) GetFillers(TheRootNode,"be_rhs");

 if (_gna146 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 346;
_Cur_Node = _gna146;

{				

  /* EXECUTE ITEM */
{


GNODE _gna147;
	_gna147 = DealWithExpression (_gna146);




	





if (_gna147 != (GNODE) NULL && (GSLOT(_gna147) != (AXS_ENTRY) NULL))
	MarkUsed(_gna147);


rValue = _gna147;


}

}

 }	  /* Balances if (_gna146 != (GNODE) NULL )*/

} /* Balances GNODE _gna146; */

}

_Cur_Constr = "<be_lhs...";
_Cur_SpecLine = 347;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  be_lhs */
{


GNODE _gna148;	

_gna148 = (GNODE) GetFillers(TheRootNode,"be_lhs");

 if (_gna148 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 347;
_Cur_Node = _gna148;

{				

  /* EXECUTE ITEM */
{


GNODE _gna149;
	_gna149 = DealWithExpression (_gna148);




	





if (_gna149 != (GNODE) NULL && (GSLOT(_gna149) != (AXS_ENTRY) NULL))
	MarkUsed(_gna149);


lValue = _gna149;


}

}

 }	  /* Balances if (_gna148 != (GNODE) NULL )*/

} /* Balances GNODE _gna148; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 349;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna150;

_gna150 = (GNODE) gmalloc ();
_gna150->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna150->node_type = 3;

_gna150->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna150 != (GNODE) NULL && (GSLOT(_gna150) != (AXS_ENTRY) NULL))
	MarkUsed(_gna150);


newValue = _gna150;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 351;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna151;

_gna151 = (GNODE) gmalloc ();
_gna151->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna151->node_type = 3;

_gna151->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna151 != (GNODE) NULL)
  if (VALIDTYPE(_gna151->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna151,""); 
  else fprintf(stderr,"\n At line 352 attempt to unparse node of invalid type %d", _gna151->node_type);
else fprintf(stderr,"\n At line 352 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna151;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 353;
_Cur_Node = TheRootNode;
{

GNODE _gna152;


_gna152 = getlocnode(TheRootNode);

_gna151 = (GNODE) GetFillers(_gna152,"line");
}

if (_gna151 != (GNODE) NULL)
  if (VALIDTYPE(_gna151->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna151,""); 
  else fprintf(stderr,"\n At line 353 attempt to unparse node of invalid type %d", _gna151->node_type);
else fprintf(stderr,"\n At line 353 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna151;
_gna151 = (GNODE) op;

if (_gna151 != (GNODE) NULL)
  if (VALIDTYPE(_gna151->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna151,""); 
  else fprintf(stderr,"\n At line 354 attempt to unparse node of invalid type %d", _gna151->node_type);
else fprintf(stderr,"\n At line 354 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna151;
_gna151 = (GNODE) lValue;

if (_gna151 != (GNODE) NULL)
  if (VALIDTYPE(_gna151->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna151,""); 
  else fprintf(stderr,"\n At line 354 attempt to unparse node of invalid type %d", _gna151->node_type);
else fprintf(stderr,"\n At line 354 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna151;
_gna151 = (GNODE) rValue;

if (_gna151 != (GNODE) NULL)
  if (VALIDTYPE(_gna151->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna151,""); 
  else fprintf(stderr,"\n At line 354 attempt to unparse node of invalid type %d", _gna151->node_type);
else fprintf(stderr,"\n At line 354 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna151;
_gna151 = (GNODE) newValue;

if (_gna151 != (GNODE) NULL)
  if (VALIDTYPE(_gna151->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna151,""); 
  else fprintf(stderr,"\n At line 354 attempt to unparse node of invalid type %d", _gna151->node_type);
else fprintf(stderr,"\n At line 354 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna151;
_gna151 = (GNODE) lValue;

if (_gna151 != (GNODE) NULL)
  if (VALIDTYPE(_gna151->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna151,""); 
  else fprintf(stderr,"\n At line 355 attempt to unparse node of invalid type %d", _gna151->node_type);
else fprintf(stderr,"\n At line 355 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna151;
_gna151 = (GNODE) rValue;

if (_gna151 != (GNODE) NULL)
  if (VALIDTYPE(_gna151->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna151,""); 
  else fprintf(stderr,"\n At line 355 attempt to unparse node of invalid type %d", _gna151->node_type);
else fprintf(stderr,"\n At line 355 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna151;
_gna151 = (GNODE) newValue;

if (_gna151 != (GNODE) NULL)
  if (VALIDTYPE(_gna151->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna151,""); 
  else fprintf(stderr,"\n At line 355 attempt to unparse node of invalid type %d", _gna151->node_type);
else fprintf(stderr,"\n At line 355 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna151;
_gna151 = (GNODE) newValue;

if (_gna151 != (GNODE) NULL)
  if (VALIDTYPE(_gna151->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna151,""); 
  else fprintf(stderr,"\n At line 355 attempt to unparse node of invalid type %d", _gna151->node_type);
else fprintf(stderr,"\n At line 355 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 357;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna153;
_gna153 = gcopy((GNODE) newValue);

return (_gna153);
}

}
}
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithLiteral (GNODE TheRootNode	)
#else

GNODE DealWithLiteral ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, Literal))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithLiteral called with node of type %s, not of type %d Literal",WhatType(TheRootNode->node_type),Literal);
	else printf("\n Procedure DealWithLiteral called with invalid node  type %d, not of type %d Literal",TheRootNode->node_type,Literal);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(IF...";
_Cur_SpecLine = 375;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna154;
{

GNODE _gna155;
_gna155 = TheRootNode;



_gna154 =  OfType(_gna155,StringConst);
}

if (_gna154) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 376;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna156;
_Cur_Constr = "(NODETYPE...";
_Cur_SpecLine = 376;
_Cur_Node = TheRootNode;
{

GNODE _gna157;
_gna157 = TheRootNode;
_gna156 = (GNODE) gmalloc ();
_gna156->node_flag = GBUILTIN | GSIMPLENODE;
_gna156->node_type = C_String;
_gna156->node_data.l_dv = NodeTable[_gna157->node_type]->nodename;
}

return (_gna156);
}

}

}
else {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 377;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna158;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 377;
_Cur_Node = TheRootNode;
{

GNODE _gna159;
_gna159 = TheRootNode;

_gna158 = (GNODE) GetFillers(_gna159,"strep");
}

return (_gna158);
}

}
}
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithNameRef (GNODE TheRootNode	)
#else

GNODE DealWithNameRef ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, NameRef))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithNameRef called with node of type %s, not of type %d NameRef",WhatType(TheRootNode->node_type),NameRef);
	else printf("\n Procedure DealWithNameRef called with invalid node  type %d, not of type %d NameRef",TheRootNode->node_type,NameRef);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(IF...";
_Cur_SpecLine = 386;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna160;
{

GNODE _gna161;
_gna161 = TheRootNode;



_gna160 =  OfType(_gna161,LabelName);
}

if (_gna160) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 388;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna162;

_gna162 = (GNODE) gmalloc ();
_gna162->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna162->node_type = 3;

_gna162->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna162 != (GNODE) NULL)
  if (VALIDTYPE(_gna162->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna162,""); 
  else fprintf(stderr,"\n At line 389 attempt to unparse node of invalid type %d", _gna162->node_type);
else fprintf(stderr,"\n At line 389 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna162;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 390;
_Cur_Node = TheRootNode;
{

GNODE _gna163;


_gna163 = getlocnode(TheRootNode);

_gna162 = (GNODE) GetFillers(_gna163,"line");
}

if (_gna162 != (GNODE) NULL)
  if (VALIDTYPE(_gna162->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna162,""); 
  else fprintf(stderr,"\n At line 390 attempt to unparse node of invalid type %d", _gna162->node_type);
else fprintf(stderr,"\n At line 390 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna162;
_Cur_Constr = "(NODETYPE...";
_Cur_SpecLine = 391;
_Cur_Node = TheRootNode;
{

GNODE _gna164;
_gna164 = TheRootNode;
_gna162 = (GNODE) gmalloc ();
_gna162->node_flag = GBUILTIN | GSIMPLENODE;
_gna162->node_type = C_String;
_gna162->node_data.l_dv = NodeTable[_gna164->node_type]->nodename;
}

if (_gna162 != (GNODE) NULL)
  if (VALIDTYPE(_gna162->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna162,""); 
  else fprintf(stderr,"\n At line 391 attempt to unparse node of invalid type %d", _gna162->node_type);
else fprintf(stderr,"\n At line 391 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna162;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 392;
_Cur_Node = TheRootNode;
{

GNODE _gna165;
_gna165 = TheRootNode;

_gna162 = (GNODE) GetFillers(_gna165,"id");
}

if (_gna162 != (GNODE) NULL)
  if (VALIDTYPE(_gna162->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna162,""); 
  else fprintf(stderr,"\n At line 392 attempt to unparse node of invalid type %d", _gna162->node_type);
else fprintf(stderr,"\n At line 392 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "<stmt...";
_Cur_SpecLine = 393;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  stmt */
{


GNODE _gna166;	

_gna166 = (GNODE) GetFillers(TheRootNode,"stmt");

 if (_gna166 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 393;
_Cur_Node = _gna166;

{				

  /* EXECUTE ITEM */
	
DealWithStatement (_gna166);  


}

 }	  /* Balances if (_gna166 != (GNODE) NULL )*/

} /* Balances GNODE _gna166; */

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 394;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna167;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 394;
_Cur_Node = TheRootNode;
{

GNODE _gna168;
_gna168 = TheRootNode;

_gna167 = (GNODE) GetFillers(_gna168,"id");
}

return (_gna167);
}

}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 398;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna169;
{

GNODE _gna170;
_gna170 = TheRootNode;



_gna169 =  OfType(_gna170,TypedName);
}

if (_gna169) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 399;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna171;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 399;
_Cur_Node = TheRootNode;
{

GNODE _gna172;
_gna172 = TheRootNode;

_gna171 = (GNODE) GetFillers(_gna172,"id");
}

return (_gna171);
}

}

}
}

}
}
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithUnaryCount (GNODE TheRootNode	)
#else

GNODE DealWithUnaryCount ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE oldValue;
	GNODE newValue;
	GNODE tmp1;

  if (!(OfType(TheRootNode, UnaryCount))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithUnaryCount called with node of type %s, not of type %d UnaryCount",WhatType(TheRootNode->node_type),UnaryCount);
	else printf("\n Procedure DealWithUnaryCount called with invalid node  type %d, not of type %d UnaryCount",TheRootNode->node_type,UnaryCount);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<ue_arg...";
_Cur_SpecLine = 413;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ue_arg */
{


GNODE _gna173;	

_gna173 = (GNODE) GetFillers(TheRootNode,"ue_arg");

 if (_gna173 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 413;
_Cur_Node = _gna173;

{				

  /* EXECUTE ITEM */
{


GNODE _gna174;
	_gna174 = DealWithExpression (_gna173);




	





if (_gna174 != (GNODE) NULL && (GSLOT(_gna174) != (AXS_ENTRY) NULL))
	MarkUsed(_gna174);


tmp1 = _gna174;


}

}

 }	  /* Balances if (_gna173 != (GNODE) NULL )*/

} /* Balances GNODE _gna173; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 415;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna175;

_gna175 = (GNODE) gmalloc ();
_gna175->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna175->node_type = 3;

_gna175->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna175 != (GNODE) NULL)
  if (VALIDTYPE(_gna175->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna175,""); 
  else fprintf(stderr,"\n At line 416 attempt to unparse node of invalid type %d", _gna175->node_type);
else fprintf(stderr,"\n At line 416 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna175;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 417;
_Cur_Node = TheRootNode;
{

GNODE _gna176;


_gna176 = getlocnode(TheRootNode);

_gna175 = (GNODE) GetFillers(_gna176,"line");
}

if (_gna175 != (GNODE) NULL)
  if (VALIDTYPE(_gna175->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna175,""); 
  else fprintf(stderr,"\n At line 417 attempt to unparse node of invalid type %d", _gna175->node_type);
else fprintf(stderr,"\n At line 417 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna175;

_gna175 = (GNODE) gmalloc ();
_gna175->node_flag = GBUILTIN | GSIMPLENODE;
_gna175->node_type = C_String;
_gna175->node_data.l_dv = NodeTable[TheRootNode->node_type]->nodename;

if (_gna175 != (GNODE) NULL)
  if (VALIDTYPE(_gna175->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna175,""); 
  else fprintf(stderr,"\n At line 418 attempt to unparse node of invalid type %d", _gna175->node_type);
else fprintf(stderr,"\n At line 418 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna175;
_gna175 = (GNODE) tmp1;

if (_gna175 != (GNODE) NULL)
  if (VALIDTYPE(_gna175->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna175,""); 
  else fprintf(stderr,"\n At line 418 attempt to unparse node of invalid type %d", _gna175->node_type);
else fprintf(stderr,"\n At line 418 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna175;
_gna175 = (GNODE) tmp1;

if (_gna175 != (GNODE) NULL)
  if (VALIDTYPE(_gna175->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna175,""); 
  else fprintf(stderr,"\n At line 419 attempt to unparse node of invalid type %d", _gna175->node_type);
else fprintf(stderr,"\n At line 419 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna175;
_gna175 = (GNODE) tmp1;

if (_gna175 != (GNODE) NULL)
  if (VALIDTYPE(_gna175->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna175,""); 
  else fprintf(stderr,"\n At line 419 attempt to unparse node of invalid type %d", _gna175->node_type);
else fprintf(stderr,"\n At line 419 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithAssignment (GNODE TheRootNode	)
#else

GNODE DealWithAssignment ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE newValue;
	GNODE leftValue;

  if (!(OfType(TheRootNode, Assignment))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithAssignment called with node of type %s, not of type %d Assignment",WhatType(TheRootNode->node_type),Assignment);
	else printf("\n Procedure DealWithAssignment called with invalid node  type %d, not of type %d Assignment",TheRootNode->node_type,Assignment);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<be_lhs...";
_Cur_SpecLine = 453;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  be_lhs */
{


GNODE _gna177;	

_gna177 = (GNODE) GetFillers(TheRootNode,"be_lhs");

 if (_gna177 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 453;
_Cur_Node = _gna177;

{				

  /* EXECUTE ITEM */
{


GNODE _gna178;
	_gna178 = DealWithExpression (_gna177);




	





if (_gna178 != (GNODE) NULL && (GSLOT(_gna178) != (AXS_ENTRY) NULL))
	MarkUsed(_gna178);


leftValue = _gna178;


}

}

 }	  /* Balances if (_gna177 != (GNODE) NULL )*/

} /* Balances GNODE _gna177; */

}

_Cur_Constr = "<be_rhs...";
_Cur_SpecLine = 455;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  be_rhs */
{


GNODE _gna179;	

_gna179 = (GNODE) GetFillers(TheRootNode,"be_rhs");

 if (_gna179 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 455;
_Cur_Node = _gna179;

{				

  /* EXECUTE ITEM */
{


GNODE _gna180;
	_gna180 = DealWithExpression (_gna179);




	





if (_gna180 != (GNODE) NULL && (GSLOT(_gna180) != (AXS_ENTRY) NULL))
	MarkUsed(_gna180);


newValue = _gna180;


}

}

 }	  /* Balances if (_gna179 != (GNODE) NULL )*/

} /* Balances GNODE _gna179; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 457;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna181;

_gna181 = (GNODE) gmalloc ();
_gna181->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna181->node_type = 3;

_gna181->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna181 != (GNODE) NULL)
  if (VALIDTYPE(_gna181->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna181,""); 
  else fprintf(stderr,"\n At line 458 attempt to unparse node of invalid type %d", _gna181->node_type);
else fprintf(stderr,"\n At line 458 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna181;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 459;
_Cur_Node = TheRootNode;
{

GNODE _gna182;


_gna182 = getlocnode(TheRootNode);

_gna181 = (GNODE) GetFillers(_gna182,"line");
}

if (_gna181 != (GNODE) NULL)
  if (VALIDTYPE(_gna181->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna181,""); 
  else fprintf(stderr,"\n At line 459 attempt to unparse node of invalid type %d", _gna181->node_type);
else fprintf(stderr,"\n At line 459 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna181;
_Cur_Constr = "(NODETYPE...";
_Cur_SpecLine = 460;
_Cur_Node = TheRootNode;
{

GNODE _gna183;
_gna183 = TheRootNode;
_gna181 = (GNODE) gmalloc ();
_gna181->node_flag = GBUILTIN | GSIMPLENODE;
_gna181->node_type = C_String;
_gna181->node_data.l_dv = NodeTable[_gna183->node_type]->nodename;
}

if (_gna181 != (GNODE) NULL)
  if (VALIDTYPE(_gna181->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna181,""); 
  else fprintf(stderr,"\n At line 460 attempt to unparse node of invalid type %d", _gna181->node_type);
else fprintf(stderr,"\n At line 460 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna181;
_gna181 = (GNODE) leftValue;

if (_gna181 != (GNODE) NULL)
  if (VALIDTYPE(_gna181->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna181,""); 
  else fprintf(stderr,"\n At line 461 attempt to unparse node of invalid type %d", _gna181->node_type);
else fprintf(stderr,"\n At line 461 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna181;
_gna181 = (GNODE) newValue;

if (_gna181 != (GNODE) NULL)
  if (VALIDTYPE(_gna181->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna181,""); 
  else fprintf(stderr,"\n At line 461 attempt to unparse node of invalid type %d", _gna181->node_type);
else fprintf(stderr,"\n At line 461 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna181;
_gna181 = (GNODE) leftValue;

if (_gna181 != (GNODE) NULL)
  if (VALIDTYPE(_gna181->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna181,""); 
  else fprintf(stderr,"\n At line 462 attempt to unparse node of invalid type %d", _gna181->node_type);
else fprintf(stderr,"\n At line 462 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna181;
_gna181 = (GNODE) newValue;

if (_gna181 != (GNODE) NULL)
  if (VALIDTYPE(_gna181->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna181,""); 
  else fprintf(stderr,"\n At line 462 attempt to unparse node of invalid type %d", _gna181->node_type);
else fprintf(stderr,"\n At line 462 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna181;
_gna181 = (GNODE) leftValue;

if (_gna181 != (GNODE) NULL)
  if (VALIDTYPE(_gna181->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna181,""); 
  else fprintf(stderr,"\n At line 462 attempt to unparse node of invalid type %d", _gna181->node_type);
else fprintf(stderr,"\n At line 462 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 464;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna184;
_gna184 = gcopy((GNODE) newValue);

return (_gna184);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithPostInc (GNODE TheRootNode	)
#else

GNODE DealWithPostInc ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE oldValue;
	GNODE newValue;
	GNODE tmp1;

  if (!(OfType(TheRootNode, PostInc))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithPostInc called with node of type %s, not of type %d PostInc",WhatType(TheRootNode->node_type),PostInc);
	else printf("\n Procedure DealWithPostInc called with invalid node  type %d, not of type %d PostInc",TheRootNode->node_type,PostInc);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<ue_arg...";
_Cur_SpecLine = 482;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ue_arg */
{


GNODE _gna185;	

_gna185 = (GNODE) GetFillers(TheRootNode,"ue_arg");

 if (_gna185 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 482;
_Cur_Node = _gna185;

{				

  /* EXECUTE ITEM */
{


GNODE _gna186;
	_gna186 = DealWithExpression (_gna185);




	





if (_gna186 != (GNODE) NULL && (GSLOT(_gna186) != (AXS_ENTRY) NULL))
	MarkUsed(_gna186);


tmp1 = _gna186;


}

}

 }	  /* Balances if (_gna185 != (GNODE) NULL )*/

} /* Balances GNODE _gna185; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 484;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna187;

_gna187 = (GNODE) gmalloc ();
_gna187->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna187->node_type = 3;

_gna187->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna187 != (GNODE) NULL && (GSLOT(_gna187) != (AXS_ENTRY) NULL))
	MarkUsed(_gna187);


oldValue = _gna187;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 485;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna188;

_gna188 = (GNODE) gmalloc ();
_gna188->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna188->node_type = 3;

_gna188->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna188 != (GNODE) NULL)
  if (VALIDTYPE(_gna188->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna188,""); 
  else fprintf(stderr,"\n At line 486 attempt to unparse node of invalid type %d", _gna188->node_type);
else fprintf(stderr,"\n At line 486 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna188;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 487;
_Cur_Node = TheRootNode;
{

GNODE _gna189;


_gna189 = getlocnode(TheRootNode);

_gna188 = (GNODE) GetFillers(_gna189,"line");
}

if (_gna188 != (GNODE) NULL)
  if (VALIDTYPE(_gna188->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna188,""); 
  else fprintf(stderr,"\n At line 487 attempt to unparse node of invalid type %d", _gna188->node_type);
else fprintf(stderr,"\n At line 487 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Assign "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna188;
_gna188 = (GNODE) oldValue;

if (_gna188 != (GNODE) NULL)
  if (VALIDTYPE(_gna188->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna188,""); 
  else fprintf(stderr,"\n At line 488 attempt to unparse node of invalid type %d", _gna188->node_type);
else fprintf(stderr,"\n At line 488 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna188;
_gna188 = (GNODE) tmp1;

if (_gna188 != (GNODE) NULL)
  if (VALIDTYPE(_gna188->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna188,""); 
  else fprintf(stderr,"\n At line 488 attempt to unparse node of invalid type %d", _gna188->node_type);
else fprintf(stderr,"\n At line 488 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna188;
_gna188 = (GNODE) oldValue;

if (_gna188 != (GNODE) NULL)
  if (VALIDTYPE(_gna188->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna188,""); 
  else fprintf(stderr,"\n At line 489 attempt to unparse node of invalid type %d", _gna188->node_type);
else fprintf(stderr,"\n At line 489 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna188;
_gna188 = (GNODE) tmp1;

if (_gna188 != (GNODE) NULL)
  if (VALIDTYPE(_gna188->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna188,""); 
  else fprintf(stderr,"\n At line 489 attempt to unparse node of invalid type %d", _gna188->node_type);
else fprintf(stderr,"\n At line 489 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna188;
_gna188 = (GNODE) oldValue;

if (_gna188 != (GNODE) NULL)
  if (VALIDTYPE(_gna188->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna188,""); 
  else fprintf(stderr,"\n At line 489 attempt to unparse node of invalid type %d", _gna188->node_type);
else fprintf(stderr,"\n At line 489 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 492;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna190;

_gna190 = (GNODE) gmalloc ();
_gna190->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna190->node_type = 3;

_gna190->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna190 != (GNODE) NULL && (GSLOT(_gna190) != (AXS_ENTRY) NULL))
	MarkUsed(_gna190);


newValue = _gna190;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 493;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna191;

_gna191 = (GNODE) gmalloc ();
_gna191->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna191->node_type = 3;

_gna191->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna191 != (GNODE) NULL)
  if (VALIDTYPE(_gna191->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna191,""); 
  else fprintf(stderr,"\n At line 494 attempt to unparse node of invalid type %d", _gna191->node_type);
else fprintf(stderr,"\n At line 494 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna191;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 495;
_Cur_Node = TheRootNode;
{

GNODE _gna192;


_gna192 = getlocnode(TheRootNode);

_gna191 = (GNODE) GetFillers(_gna192,"line");
}

if (_gna191 != (GNODE) NULL)
  if (VALIDTYPE(_gna191->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna191,""); 
  else fprintf(stderr,"\n At line 495 attempt to unparse node of invalid type %d", _gna191->node_type);
else fprintf(stderr,"\n At line 495 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Plus "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna191;
_gna191 = (GNODE) tmp1;

if (_gna191 != (GNODE) NULL)
  if (VALIDTYPE(_gna191->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna191,""); 
  else fprintf(stderr,"\n At line 496 attempt to unparse node of invalid type %d", _gna191->node_type);
else fprintf(stderr,"\n At line 496 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  1 "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna191;
_gna191 = (GNODE) newValue;

if (_gna191 != (GNODE) NULL)
  if (VALIDTYPE(_gna191->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna191,""); 
  else fprintf(stderr,"\n At line 496 attempt to unparse node of invalid type %d", _gna191->node_type);
else fprintf(stderr,"\n At line 496 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna191;
_gna191 = (GNODE) tmp1;

if (_gna191 != (GNODE) NULL)
  if (VALIDTYPE(_gna191->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna191,""); 
  else fprintf(stderr,"\n At line 497 attempt to unparse node of invalid type %d", _gna191->node_type);
else fprintf(stderr,"\n At line 497 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna191;
_gna191 = (GNODE) newValue;

if (_gna191 != (GNODE) NULL)
  if (VALIDTYPE(_gna191->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna191,""); 
  else fprintf(stderr,"\n At line 497 attempt to unparse node of invalid type %d", _gna191->node_type);
else fprintf(stderr,"\n At line 497 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna191;
_gna191 = (GNODE) newValue;

if (_gna191 != (GNODE) NULL)
  if (VALIDTYPE(_gna191->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna191,""); 
  else fprintf(stderr,"\n At line 497 attempt to unparse node of invalid type %d", _gna191->node_type);
else fprintf(stderr,"\n At line 497 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 499;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna193;

_gna193 = (GNODE) gmalloc ();
_gna193->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna193->node_type = 3;

_gna193->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna193 != (GNODE) NULL)
  if (VALIDTYPE(_gna193->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna193,""); 
  else fprintf(stderr,"\n At line 500 attempt to unparse node of invalid type %d", _gna193->node_type);
else fprintf(stderr,"\n At line 500 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna193;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 501;
_Cur_Node = TheRootNode;
{

GNODE _gna194;


_gna194 = getlocnode(TheRootNode);

_gna193 = (GNODE) GetFillers(_gna194,"line");
}

if (_gna193 != (GNODE) NULL)
  if (VALIDTYPE(_gna193->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna193,""); 
  else fprintf(stderr,"\n At line 501 attempt to unparse node of invalid type %d", _gna193->node_type);
else fprintf(stderr,"\n At line 501 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Assign "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna193;
_gna193 = (GNODE) tmp1;

if (_gna193 != (GNODE) NULL)
  if (VALIDTYPE(_gna193->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna193,""); 
  else fprintf(stderr,"\n At line 502 attempt to unparse node of invalid type %d", _gna193->node_type);
else fprintf(stderr,"\n At line 502 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna193;
_gna193 = (GNODE) newValue;

if (_gna193 != (GNODE) NULL)
  if (VALIDTYPE(_gna193->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna193,""); 
  else fprintf(stderr,"\n At line 502 attempt to unparse node of invalid type %d", _gna193->node_type);
else fprintf(stderr,"\n At line 502 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna193;
_gna193 = (GNODE) tmp1;

if (_gna193 != (GNODE) NULL)
  if (VALIDTYPE(_gna193->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna193,""); 
  else fprintf(stderr,"\n At line 503 attempt to unparse node of invalid type %d", _gna193->node_type);
else fprintf(stderr,"\n At line 503 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna193;
_gna193 = (GNODE) newValue;

if (_gna193 != (GNODE) NULL)
  if (VALIDTYPE(_gna193->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna193,""); 
  else fprintf(stderr,"\n At line 503 attempt to unparse node of invalid type %d", _gna193->node_type);
else fprintf(stderr,"\n At line 503 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna193;
_gna193 = (GNODE) tmp1;

if (_gna193 != (GNODE) NULL)
  if (VALIDTYPE(_gna193->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna193,""); 
  else fprintf(stderr,"\n At line 503 attempt to unparse node of invalid type %d", _gna193->node_type);
else fprintf(stderr,"\n At line 503 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 506;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna195;
_gna195 = gcopy((GNODE) oldValue);

return (_gna195);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithPostDec (GNODE TheRootNode	)
#else

GNODE DealWithPostDec ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE oldValue;
	GNODE newValue;
	GNODE tmp1;

  if (!(OfType(TheRootNode, PostDec))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithPostDec called with node of type %s, not of type %d PostDec",WhatType(TheRootNode->node_type),PostDec);
	else printf("\n Procedure DealWithPostDec called with invalid node  type %d, not of type %d PostDec",TheRootNode->node_type,PostDec);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<ue_arg...";
_Cur_SpecLine = 518;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ue_arg */
{


GNODE _gna196;	

_gna196 = (GNODE) GetFillers(TheRootNode,"ue_arg");

 if (_gna196 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 518;
_Cur_Node = _gna196;

{				

  /* EXECUTE ITEM */
{


GNODE _gna197;
	_gna197 = DealWithExpression (_gna196);




	





if (_gna197 != (GNODE) NULL && (GSLOT(_gna197) != (AXS_ENTRY) NULL))
	MarkUsed(_gna197);


tmp1 = _gna197;


}

}

 }	  /* Balances if (_gna196 != (GNODE) NULL )*/

} /* Balances GNODE _gna196; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 520;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna198;

_gna198 = (GNODE) gmalloc ();
_gna198->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna198->node_type = 3;

_gna198->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna198 != (GNODE) NULL && (GSLOT(_gna198) != (AXS_ENTRY) NULL))
	MarkUsed(_gna198);


oldValue = _gna198;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 521;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna199;

_gna199 = (GNODE) gmalloc ();
_gna199->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna199->node_type = 3;

_gna199->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna199 != (GNODE) NULL)
  if (VALIDTYPE(_gna199->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna199,""); 
  else fprintf(stderr,"\n At line 522 attempt to unparse node of invalid type %d", _gna199->node_type);
else fprintf(stderr,"\n At line 522 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna199;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 523;
_Cur_Node = TheRootNode;
{

GNODE _gna200;


_gna200 = getlocnode(TheRootNode);

_gna199 = (GNODE) GetFillers(_gna200,"line");
}

if (_gna199 != (GNODE) NULL)
  if (VALIDTYPE(_gna199->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna199,""); 
  else fprintf(stderr,"\n At line 523 attempt to unparse node of invalid type %d", _gna199->node_type);
else fprintf(stderr,"\n At line 523 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Assign "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna199;
_gna199 = (GNODE) oldValue;

if (_gna199 != (GNODE) NULL)
  if (VALIDTYPE(_gna199->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna199,""); 
  else fprintf(stderr,"\n At line 524 attempt to unparse node of invalid type %d", _gna199->node_type);
else fprintf(stderr,"\n At line 524 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna199;
_gna199 = (GNODE) tmp1;

if (_gna199 != (GNODE) NULL)
  if (VALIDTYPE(_gna199->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna199,""); 
  else fprintf(stderr,"\n At line 524 attempt to unparse node of invalid type %d", _gna199->node_type);
else fprintf(stderr,"\n At line 524 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna199;
_gna199 = (GNODE) oldValue;

if (_gna199 != (GNODE) NULL)
  if (VALIDTYPE(_gna199->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna199,""); 
  else fprintf(stderr,"\n At line 525 attempt to unparse node of invalid type %d", _gna199->node_type);
else fprintf(stderr,"\n At line 525 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna199;
_gna199 = (GNODE) tmp1;

if (_gna199 != (GNODE) NULL)
  if (VALIDTYPE(_gna199->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna199,""); 
  else fprintf(stderr,"\n At line 525 attempt to unparse node of invalid type %d", _gna199->node_type);
else fprintf(stderr,"\n At line 525 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna199;
_gna199 = (GNODE) oldValue;

if (_gna199 != (GNODE) NULL)
  if (VALIDTYPE(_gna199->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna199,""); 
  else fprintf(stderr,"\n At line 525 attempt to unparse node of invalid type %d", _gna199->node_type);
else fprintf(stderr,"\n At line 525 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 528;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna201;

_gna201 = (GNODE) gmalloc ();
_gna201->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna201->node_type = 3;

_gna201->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna201 != (GNODE) NULL && (GSLOT(_gna201) != (AXS_ENTRY) NULL))
	MarkUsed(_gna201);


newValue = _gna201;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 529;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna202;

_gna202 = (GNODE) gmalloc ();
_gna202->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna202->node_type = 3;

_gna202->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna202 != (GNODE) NULL)
  if (VALIDTYPE(_gna202->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna202,""); 
  else fprintf(stderr,"\n At line 530 attempt to unparse node of invalid type %d", _gna202->node_type);
else fprintf(stderr,"\n At line 530 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna202;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 531;
_Cur_Node = TheRootNode;
{

GNODE _gna203;


_gna203 = getlocnode(TheRootNode);

_gna202 = (GNODE) GetFillers(_gna203,"line");
}

if (_gna202 != (GNODE) NULL)
  if (VALIDTYPE(_gna202->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna202,""); 
  else fprintf(stderr,"\n At line 531 attempt to unparse node of invalid type %d", _gna202->node_type);
else fprintf(stderr,"\n At line 531 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Minus "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna202;
_gna202 = (GNODE) tmp1;

if (_gna202 != (GNODE) NULL)
  if (VALIDTYPE(_gna202->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna202,""); 
  else fprintf(stderr,"\n At line 532 attempt to unparse node of invalid type %d", _gna202->node_type);
else fprintf(stderr,"\n At line 532 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  1 "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna202;
_gna202 = (GNODE) newValue;

if (_gna202 != (GNODE) NULL)
  if (VALIDTYPE(_gna202->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna202,""); 
  else fprintf(stderr,"\n At line 532 attempt to unparse node of invalid type %d", _gna202->node_type);
else fprintf(stderr,"\n At line 532 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna202;
_gna202 = (GNODE) tmp1;

if (_gna202 != (GNODE) NULL)
  if (VALIDTYPE(_gna202->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna202,""); 
  else fprintf(stderr,"\n At line 533 attempt to unparse node of invalid type %d", _gna202->node_type);
else fprintf(stderr,"\n At line 533 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna202;
_gna202 = (GNODE) newValue;

if (_gna202 != (GNODE) NULL)
  if (VALIDTYPE(_gna202->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna202,""); 
  else fprintf(stderr,"\n At line 533 attempt to unparse node of invalid type %d", _gna202->node_type);
else fprintf(stderr,"\n At line 533 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna202;
_gna202 = (GNODE) newValue;

if (_gna202 != (GNODE) NULL)
  if (VALIDTYPE(_gna202->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna202,""); 
  else fprintf(stderr,"\n At line 533 attempt to unparse node of invalid type %d", _gna202->node_type);
else fprintf(stderr,"\n At line 533 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 535;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna204;

_gna204 = (GNODE) gmalloc ();
_gna204->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna204->node_type = 3;

_gna204->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna204 != (GNODE) NULL)
  if (VALIDTYPE(_gna204->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna204,""); 
  else fprintf(stderr,"\n At line 536 attempt to unparse node of invalid type %d", _gna204->node_type);
else fprintf(stderr,"\n At line 536 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna204;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 537;
_Cur_Node = TheRootNode;
{

GNODE _gna205;


_gna205 = getlocnode(TheRootNode);

_gna204 = (GNODE) GetFillers(_gna205,"line");
}

if (_gna204 != (GNODE) NULL)
  if (VALIDTYPE(_gna204->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna204,""); 
  else fprintf(stderr,"\n At line 537 attempt to unparse node of invalid type %d", _gna204->node_type);
else fprintf(stderr,"\n At line 537 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Assign "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna204;
_gna204 = (GNODE) tmp1;

if (_gna204 != (GNODE) NULL)
  if (VALIDTYPE(_gna204->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna204,""); 
  else fprintf(stderr,"\n At line 538 attempt to unparse node of invalid type %d", _gna204->node_type);
else fprintf(stderr,"\n At line 538 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna204;
_gna204 = (GNODE) newValue;

if (_gna204 != (GNODE) NULL)
  if (VALIDTYPE(_gna204->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna204,""); 
  else fprintf(stderr,"\n At line 538 attempt to unparse node of invalid type %d", _gna204->node_type);
else fprintf(stderr,"\n At line 538 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna204;
_gna204 = (GNODE) tmp1;

if (_gna204 != (GNODE) NULL)
  if (VALIDTYPE(_gna204->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna204,""); 
  else fprintf(stderr,"\n At line 539 attempt to unparse node of invalid type %d", _gna204->node_type);
else fprintf(stderr,"\n At line 539 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna204;
_gna204 = (GNODE) newValue;

if (_gna204 != (GNODE) NULL)
  if (VALIDTYPE(_gna204->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna204,""); 
  else fprintf(stderr,"\n At line 539 attempt to unparse node of invalid type %d", _gna204->node_type);
else fprintf(stderr,"\n At line 539 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna204;
_gna204 = (GNODE) tmp1;

if (_gna204 != (GNODE) NULL)
  if (VALIDTYPE(_gna204->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna204,""); 
  else fprintf(stderr,"\n At line 539 attempt to unparse node of invalid type %d", _gna204->node_type);
else fprintf(stderr,"\n At line 539 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 542;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna206;
_gna206 = gcopy((GNODE) oldValue);

return (_gna206);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithPreInc (GNODE TheRootNode	)
#else

GNODE DealWithPreInc ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE oldValue;
	GNODE newValue;
	GNODE tmp1;

  if (!(OfType(TheRootNode, PreInc))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithPreInc called with node of type %s, not of type %d PreInc",WhatType(TheRootNode->node_type),PreInc);
	else printf("\n Procedure DealWithPreInc called with invalid node  type %d, not of type %d PreInc",TheRootNode->node_type,PreInc);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<ue_arg...";
_Cur_SpecLine = 554;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ue_arg */
{


GNODE _gna207;	

_gna207 = (GNODE) GetFillers(TheRootNode,"ue_arg");

 if (_gna207 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 554;
_Cur_Node = _gna207;

{				

  /* EXECUTE ITEM */
{


GNODE _gna208;
	_gna208 = DealWithExpression (_gna207);




	





if (_gna208 != (GNODE) NULL && (GSLOT(_gna208) != (AXS_ENTRY) NULL))
	MarkUsed(_gna208);


tmp1 = _gna208;


}

}

 }	  /* Balances if (_gna207 != (GNODE) NULL )*/

} /* Balances GNODE _gna207; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 563;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna209;

_gna209 = (GNODE) gmalloc ();
_gna209->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna209->node_type = 3;

_gna209->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna209 != (GNODE) NULL && (GSLOT(_gna209) != (AXS_ENTRY) NULL))
	MarkUsed(_gna209);


newValue = _gna209;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 564;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna210;

_gna210 = (GNODE) gmalloc ();
_gna210->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna210->node_type = 3;

_gna210->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna210 != (GNODE) NULL)
  if (VALIDTYPE(_gna210->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna210,""); 
  else fprintf(stderr,"\n At line 565 attempt to unparse node of invalid type %d", _gna210->node_type);
else fprintf(stderr,"\n At line 565 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna210;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 566;
_Cur_Node = TheRootNode;
{

GNODE _gna211;


_gna211 = getlocnode(TheRootNode);

_gna210 = (GNODE) GetFillers(_gna211,"line");
}

if (_gna210 != (GNODE) NULL)
  if (VALIDTYPE(_gna210->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna210,""); 
  else fprintf(stderr,"\n At line 566 attempt to unparse node of invalid type %d", _gna210->node_type);
else fprintf(stderr,"\n At line 566 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Plus "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna210;
_gna210 = (GNODE) tmp1;

if (_gna210 != (GNODE) NULL)
  if (VALIDTYPE(_gna210->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna210,""); 
  else fprintf(stderr,"\n At line 567 attempt to unparse node of invalid type %d", _gna210->node_type);
else fprintf(stderr,"\n At line 567 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  1 "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna210;
_gna210 = (GNODE) newValue;

if (_gna210 != (GNODE) NULL)
  if (VALIDTYPE(_gna210->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna210,""); 
  else fprintf(stderr,"\n At line 567 attempt to unparse node of invalid type %d", _gna210->node_type);
else fprintf(stderr,"\n At line 567 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna210;
_gna210 = (GNODE) tmp1;

if (_gna210 != (GNODE) NULL)
  if (VALIDTYPE(_gna210->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna210,""); 
  else fprintf(stderr,"\n At line 568 attempt to unparse node of invalid type %d", _gna210->node_type);
else fprintf(stderr,"\n At line 568 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna210;
_gna210 = (GNODE) newValue;

if (_gna210 != (GNODE) NULL)
  if (VALIDTYPE(_gna210->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna210,""); 
  else fprintf(stderr,"\n At line 568 attempt to unparse node of invalid type %d", _gna210->node_type);
else fprintf(stderr,"\n At line 568 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna210;
_gna210 = (GNODE) newValue;

if (_gna210 != (GNODE) NULL)
  if (VALIDTYPE(_gna210->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna210,""); 
  else fprintf(stderr,"\n At line 568 attempt to unparse node of invalid type %d", _gna210->node_type);
else fprintf(stderr,"\n At line 568 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 570;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna212;

_gna212 = (GNODE) gmalloc ();
_gna212->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna212->node_type = 3;

_gna212->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna212 != (GNODE) NULL)
  if (VALIDTYPE(_gna212->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna212,""); 
  else fprintf(stderr,"\n At line 571 attempt to unparse node of invalid type %d", _gna212->node_type);
else fprintf(stderr,"\n At line 571 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna212;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 572;
_Cur_Node = TheRootNode;
{

GNODE _gna213;


_gna213 = getlocnode(TheRootNode);

_gna212 = (GNODE) GetFillers(_gna213,"line");
}

if (_gna212 != (GNODE) NULL)
  if (VALIDTYPE(_gna212->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna212,""); 
  else fprintf(stderr,"\n At line 572 attempt to unparse node of invalid type %d", _gna212->node_type);
else fprintf(stderr,"\n At line 572 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Assign "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna212;
_gna212 = (GNODE) tmp1;

if (_gna212 != (GNODE) NULL)
  if (VALIDTYPE(_gna212->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna212,""); 
  else fprintf(stderr,"\n At line 573 attempt to unparse node of invalid type %d", _gna212->node_type);
else fprintf(stderr,"\n At line 573 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna212;
_gna212 = (GNODE) newValue;

if (_gna212 != (GNODE) NULL)
  if (VALIDTYPE(_gna212->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna212,""); 
  else fprintf(stderr,"\n At line 573 attempt to unparse node of invalid type %d", _gna212->node_type);
else fprintf(stderr,"\n At line 573 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna212;
_gna212 = (GNODE) tmp1;

if (_gna212 != (GNODE) NULL)
  if (VALIDTYPE(_gna212->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna212,""); 
  else fprintf(stderr,"\n At line 574 attempt to unparse node of invalid type %d", _gna212->node_type);
else fprintf(stderr,"\n At line 574 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna212;
_gna212 = (GNODE) newValue;

if (_gna212 != (GNODE) NULL)
  if (VALIDTYPE(_gna212->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna212,""); 
  else fprintf(stderr,"\n At line 574 attempt to unparse node of invalid type %d", _gna212->node_type);
else fprintf(stderr,"\n At line 574 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna212;
_gna212 = (GNODE) tmp1;

if (_gna212 != (GNODE) NULL)
  if (VALIDTYPE(_gna212->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna212,""); 
  else fprintf(stderr,"\n At line 574 attempt to unparse node of invalid type %d", _gna212->node_type);
else fprintf(stderr,"\n At line 574 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 577;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna214;
_gna214 = gcopy((GNODE) newValue);

return (_gna214);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithPreDec (GNODE TheRootNode	)
#else

GNODE DealWithPreDec ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE oldValue;
	GNODE newValue;
	GNODE tmp1;

  if (!(OfType(TheRootNode, PreDec))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithPreDec called with node of type %s, not of type %d PreDec",WhatType(TheRootNode->node_type),PreDec);
	else printf("\n Procedure DealWithPreDec called with invalid node  type %d, not of type %d PreDec",TheRootNode->node_type,PreDec);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<ue_arg...";
_Cur_SpecLine = 589;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ue_arg */
{


GNODE _gna215;	

_gna215 = (GNODE) GetFillers(TheRootNode,"ue_arg");

 if (_gna215 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 589;
_Cur_Node = _gna215;

{				

  /* EXECUTE ITEM */
{


GNODE _gna216;
	_gna216 = DealWithExpression (_gna215);




	





if (_gna216 != (GNODE) NULL && (GSLOT(_gna216) != (AXS_ENTRY) NULL))
	MarkUsed(_gna216);


tmp1 = _gna216;


}

}

 }	  /* Balances if (_gna215 != (GNODE) NULL )*/

} /* Balances GNODE _gna215; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 598;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna217;

_gna217 = (GNODE) gmalloc ();
_gna217->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna217->node_type = 3;

_gna217->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna217 != (GNODE) NULL && (GSLOT(_gna217) != (AXS_ENTRY) NULL))
	MarkUsed(_gna217);


newValue = _gna217;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 599;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna218;

_gna218 = (GNODE) gmalloc ();
_gna218->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna218->node_type = 3;

_gna218->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna218 != (GNODE) NULL)
  if (VALIDTYPE(_gna218->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna218,""); 
  else fprintf(stderr,"\n At line 600 attempt to unparse node of invalid type %d", _gna218->node_type);
else fprintf(stderr,"\n At line 600 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna218;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 601;
_Cur_Node = TheRootNode;
{

GNODE _gna219;


_gna219 = getlocnode(TheRootNode);

_gna218 = (GNODE) GetFillers(_gna219,"line");
}

if (_gna218 != (GNODE) NULL)
  if (VALIDTYPE(_gna218->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna218,""); 
  else fprintf(stderr,"\n At line 601 attempt to unparse node of invalid type %d", _gna218->node_type);
else fprintf(stderr,"\n At line 601 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Minus "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna218;
_gna218 = (GNODE) tmp1;

if (_gna218 != (GNODE) NULL)
  if (VALIDTYPE(_gna218->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna218,""); 
  else fprintf(stderr,"\n At line 602 attempt to unparse node of invalid type %d", _gna218->node_type);
else fprintf(stderr,"\n At line 602 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  1 "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna218;
_gna218 = (GNODE) newValue;

if (_gna218 != (GNODE) NULL)
  if (VALIDTYPE(_gna218->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna218,""); 
  else fprintf(stderr,"\n At line 602 attempt to unparse node of invalid type %d", _gna218->node_type);
else fprintf(stderr,"\n At line 602 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna218;
_gna218 = (GNODE) tmp1;

if (_gna218 != (GNODE) NULL)
  if (VALIDTYPE(_gna218->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna218,""); 
  else fprintf(stderr,"\n At line 603 attempt to unparse node of invalid type %d", _gna218->node_type);
else fprintf(stderr,"\n At line 603 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna218;
_gna218 = (GNODE) newValue;

if (_gna218 != (GNODE) NULL)
  if (VALIDTYPE(_gna218->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna218,""); 
  else fprintf(stderr,"\n At line 603 attempt to unparse node of invalid type %d", _gna218->node_type);
else fprintf(stderr,"\n At line 603 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna218;
_gna218 = (GNODE) newValue;

if (_gna218 != (GNODE) NULL)
  if (VALIDTYPE(_gna218->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna218,""); 
  else fprintf(stderr,"\n At line 603 attempt to unparse node of invalid type %d", _gna218->node_type);
else fprintf(stderr,"\n At line 603 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 605;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna220;

_gna220 = (GNODE) gmalloc ();
_gna220->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna220->node_type = 3;

_gna220->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna220 != (GNODE) NULL)
  if (VALIDTYPE(_gna220->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna220,""); 
  else fprintf(stderr,"\n At line 606 attempt to unparse node of invalid type %d", _gna220->node_type);
else fprintf(stderr,"\n At line 606 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna220;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 607;
_Cur_Node = TheRootNode;
{

GNODE _gna221;


_gna221 = getlocnode(TheRootNode);

_gna220 = (GNODE) GetFillers(_gna221,"line");
}

if (_gna220 != (GNODE) NULL)
  if (VALIDTYPE(_gna220->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna220,""); 
  else fprintf(stderr,"\n At line 607 attempt to unparse node of invalid type %d", _gna220->node_type);
else fprintf(stderr,"\n At line 607 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Assign "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna220;
_gna220 = (GNODE) tmp1;

if (_gna220 != (GNODE) NULL)
  if (VALIDTYPE(_gna220->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna220,""); 
  else fprintf(stderr,"\n At line 608 attempt to unparse node of invalid type %d", _gna220->node_type);
else fprintf(stderr,"\n At line 608 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna220;
_gna220 = (GNODE) newValue;

if (_gna220 != (GNODE) NULL)
  if (VALIDTYPE(_gna220->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna220,""); 
  else fprintf(stderr,"\n At line 608 attempt to unparse node of invalid type %d", _gna220->node_type);
else fprintf(stderr,"\n At line 608 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna220;
_gna220 = (GNODE) tmp1;

if (_gna220 != (GNODE) NULL)
  if (VALIDTYPE(_gna220->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna220,""); 
  else fprintf(stderr,"\n At line 609 attempt to unparse node of invalid type %d", _gna220->node_type);
else fprintf(stderr,"\n At line 609 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna220;
_gna220 = (GNODE) newValue;

if (_gna220 != (GNODE) NULL)
  if (VALIDTYPE(_gna220->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna220,""); 
  else fprintf(stderr,"\n At line 609 attempt to unparse node of invalid type %d", _gna220->node_type);
else fprintf(stderr,"\n At line 609 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna220;
_gna220 = (GNODE) tmp1;

if (_gna220 != (GNODE) NULL)
  if (VALIDTYPE(_gna220->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna220,""); 
  else fprintf(stderr,"\n At line 609 attempt to unparse node of invalid type %d", _gna220->node_type);
else fprintf(stderr,"\n At line 609 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 612;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna222;
_gna222 = gcopy((GNODE) newValue);

return (_gna222);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithStatement (GNODE TheRootNode	)
#else

GNODE DealWithStatement ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, Statement))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithStatement called with node of type %s, not of type %d Statement",WhatType(TheRootNode->node_type),Statement);
	else printf("\n Procedure DealWithStatement called with invalid node  type %d, not of type %d Statement",TheRootNode->node_type,Statement);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(IF...";
_Cur_SpecLine = 627;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna223;
{

GNODE _gna224;
_gna224 = TheRootNode;



_gna223 =  OfType(_gna224,Goto);
}

if (_gna223) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 628;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithGoto (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 631;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna225;
{

GNODE _gna226;
_gna226 = TheRootNode;



_gna225 =  OfType(_gna226,LabelStmt);
}

if (_gna225) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 632;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithLabelStmt (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 635;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna227;
{

GNODE _gna228;
_gna228 = TheRootNode;



_gna227 =  OfType(_gna228,Continue);
}

if (_gna227) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 636;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithContinue (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 639;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna229;
{

GNODE _gna230;
_gna230 = TheRootNode;



_gna229 =  OfType(_gna230,Break);
}

if (_gna229) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 640;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithBreak (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 643;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna231;
{

GNODE _gna232;
_gna232 = TheRootNode;



_gna231 =  OfType(_gna232,Switch);
}

if (_gna231) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 644;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithSwitch (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 647;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna233;
{

GNODE _gna234;
_gna234 = TheRootNode;



_gna233 =  OfType(_gna234,Do);
}

if (_gna233) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 648;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithDo (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 651;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna235;
{

GNODE _gna236;
_gna236 = TheRootNode;



_gna235 =  OfType(_gna236,For);
}

if (_gna235) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 652;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithFor (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 655;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna237;
{

GNODE _gna238;
_gna238 = TheRootNode;



_gna237 =  OfType(_gna238,While);
}

if (_gna237) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 656;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithWhile (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 659;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna239;
{

GNODE _gna240;
_gna240 = TheRootNode;



_gna239 =  OfType(_gna240,If);
}

if (_gna239) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 660;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithIf (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 663;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna241;
{

GNODE _gna242;
_gna242 = TheRootNode;



_gna241 =  OfType(_gna242,Block);
}

if (_gna241) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 664;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithBlock (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 667;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna243;
{

GNODE _gna244;
_gna244 = TheRootNode;



_gna243 =  OfType(_gna244,Return);
}

if (_gna243) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 668;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithReturn (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 671;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna245;
{

GNODE _gna246;
_gna246 = TheRootNode;



_gna245 =  OfType(_gna246,NullStmt);
}

if (_gna245) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 672;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithNullStmt (TheRootNode);  


}

}
else {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 675;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna247;
{

GNODE _gna248;
_gna248 = TheRootNode;



_gna247 =  OfType(_gna248,ExprStmt);
}

if (_gna247) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 676;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithExprStmt (TheRootNode);  


}

}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithGoto (GNODE TheRootNode	)
#else

GNODE DealWithGoto ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE label;

  if (!(OfType(TheRootNode, Goto))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithGoto called with node of type %s, not of type %d Goto",WhatType(TheRootNode->node_type),Goto);
	else printf("\n Procedure DealWithGoto called with invalid node  type %d, not of type %d Goto",TheRootNode->node_type,Goto);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<gotoname...";
_Cur_SpecLine = 693;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  gotoname */
{


GNODE _gna249;	

_gna249 = (GNODE) GetFillers(TheRootNode,"gotoname");

 if (_gna249 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 693;
_Cur_Node = _gna249;

{				

  /* EXECUTE ITEM */
{


GNODE _gna250;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 693;
_Cur_Node = _gna249;
{

GNODE _gna251;
_gna251 = _gna249;

_gna250 = (GNODE) GetFillers(_gna251,"id");
}

if (_gna250 != (GNODE) NULL && (GSLOT(_gna250) != (AXS_ENTRY) NULL))
	MarkUsed(_gna250);


label = _gna250;


}

}

 }	  /* Balances if (_gna249 != (GNODE) NULL )*/

} /* Balances GNODE _gna249; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 694;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna252;

_gna252 = (GNODE) gmalloc ();
_gna252->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna252->node_type = 3;

_gna252->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna252 != (GNODE) NULL)
  if (VALIDTYPE(_gna252->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna252,""); 
  else fprintf(stderr,"\n At line 695 attempt to unparse node of invalid type %d", _gna252->node_type);
else fprintf(stderr,"\n At line 695 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna252;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 696;
_Cur_Node = TheRootNode;
{

GNODE _gna253;


_gna253 = getlocnode(TheRootNode);

_gna252 = (GNODE) GetFillers(_gna253,"line");
}

if (_gna252 != (GNODE) NULL)
  if (VALIDTYPE(_gna252->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna252,""); 
  else fprintf(stderr,"\n At line 696 attempt to unparse node of invalid type %d", _gna252->node_type);
else fprintf(stderr,"\n At line 696 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna252;
_Cur_Constr = "(NODETYPE...";
_Cur_SpecLine = 697;
_Cur_Node = TheRootNode;
{

GNODE _gna254;
_gna254 = TheRootNode;
_gna252 = (GNODE) gmalloc ();
_gna252->node_flag = GBUILTIN | GSIMPLENODE;
_gna252->node_type = C_String;
_gna252->node_data.l_dv = NodeTable[_gna254->node_type]->nodename;
}

if (_gna252 != (GNODE) NULL)
  if (VALIDTYPE(_gna252->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna252,""); 
  else fprintf(stderr,"\n At line 697 attempt to unparse node of invalid type %d", _gna252->node_type);
else fprintf(stderr,"\n At line 697 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna252;
_gna252 = (GNODE) label;

if (_gna252 != (GNODE) NULL)
  if (VALIDTYPE(_gna252->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna252,""); 
  else fprintf(stderr,"\n At line 698 attempt to unparse node of invalid type %d", _gna252->node_type);
else fprintf(stderr,"\n At line 698 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithLabelStmt (GNODE TheRootNode	)
#else

GNODE DealWithLabelStmt ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, LabelStmt))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithLabelStmt called with node of type %s, not of type %d LabelStmt",WhatType(TheRootNode->node_type),LabelStmt);
	else printf("\n Procedure DealWithLabelStmt called with invalid node  type %d, not of type %d LabelStmt",TheRootNode->node_type,LabelStmt);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(IF...";
_Cur_SpecLine = 710;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna255;
{

GNODE _gna256;
_gna256 = TheRootNode;



_gna255 =  OfType(_gna256,Label);
}

if (_gna255) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 712;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna257;

_gna257 = (GNODE) gmalloc ();
_gna257->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna257->node_type = 3;

_gna257->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna257 != (GNODE) NULL)
  if (VALIDTYPE(_gna257->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna257,""); 
  else fprintf(stderr,"\n At line 713 attempt to unparse node of invalid type %d", _gna257->node_type);
else fprintf(stderr,"\n At line 713 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna257;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 714;
_Cur_Node = TheRootNode;
{

GNODE _gna258;


_gna258 = getlocnode(TheRootNode);

_gna257 = (GNODE) GetFillers(_gna258,"line");
}

if (_gna257 != (GNODE) NULL)
  if (VALIDTYPE(_gna257->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna257,""); 
  else fprintf(stderr,"\n At line 714 attempt to unparse node of invalid type %d", _gna257->node_type);
else fprintf(stderr,"\n At line 714 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna257;
_Cur_Constr = "(NODETYPE...";
_Cur_SpecLine = 715;
_Cur_Node = TheRootNode;
{

GNODE _gna259;
_gna259 = TheRootNode;
_gna257 = (GNODE) gmalloc ();
_gna257->node_flag = GBUILTIN | GSIMPLENODE;
_gna257->node_type = C_String;
_gna257->node_data.l_dv = NodeTable[_gna259->node_type]->nodename;
}

if (_gna257 != (GNODE) NULL)
  if (VALIDTYPE(_gna257->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna257,""); 
  else fprintf(stderr,"\n At line 715 attempt to unparse node of invalid type %d", _gna257->node_type);
else fprintf(stderr,"\n At line 715 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna257;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 716;
_Cur_Node = TheRootNode;
{


GNODE _gna260;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 716;
_Cur_Node = TheRootNode;
{

GNODE _gna261;
_gna261 = TheRootNode;

_gna260 = (GNODE) GetFillers(_gna261,"labelname");
}

_gna257 = (GNODE) GetFillers(_gna260,"id");
}

if (_gna257 != (GNODE) NULL)
  if (VALIDTYPE(_gna257->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna257,""); 
  else fprintf(stderr,"\n At line 716 attempt to unparse node of invalid type %d", _gna257->node_type);
else fprintf(stderr,"\n At line 716 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 717;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna262;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 717;
_Cur_Node = TheRootNode;
{


GNODE _gna263;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 717;
_Cur_Node = TheRootNode;
{

GNODE _gna264;
_gna264 = TheRootNode;

_gna263 = (GNODE) GetFillers(_gna264,"labelname");
}

_gna262 = (GNODE) GetFillers(_gna263,"id");
}

return (_gna262);
}

}

}
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithContinue (GNODE TheRootNode	)
#else

GNODE DealWithContinue ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE continueLine;

  if (!(OfType(TheRootNode, Continue))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithContinue called with node of type %s, not of type %d Continue",WhatType(TheRootNode->node_type),Continue);
	else printf("\n Procedure DealWithContinue called with invalid node  type %d, not of type %d Continue",TheRootNode->node_type,Continue);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<enclosing\n\t\t(ASSIGN...";
_Cur_SpecLine = 729;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  enclosing */
{


GNODE _gna265;	

_gna265 = (GNODE) GetFillers(TheRootNode,"enclosing");

 if (_gna265 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 730;
_Cur_Node = _gna265;

{				

  /* EXECUTE ITEM */
{


GNODE _gna266;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 731;
_Cur_Node = _gna265;
{

GNODE _gna267;


_gna267 = getlocnode(_gna265);

_gna266 = (GNODE) GetFillers(_gna267,"line");
}

if (_gna266 != (GNODE) NULL && (GSLOT(_gna266) != (AXS_ENTRY) NULL))
	MarkUsed(_gna266);


continueLine = _gna266;


}

}

 }	  /* Balances if (_gna265 != (GNODE) NULL )*/

} /* Balances GNODE _gna265; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 733;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna268;

_gna268 = (GNODE) gmalloc ();
_gna268->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna268->node_type = 3;

_gna268->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna268 != (GNODE) NULL)
  if (VALIDTYPE(_gna268->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna268,""); 
  else fprintf(stderr,"\n At line 734 attempt to unparse node of invalid type %d", _gna268->node_type);
else fprintf(stderr,"\n At line 734 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna268;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 735;
_Cur_Node = TheRootNode;
{

GNODE _gna269;


_gna269 = getlocnode(TheRootNode);

_gna268 = (GNODE) GetFillers(_gna269,"line");
}

if (_gna268 != (GNODE) NULL)
  if (VALIDTYPE(_gna268->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna268,""); 
  else fprintf(stderr,"\n At line 735 attempt to unparse node of invalid type %d", _gna268->node_type);
else fprintf(stderr,"\n At line 735 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Goto "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna268;
_gna268 = (GNODE) continueLine;

if (_gna268 != (GNODE) NULL)
  if (VALIDTYPE(_gna268->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna268,""); 
  else fprintf(stderr,"\n At line 736 attempt to unparse node of invalid type %d", _gna268->node_type);
else fprintf(stderr,"\n At line 736 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithBreak (GNODE TheRootNode	)
#else

GNODE DealWithBreak ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE breakLine;

  if (!(OfType(TheRootNode, Break))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithBreak called with node of type %s, not of type %d Break",WhatType(TheRootNode->node_type),Break);
	else printf("\n Procedure DealWithBreak called with invalid node  type %d, not of type %d Break",TheRootNode->node_type,Break);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<enclosing\n\t\t(IF...";
_Cur_SpecLine = 745;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  enclosing */
{


GNODE _gna270;	

_gna270 = (GNODE) GetFillers(TheRootNode,"enclosing");

 if (_gna270 != (GNODE) NULL) {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 746;
_Cur_Node = _gna270;

{				

  /* EXECUTE ITEM */
{

int _gna271;
{


GNODE _gna272;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 746;
_Cur_Node = _gna270;
{

GNODE _gna273;
_gna273 = _gna270;

_gna272 = (GNODE) GetFillers(_gna273,"successor");
}
_gna271 = (_gna272== (GNODE) NULL);
}

if (_gna271) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 747;
_Cur_Node = _gna270;

{				

  /* EXECUTE ITEM */
{

GNODE _gna274;

_gna274 = (GNODE) gmalloc ();
_gna274->node_flag = GBUILTIN | GSIMPLENODE;
_gna274->node_type = C_String;
_gna274->node_data.l_dv = "FINISH";

if (_gna274 != (GNODE) NULL && (GSLOT(_gna274) != (AXS_ENTRY) NULL))
	MarkUsed(_gna274);


breakLine = _gna274;


}

}

}
else {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 750;
_Cur_Node = _gna270;

{				

  /* EXECUTE ITEM */
{


GNODE _gna275;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 751;
_Cur_Node = _gna270;
{


GNODE _gna276;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 751;
_Cur_Node = _gna270;
{


GNODE _gna277;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 751;
_Cur_Node = _gna270;
{

GNODE _gna278;
_gna278 = _gna270;

_gna277 = (GNODE) GetFillers(_gna278,"successor");
}

_gna276 = (GNODE) GetFillers(_gna277,"where");
}

_gna275 = (GNODE) GetFillers(_gna276,"line");
}

if (_gna275 != (GNODE) NULL && (GSLOT(_gna275) != (AXS_ENTRY) NULL))
	MarkUsed(_gna275);


breakLine = _gna275;


}

}
}
}

}

 }	  /* Balances if (_gna270 != (GNODE) NULL )*/

} /* Balances GNODE _gna270; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 755;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna279;

_gna279 = (GNODE) gmalloc ();
_gna279->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna279->node_type = 3;

_gna279->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna279 != (GNODE) NULL)
  if (VALIDTYPE(_gna279->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna279,""); 
  else fprintf(stderr,"\n At line 756 attempt to unparse node of invalid type %d", _gna279->node_type);
else fprintf(stderr,"\n At line 756 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna279;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 757;
_Cur_Node = TheRootNode;
{

GNODE _gna280;


_gna280 = getlocnode(TheRootNode);

_gna279 = (GNODE) GetFillers(_gna280,"line");
}

if (_gna279 != (GNODE) NULL)
  if (VALIDTYPE(_gna279->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna279,""); 
  else fprintf(stderr,"\n At line 757 attempt to unparse node of invalid type %d", _gna279->node_type);
else fprintf(stderr,"\n At line 757 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Goto "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna279;
_gna279 = (GNODE) breakLine;

if (_gna279 != (GNODE) NULL)
  if (VALIDTYPE(_gna279->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna279,""); 
  else fprintf(stderr,"\n At line 758 attempt to unparse node of invalid type %d", _gna279->node_type);
else fprintf(stderr,"\n At line 758 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithSwitch (GNODE TheRootNode	)
#else

GNODE DealWithSwitch ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE testValue;
	GNODE lastCase;
	GNODE newblock;

  if (!(OfType(TheRootNode, Switch))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithSwitch called with node of type %s, not of type %d Switch",WhatType(TheRootNode->node_type),Switch);
	else printf("\n Procedure DealWithSwitch called with invalid node  type %d, not of type %d Switch",TheRootNode->node_type,Switch);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<switchcondition...";
_Cur_SpecLine = 769;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  switchcondition */
{


GNODE _gna281;	

_gna281 = (GNODE) GetFillers(TheRootNode,"switchcondition");

 if (_gna281 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 769;
_Cur_Node = _gna281;

{				

  /* EXECUTE ITEM */
{


GNODE _gna282;
	_gna282 = DealWithExpression (_gna281);




	





if (_gna282 != (GNODE) NULL && (GSLOT(_gna282) != (AXS_ENTRY) NULL))
	MarkUsed(_gna282);


testValue = _gna282;


}

}

 }	  /* Balances if (_gna281 != (GNODE) NULL )*/

} /* Balances GNODE _gna281; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 771;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna283;

_gna283 = (GNODE) gmalloc ();
_gna283->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna283->node_type = 3;

_gna283->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna283 != (GNODE) NULL)
  if (VALIDTYPE(_gna283->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna283,""); 
  else fprintf(stderr,"\n At line 772 attempt to unparse node of invalid type %d", _gna283->node_type);
else fprintf(stderr,"\n At line 772 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna283;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 773;
_Cur_Node = TheRootNode;
{

GNODE _gna284;


_gna284 = getlocnode(TheRootNode);

_gna283 = (GNODE) GetFillers(_gna284,"line");
}

if (_gna283 != (GNODE) NULL)
  if (VALIDTYPE(_gna283->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna283,""); 
  else fprintf(stderr,"\n At line 773 attempt to unparse node of invalid type %d", _gna283->node_type);
else fprintf(stderr,"\n At line 773 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Switch "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna283;
_gna283 = (GNODE) testValue;

if (_gna283 != (GNODE) NULL)
  if (VALIDTYPE(_gna283->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna283,""); 
  else fprintf(stderr,"\n At line 774 attempt to unparse node of invalid type %d", _gna283->node_type);
else fprintf(stderr,"\n At line 774 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithDo (GNODE TheRootNode	)
#else

GNODE DealWithDo ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE testValue;
	GNODE newTestValue;
	GNODE newValue;
	GNODE newblock;
	GNODE endLine;

  if (!(OfType(TheRootNode, Do))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithDo called with node of type %s, not of type %d Do",WhatType(TheRootNode->node_type),Do);
	else printf("\n Procedure DealWithDo called with invalid node  type %d, not of type %d Do",TheRootNode->node_type,Do);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 832;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna285;

_gna285 = (GNODE) gmalloc ();
_gna285->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna285->node_type = 3;

_gna285->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna285 != (GNODE) NULL)
  if (VALIDTYPE(_gna285->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna285,""); 
  else fprintf(stderr,"\n At line 833 attempt to unparse node of invalid type %d", _gna285->node_type);
else fprintf(stderr,"\n At line 833 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna285;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 834;
_Cur_Node = TheRootNode;
{

GNODE _gna286;


_gna286 = getlocnode(TheRootNode);

_gna285 = (GNODE) GetFillers(_gna286,"line");
}

if (_gna285 != (GNODE) NULL)
  if (VALIDTYPE(_gna285->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna285,""); 
  else fprintf(stderr,"\n At line 834 attempt to unparse node of invalid type %d", _gna285->node_type);
else fprintf(stderr,"\n At line 834 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," (Loop Do \n");

}

_Cur_Constr = "<docondition...";
_Cur_SpecLine = 836;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  docondition */
{


GNODE _gna287;	

_gna287 = (GNODE) GetFillers(TheRootNode,"docondition");

 if (_gna287 != (GNODE) NULL) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 836;
_Cur_Node = _gna287;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  (");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna288;
_gna288 = (GNODE) fileName;

if (_gna288 != (GNODE) NULL)
  if (VALIDTYPE(_gna288->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna288,""); 
  else fprintf(stderr,"\n At line 836 attempt to unparse node of invalid type %d", _gna288->node_type);
else fprintf(stderr,"\n At line 836 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_cond"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna288;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 836;
_Cur_Node = _gna287;
{

GNODE _gna289;


_gna289 = getlocnode(_gna287);

_gna288 = (GNODE) GetFillers(_gna289,"line");
}

if (_gna288 != (GNODE) NULL)
  if (VALIDTYPE(_gna288->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna288,""); 
  else fprintf(stderr,"\n At line 836 attempt to unparse node of invalid type %d", _gna288->node_type);
else fprintf(stderr,"\n At line 836 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,")\n");

}

 }	  /* Balances if (_gna287 != (GNODE) NULL )*/

} /* Balances GNODE _gna287; */

}

_Cur_Constr = "<dobody...";
_Cur_SpecLine = 837;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  dobody */
{


GNODE _gna290;	

_gna290 = (GNODE) GetFillers(TheRootNode,"dobody");

 if (_gna290 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 837;
_Cur_Node = _gna290;

{				

  /* EXECUTE ITEM */
	
GatherContainedStatements (_gna290);  


}

 }	  /* Balances if (_gna290 != (GNODE) NULL )*/

} /* Balances GNODE _gna290; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 838;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"))\n");

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithFor (GNODE TheRootNode	)
#else

GNODE DealWithFor ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE testValue;
	GNODE newTestValue;
	GNODE newValue;
	GNODE newblock;
	GNODE endLine;

  if (!(OfType(TheRootNode, For))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithFor called with node of type %s, not of type %d For",WhatType(TheRootNode->node_type),For);
	else printf("\n Procedure DealWithFor called with invalid node  type %d, not of type %d For",TheRootNode->node_type,For);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<forinit...";
_Cur_SpecLine = 898;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forinit */
{


GNODE _gna292;	

_gna292 = (GNODE) GetFillers(TheRootNode,"forinit");

 if (_gna292 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 898;
_Cur_Node = _gna292;

{				

  /* EXECUTE ITEM */
	
DealWithStatement (_gna292);  


}

 }	  /* Balances if (_gna292 != (GNODE) NULL )*/

} /* Balances GNODE _gna292; */

}

_Cur_Constr = "<forcondition...";
_Cur_SpecLine = 900;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forcondition */
{


GNODE _gna293;	

_gna293 = (GNODE) GetFillers(TheRootNode,"forcondition");

 if (_gna293 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 900;
_Cur_Node = _gna293;

{				

  /* EXECUTE ITEM */
{


GNODE _gna294;
	_gna294 = DealWithExpression (_gna293);




	





if (_gna294 != (GNODE) NULL && (GSLOT(_gna294) != (AXS_ENTRY) NULL))
	MarkUsed(_gna294);


testValue = _gna294;


}

}

 }	  /* Balances if (_gna293 != (GNODE) NULL )*/

} /* Balances GNODE _gna293; */

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 901;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna295;
{


GNODE _gna296;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 901;
_Cur_Node = TheRootNode;
{

GNODE _gna297;
_gna297 = TheRootNode;

_gna296 = (GNODE) GetFillers(_gna297,"forcondition");
}
_gna295 = (_gna296== (GNODE) NULL);
}

if (_gna295) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 902;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna298;

_gna298 = (GNODE) gmalloc ();
_gna298->node_flag = GBUILTIN | GSIMPLENODE;
_gna298->node_type = C_Integer;
_gna298->node_data.l_iv = 1;

if (_gna298 != (GNODE) NULL && (GSLOT(_gna298) != (AXS_ENTRY) NULL))
	MarkUsed(_gna298);


testValue = _gna298;


}

}

}
}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 905;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna299;

_gna299 = (GNODE) gmalloc ();
_gna299->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna299->node_type = 3;

_gna299->node_data.l_dv = ( (char *)( (char *) newBlock())) ;

if (_gna299 != (GNODE) NULL && (GSLOT(_gna299) != (AXS_ENTRY) NULL))
	MarkUsed(_gna299);


newblock = _gna299;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 907;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna300;

_gna300 = (GNODE) gmalloc ();
_gna300->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna300->node_type = 3;

_gna300->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna300 != (GNODE) NULL)
  if (VALIDTYPE(_gna300->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna300,""); 
  else fprintf(stderr,"\n At line 908 attempt to unparse node of invalid type %d", _gna300->node_type);
else fprintf(stderr,"\n At line 908 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna300;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 909;
_Cur_Node = TheRootNode;
{

GNODE _gna301;


_gna301 = getlocnode(TheRootNode);

_gna300 = (GNODE) GetFillers(_gna301,"line");
}

if (_gna300 != (GNODE) NULL)
  if (VALIDTYPE(_gna300->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna300,""); 
  else fprintf(stderr,"\n At line 909 attempt to unparse node of invalid type %d", _gna300->node_type);
else fprintf(stderr,"\n At line 909 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (While "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna300;
_gna300 = (GNODE) testValue;

if (_gna300 != (GNODE) NULL)
  if (VALIDTYPE(_gna300->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna300,""); 
  else fprintf(stderr,"\n At line 910 attempt to unparse node of invalid type %d", _gna300->node_type);
else fprintf(stderr,"\n At line 910 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "<forbody...";
_Cur_SpecLine = 913;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forbody */
{


GNODE _gna302;	

_gna302 = (GNODE) GetFillers(TheRootNode,"forbody");

 if (_gna302 != (GNODE) NULL) {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 914;
_Cur_Node = _gna302;

{				

  /* EXECUTE ITEM */
{

int _gna303;
{

GNODE _gna304;

_gna304 = (GNODE) gmalloc ();
_gna304->node_flag = GBUILTIN | GSIMPLENODE;
_gna304->node_type = C_String;
_gna304->node_data.l_dv = NodeTable[_gna302->node_type]->nodename;
  {

GNODE _gna305;

_gna305 = (GNODE) gmalloc ();
_gna305->node_flag = GBUILTIN | GSIMPLENODE;
_gna305->node_type = C_String;
_gna305->node_data.l_dv = "Block";
_gna303 = gequal(_gna304, _gna305);
}
}

if (_gna303) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 916;
_Cur_Node = _gna302;

{				

  /* EXECUTE ITEM */
	
DealWithStatement (_gna302);  


}

}
else {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 919;
_Cur_Node = _gna302;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna306;

_gna306 = (GNODE) gmalloc ();
_gna306->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna306->node_type = 3;

_gna306->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna306 != (GNODE) NULL)
  if (VALIDTYPE(_gna306->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna306,""); 
  else fprintf(stderr,"\n At line 920 attempt to unparse node of invalid type %d", _gna306->node_type);
else fprintf(stderr,"\n At line 920 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna306;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 921;
_Cur_Node = _gna302;
{

GNODE _gna307;


_gna307 = getlocnode(_gna302);

_gna306 = (GNODE) GetFillers(_gna307,"line");
}

if (_gna306 != (GNODE) NULL)
  if (VALIDTYPE(_gna306->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna306,""); 
  else fprintf(stderr,"\n At line 921 attempt to unparse node of invalid type %d", _gna306->node_type);
else fprintf(stderr,"\n At line 921 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Begin "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna306;
_gna306 = (GNODE) newblock;

if (_gna306 != (GNODE) NULL)
  if (VALIDTYPE(_gna306->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna306,""); 
  else fprintf(stderr,"\n At line 922 attempt to unparse node of invalid type %d", _gna306->node_type);
else fprintf(stderr,"\n At line 922 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 924;
_Cur_Node = _gna302;

{				

  /* EXECUTE ITEM */
{


GNODE _gna308;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 924;
_Cur_Node = _gna302;
{

GNODE _gna309;


_gna309 = getlocnode(_gna302);

_gna308 = (GNODE) GetFillers(_gna309,"line");
}

if (_gna308 != (GNODE) NULL && (GSLOT(_gna308) != (AXS_ENTRY) NULL))
	MarkUsed(_gna308);


endLine = _gna308;


}

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 925;
_Cur_Node = _gna302;

{				

  /* EXECUTE ITEM */
	
DealWithStatement (_gna302);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 926;
_Cur_Node = _gna302;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna310;

_gna310 = (GNODE) gmalloc ();
_gna310->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna310->node_type = 3;

_gna310->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna310 != (GNODE) NULL)
  if (VALIDTYPE(_gna310->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna310,""); 
  else fprintf(stderr,"\n At line 927 attempt to unparse node of invalid type %d", _gna310->node_type);
else fprintf(stderr,"\n At line 927 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna310;
_gna310 = (GNODE) endLine;

if (_gna310 != (GNODE) NULL)
  if (VALIDTYPE(_gna310->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna310,""); 
  else fprintf(stderr,"\n At line 928 attempt to unparse node of invalid type %d", _gna310->node_type);
else fprintf(stderr,"\n At line 928 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (End "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna310;
_gna310 = (GNODE) newblock;

if (_gna310 != (GNODE) NULL)
  if (VALIDTYPE(_gna310->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna310,""); 
  else fprintf(stderr,"\n At line 929 attempt to unparse node of invalid type %d", _gna310->node_type);
else fprintf(stderr,"\n At line 929 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}
}
}

}

 }	  /* Balances if (_gna302 != (GNODE) NULL )*/

} /* Balances GNODE _gna302; */

}

_Cur_Constr = "<forincrement...";
_Cur_SpecLine = 933;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forincrement */
{


GNODE _gna311;	

_gna311 = (GNODE) GetFillers(TheRootNode,"forincrement");

 if (_gna311 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 933;
_Cur_Node = _gna311;

{				

  /* EXECUTE ITEM */
	
DealWithExpression (_gna311);  


}

 }	  /* Balances if (_gna311 != (GNODE) NULL )*/

} /* Balances GNODE _gna311; */

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithWhile (GNODE TheRootNode	)
#else

GNODE DealWithWhile ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE testValue;
	GNODE newTestValue;
	GNODE newValue;
	GNODE newblock;
	GNODE endLine;

  if (!(OfType(TheRootNode, While))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithWhile called with node of type %s, not of type %d While",WhatType(TheRootNode->node_type),While);
	else printf("\n Procedure DealWithWhile called with invalid node  type %d, not of type %d While",TheRootNode->node_type,While);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 949;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna312;

_gna312 = (GNODE) gmalloc ();
_gna312->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna312->node_type = 3;

_gna312->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna312 != (GNODE) NULL)
  if (VALIDTYPE(_gna312->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna312,""); 
  else fprintf(stderr,"\n At line 950 attempt to unparse node of invalid type %d", _gna312->node_type);
else fprintf(stderr,"\n At line 950 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna312;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 951;
_Cur_Node = TheRootNode;
{

GNODE _gna313;


_gna313 = getlocnode(TheRootNode);

_gna312 = (GNODE) GetFillers(_gna313,"line");
}

if (_gna312 != (GNODE) NULL)
  if (VALIDTYPE(_gna312->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna312,""); 
  else fprintf(stderr,"\n At line 951 attempt to unparse node of invalid type %d", _gna312->node_type);
else fprintf(stderr,"\n At line 951 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," (Loop While \n");

}

_Cur_Constr = "<whilecondition...";
_Cur_SpecLine = 953;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  whilecondition */
{


GNODE _gna314;	

_gna314 = (GNODE) GetFillers(TheRootNode,"whilecondition");

 if (_gna314 != (GNODE) NULL) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 953;
_Cur_Node = _gna314;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  (");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna315;
_gna315 = (GNODE) fileName;

if (_gna315 != (GNODE) NULL)
  if (VALIDTYPE(_gna315->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna315,""); 
  else fprintf(stderr,"\n At line 953 attempt to unparse node of invalid type %d", _gna315->node_type);
else fprintf(stderr,"\n At line 953 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_cond"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna315;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 953;
_Cur_Node = _gna314;
{

GNODE _gna316;


_gna316 = getlocnode(_gna314);

_gna315 = (GNODE) GetFillers(_gna316,"line");
}

if (_gna315 != (GNODE) NULL)
  if (VALIDTYPE(_gna315->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna315,""); 
  else fprintf(stderr,"\n At line 953 attempt to unparse node of invalid type %d", _gna315->node_type);
else fprintf(stderr,"\n At line 953 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,")\n");

}

 }	  /* Balances if (_gna314 != (GNODE) NULL )*/

} /* Balances GNODE _gna314; */

}

_Cur_Constr = "<whilebody...";
_Cur_SpecLine = 954;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  whilebody */
{


GNODE _gna317;	

_gna317 = (GNODE) GetFillers(TheRootNode,"whilebody");

 if (_gna317 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 954;
_Cur_Node = _gna317;

{				

  /* EXECUTE ITEM */
	
GatherContainedStatements (_gna317);  


}

 }	  /* Balances if (_gna317 != (GNODE) NULL )*/

} /* Balances GNODE _gna317; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 955;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"))\n");

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithIf (GNODE TheRootNode	)
#else

GNODE DealWithIf ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE newValue;
	GNODE opposite;
	GNODE newblock;
	GNODE endLine;

  if (!(OfType(TheRootNode, If))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithIf called with node of type %s, not of type %d If",WhatType(TheRootNode->node_type),If);
	else printf("\n Procedure DealWithIf called with invalid node  type %d, not of type %d If",TheRootNode->node_type,If);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 999;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna319;

_gna319 = (GNODE) gmalloc ();
_gna319->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna319->node_type = 3;

_gna319->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna319 != (GNODE) NULL)
  if (VALIDTYPE(_gna319->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna319,""); 
  else fprintf(stderr,"\n At line 1000 attempt to unparse node of invalid type %d", _gna319->node_type);
else fprintf(stderr,"\n At line 1000 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna319;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1001;
_Cur_Node = TheRootNode;
{

GNODE _gna320;


_gna320 = getlocnode(TheRootNode);

_gna319 = (GNODE) GetFillers(_gna320,"line");
}

if (_gna319 != (GNODE) NULL)
  if (VALIDTYPE(_gna319->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna319,""); 
  else fprintf(stderr,"\n At line 1001 attempt to unparse node of invalid type %d", _gna319->node_type);
else fprintf(stderr,"\n At line 1001 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," (Test If \n");

}

_Cur_Constr = "<ifcondition...";
_Cur_SpecLine = 1003;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ifcondition */
{


GNODE _gna321;	

_gna321 = (GNODE) GetFillers(TheRootNode,"ifcondition");

 if (_gna321 != (GNODE) NULL) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1003;
_Cur_Node = _gna321;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  (");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna322;
_gna322 = (GNODE) fileName;

if (_gna322 != (GNODE) NULL)
  if (VALIDTYPE(_gna322->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna322,""); 
  else fprintf(stderr,"\n At line 1003 attempt to unparse node of invalid type %d", _gna322->node_type);
else fprintf(stderr,"\n At line 1003 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_cond"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna322;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1003;
_Cur_Node = _gna321;
{

GNODE _gna323;


_gna323 = getlocnode(_gna321);

_gna322 = (GNODE) GetFillers(_gna323,"line");
}

if (_gna322 != (GNODE) NULL)
  if (VALIDTYPE(_gna322->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna322,""); 
  else fprintf(stderr,"\n At line 1003 attempt to unparse node of invalid type %d", _gna322->node_type);
else fprintf(stderr,"\n At line 1003 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,")\n");

}

 }	  /* Balances if (_gna321 != (GNODE) NULL )*/

} /* Balances GNODE _gna321; */

}

_Cur_Constr = "<ifTbranch...";
_Cur_SpecLine = 1004;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ifTbranch */
{


GNODE _gna324;	

_gna324 = (GNODE) GetFillers(TheRootNode,"ifTbranch");

 if (_gna324 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1004;
_Cur_Node = _gna324;

{				

  /* EXECUTE ITEM */
	
GatherContainedStatements (_gna324);  


}

 }	  /* Balances if (_gna324 != (GNODE) NULL )*/

} /* Balances GNODE _gna324; */

}

_Cur_Constr = "<ifFbranch...";
_Cur_SpecLine = 1005;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ifFbranch */
{


GNODE _gna325;	

_gna325 = (GNODE) GetFillers(TheRootNode,"ifFbranch");

 if (_gna325 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1005;
_Cur_Node = _gna325;

{				

  /* EXECUTE ITEM */
	
GatherContainedStatements (_gna325);  


}

 }	  /* Balances if (_gna325 != (GNODE) NULL )*/

} /* Balances GNODE _gna325; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1006;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"))\n");

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithBlock (GNODE TheRootNode	)
#else

GNODE DealWithBlock ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE newblock;
	GNODE flname;

  if (!(OfType(TheRootNode, Block))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithBlock called with node of type %s, not of type %d Block",WhatType(TheRootNode->node_type),Block);
	else printf("\n Procedure DealWithBlock called with invalid node  type %d, not of type %d Block",TheRootNode->node_type,Block);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1080;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna327;

_gna327 = (GNODE) gmalloc ();
_gna327->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna327->node_type = 3;

_gna327->node_data.l_dv = ( (char *)( (char *) newBlock())) ;

if (_gna327 != (GNODE) NULL && (GSLOT(_gna327) != (AXS_ENTRY) NULL))
	MarkUsed(_gna327);


newblock = _gna327;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1082;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna328;

_gna328 = (GNODE) gmalloc ();
_gna328->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna328->node_type = 3;

_gna328->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna328 != (GNODE) NULL)
  if (VALIDTYPE(_gna328->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna328,""); 
  else fprintf(stderr,"\n At line 1083 attempt to unparse node of invalid type %d", _gna328->node_type);
else fprintf(stderr,"\n At line 1083 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna328;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1084;
_Cur_Node = TheRootNode;
{

GNODE _gna329;


_gna329 = getlocnode(TheRootNode);

_gna328 = (GNODE) GetFillers(_gna329,"line");
}

if (_gna328 != (GNODE) NULL)
  if (VALIDTYPE(_gna328->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna328,""); 
  else fprintf(stderr,"\n At line 1084 attempt to unparse node of invalid type %d", _gna328->node_type);
else fprintf(stderr,"\n At line 1084 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Begin "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna328;
_gna328 = (GNODE) newblock;

if (_gna328 != (GNODE) NULL)
  if (VALIDTYPE(_gna328->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna328,""); 
  else fprintf(stderr,"\n At line 1085 attempt to unparse node of invalid type %d", _gna328->node_type);
else fprintf(stderr,"\n At line 1085 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "<locals\n\t\t{Declarati...";
_Cur_SpecLine = 1087;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  locals */
{


GNODE _gna330;	

_gna330 = (GNODE) GetFillers(TheRootNode,"locals");

 if (_gna330 != (GNODE) NULL) {

_Cur_Constr = "{Declaration\n\t\t(?Obj...";
_Cur_SpecLine = 1088;
_Cur_Node = _gna330;

{

_Cur_Constr = "{Declaration\n\t\t(?Obj...";
_Cur_SpecLine = 1088;
_Cur_Node = _gna330;

{

GNODE _gna331;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Declaration */
 
if (_gna330->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna331 = (GNODE)( _gna330->node_data.l_dv);
  for(;_gna331 != (GNODE) NULL;_gna331=_gna331->gnext) {
    if (OfType(_gna331,Declaration)) {

_Cur_Constr = "(?ObjectDef\n\t\t\t(ASSI...";
_Cur_SpecLine = 1089;
_Cur_Node = _gna331;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE ObjectDef */		

if (OfType(_gna331,ObjectDef)) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1090;
_Cur_Node = _gna331;

{				

  /* EXECUTE ITEM */
{


GNODE _gna333;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1090;
_Cur_Node = _gna331;
{

GNODE _gna334;


_gna334 = getlocnode(_gna331);

_gna333 = (GNODE) GetFillers(_gna334,"file");
}

if (_gna333 != (GNODE) NULL && (GSLOT(_gna333) != (AXS_ENTRY) NULL))
	MarkUsed(_gna333);


flname = _gna333;


}

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1091;
_Cur_Node = _gna331;

{				

  /* EXECUTE ITEM */
{

int _gna335;
{ 
GNODE _gna336;

_gna336 = (GNODE) gmalloc ();
_gna336->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna336->node_type = 0;

_gna336->node_data.l_iv = ( (int) ( IsHeader( getCstring(flname))) );
  {

GNODE _gna337;

_gna337 = (GNODE) gmalloc ();
_gna337->node_flag = GBUILTIN | GSIMPLENODE;
_gna337->node_type = C_Integer;
_gna337->node_data.l_iv = 0;
_gna335 = gequal(_gna336, _gna337);
}
}

if (_gna335) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1092;
_Cur_Node = _gna331;

{				

  /* EXECUTE ITEM */
	
DealWithObjectDef (_gna331);  


}

}
}

}

}

}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 1088 is %s not type %d---Declaration",NodeTable[_gna331->node_type]->nodename,Declaration);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 1088- Parent NOT a LIST !");


}

}

 }	  /* Balances if (_gna330 != (GNODE) NULL )*/

} /* Balances GNODE _gna330; */

}

_Cur_Constr = "<blockbody\n\t\t{Statem...";
_Cur_SpecLine = 1097;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  blockbody */
{


GNODE _gna338;	

_gna338 = (GNODE) GetFillers(TheRootNode,"blockbody");

 if (_gna338 != (GNODE) NULL) {

_Cur_Constr = "{Statement\t(CALL...";
_Cur_SpecLine = 1098;
_Cur_Node = _gna338;

{

_Cur_Constr = "{Statement\t(CALL...";
_Cur_SpecLine = 1098;
_Cur_Node = _gna338;

{

GNODE _gna339;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Statement */
 
if (_gna338->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna339 = (GNODE)( _gna338->node_data.l_dv);
  for(;_gna339 != (GNODE) NULL;_gna339=_gna339->gnext) {
    if (OfType(_gna339,Statement)) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1098;
_Cur_Node = _gna339;

{				

  /* EXECUTE ITEM */
	
DealWithStatement (_gna339);  


}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 1098 is %s not type %d---Statement",NodeTable[_gna339->node_type]->nodename,Statement);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 1098- Parent NOT a LIST !");


}

}

 }	  /* Balances if (_gna338 != (GNODE) NULL )*/

} /* Balances GNODE _gna338; */

}

_Cur_Constr = "<blockend\n\t(PRINT...";
_Cur_SpecLine = 1101;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  blockend */
{


GNODE _gna341;	

_gna341 = (GNODE) GetFillers(TheRootNode,"blockend");

 if (_gna341 != (GNODE) NULL) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1102;
_Cur_Node = _gna341;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna342;

_gna342 = (GNODE) gmalloc ();
_gna342->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna342->node_type = 3;

_gna342->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna342 != (GNODE) NULL)
  if (VALIDTYPE(_gna342->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna342,""); 
  else fprintf(stderr,"\n At line 1103 attempt to unparse node of invalid type %d", _gna342->node_type);
else fprintf(stderr,"\n At line 1103 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna342;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1104;
_Cur_Node = _gna341;
{

GNODE _gna343;
_gna343 = _gna341;

_gna342 = (GNODE) GetFillers(_gna343,"line");
}

if (_gna342 != (GNODE) NULL)
  if (VALIDTYPE(_gna342->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna342,""); 
  else fprintf(stderr,"\n At line 1104 attempt to unparse node of invalid type %d", _gna342->node_type);
else fprintf(stderr,"\n At line 1104 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (End "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna342;
_gna342 = (GNODE) newblock;

if (_gna342 != (GNODE) NULL)
  if (VALIDTYPE(_gna342->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna342,""); 
  else fprintf(stderr,"\n At line 1105 attempt to unparse node of invalid type %d", _gna342->node_type);
else fprintf(stderr,"\n At line 1105 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

 }	  /* Balances if (_gna341 != (GNODE) NULL )*/

} /* Balances GNODE _gna341; */

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithReturn (GNODE TheRootNode	)
#else

GNODE DealWithReturn ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE newValue;

  if (!(OfType(TheRootNode, Return))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithReturn called with node of type %s, not of type %d Return",WhatType(TheRootNode->node_type),Return);
	else printf("\n Procedure DealWithReturn called with invalid node  type %d, not of type %d Return",TheRootNode->node_type,Return);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<value...";
_Cur_SpecLine = 1117;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  value */
{


GNODE _gna344;	

_gna344 = (GNODE) GetFillers(TheRootNode,"value");

 if (_gna344 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1117;
_Cur_Node = _gna344;

{				

  /* EXECUTE ITEM */
{


GNODE _gna345;
	_gna345 = DealWithExpression (_gna344);




	





if (_gna345 != (GNODE) NULL && (GSLOT(_gna345) != (AXS_ENTRY) NULL))
	MarkUsed(_gna345);


newValue = _gna345;


}

}

 }	  /* Balances if (_gna344 != (GNODE) NULL )*/

} /* Balances GNODE _gna344; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1119;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna346;

_gna346 = (GNODE) gmalloc ();
_gna346->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna346->node_type = 3;

_gna346->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna346 != (GNODE) NULL)
  if (VALIDTYPE(_gna346->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna346,""); 
  else fprintf(stderr,"\n At line 1120 attempt to unparse node of invalid type %d", _gna346->node_type);
else fprintf(stderr,"\n At line 1120 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna346;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1121;
_Cur_Node = TheRootNode;
{

GNODE _gna347;


_gna347 = getlocnode(TheRootNode);

_gna346 = (GNODE) GetFillers(_gna347,"line");
}

if (_gna346 != (GNODE) NULL)
  if (VALIDTYPE(_gna346->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna346,""); 
  else fprintf(stderr,"\n At line 1121 attempt to unparse node of invalid type %d", _gna346->node_type);
else fprintf(stderr,"\n At line 1121 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Return "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna346;
_gna346 = (GNODE) newValue;

if (_gna346 != (GNODE) NULL)
  if (VALIDTYPE(_gna346->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna346,""); 
  else fprintf(stderr,"\n At line 1122 attempt to unparse node of invalid type %d", _gna346->node_type);
else fprintf(stderr,"\n At line 1122 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,") ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna346;
_gna346 = (GNODE) newValue;

if (_gna346 != (GNODE) NULL)
  if (VALIDTYPE(_gna346->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna346,""); 
  else fprintf(stderr,"\n At line 1122 attempt to unparse node of invalid type %d", _gna346->node_type);
else fprintf(stderr,"\n At line 1122 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,") nil)\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1123;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna348;
_gna348 = gcopy((GNODE) newValue);

return (_gna348);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithNullStmt (GNODE TheRootNode	)
#else

GNODE DealWithNullStmt ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, NullStmt))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithNullStmt called with node of type %s, not of type %d NullStmt",WhatType(TheRootNode->node_type),NullStmt);
	else printf("\n Procedure DealWithNullStmt called with invalid node  type %d, not of type %d NullStmt",TheRootNode->node_type,NullStmt);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1131;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna349;
_gna349 = gcopy((GNODE) NULL);

return (_gna349);
}

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithExprStmt (GNODE TheRootNode	)
#else

GNODE DealWithExprStmt ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, ExprStmt))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithExprStmt called with node of type %s, not of type %d ExprStmt",WhatType(TheRootNode->node_type),ExprStmt);
	else printf("\n Procedure DealWithExprStmt called with invalid node  type %d, not of type %d ExprStmt",TheRootNode->node_type,ExprStmt);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<expr\n\t\t(CALL...";
_Cur_SpecLine = 1140;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  expr */
{


GNODE _gna350;	

_gna350 = (GNODE) GetFillers(TheRootNode,"expr");

 if (_gna350 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1141;
_Cur_Node = _gna350;

{				

  /* EXECUTE ITEM */
	
DealWithExpression (_gna350);  


}

 }	  /* Balances if (_gna350 != (GNODE) NULL )*/

} /* Balances GNODE _gna350; */

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithCase (GNODE TheRootNode,GNODE testValue	)
#else

GNODE DealWithCase ( TheRootNode,testValue )

 GNODE TheRootNode;
	GNODE testValue;
#endif

{
	GNODE endLine;
	GNODE newValue;
	GNODE caseValue;

  if (!(OfType(TheRootNode, Case))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithCase called with node of type %s, not of type %d Case",WhatType(TheRootNode->node_type),Case);
	else printf("\n Procedure DealWithCase called with invalid node  type %d, not of type %d Case",TheRootNode->node_type,Case);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "<caselabel...";
_Cur_SpecLine = 1162;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  caselabel */
{


GNODE _gna351;	

_gna351 = (GNODE) GetFillers(TheRootNode,"caselabel");

 if (_gna351 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1162;
_Cur_Node = _gna351;

{				

  /* EXECUTE ITEM */
{


GNODE _gna352;
	_gna352 = DealWithExpression (_gna351);




	





if (_gna352 != (GNODE) NULL && (GSLOT(_gna352) != (AXS_ENTRY) NULL))
	MarkUsed(_gna352);


caseValue = _gna352;


}

}

 }	  /* Balances if (_gna351 != (GNODE) NULL )*/

} /* Balances GNODE _gna351; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1164;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna353;

_gna353 = (GNODE) gmalloc ();
_gna353->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna353->node_type = 3;

_gna353->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna353 != (GNODE) NULL && (GSLOT(_gna353) != (AXS_ENTRY) NULL))
	MarkUsed(_gna353);


newValue = _gna353;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1165;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna354;

_gna354 = (GNODE) gmalloc ();
_gna354->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna354->node_type = 3;

_gna354->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna354 != (GNODE) NULL)
  if (VALIDTYPE(_gna354->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna354,""); 
  else fprintf(stderr,"\n At line 1166 attempt to unparse node of invalid type %d", _gna354->node_type);
else fprintf(stderr,"\n At line 1166 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna354;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1167;
_Cur_Node = TheRootNode;
{

GNODE _gna355;


_gna355 = getlocnode(TheRootNode);

_gna354 = (GNODE) GetFillers(_gna355,"line");
}

if (_gna354 != (GNODE) NULL)
  if (VALIDTYPE(_gna354->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna354,""); 
  else fprintf(stderr,"\n At line 1167 attempt to unparse node of invalid type %d", _gna354->node_type);
else fprintf(stderr,"\n At line 1167 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (EqEq "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna354;
_gna354 = (GNODE) testValue;

if (_gna354 != (GNODE) NULL)
  if (VALIDTYPE(_gna354->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna354,""); 
  else fprintf(stderr,"\n At line 1168 attempt to unparse node of invalid type %d", _gna354->node_type);
else fprintf(stderr,"\n At line 1168 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna354;
_gna354 = (GNODE) caseValue;

if (_gna354 != (GNODE) NULL)
  if (VALIDTYPE(_gna354->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna354,""); 
  else fprintf(stderr,"\n At line 1169 attempt to unparse node of invalid type %d", _gna354->node_type);
else fprintf(stderr,"\n At line 1169 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna354;
_gna354 = (GNODE) newValue;

if (_gna354 != (GNODE) NULL)
  if (VALIDTYPE(_gna354->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna354,""); 
  else fprintf(stderr,"\n At line 1170 attempt to unparse node of invalid type %d", _gna354->node_type);
else fprintf(stderr,"\n At line 1170 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1171;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna356;

_gna356 = (GNODE) gmalloc ();
_gna356->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna356->node_type = 3;

_gna356->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna356 != (GNODE) NULL)
  if (VALIDTYPE(_gna356->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna356,""); 
  else fprintf(stderr,"\n At line 1172 attempt to unparse node of invalid type %d", _gna356->node_type);
else fprintf(stderr,"\n At line 1172 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna356;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1173;
_Cur_Node = TheRootNode;
{

GNODE _gna357;


_gna357 = getlocnode(TheRootNode);

_gna356 = (GNODE) GetFillers(_gna357,"line");
}

if (_gna356 != (GNODE) NULL)
  if (VALIDTYPE(_gna356->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna356,""); 
  else fprintf(stderr,"\n At line 1173 attempt to unparse node of invalid type %d", _gna356->node_type);
else fprintf(stderr,"\n At line 1173 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (If "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna356;
_gna356 = (GNODE) newValue;

if (_gna356 != (GNODE) NULL)
  if (VALIDTYPE(_gna356->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna356,""); 
  else fprintf(stderr,"\n At line 1174 attempt to unparse node of invalid type %d", _gna356->node_type);
else fprintf(stderr,"\n At line 1174 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithObjectDef (GNODE TheRootNode	)
#else

GNODE DealWithObjectDef ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE newValue;

  if (!(OfType(TheRootNode, ObjectDef))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithObjectDef called with node of type %s, not of type %d ObjectDef",WhatType(TheRootNode->node_type),ObjectDef);
	else printf("\n Procedure DealWithObjectDef called with invalid node  type %d, not of type %d ObjectDef",TheRootNode->node_type,ObjectDef);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1189;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna358;

{

int _gna359;
{


GNODE _gna360;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1189;
_Cur_Node = TheRootNode;
{

GNODE _gna361;
_gna361 = TheRootNode;

_gna360 = (GNODE) GetFillers(_gna361,"init");
}
_gna359 = (_gna360== (GNODE) NULL);
}

_gna358 = !_gna359;
}

if (_gna358) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1191;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna362;

_gna362 = (GNODE) gmalloc ();
_gna362->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna362->node_type = 3;

_gna362->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna362 != (GNODE) NULL)
  if (VALIDTYPE(_gna362->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna362,""); 
  else fprintf(stderr,"\n At line 1192 attempt to unparse node of invalid type %d", _gna362->node_type);
else fprintf(stderr,"\n At line 1192 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna362;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1193;
_Cur_Node = TheRootNode;
{

GNODE _gna363;


_gna363 = getlocnode(TheRootNode);

_gna362 = (GNODE) GetFillers(_gna363,"line");
}

if (_gna362 != (GNODE) NULL)
  if (VALIDTYPE(_gna362->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna362,""); 
  else fprintf(stderr,"\n At line 1193 attempt to unparse node of invalid type %d", _gna362->node_type);
else fprintf(stderr,"\n At line 1193 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna362;
_Cur_Constr = "(NODETYPE...";
_Cur_SpecLine = 1194;
_Cur_Node = TheRootNode;
{

GNODE _gna364;
_gna364 = TheRootNode;
_gna362 = (GNODE) gmalloc ();
_gna362->node_flag = GBUILTIN | GSIMPLENODE;
_gna362->node_type = C_String;
_gna362->node_data.l_dv = NodeTable[_gna364->node_type]->nodename;
}

if (_gna362 != (GNODE) NULL)
  if (VALIDTYPE(_gna362->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna362,""); 
  else fprintf(stderr,"\n At line 1194 attempt to unparse node of invalid type %d", _gna362->node_type);
else fprintf(stderr,"\n At line 1194 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna362;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1195;
_Cur_Node = TheRootNode;
{

GNODE _gna365;
_gna365 = TheRootNode;

_gna362 = (GNODE) GetFillers(_gna365,"type");
}

if (_gna362 != (GNODE) NULL)
  if (VALIDTYPE(_gna362->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna362,""); 
  else fprintf(stderr,"\n At line 1195 attempt to unparse node of invalid type %d", _gna362->node_type);
else fprintf(stderr,"\n At line 1195 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna362;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1196;
_Cur_Node = TheRootNode;
{

GNODE _gna366;
_gna366 = TheRootNode;

_gna362 = (GNODE) GetFillers(_gna366,"id");
}

if (_gna362 != (GNODE) NULL)
  if (VALIDTYPE(_gna362->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna362,""); 
  else fprintf(stderr,"\n At line 1196 attempt to unparse node of invalid type %d", _gna362->node_type);
else fprintf(stderr,"\n At line 1196 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "<init...";
_Cur_SpecLine = 1198;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  init */
{


GNODE _gna367;	

_gna367 = (GNODE) GetFillers(TheRootNode,"init");

 if (_gna367 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1198;
_Cur_Node = _gna367;

{				

  /* EXECUTE ITEM */
{


GNODE _gna368;
	_gna368 = DealWithExpression (_gna367);




	





if (_gna368 != (GNODE) NULL && (GSLOT(_gna368) != (AXS_ENTRY) NULL))
	MarkUsed(_gna368);


newValue = _gna368;


}

}

 }	  /* Balances if (_gna367 != (GNODE) NULL )*/

} /* Balances GNODE _gna367; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1199;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna369;

_gna369 = (GNODE) gmalloc ();
_gna369->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna369->node_type = 3;

_gna369->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna369 != (GNODE) NULL)
  if (VALIDTYPE(_gna369->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna369,""); 
  else fprintf(stderr,"\n At line 1200 attempt to unparse node of invalid type %d", _gna369->node_type);
else fprintf(stderr,"\n At line 1200 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna369;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1201;
_Cur_Node = TheRootNode;
{

GNODE _gna370;


_gna370 = getlocnode(TheRootNode);

_gna369 = (GNODE) GetFillers(_gna370,"line");
}

if (_gna369 != (GNODE) NULL)
  if (VALIDTYPE(_gna369->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna369,""); 
  else fprintf(stderr,"\n At line 1201 attempt to unparse node of invalid type %d", _gna369->node_type);
else fprintf(stderr,"\n At line 1201 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (Assign "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna369;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1202;
_Cur_Node = TheRootNode;
{

GNODE _gna371;
_gna371 = TheRootNode;

_gna369 = (GNODE) GetFillers(_gna371,"id");
}

if (_gna369 != (GNODE) NULL)
  if (VALIDTYPE(_gna369->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna369,""); 
  else fprintf(stderr,"\n At line 1202 attempt to unparse node of invalid type %d", _gna369->node_type);
else fprintf(stderr,"\n At line 1202 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna369;
_gna369 = (GNODE) newValue;

if (_gna369 != (GNODE) NULL)
  if (VALIDTYPE(_gna369->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna369,""); 
  else fprintf(stderr,"\n At line 1203 attempt to unparse node of invalid type %d", _gna369->node_type);
else fprintf(stderr,"\n At line 1203 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

}
else {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1209;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna372;

_gna372 = (GNODE) gmalloc ();
_gna372->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna372->node_type = 3;

_gna372->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna372 != (GNODE) NULL)
  if (VALIDTYPE(_gna372->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna372,""); 
  else fprintf(stderr,"\n At line 1210 attempt to unparse node of invalid type %d", _gna372->node_type);
else fprintf(stderr,"\n At line 1210 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna372;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1211;
_Cur_Node = TheRootNode;
{

GNODE _gna373;


_gna373 = getlocnode(TheRootNode);

_gna372 = (GNODE) GetFillers(_gna373,"line");
}

if (_gna372 != (GNODE) NULL)
  if (VALIDTYPE(_gna372->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna372,""); 
  else fprintf(stderr,"\n At line 1211 attempt to unparse node of invalid type %d", _gna372->node_type);
else fprintf(stderr,"\n At line 1211 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ("); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna372;
_Cur_Constr = "(NODETYPE...";
_Cur_SpecLine = 1212;
_Cur_Node = TheRootNode;
{

GNODE _gna374;
_gna374 = TheRootNode;
_gna372 = (GNODE) gmalloc ();
_gna372->node_flag = GBUILTIN | GSIMPLENODE;
_gna372->node_type = C_String;
_gna372->node_data.l_dv = NodeTable[_gna374->node_type]->nodename;
}

if (_gna372 != (GNODE) NULL)
  if (VALIDTYPE(_gna372->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna372,""); 
  else fprintf(stderr,"\n At line 1212 attempt to unparse node of invalid type %d", _gna372->node_type);
else fprintf(stderr,"\n At line 1212 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna372;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1213;
_Cur_Node = TheRootNode;
{

GNODE _gna375;
_gna375 = TheRootNode;

_gna372 = (GNODE) GetFillers(_gna375,"type");
}

if (_gna372 != (GNODE) NULL)
  if (VALIDTYPE(_gna372->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna372,""); 
  else fprintf(stderr,"\n At line 1213 attempt to unparse node of invalid type %d", _gna372->node_type);
else fprintf(stderr,"\n At line 1213 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna372;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1214;
_Cur_Node = TheRootNode;
{

GNODE _gna376;
_gna376 = TheRootNode;

_gna372 = (GNODE) GetFillers(_gna376,"id");
}

if (_gna372 != (GNODE) NULL)
  if (VALIDTYPE(_gna372->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna372,""); 
  else fprintf(stderr,"\n At line 1214 attempt to unparse node of invalid type %d", _gna372->node_type);
else fprintf(stderr,"\n At line 1214 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}
}
}

}
}


#if __STDC__ || __cplusplus

void Transform (GNODE TheRootNode	)
#else

void Transform ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE flname;

  if (!(OfType(TheRootNode, CFile))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure Transform called with node of type %s, not of type %d CFile",WhatType(TheRootNode->node_type),CFile);
	else printf("\n Procedure Transform called with invalid node  type %d, not of type %d CFile",TheRootNode->node_type,CFile);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return;
  }

_Cur_Constr = "<globals\n\t\t{Declarat...";
_Cur_SpecLine = 1229;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  globals */
{


GNODE _gna377;	

_gna377 = (GNODE) GetFillers(TheRootNode,"globals");

 if (_gna377 != (GNODE) NULL) {

_Cur_Constr = "{Declaration\n...";
_Cur_SpecLine = 1230;
_Cur_Node = _gna377;

{

_Cur_Constr = "{Declaration\n...";
_Cur_SpecLine = 1230;
_Cur_Node = _gna377;

{

GNODE _gna378;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Declaration */
 
if (_gna377->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna378 = (GNODE)( _gna377->node_data.l_dv);
  for(;_gna378 != (GNODE) NULL;_gna378=_gna378->gnext) {
    if (OfType(_gna378,Declaration)) {

_Cur_Constr = "(?FunctionDef\n\t\t\t<de...";
_Cur_SpecLine = 1232;
_Cur_Node = _gna378;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE FunctionDef */		

if (OfType(_gna378,FunctionDef)) {

_Cur_Constr = "<defname\n\t\t\t(PRINT...";
_Cur_SpecLine = 1233;
_Cur_Node = _gna378;

{
	
	



/* ACCESS DOWN ON SLOT  defname */
{


GNODE _gna380;	

_gna380 = (GNODE) GetFillers(_gna378,"defname");

 if (_gna380 != (GNODE) NULL) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1234;
_Cur_Node = _gna380;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna381;

_gna381 = (GNODE) gmalloc ();
_gna381->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna381->node_type = 3;

_gna381->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna381 != (GNODE) NULL)
  if (VALIDTYPE(_gna381->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna381,""); 
  else fprintf(stderr,"\n At line 1235 attempt to unparse node of invalid type %d", _gna381->node_type);
else fprintf(stderr,"\n At line 1235 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna381;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1236;
_Cur_Node = _gna380;
{

GNODE _gna382;


_gna382 = getlocnode(_gna380);

_gna381 = (GNODE) GetFillers(_gna382,"line");
}

if (_gna381 != (GNODE) NULL)
  if (VALIDTYPE(_gna381->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna381,""); 
  else fprintf(stderr,"\n At line 1236 attempt to unparse node of invalid type %d", _gna381->node_type);
else fprintf(stderr,"\n At line 1236 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (FunctionDef "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna381;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1237;
_Cur_Node = _gna380;
{

GNODE _gna383;
_gna383 = _gna380;

_gna381 = (GNODE) GetFillers(_gna383,"id");
}

if (_gna381 != (GNODE) NULL)
  if (VALIDTYPE(_gna381->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna381,""); 
  else fprintf(stderr,"\n At line 1237 attempt to unparse node of invalid type %d", _gna381->node_type);
else fprintf(stderr,"\n At line 1237 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

 }	  /* Balances if (_gna380 != (GNODE) NULL )*/

} /* Balances GNODE _gna380; */

}

_Cur_Constr = "<args\n\t\t\t\t{Declarati...";
_Cur_SpecLine = 1240;
_Cur_Node = _gna378;

{
	
	



/* ACCESS DOWN ON SLOT  args */
{


GNODE _gna384;	

_gna384 = (GNODE) GetFillers(_gna378,"args");

 if (_gna384 != (GNODE) NULL) {

_Cur_Constr = "{Declaration\n\t\t\t\t(?O...";
_Cur_SpecLine = 1241;
_Cur_Node = _gna384;

{

_Cur_Constr = "{Declaration\n\t\t\t\t(?O...";
_Cur_SpecLine = 1241;
_Cur_Node = _gna384;

{

GNODE _gna385;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Declaration */
 
if (_gna384->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna385 = (GNODE)( _gna384->node_data.l_dv);
  for(;_gna385 != (GNODE) NULL;_gna385=_gna385->gnext) {
    if (OfType(_gna385,Declaration)) {

_Cur_Constr = "(?ObjectDef\n\t\t\t\t(ASS...";
_Cur_SpecLine = 1242;
_Cur_Node = _gna385;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE ObjectDef */		

if (OfType(_gna385,ObjectDef)) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1243;
_Cur_Node = _gna385;

{				

  /* EXECUTE ITEM */
{


GNODE _gna387;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1243;
_Cur_Node = _gna385;
{

GNODE _gna388;


_gna388 = getlocnode(_gna385);

_gna387 = (GNODE) GetFillers(_gna388,"file");
}

if (_gna387 != (GNODE) NULL && (GSLOT(_gna387) != (AXS_ENTRY) NULL))
	MarkUsed(_gna387);


flname = _gna387;


}

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1244;
_Cur_Node = _gna385;

{				

  /* EXECUTE ITEM */
{

int _gna389;
{ 
GNODE _gna390;

_gna390 = (GNODE) gmalloc ();
_gna390->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna390->node_type = 0;

_gna390->node_data.l_iv = ( (int) ( IsHeader( getCstring(fname))) );
  {

GNODE _gna391;

_gna391 = (GNODE) gmalloc ();
_gna391->node_flag = GBUILTIN | GSIMPLENODE;
_gna391->node_type = C_Integer;
_gna391->node_data.l_iv = 0;
_gna389 = gequal(_gna390, _gna391);
}
}

if (_gna389) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1245;
_Cur_Node = _gna385;

{				

  /* EXECUTE ITEM */
	
DealWithObjectDef (_gna385);  


}

}
}

}

}

}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 1241 is %s not type %d---Declaration",NodeTable[_gna385->node_type]->nodename,Declaration);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 1241- Parent NOT a LIST !");


}

}

 }	  /* Balances if (_gna384 != (GNODE) NULL )*/

} /* Balances GNODE _gna384; */

}

_Cur_Constr = "<body\n\t\t\t\t(CALL...";
_Cur_SpecLine = 1250;
_Cur_Node = _gna378;

{
	
	



/* ACCESS DOWN ON SLOT  body */
{


GNODE _gna392;	

_gna392 = (GNODE) GetFillers(_gna378,"body");

 if (_gna392 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1251;
_Cur_Node = _gna392;

{				

  /* EXECUTE ITEM */
	
DealWithStatement (_gna392);  


}

 }	  /* Balances if (_gna392 != (GNODE) NULL )*/

} /* Balances GNODE _gna392; */

}

}

}

_Cur_Constr = "(?ObjectDef\n\t\t\t(ASSI...";
_Cur_SpecLine = 1255;
_Cur_Node = _gna378;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE ObjectDef */		

if (OfType(_gna378,ObjectDef)) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1256;
_Cur_Node = _gna378;

{				

  /* EXECUTE ITEM */
{


GNODE _gna393;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1256;
_Cur_Node = _gna378;
{

GNODE _gna394;


_gna394 = getlocnode(_gna378);

_gna393 = (GNODE) GetFillers(_gna394,"file");
}

if (_gna393 != (GNODE) NULL && (GSLOT(_gna393) != (AXS_ENTRY) NULL))
	MarkUsed(_gna393);


flname = _gna393;


}

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1257;
_Cur_Node = _gna378;

{				

  /* EXECUTE ITEM */
{

int _gna395;
{ 
GNODE _gna396;

_gna396 = (GNODE) gmalloc ();
_gna396->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna396->node_type = 0;

_gna396->node_data.l_iv = ( (int) ( IsHeader( getCstring(fname))) );
  {

GNODE _gna397;

_gna397 = (GNODE) gmalloc ();
_gna397->node_flag = GBUILTIN | GSIMPLENODE;
_gna397->node_type = C_Integer;
_gna397->node_data.l_iv = 0;
_gna395 = gequal(_gna396, _gna397);
}
}

if (_gna395) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1258;
_Cur_Node = _gna378;

{				

  /* EXECUTE ITEM */
	
DealWithObjectDef (_gna378);  


}

}
}

}

}

}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 1230 is %s not type %d---Declaration",NodeTable[_gna378->node_type]->nodename,Declaration);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 1230- Parent NOT a LIST !");


}

}

 }	  /* Balances if (_gna377 != (GNODE) NULL )*/

} /* Balances GNODE _gna377; */

}
}


#if __STDC__ || __cplusplus

void VariableReference (GNODE TheRootNode	)
#else

void VariableReference ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE tmpt;

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1271;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna398;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1271;
_Cur_Node = TheRootNode;
{

GNODE _gna399;


_gna399 = getlocnode(TheRootNode);

_gna398 = (GNODE) GetFillers(_gna399,"line");
}

if (_gna398 != (GNODE) NULL && (GSLOT(_gna398) != (AXS_ENTRY) NULL))
	MarkUsed(_gna398);


tmpt = _gna398;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1272;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ( ");

}

_Cur_Constr = "[(?IdName\n\t(PRINT...";
_Cur_SpecLine = 1273;
_Cur_Node = TheRootNode;

{

/* LIST ITERATION ACCESS over all TREE CHILDREN */





_Cur_Constr = "[(?IdName\n\t(PRINT...";
_Cur_SpecLine = 1273;
_Cur_Node = TheRootNode;

if (TheRootNode != (GNODE) NULL)
{
#ifdef EXTSEARCH
	char *_G_DATA;
#endif

GNODE _gna402,_gna403,roothead;

#ifndef EXTSEARCH
GNODE SearchRoot;
#endif


_gna403 = TheRootNode;

if (IsList(_gna403)) {
#ifdef EXTSEARCH
	_G_SEARCH = SEARCHINIT;
#else
	SearchRoot = gcopy(_gna403->gparent);  /* If starting at a list, stop at the parent of the list */
                                            /* This is because each member of the list points to the parent, */
                                            /* Not the List head node */
#endif
} else {

#ifdef EXTSEARCH
_G_SEARCH = SEARCHINIT;
#else
SearchRoot = gcopy(_gna403);

#endif
}

/* 
rootcopy = gcopy(_gna403);
rootcopy->node_flag |= GSEARCHROOT;
rootcopy->gkids = (GNODE) NULL;
*/


roothead = gcopy(_gna403);       /* The search (on the unseen list) at the top of the loop always assumes the */
                                     /* The current node has been seen. */
roothead->node_flag |= GSEARCHROOT;
roothead->gkids = SearchRoot;

SearchRoot->node_flag = SearchRoot->node_flag & (!GTHREADED) ; /* Ignore threading of root; we'll come back to this later */
/* If this is inside another global search, we'll continue on the
  previous search unmolested, since this Searchroot is a copy */

_gna402 = roothead;




SearchRoot->gkids = (GNODE) NULL;

/* Depth first search through children of TheRootNode */

while (1) {  
	if (_gna402->gkids != (GNODE) NULL) {
	  _gna403 = _gna402->gkids; 
	  GCONDFREE(_gna402);
  	  _gna402 = _gna403;
	  if(IsList(_gna403)) {
	    if (!gnull(_gna403))
	      _gna402 = ThreadList(_gna403);
	    continue;
	  }
	}
        else if ((_gna402->node_flag & (GTHREADED) )) {
	  _gna403 =  _gna402->glast;
	  GCONDFREE(_gna402); 
	  _gna402 = _gna403;
 	  continue;
	}
	else if (_gna402 == SearchRoot ) {
	  break;
	} else {
	  _gna403 = _gna402->gparent;
	  GCONDFREE(_gna402); 
	  _gna402 = _gna403;
	  continue;
	}


#ifdef EXTSEARCH
	if (!(SEARCHTEST(_G_SEARCH,_G_DATA))) {
		SEARCHMARK(_G_DATA);
#else
	if(!(OnPath(_gna403,SearchRoot))) {
#endif

_Cur_Constr = "(?IdName\n\t(PRINT...";
_Cur_SpecLine = 1273;
_Cur_Node = _gna403;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE IdName */		

if (OfType(_gna403,IdName)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1274;
_Cur_Node = _gna403;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna408;
_gna408 = _gna403;

if (_gna408 != (GNODE) NULL)
  if (VALIDTYPE(_gna408->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna408,""); 
  else fprintf(stderr,"\n At line 1274 attempt to unparse node of invalid type %d", _gna408->node_type);
else fprintf(stderr,"\n At line 1274 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," ");

}

_Cur_Constr = "<def\t(PRINT...";
_Cur_SpecLine = 1275;
_Cur_Node = _gna403;

{
	
	



/* ACCESS DOWN ON SLOT  def */
{


GNODE _gna409;	

_gna409 = (GNODE) GetFillers(_gna403,"def");

 if (_gna409 != (GNODE) NULL) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1275;
_Cur_Node = _gna409;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna410;
_gna410 = (GNODE) fileName;

if (_gna410 != (GNODE) NULL)
  if (VALIDTYPE(_gna410->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna410,""); 
  else fprintf(stderr,"\n At line 1275 attempt to unparse node of invalid type %d", _gna410->node_type);
else fprintf(stderr,"\n At line 1275 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna410;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1275;
_Cur_Node = _gna409;
{

GNODE _gna411;


_gna411 = getlocnode(_gna409);

_gna410 = (GNODE) GetFillers(_gna411,"line");
}

if (_gna410 != (GNODE) NULL)
  if (VALIDTYPE(_gna410->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna410,""); 
  else fprintf(stderr,"\n At line 1275 attempt to unparse node of invalid type %d", _gna410->node_type);
else fprintf(stderr,"\n At line 1275 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,") ");

}

 }	  /* Balances if (_gna409 != (GNODE) NULL )*/

} /* Balances GNODE _gna409; */

}

}

}

        if (!(_gna403->node_flag & GBUILTIN))
		_gna402 = ExpandAll(_gna403);
		
/* Expand the current node and start looking at these children */


        }

}	

      }
#ifdef EXTSEARCH
	SEARCHFINIT(_G_SEARCH);
#endif

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1278;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1280;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," ( ");

}

_Cur_Constr = "[(?IdName\n...";
_Cur_SpecLine = 1281;
_Cur_Node = TheRootNode;

{

/* LIST ITERATION ACCESS over all TREE CHILDREN */





_Cur_Constr = "[(?IdName\n...";
_Cur_SpecLine = 1281;
_Cur_Node = TheRootNode;

if (TheRootNode != (GNODE) NULL)
{
#ifdef EXTSEARCH
	char *_G_DATA;
#endif

GNODE _gna415,_gna416,roothead;

#ifndef EXTSEARCH
GNODE SearchRoot;
#endif


_gna416 = TheRootNode;

if (IsList(_gna416)) {
#ifdef EXTSEARCH
	_G_SEARCH = SEARCHINIT;
#else
	SearchRoot = gcopy(_gna416->gparent);  /* If starting at a list, stop at the parent of the list */
                                            /* This is because each member of the list points to the parent, */
                                            /* Not the List head node */
#endif
} else {

#ifdef EXTSEARCH
_G_SEARCH = SEARCHINIT;
#else
SearchRoot = gcopy(_gna416);

#endif
}

/* 
rootcopy = gcopy(_gna416);
rootcopy->node_flag |= GSEARCHROOT;
rootcopy->gkids = (GNODE) NULL;
*/


roothead = gcopy(_gna416);       /* The search (on the unseen list) at the top of the loop always assumes the */
                                     /* The current node has been seen. */
roothead->node_flag |= GSEARCHROOT;
roothead->gkids = SearchRoot;

SearchRoot->node_flag = SearchRoot->node_flag & (!GTHREADED) ; /* Ignore threading of root; we'll come back to this later */
/* If this is inside another global search, we'll continue on the
  previous search unmolested, since this Searchroot is a copy */

_gna415 = roothead;




SearchRoot->gkids = (GNODE) NULL;

/* Depth first search through children of TheRootNode */

while (1) {  
	if (_gna415->gkids != (GNODE) NULL) {
	  _gna416 = _gna415->gkids; 
	  GCONDFREE(_gna415);
  	  _gna415 = _gna416;
	  if(IsList(_gna416)) {
	    if (!gnull(_gna416))
	      _gna415 = ThreadList(_gna416);
	    continue;
	  }
	}
        else if ((_gna415->node_flag & (GTHREADED) )) {
	  _gna416 =  _gna415->glast;
	  GCONDFREE(_gna415); 
	  _gna415 = _gna416;
 	  continue;
	}
	else if (_gna415 == SearchRoot ) {
	  break;
	} else {
	  _gna416 = _gna415->gparent;
	  GCONDFREE(_gna415); 
	  _gna415 = _gna416;
	  continue;
	}


#ifdef EXTSEARCH
	if (!(SEARCHTEST(_G_SEARCH,_G_DATA))) {
		SEARCHMARK(_G_DATA);
#else
	if(!(OnPath(_gna416,SearchRoot))) {
#endif

_Cur_Constr = "(?IdName\n...";
_Cur_SpecLine = 1281;
_Cur_Node = _gna416;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE IdName */		

if (OfType(_gna416,IdName)) {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1282;
_Cur_Node = _gna416;

{				

  /* EXECUTE ITEM */
{

int _gna421;

_gna421 = 0;	

{
if( _gna421 == 0 ){

int _gna422;

_gna422 = 1;	
{
if( _gna422 == 1 ){

int _gna423;
{

GNODE _gna424;
_gna424 = _gna416->gparent;



_gna423 =  OfType(_gna424,Assignment);
}
_gna422 = _gna423 && _gna422;
}
}	
{
if( _gna422 == 1 ){

int _gna425;
{

GNODE _gna426;

_gna426 = (GNODE) gmalloc ();
_gna426->node_flag = GBUILTIN | GSIMPLENODE;
_gna426->node_type = C_String;
_gna426->node_data.l_dv = (GSLOT(_gna416)) ? GSLOT(_gna416)->slotname : "";
  {

GNODE _gna427;

_gna427 = (GNODE) gmalloc ();
_gna427->node_flag = GBUILTIN | GSIMPLENODE;
_gna427->node_type = C_String;
_gna427->node_data.l_dv = "be_lhs";
_gna425 = gequal(_gna426, _gna427);
}
}
_gna422 = _gna425 && _gna422;
}
}
_gna421 = _gna422 || _gna421;
}
}	

{
if( _gna421 == 0 ){

int _gna428;
{

GNODE _gna429;
_gna429 = _gna416->gparent;



_gna428 =  OfType(_gna429,UnaryCount);
}
_gna421 = _gna428 || _gna421;
}
}

if (_gna421) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1285;
_Cur_Node = _gna416;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna430;
_gna430 = _gna416;

if (_gna430 != (GNODE) NULL)
  if (VALIDTYPE(_gna430->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna430,""); 
  else fprintf(stderr,"\n At line 1285 attempt to unparse node of invalid type %d", _gna430->node_type);
else fprintf(stderr,"\n At line 1285 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," ");

}

_Cur_Constr = "<def\t(PRINT...";
_Cur_SpecLine = 1286;
_Cur_Node = _gna416;

{
	
	



/* ACCESS DOWN ON SLOT  def */
{


GNODE _gna431;	

_gna431 = (GNODE) GetFillers(_gna416,"def");

 if (_gna431 != (GNODE) NULL) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1286;
_Cur_Node = _gna431;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna432;
_gna432 = (GNODE) fileName;

if (_gna432 != (GNODE) NULL)
  if (VALIDTYPE(_gna432->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna432,""); 
  else fprintf(stderr,"\n At line 1286 attempt to unparse node of invalid type %d", _gna432->node_type);
else fprintf(stderr,"\n At line 1286 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna432;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1286;
_Cur_Node = _gna431;
{

GNODE _gna433;


_gna433 = getlocnode(_gna431);

_gna432 = (GNODE) GetFillers(_gna433,"line");
}

if (_gna432 != (GNODE) NULL)
  if (VALIDTYPE(_gna432->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna432,""); 
  else fprintf(stderr,"\n At line 1286 attempt to unparse node of invalid type %d", _gna432->node_type);
else fprintf(stderr,"\n At line 1286 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,") ");

}

 }	  /* Balances if (_gna431 != (GNODE) NULL )*/

} /* Balances GNODE _gna431; */

}

}
}

}

}

}

        if (!(_gna416->node_flag & GBUILTIN))
		_gna415 = ExpandAll(_gna416);
		
/* Expand the current node and start looking at these children */


        }

}	

      }
#ifdef EXTSEARCH
	SEARCHFINIT(_G_SEARCH);
#endif

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1290;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n");

}
}


#if __STDC__ || __cplusplus

GNODE  LOCSTRING (GNODE TheRootNode,GNODE Suffix	)
#else

GNODE LOCSTRING ( TheRootNode,Suffix )

 GNODE TheRootNode;
	GNODE Suffix;
#endif

{
	GNODE tmpt;

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1301;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna435;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1301;
_Cur_Node = TheRootNode;
{

GNODE _gna436;


_gna436 = getlocnode(TheRootNode);

_gna435 = (GNODE) GetFillers(_gna436,"line");
}

if (_gna435 != (GNODE) NULL && (GSLOT(_gna435) != (AXS_ENTRY) NULL))
	MarkUsed(_gna435);


tmpt = _gna435;


}

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1302;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna437;

_gna437 = (GNODE) gmalloc ();
_gna437->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna437->node_type = 3;

_gna437->node_data.l_dv = ( (char *)( mystrconcat( mystrconcat( mystrconcat( getCstring(fileName),"_stmt"),myitoa(getCint(tmpt))),getCstring(Suffix)))) ;

return (_gna437);
}

}
}


#if __STDC__ || __cplusplus

void FileFlow (GNODE TheRootNode	)
#else

void FileFlow ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE foo;
	GNODE tfile;
	GNODE controlFileName;
	GNODE componentFileName;

  if (!(OfType(TheRootNode, CFile))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure FileFlow called with node of type %s, not of type %d CFile",WhatType(TheRootNode->node_type),CFile);
	else printf("\n Procedure FileFlow called with invalid node  type %d, not of type %d CFile",TheRootNode->node_type,CFile);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return;
  }

_Cur_Constr = "<where...";
_Cur_SpecLine = 1319;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  where */
{


GNODE _gna438;	

_gna438 = (GNODE) GetFillers(TheRootNode,"where");

 if (_gna438 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1319;
_Cur_Node = _gna438;

{				

  /* EXECUTE ITEM */
{


GNODE _gna439;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1319;
_Cur_Node = _gna438;
{

GNODE _gna440;


_gna440 = getlocnode(_gna438);

_gna439 = (GNODE) GetFillers(_gna440,"file");
}

if (_gna439 != (GNODE) NULL && (GSLOT(_gna439) != (AXS_ENTRY) NULL))
	MarkUsed(_gna439);


tfile = _gna439;


}

}

 }	  /* Balances if (_gna438 != (GNODE) NULL )*/

} /* Balances GNODE _gna438; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1320;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna441;

_gna441 = (GNODE) gmalloc ();
_gna441->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna441->node_type = 3;

_gna441->node_data.l_dv = ( (char *)( (char *)newFileName( getCstring(tfile)))) ;

if (_gna441 != (GNODE) NULL && (GSLOT(_gna441) != (AXS_ENTRY) NULL))
	MarkUsed(_gna441);


fileName = _gna441;


}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1321;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna442;

_gna442 = (GNODE) gmalloc ();
_gna442->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna442->node_type = 3;

_gna442->node_data.l_dv = ( (char *)( (char *)newControlFileName( getCstring(tfile)))) ;

if (_gna442 != (GNODE) NULL && (GSLOT(_gna442) != (AXS_ENTRY) NULL))
	MarkUsed(_gna442);


controlFileName = _gna442;


}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1322;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna443;

_gna443 = (GNODE) gmalloc ();
_gna443->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna443->node_type = 3;

_gna443->node_data.l_dv = ( (char *)( (char *)newComponentFileName( getCstring(tfile)))) ;

if (_gna443 != (GNODE) NULL && (GSLOT(_gna443) != (AXS_ENTRY) NULL))
	MarkUsed(_gna443);


componentFileName = _gna443;


}

}

_Cur_Constr = "(OPEN...";
_Cur_SpecLine = 1324;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna444;
_gna444 = (GNODE) controlFileName;
control = gmalloc();
control->node_flag = (GSIMPLENODE | GBUILTIN);
control->node_type = C_File;

if ((control->node_data.l_dv = (char *) fopen(getCstring(_gna444),"w")) == NULL) {
	fprintf(stderr,"\nFATAL ERROR **********Cannot open (or create, if output) File %s **********!!!\n",getCstring(_gna444));
	exit(1);
	}

}

}

_Cur_Constr = "(OPEN...";
_Cur_SpecLine = 1325;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna445;
_gna445 = (GNODE) componentFileName;
component = gmalloc();
component->node_flag = (GSIMPLENODE | GBUILTIN);
component->node_type = C_File;

if ((component->node_data.l_dv = (char *) fopen(getCstring(_gna445),"w")) == NULL) {
	fprintf(stderr,"\nFATAL ERROR **********Cannot open (or create, if output) File %s **********!!!\n",getCstring(_gna445));
	exit(1);
	}

}

}

_Cur_Constr = "<globals\n\n...";
_Cur_SpecLine = 1327;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  globals */
{


GNODE _gna446;	

_gna446 = (GNODE) GetFillers(TheRootNode,"globals");

 if (_gna446 != (GNODE) NULL) {

_Cur_Constr = "{Declaration\n...";
_Cur_SpecLine = 1329;
_Cur_Node = _gna446;

{

_Cur_Constr = "{Declaration\n...";
_Cur_SpecLine = 1329;
_Cur_Node = _gna446;

{

GNODE _gna447;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Declaration */
 
if (_gna446->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna447 = (GNODE)( _gna446->node_data.l_dv);
  for(;_gna447 != (GNODE) NULL;_gna447=_gna447->gnext) {
    if (OfType(_gna447,Declaration)) {

_Cur_Constr = "(?FunctionDef\n\t\t<id\n...";
_Cur_SpecLine = 1330;
_Cur_Node = _gna447;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE FunctionDef */		

if (OfType(_gna447,FunctionDef)) {

_Cur_Constr = "<id\n\t\t\t(ASSIGN...";
_Cur_SpecLine = 1331;
_Cur_Node = _gna447;

{
	
	



/* ACCESS DOWN ON SLOT  id */
{


GNODE _gna449;	

_gna449 = (GNODE) GetFillers(_gna447,"id");

 if (_gna449 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1332;
_Cur_Node = _gna449;

{				

  /* EXECUTE ITEM */
{

GNODE _gna450;
_gna450 = gcopy(_gna449);

if (_gna450 != (GNODE) NULL && (GSLOT(_gna450) != (AXS_ENTRY) NULL))
	MarkUsed(_gna450);


fname = _gna450;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1333;
_Cur_Node = _gna449;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna451;
_gna451 = (GNODE) fname;
	
                gunparse((FILE *)control->node_data.l_dv,_gna451,"verbose");
	}
        fprintf((FILE *)control->node_data.l_dv,"\n(");

}

 }	  /* Balances if (_gna449 != (GNODE) NULL )*/

} /* Balances GNODE _gna449; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1335;
_Cur_Node = _gna447;

{				

  /* EXECUTE ITEM */
{


GNODE _gna452;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1335;
_Cur_Node = _gna447;
{

GNODE _gna453;


_gna453 = getlocnode(_gna447);

_gna452 = (GNODE) GetFillers(_gna453,"file");
}

if (_gna452 != (GNODE) NULL && (GSLOT(_gna452) != (AXS_ENTRY) NULL))
	MarkUsed(_gna452);


fname = _gna452;


}

}

_Cur_Constr = "<args\n...";
_Cur_SpecLine = 1336;
_Cur_Node = _gna447;

{
	
	



/* ACCESS DOWN ON SLOT  args */
{


GNODE _gna454;	

_gna454 = (GNODE) GetFillers(_gna447,"args");

 if (_gna454 != (GNODE) NULL) {

_Cur_Constr = "{Declaration\n\t\t\t\t(PR...";
_Cur_SpecLine = 1337;
_Cur_Node = _gna454;

{

_Cur_Constr = "{Declaration\n\t\t\t\t(PR...";
_Cur_SpecLine = 1337;
_Cur_Node = _gna454;

{

GNODE _gna455;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Declaration */
 
if (_gna454->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna455 = (GNODE)( _gna454->node_data.l_dv);
  for(;_gna455 != (GNODE) NULL;_gna455=_gna455->gnext) {
    if (OfType(_gna455,Declaration)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1338;
_Cur_Node = _gna455;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna457;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1338;
_Cur_Node = _gna455;
{

GNODE _gna458;
_gna458 = _gna455;

_gna457 = (GNODE) GetFillers(_gna458,"id");
}

if (_gna457 != (GNODE) NULL)
  if (VALIDTYPE(_gna457->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna457,""); 
  else fprintf(stderr,"\n At line 1338 attempt to unparse node of invalid type %d", _gna457->node_type);
else fprintf(stderr,"\n At line 1338 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna457;
_gna457 = (GNODE) fileName;

if (_gna457 != (GNODE) NULL)
  if (VALIDTYPE(_gna457->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna457,""); 
  else fprintf(stderr,"\n At line 1338 attempt to unparse node of invalid type %d", _gna457->node_type);
else fprintf(stderr,"\n At line 1338 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna457;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1338;
_Cur_Node = _gna455;
{

GNODE _gna459;


_gna459 = getlocnode(_gna455);

_gna457 = (GNODE) GetFillers(_gna459,"line");
}

if (_gna457 != (GNODE) NULL)
  if (VALIDTYPE(_gna457->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna457,""); 
  else fprintf(stderr,"\n At line 1338 attempt to unparse node of invalid type %d", _gna457->node_type);
else fprintf(stderr,"\n At line 1338 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,") ");

}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 1337 is %s not type %d---Declaration",NodeTable[_gna455->node_type]->nodename,Declaration);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 1337- Parent NOT a LIST !");


}

}

 }	  /* Balances if (_gna454 != (GNODE) NULL )*/

} /* Balances GNODE _gna454; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1341;
_Cur_Node = _gna447;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,")\n");

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1343;
_Cur_Node = _gna447;

{				

  /* EXECUTE ITEM */
{

int _gna461;
{ 
GNODE _gna462;

_gna462 = (GNODE) gmalloc ();
_gna462->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna462->node_type = 0;

_gna462->node_data.l_iv = ( (int) ( IsHeader(getCstring(fname))) );
  {

GNODE _gna463;

_gna463 = (GNODE) gmalloc ();
_gna463->node_flag = GBUILTIN | GSIMPLENODE;
_gna463->node_type = C_Integer;
_gna463->node_data.l_iv = 0;
_gna461 = gequal(_gna462, _gna463);
}
}

if (_gna461) {

_Cur_Constr = "<id...";
_Cur_SpecLine = 1346;
_Cur_Node = _gna447;

{
	
	



/* ACCESS DOWN ON SLOT  id */
{


GNODE _gna464;	

_gna464 = (GNODE) GetFillers(_gna447,"id");

 if (_gna464 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1346;
_Cur_Node = _gna464;

{				

  /* EXECUTE ITEM */
{

GNODE _gna465;
_gna465 = gcopy(_gna464);

if (_gna465 != (GNODE) NULL && (GSLOT(_gna465) != (AXS_ENTRY) NULL))
	MarkUsed(_gna465);


fname = _gna465;


}

}

 }	  /* Balances if (_gna464 != (GNODE) NULL )*/

} /* Balances GNODE _gna464; */

}

_Cur_Constr = "<body\n...";
_Cur_SpecLine = 1347;
_Cur_Node = _gna447;

{
	
	



/* ACCESS DOWN ON SLOT  body */
{


GNODE _gna466;	

_gna466 = (GNODE) GetFillers(_gna447,"body");

 if (_gna466 != (GNODE) NULL) {

_Cur_Constr = "<blockend...";
_Cur_SpecLine = 1348;
_Cur_Node = _gna466;

{
	
	



/* ACCESS DOWN ON SLOT  blockend */
{


GNODE _gna467;	

_gna467 = (GNODE) GetFillers(_gna466,"blockend");

 if (_gna467 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1348;
_Cur_Node = _gna467;

{				

  /* EXECUTE ITEM */
{


GNODE _gna468;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna469;

_gna469 = (GNODE) gmalloc ();
_gna469->node_flag = GBUILTIN | GSIMPLENODE;
_gna469->node_type = C_String;
_gna469->node_data.l_dv = "";
	_gna468 = LOCSTRING (_gna467,_gna469);




	



}

if (_gna468 != (GNODE) NULL && (GSLOT(_gna468) != (AXS_ENTRY) NULL))
	MarkUsed(_gna468);


foo = _gna468;


}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1349;
_Cur_Node = _gna467;

{				

  /* EXECUTE ITEM */
{

GNODE _gna470;
_gna470 = gcopy((GNODE) foo);

if (_gna470 != (GNODE) NULL && (GSLOT(_gna470) != (AXS_ENTRY) NULL))
	MarkUsed(_gna470);


finish_stmt = _gna470;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1350;
_Cur_Node = _gna467;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna471;
_gna471 = (GNODE) fileName;

if (_gna471 != (GNODE) NULL)
  if (VALIDTYPE(_gna471->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna471,""); 
  else fprintf(stderr,"\n At line 1351 attempt to unparse node of invalid type %d", _gna471->node_type);
else fprintf(stderr,"\n At line 1351 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna471;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1351;
_Cur_Node = _gna467;
{

GNODE _gna472;


_gna472 = getlocnode(_gna467);

_gna471 = (GNODE) GetFillers(_gna472,"line");
}

if (_gna471 != (GNODE) NULL)
  if (VALIDTYPE(_gna471->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna471,""); 
  else fprintf(stderr,"\n At line 1351 attempt to unparse node of invalid type %d", _gna471->node_type);
else fprintf(stderr,"\n At line 1351 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n (\n("); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna471;

_gna471 = (GNODE) gmalloc ();
_gna471->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna471->node_type = 3;

_gna471->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna471 != (GNODE) NULL)
  if (VALIDTYPE(_gna471->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna471,""); 
  else fprintf(stderr,"\n At line 1352 attempt to unparse node of invalid type %d", _gna471->node_type);
else fprintf(stderr,"\n At line 1352 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna471;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1353;
_Cur_Node = _gna467;
{

GNODE _gna473;


_gna473 = getlocnode(_gna467);

_gna471 = (GNODE) GetFillers(_gna473,"line");
}

if (_gna471 != (GNODE) NULL)
  if (VALIDTYPE(_gna471->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna471,""); 
  else fprintf(stderr,"\n At line 1353 attempt to unparse node of invalid type %d", _gna471->node_type);
else fprintf(stderr,"\n At line 1353 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," (Finish))\n )\n)\n");

}

 }	  /* Balances if (_gna467 != (GNODE) NULL )*/

} /* Balances GNODE _gna467; */

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1357;
_Cur_Node = _gna466;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna474;
_gna474 = gcopy((GNODE) foo);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna475;
_gna475 = gcopy((GNODE) foo);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna476;
_gna476 = gcopy((GNODE) foo);
	
CompoundFlow (_gna466,_gna474,_gna475,_gna476);  
}}}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1358;
_Cur_Node = _gna466;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */  /* Clip the format string at percent sign */
	fprintf(stdout,"\n(EndFunctionNamed ");  /* Clip the format string at percent sign */
	fprintf(stdout,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna477;
_gna477 = (GNODE) fname;
	
                gunparse(stdout,_gna477,"verbose");
	}
        fprintf(stdout,")\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1359;
_Cur_Node = _gna466;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n)\n\n");

}

 }	  /* Balances if (_gna466 != (GNODE) NULL )*/

} /* Balances GNODE _gna466; */

}

}
}

}

}

}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 1329 is %s not type %d---Declaration",NodeTable[_gna447->node_type]->nodename,Declaration);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 1329- Parent NOT a LIST !");


}

}

 }	  /* Balances if (_gna446 != (GNODE) NULL )*/

} /* Balances GNODE _gna446; */

}
}


#if __STDC__ || __cplusplus

GNODE  BlockFirst (GNODE TheRootNode	)
#else

GNODE BlockFirst ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, Statement))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure BlockFirst called with node of type %s, not of type %d Statement",WhatType(TheRootNode->node_type),Statement);
	else printf("\n Procedure BlockFirst called with invalid node  type %d, not of type %d Statement",TheRootNode->node_type,Statement);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(?Block\n...";
_Cur_SpecLine = 1391;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Block */		

if (OfType(TheRootNode,Block)) {

_Cur_Constr = "<blockbody\n...";
_Cur_SpecLine = 1392;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  blockbody */
{


GNODE _gna479;	

_gna479 = (GNODE) GetFillers(TheRootNode,"blockbody");

 if (_gna479 != (GNODE) NULL) {

_Cur_Constr = "{Statement\n...";
_Cur_SpecLine = 1393;
_Cur_Node = _gna479;

{

_Cur_Constr = "{Statement\n...";
_Cur_SpecLine = 1393;
_Cur_Node = _gna479;

{

GNODE _gna480;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Statement */
 
if (_gna479->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna480 = (GNODE)( _gna479->node_data.l_dv);
  for(;_gna480 != (GNODE) NULL;_gna480=_gna480->gnext) {
    if (OfType(_gna480,Statement)) {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1394;
_Cur_Node = _gna480;

{				

  /* EXECUTE ITEM */
{

int _gna482;

{

int _gna483;
{

GNODE _gna484;
_gna484 = _gna480;



_gna483 =  OfType(_gna484,NullStmt);
}

_gna482 = !_gna483;
}

if (_gna482) {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1396;
_Cur_Node = _gna480;

{				

  /* EXECUTE ITEM */
{

int _gna485;

{

int _gna486;
{

GNODE _gna487;
_gna487 = _gna480;



_gna486 =  OfType(_gna487,Block);
}

_gna485 = !_gna486;
}

if (_gna485) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1397;
_Cur_Node = _gna480;

{				

  /* EXECUTE ITEM */
{


GNODE _gna488;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna489;

_gna489 = (GNODE) gmalloc ();
_gna489->node_flag = GBUILTIN | GSIMPLENODE;
_gna489->node_type = C_String;
_gna489->node_data.l_dv = "";
	_gna488 = LOCSTRING (_gna480,_gna489);




	



}

return (_gna488);
}

}

}
else {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1398;
_Cur_Node = _gna480;

{				

  /* EXECUTE ITEM */
{


GNODE _gna490;
	_gna490 = BlockFirst (_gna480);




	





return (_gna490);
}

}
}
}

}

}
}

}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 1393 is %s not type %d---Statement",NodeTable[_gna480->node_type]->nodename,Statement);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 1393- Parent NOT a LIST !");


}

}

 }	  /* Balances if (_gna479 != (GNODE) NULL )*/

} /* Balances GNODE _gna479; */

}

}

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1402;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna491;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna492;

_gna492 = (GNODE) gmalloc ();
_gna492->node_flag = GBUILTIN | GSIMPLENODE;
_gna492->node_type = C_String;
_gna492->node_data.l_dv = "";
	_gna491 = LOCSTRING (TheRootNode,_gna492);




	



}

return (_gna491);
}

}
}


#if __STDC__ || __cplusplus

GNODE  BlockEnd (GNODE TheRootNode	)
#else

GNODE BlockEnd ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE End;

  if (!(OfType(TheRootNode, Statement))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure BlockEnd called with node of type %s, not of type %d Statement",WhatType(TheRootNode->node_type),Statement);
	else printf("\n Procedure BlockEnd called with invalid node  type %d, not of type %d Statement",TheRootNode->node_type,Statement);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(?Block\n...";
_Cur_SpecLine = 1412;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Block */		

if (OfType(TheRootNode,Block)) {

_Cur_Constr = "<blockbody\n...";
_Cur_SpecLine = 1413;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  blockbody */
{


GNODE _gna493;	

_gna493 = (GNODE) GetFillers(TheRootNode,"blockbody");

 if (_gna493 != (GNODE) NULL) {

_Cur_Constr = "{Statement\n...";
_Cur_SpecLine = 1414;
_Cur_Node = _gna493;

{

_Cur_Constr = "{Statement\n...";
_Cur_SpecLine = 1414;
_Cur_Node = _gna493;

{

GNODE _gna494;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Statement */
 
if (_gna493->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna494 = (GNODE)( _gna493->node_data.l_dv);
  for(;_gna494 != (GNODE) NULL;_gna494=_gna494->gnext) {
    if (OfType(_gna494,Statement)) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1415;
_Cur_Node = _gna494;

{				

  /* EXECUTE ITEM */
{

GNODE _gna496;
_gna496 = gcopy(_gna494);

if (_gna496 != (GNODE) NULL && (GSLOT(_gna496) != (AXS_ENTRY) NULL))
	MarkUsed(_gna496);


End = _gna496;


}

}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 1414 is %s not type %d---Statement",NodeTable[_gna494->node_type]->nodename,Statement);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 1414- Parent NOT a LIST !");


}

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1416;
_Cur_Node = _gna493;

{				

  /* EXECUTE ITEM */
{

int _gna497;

{

int _gna498;
{

GNODE _gna499;
_gna499 = (GNODE) End;



_gna498 =  OfType(_gna499,NullStmt);
}

_gna497 = !_gna498;
}

if (_gna497) {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1418;
_Cur_Node = _gna493;

{				

  /* EXECUTE ITEM */
{

int _gna500;

{

int _gna501;
{

GNODE _gna502;
_gna502 = (GNODE) End;



_gna501 =  OfType(_gna502,Block);
}

_gna500 = !_gna501;
}

if (_gna500) {

_Cur_Constr = "(SEARCH...";
_Cur_SpecLine = 1419;
_Cur_Node = _gna493;

{				

  /* EXECUTE ITEM */
{




/* Search down  a NODE of TYPE Statement */

GNODE _gna503;
_gna503 = gcopy((GNODE) End);
if (OfType(_gna503,Statement)) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1419;
_Cur_Node = _gna503;

{				

  /* EXECUTE ITEM */
{


GNODE _gna504;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna505;

_gna505 = (GNODE) gmalloc ();
_gna505->node_flag = GBUILTIN | GSIMPLENODE;
_gna505->node_type = C_String;
_gna505->node_data.l_dv = "";
	_gna504 = LOCSTRING (_gna503,_gna505);




	



}

return (_gna504);
}

}
}
	

}

}

}
else {

_Cur_Constr = "(SEARCH...";
_Cur_SpecLine = 1420;
_Cur_Node = _gna493;

{				

  /* EXECUTE ITEM */
{




/* Search down  a NODE of TYPE Block */

GNODE _gna506;
_gna506 = gcopy((GNODE) End);
if (OfType(_gna506,Block)) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1420;
_Cur_Node = _gna506;

{				

  /* EXECUTE ITEM */
{


GNODE _gna507;
	_gna507 = BlockFirst (_gna506);




	





return (_gna507);
}

}
}
	

}

}
}
}

}

}
}

}

 }	  /* Balances if (_gna493 != (GNODE) NULL )*/

} /* Balances GNODE _gna493; */

}

}

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1424;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna508;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna509;

_gna509 = (GNODE) gmalloc ();
_gna509->node_flag = GBUILTIN | GSIMPLENODE;
_gna509->node_type = C_String;
_gna509->node_data.l_dv = "";
	_gna508 = LOCSTRING (TheRootNode,_gna509);




	



}

return (_gna508);
}

}
}


#if __STDC__ || __cplusplus

GNODE  FindNext (GNODE TheRootNode,GNODE GivenNext	)
#else

GNODE FindNext ( TheRootNode,GivenNext )

 GNODE TheRootNode;
	GNODE GivenNext;
#endif

{
	GNODE Cursor;

  if (!(OfType(TheRootNode, Statement))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure FindNext called with node of type %s, not of type %d Statement",WhatType(TheRootNode->node_type),Statement);
	else printf("\n Procedure FindNext called with invalid node  type %d, not of type %d Statement",TheRootNode->node_type,Statement);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1436;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna510;
_gna510 = gcopy(TheRootNode);

if (_gna510 != (GNODE) NULL && (GSLOT(_gna510) != (AXS_ENTRY) NULL))
	MarkUsed(_gna510);


Cursor = _gna510;


}

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1438;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna511;

{

int _gna512;
{

GNODE _gna513;

{

GNODE _gna514;
_gna514 = (GNODE) Cursor;
if (_gna514->node_flag & (GLISTMEMBER | GITERMEMBER))
	_gna513 = GNEXT(_gna514);
else _gna513 = (GNODE) NULL;

}
_gna512 = (_gna513== (GNODE) NULL);
}

_gna511 = !_gna512;
}

if (_gna511) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1439;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna515;

{

GNODE _gna516;
_gna516 = (GNODE) Cursor;
if (_gna516->node_flag & (GLISTMEMBER | GITERMEMBER))
	_gna515 = gcopy(GNEXT(_gna516));
else _gna515 = (GNODE) NULL;

}

if (_gna515 != (GNODE) NULL && (GSLOT(_gna515) != (AXS_ENTRY) NULL))
	MarkUsed(_gna515);


Cursor = _gna515;


}

}

_Cur_Constr = "(WHILE...";
_Cur_SpecLine = 1440;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna517;

_gna517 = 1;	
{
if( _gna517 == 1 ){

int _gna518;

{

int _gna519;
{

GNODE _gna520;
_gna520 = (GNODE) Cursor;
_gna519 = (_gna520== (GNODE) NULL);
}

_gna518 = !_gna519;
}
_gna517 = _gna518 && _gna517;
}
}	
{
if( _gna517 == 1 ){

int _gna521;
{

GNODE _gna522;
_gna522 = (GNODE) Cursor;



_gna521 =  OfType(_gna522,NullStmt);
}
_gna517 = _gna521 && _gna517;
}
}

while(_gna517) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1441;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna523;

{

GNODE _gna524;
_gna524 = (GNODE) Cursor;
if (_gna524->node_flag & (GLISTMEMBER | GITERMEMBER))
	_gna523 = gcopy(GNEXT(_gna524));
else _gna523 = (GNODE) NULL;

}

if (_gna523 != (GNODE) NULL && (GSLOT(_gna523) != (AXS_ENTRY) NULL))
	MarkUsed(_gna523);


Cursor = _gna523;


}

}
{

int _gna525;

_gna525 = 1;	
{
if( _gna525 == 1 ){

int _gna526;

{

int _gna527;
{

GNODE _gna528;
_gna528 = (GNODE) Cursor;
_gna527 = (_gna528== (GNODE) NULL);
}

_gna526 = !_gna527;
}
_gna525 = _gna526 && _gna525;
}
}	
{
if( _gna525 == 1 ){

int _gna529;
{

GNODE _gna530;
_gna530 = (GNODE) Cursor;



_gna529 =  OfType(_gna530,NullStmt);
}
_gna525 = _gna529 && _gna525;
}
}
_gna517 = _gna525;
}
}
}

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1442;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna531;

{

int _gna532;
{

GNODE _gna533;
_gna533 = (GNODE) Cursor;
_gna532 = (_gna533== (GNODE) NULL);
}

_gna531 = !_gna532;
}

if (_gna531) {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1443;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna534;
{

GNODE _gna535;
_gna535 = (GNODE) Cursor;



_gna534 =  OfType(_gna535,Block);
}

if (_gna534) {

_Cur_Constr = "(SEARCH...";
_Cur_SpecLine = 1444;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{




/* Search down  a NODE of TYPE Block */

GNODE _gna536;
_gna536 = gcopy((GNODE) Cursor);
if (OfType(_gna536,Block)) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1444;
_Cur_Node = _gna536;

{				

  /* EXECUTE ITEM */
{


GNODE _gna537;
	_gna537 = BlockFirst (_gna536);




	





return (_gna537);
}

}
}
	

}

}

}
else {

_Cur_Constr = "(SEARCH...";
_Cur_SpecLine = 1445;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{




/* Search down  a NODE of TYPE Statement */

GNODE _gna538;
_gna538 = gcopy((GNODE) Cursor);
if (OfType(_gna538,Statement)) {

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1445;
_Cur_Node = _gna538;

{				

  /* EXECUTE ITEM */
{


GNODE _gna539;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna540;

_gna540 = (GNODE) gmalloc ();
_gna540->node_flag = GBUILTIN | GSIMPLENODE;
_gna540->node_type = C_String;
_gna540->node_data.l_dv = "";
	_gna539 = LOCSTRING (_gna538,_gna540);




	



}

return (_gna539);
}

}
}
	

}

}
}
}

}

}
}

}

}
}

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1448;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna541;
_gna541 = gcopy((GNODE) GivenNext);

return (_gna541);
}

}
}


#if __STDC__ || __cplusplus

void CompoundFlow (GNODE TheRootNode,GNODE NextLoc,GNODE ContinueLoc,GNODE BreakLoc	)
#else

void CompoundFlow ( TheRootNode,NextLoc,ContinueLoc,BreakLoc )

 GNODE TheRootNode;
	GNODE NextLoc;
	GNODE ContinueLoc;
	GNODE BreakLoc;
#endif

{
	GNODE CurLoc;
	GNODE TheNext;

  if (!(OfType(TheRootNode, Block))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure CompoundFlow called with node of type %s, not of type %d Block",WhatType(TheRootNode->node_type),Block);
	else printf("\n Procedure CompoundFlow called with invalid node  type %d, not of type %d Block",TheRootNode->node_type,Block);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return;
  }

_Cur_Constr = "<blockbody\n...";
_Cur_SpecLine = 1466;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  blockbody */
{


GNODE _gna542;	

_gna542 = (GNODE) GetFillers(TheRootNode,"blockbody");

 if (_gna542 != (GNODE) NULL) {

_Cur_Constr = "{Statement\n...";
_Cur_SpecLine = 1467;
_Cur_Node = _gna542;

{

_Cur_Constr = "{Statement\n...";
_Cur_SpecLine = 1467;
_Cur_Node = _gna542;

{

GNODE _gna543;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Statement */
 
if (_gna542->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna543 = (GNODE)( _gna542->node_data.l_dv);
  for(;_gna543 != (GNODE) NULL;_gna543=_gna543->gnext) {
    if (OfType(_gna543,Statement)) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1468;
_Cur_Node = _gna543;

{				

  /* EXECUTE ITEM */
{

GNODE _gna545;


_gna545 = getlocnode(_gna543);

if (_gna545 != (GNODE) NULL && (GSLOT(_gna545) != (AXS_ENTRY) NULL))
	MarkUsed(_gna545);


CurLoc = _gna545;


}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1469;
_Cur_Node = _gna543;

{				

  /* EXECUTE ITEM */
{


GNODE _gna546;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna547;
_gna547 = gcopy((GNODE) NextLoc);
	_gna546 = FindNext (_gna543,_gna547);




	



}

if (_gna546 != (GNODE) NULL && (GSLOT(_gna546) != (AXS_ENTRY) NULL))
	MarkUsed(_gna546);


TheNext = _gna546;


}

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1473;
_Cur_Node = _gna543;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna548;
_gna548 = gcopy((GNODE) TheNext);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna549;
_gna549 = gcopy((GNODE) ContinueLoc);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna550;
_gna550 = gcopy((GNODE) BreakLoc);
	
StmtFlow (_gna543,_gna548,_gna549,_gna550);  
}}}

}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 1467 is %s not type %d---Statement",NodeTable[_gna543->node_type]->nodename,Statement);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 1467- Parent NOT a LIST !");


}

}

 }	  /* Balances if (_gna542 != (GNODE) NULL )*/

} /* Balances GNODE _gna542; */

}
}


#if __STDC__ || __cplusplus

void PrintNext (GNODE TheRootNode,GNODE GivenNext	)
#else

void PrintNext ( TheRootNode,GivenNext )

 GNODE TheRootNode;
	GNODE GivenNext;
#endif

{

  if (!(OfType(TheRootNode, Statement))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure PrintNext called with node of type %s, not of type %d Statement",WhatType(TheRootNode->node_type),Statement);
	else printf("\n Procedure PrintNext called with invalid node  type %d, not of type %d Statement",TheRootNode->node_type,Statement);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return;
  }

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1485;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna551;
_gna551 = (GNODE) fileName;

if (_gna551 != (GNODE) NULL)
  if (VALIDTYPE(_gna551->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna551,""); 
  else fprintf(stderr,"\n At line 1485 attempt to unparse node of invalid type %d", _gna551->node_type);
else fprintf(stderr,"\n At line 1485 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna551;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1485;
_Cur_Node = TheRootNode;
{

GNODE _gna552;


_gna552 = getlocnode(TheRootNode);

_gna551 = (GNODE) GetFillers(_gna552,"line");
}

if (_gna551 != (GNODE) NULL)
  if (VALIDTYPE(_gna551->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna551,""); 
  else fprintf(stderr,"\n At line 1485 attempt to unparse node of invalid type %d", _gna551->node_type);
else fprintf(stderr,"\n At line 1485 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna551;
_gna551 = (GNODE) GivenNext;

if (_gna551 != (GNODE) NULL)
  if (VALIDTYPE(_gna551->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna551,""); 
  else fprintf(stderr,"\n At line 1485 attempt to unparse node of invalid type %d", _gna551->node_type);
else fprintf(stderr,"\n At line 1485 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}
}


#if __STDC__ || __cplusplus

GNODE  DealWithCond (GNODE TheRootNode	)
#else

GNODE DealWithCond ( TheRootNode )

 GNODE TheRootNode;
#endif

{
	GNODE leftValue;
	GNODE rightValue;
	GNODE newValue;

  if (!(OfType(TheRootNode, Expression))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure DealWithCond called with node of type %s, not of type %d Expression",WhatType(TheRootNode->node_type),Expression);
	else printf("\n Procedure DealWithCond called with invalid node  type %d, not of type %d Expression",TheRootNode->node_type,Expression);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return((GNODE) NULL);
  }

_Cur_Constr = "(?LogAnd\n...";
_Cur_SpecLine = 1497;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE LogAnd */		

if (OfType(TheRootNode,LogAnd)) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1498;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna553;

_gna553 = (GNODE) gmalloc ();
_gna553->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna553->node_type = 3;

_gna553->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna553 != (GNODE) NULL && (GSLOT(_gna553) != (AXS_ENTRY) NULL))
	MarkUsed(_gna553);


newValue = _gna553;


}

}

_Cur_Constr = "<be_lhs\n...";
_Cur_SpecLine = 1499;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  be_lhs */
{


GNODE _gna554;	

_gna554 = (GNODE) GetFillers(TheRootNode,"be_lhs");

 if (_gna554 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1500;
_Cur_Node = _gna554;

{				

  /* EXECUTE ITEM */
{


GNODE _gna555;
	_gna555 = DealWithCond (_gna554);




	





if (_gna555 != (GNODE) NULL && (GSLOT(_gna555) != (AXS_ENTRY) NULL))
	MarkUsed(_gna555);


leftValue = _gna555;


}

}

 }	  /* Balances if (_gna554 != (GNODE) NULL )*/

} /* Balances GNODE _gna554; */

}

_Cur_Constr = "<be_rhs\n...";
_Cur_SpecLine = 1501;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  be_rhs */
{


GNODE _gna556;	

_gna556 = (GNODE) GetFillers(TheRootNode,"be_rhs");

 if (_gna556 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1502;
_Cur_Node = _gna556;

{				

  /* EXECUTE ITEM */
{


GNODE _gna557;
	_gna557 = DealWithCond (_gna556);




	





if (_gna557 != (GNODE) NULL && (GSLOT(_gna557) != (AXS_ENTRY) NULL))
	MarkUsed(_gna557);


rightValue = _gna557;


}

}

 }	  /* Balances if (_gna556 != (GNODE) NULL )*/

} /* Balances GNODE _gna556; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1504;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna558;

_gna558 = (GNODE) gmalloc ();
_gna558->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna558->node_type = 3;

_gna558->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna558 != (GNODE) NULL)
  if (VALIDTYPE(_gna558->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna558,""); 
  else fprintf(stderr,"\n At line 1505 attempt to unparse node of invalid type %d", _gna558->node_type);
else fprintf(stderr,"\n At line 1505 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna558;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1506;
_Cur_Node = TheRootNode;
{

GNODE _gna559;


_gna559 = getlocnode(TheRootNode);

_gna558 = (GNODE) GetFillers(_gna559,"line");
}

if (_gna558 != (GNODE) NULL)
  if (VALIDTYPE(_gna558->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna558,""); 
  else fprintf(stderr,"\n At line 1506 attempt to unparse node of invalid type %d", _gna558->node_type);
else fprintf(stderr,"\n At line 1506 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (LogAnd "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna558;
_gna558 = (GNODE) leftValue;

if (_gna558 != (GNODE) NULL)
  if (VALIDTYPE(_gna558->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna558,""); 
  else fprintf(stderr,"\n At line 1507 attempt to unparse node of invalid type %d", _gna558->node_type);
else fprintf(stderr,"\n At line 1507 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna558;
_gna558 = (GNODE) rightValue;

if (_gna558 != (GNODE) NULL)
  if (VALIDTYPE(_gna558->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna558,""); 
  else fprintf(stderr,"\n At line 1508 attempt to unparse node of invalid type %d", _gna558->node_type);
else fprintf(stderr,"\n At line 1508 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna558;
_gna558 = (GNODE) newValue;

if (_gna558 != (GNODE) NULL)
  if (VALIDTYPE(_gna558->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna558,""); 
  else fprintf(stderr,"\n At line 1509 attempt to unparse node of invalid type %d", _gna558->node_type);
else fprintf(stderr,"\n At line 1509 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1511;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna560;
_gna560 = gcopy((GNODE) newValue);

return (_gna560);
}

}

}

}

_Cur_Constr = "(?LogOr\n...";
_Cur_SpecLine = 1514;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE LogOr */		

if (OfType(TheRootNode,LogOr)) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1515;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna561;

_gna561 = (GNODE) gmalloc ();
_gna561->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna561->node_type = 3;

_gna561->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna561 != (GNODE) NULL && (GSLOT(_gna561) != (AXS_ENTRY) NULL))
	MarkUsed(_gna561);


newValue = _gna561;


}

}

_Cur_Constr = "<be_lhs\n...";
_Cur_SpecLine = 1517;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  be_lhs */
{


GNODE _gna562;	

_gna562 = (GNODE) GetFillers(TheRootNode,"be_lhs");

 if (_gna562 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1518;
_Cur_Node = _gna562;

{				

  /* EXECUTE ITEM */
{


GNODE _gna563;
	_gna563 = DealWithCond (_gna562);




	





if (_gna563 != (GNODE) NULL && (GSLOT(_gna563) != (AXS_ENTRY) NULL))
	MarkUsed(_gna563);


leftValue = _gna563;


}

}

 }	  /* Balances if (_gna562 != (GNODE) NULL )*/

} /* Balances GNODE _gna562; */

}

_Cur_Constr = "<be_rhs\n...";
_Cur_SpecLine = 1519;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  be_rhs */
{


GNODE _gna564;	

_gna564 = (GNODE) GetFillers(TheRootNode,"be_rhs");

 if (_gna564 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1520;
_Cur_Node = _gna564;

{				

  /* EXECUTE ITEM */
{


GNODE _gna565;
	_gna565 = DealWithCond (_gna564);




	





if (_gna565 != (GNODE) NULL && (GSLOT(_gna565) != (AXS_ENTRY) NULL))
	MarkUsed(_gna565);


rightValue = _gna565;


}

}

 }	  /* Balances if (_gna564 != (GNODE) NULL )*/

} /* Balances GNODE _gna564; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1522;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna566;

_gna566 = (GNODE) gmalloc ();
_gna566->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna566->node_type = 3;

_gna566->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna566 != (GNODE) NULL)
  if (VALIDTYPE(_gna566->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna566,""); 
  else fprintf(stderr,"\n At line 1523 attempt to unparse node of invalid type %d", _gna566->node_type);
else fprintf(stderr,"\n At line 1523 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna566;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1524;
_Cur_Node = TheRootNode;
{

GNODE _gna567;


_gna567 = getlocnode(TheRootNode);

_gna566 = (GNODE) GetFillers(_gna567,"line");
}

if (_gna566 != (GNODE) NULL)
  if (VALIDTYPE(_gna566->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna566,""); 
  else fprintf(stderr,"\n At line 1524 attempt to unparse node of invalid type %d", _gna566->node_type);
else fprintf(stderr,"\n At line 1524 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (LogOr "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna566;
_gna566 = (GNODE) leftValue;

if (_gna566 != (GNODE) NULL)
  if (VALIDTYPE(_gna566->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna566,""); 
  else fprintf(stderr,"\n At line 1525 attempt to unparse node of invalid type %d", _gna566->node_type);
else fprintf(stderr,"\n At line 1525 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna566;
_gna566 = (GNODE) rightValue;

if (_gna566 != (GNODE) NULL)
  if (VALIDTYPE(_gna566->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna566,""); 
  else fprintf(stderr,"\n At line 1526 attempt to unparse node of invalid type %d", _gna566->node_type);
else fprintf(stderr,"\n At line 1526 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna566;
_gna566 = (GNODE) newValue;

if (_gna566 != (GNODE) NULL)
  if (VALIDTYPE(_gna566->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna566,""); 
  else fprintf(stderr,"\n At line 1527 attempt to unparse node of invalid type %d", _gna566->node_type);
else fprintf(stderr,"\n At line 1527 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"))\n");

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1530;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna568;
_gna568 = gcopy((GNODE) newValue);

return (_gna568);
}

}

}

}

_Cur_Constr = "(?Expression\n\n...";
_Cur_SpecLine = 1533;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Expression */		

if (OfType(TheRootNode,Expression)) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1535;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{ 
GNODE _gna569;

_gna569 = (GNODE) gmalloc ();
_gna569->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna569->node_type = 3;

_gna569->node_data.l_dv = ( (char *)( (char *) newResult( getCstring( fileName ) ))) ;

if (_gna569 != (GNODE) NULL && (GSLOT(_gna569) != (AXS_ENTRY) NULL))
	MarkUsed(_gna569);


newValue = _gna569;


}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1537;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna570;
	_gna570 = DealWithExpression (TheRootNode);




	





if (_gna570 != (GNODE) NULL && (GSLOT(_gna570) != (AXS_ENTRY) NULL))
	MarkUsed(_gna570);


newValue = _gna570;


}

}

_Cur_Constr = "(RETURN...";
_Cur_SpecLine = 1538;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna571;
_gna571 = gcopy((GNODE) newValue);

return (_gna571);
}

}

}

}
}


#if __STDC__ || __cplusplus

void CondFlow (GNODE TheRootNode,GNODE In,GNODE To,GNODE Fo	)
#else

void CondFlow ( TheRootNode,In,To,Fo )

 GNODE TheRootNode;
	GNODE In;
	GNODE To;
	GNODE Fo;
#endif

{
	GNODE newnode;

  if (!(OfType(TheRootNode, Expression))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure CondFlow called with node of type %s, not of type %d Expression",WhatType(TheRootNode->node_type),Expression);
	else printf("\n Procedure CondFlow called with invalid node  type %d, not of type %d Expression",TheRootNode->node_type,Expression);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return;
  }

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1587;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna572;
_gna572 = (GNODE) fileName;

if (_gna572 != (GNODE) NULL)
  if (VALIDTYPE(_gna572->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna572,""); 
  else fprintf(stderr,"\n At line 1587 attempt to unparse node of invalid type %d", _gna572->node_type);
else fprintf(stderr,"\n At line 1587 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_cond"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna572;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1587;
_Cur_Node = TheRootNode;
{

GNODE _gna573;


_gna573 = getlocnode(TheRootNode);

_gna572 = (GNODE) GetFillers(_gna573,"line");
}

if (_gna572 != (GNODE) NULL)
  if (VALIDTYPE(_gna572->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna572,""); 
  else fprintf(stderr,"\n At line 1587 attempt to unparse node of invalid type %d", _gna572->node_type);
else fprintf(stderr,"\n At line 1587 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1589;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithCond (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1590;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1591;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
VariableReference (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1593;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,")\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1595;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna576;
_gna576 = (GNODE) In;

if (_gna576 != (GNODE) NULL)
  if (VALIDTYPE(_gna576->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna576,""); 
  else fprintf(stderr,"\n At line 1595 attempt to unparse node of invalid type %d", _gna576->node_type);
else fprintf(stderr,"\n At line 1595 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna576;
_gna576 = (GNODE) fileName;

if (_gna576 != (GNODE) NULL)
  if (VALIDTYPE(_gna576->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna576,""); 
  else fprintf(stderr,"\n At line 1595 attempt to unparse node of invalid type %d", _gna576->node_type);
else fprintf(stderr,"\n At line 1595 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"_cond"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna576;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1595;
_Cur_Node = TheRootNode;
{

GNODE _gna577;


_gna577 = getlocnode(TheRootNode);

_gna576 = (GNODE) GetFillers(_gna577,"line");
}

if (_gna576 != (GNODE) NULL)
  if (VALIDTYPE(_gna576->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna576,""); 
  else fprintf(stderr,"\n At line 1595 attempt to unparse node of invalid type %d", _gna576->node_type);
else fprintf(stderr,"\n At line 1595 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna576;
_gna576 = (GNODE) To;

if (_gna576 != (GNODE) NULL)
  if (VALIDTYPE(_gna576->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna576,""); 
  else fprintf(stderr,"\n At line 1595 attempt to unparse node of invalid type %d", _gna576->node_type);
else fprintf(stderr,"\n At line 1595 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna576;
_gna576 = (GNODE) Fo;

if (_gna576 != (GNODE) NULL)
  if (VALIDTYPE(_gna576->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna576,""); 
  else fprintf(stderr,"\n At line 1595 attempt to unparse node of invalid type %d", _gna576->node_type);
else fprintf(stderr,"\n At line 1595 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}
}


#if __STDC__ || __cplusplus

void GatherStatementsInBlock (GNODE TheRootNode	)
#else

void GatherStatementsInBlock ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, Block))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure GatherStatementsInBlock called with node of type %s, not of type %d Block",WhatType(TheRootNode->node_type),Block);
	else printf("\n Procedure GatherStatementsInBlock called with invalid node  type %d, not of type %d Block",TheRootNode->node_type,Block);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return;
  }

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1608;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," (\n");

}

_Cur_Constr = "<blockbody...";
_Cur_SpecLine = 1609;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  blockbody */
{


GNODE _gna579;	

_gna579 = (GNODE) GetFillers(TheRootNode,"blockbody");

 if (_gna579 != (GNODE) NULL) {

_Cur_Constr = "(TRAVERSE...";
_Cur_SpecLine = 1610;
_Cur_Node = _gna579;

{				

  /* EXECUTE ITEM */
{




/* Search down  a NODE of TYPE Statement */

GNODE _gna580;
_gna580 = gcopy(_gna579);
if (OfType(_gna580,Statement)) {

_Cur_Constr = "{Statement...";
_Cur_SpecLine = 1612;
_Cur_Node = _gna580;

{

_Cur_Constr = "{Statement...";
_Cur_SpecLine = 1612;
_Cur_Node = _gna580;

{

GNODE _gna581;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Statement */
 
if (_gna580->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna581 = (GNODE)( _gna580->node_data.l_dv);
  for(;_gna581 != (GNODE) NULL;_gna581=_gna581->gnext) {
    if (OfType(_gna581,Statement)) {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1613;
_Cur_Node = _gna581;

{				

  /* EXECUTE ITEM */
{

int _gna583;
{

GNODE _gna584;
_gna584 = _gna581;



_gna583 =  OfType(_gna584,For);
}

if (_gna583) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1614;
_Cur_Node = _gna581;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  ");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna585;
_gna585 = (GNODE) fileName;

if (_gna585 != (GNODE) NULL)
  if (VALIDTYPE(_gna585->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna585,""); 
  else fprintf(stderr,"\n At line 1614 attempt to unparse node of invalid type %d", _gna585->node_type);
else fprintf(stderr,"\n At line 1614 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna585;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1614;
_Cur_Node = _gna581;
{

GNODE _gna586;


_gna586 = getlocnode(_gna581);

_gna585 = (GNODE) GetFillers(_gna586,"line");
}

if (_gna585 != (GNODE) NULL)
  if (VALIDTYPE(_gna585->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna585,""); 
  else fprintf(stderr,"\n At line 1614 attempt to unparse node of invalid type %d", _gna585->node_type);
else fprintf(stderr,"\n At line 1614 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"for\n");

}

}
else {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1615;
_Cur_Node = _gna581;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  ");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna587;
_gna587 = (GNODE) fileName;

if (_gna587 != (GNODE) NULL)
  if (VALIDTYPE(_gna587->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna587,""); 
  else fprintf(stderr,"\n At line 1615 attempt to unparse node of invalid type %d", _gna587->node_type);
else fprintf(stderr,"\n At line 1615 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna587;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1615;
_Cur_Node = _gna581;
{

GNODE _gna588;


_gna588 = getlocnode(_gna581);

_gna587 = (GNODE) GetFillers(_gna588,"line");
}

if (_gna587 != (GNODE) NULL)
  if (VALIDTYPE(_gna587->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna587,""); 
  else fprintf(stderr,"\n At line 1615 attempt to unparse node of invalid type %d", _gna587->node_type);
else fprintf(stderr,"\n At line 1615 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"\n");

}
}
}

}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 1612 is %s not type %d---Statement",NodeTable[_gna581->node_type]->nodename,Statement);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 1612- Parent NOT a LIST !");


}

}
}
	

}

}

 }	  /* Balances if (_gna579 != (GNODE) NULL )*/

} /* Balances GNODE _gna579; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1618;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n");

}
}


#if __STDC__ || __cplusplus

void GatherSingleStatement (GNODE TheRootNode	)
#else

void GatherSingleStatement ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, Statement))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure GatherSingleStatement called with node of type %s, not of type %d Statement",WhatType(TheRootNode->node_type),Statement);
	else printf("\n Procedure GatherSingleStatement called with invalid node  type %d, not of type %d Statement",TheRootNode->node_type,Statement);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return;
  }

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1626;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna590;
{

GNODE _gna591;
_gna591 = TheRootNode;



_gna590 =  OfType(_gna591,For);
}

if (_gna590) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1627;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  (");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna592;
_gna592 = (GNODE) fileName;

if (_gna592 != (GNODE) NULL)
  if (VALIDTYPE(_gna592->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna592,""); 
  else fprintf(stderr,"\n At line 1627 attempt to unparse node of invalid type %d", _gna592->node_type);
else fprintf(stderr,"\n At line 1627 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna592;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1627;
_Cur_Node = TheRootNode;
{

GNODE _gna593;


_gna593 = getlocnode(TheRootNode);

_gna592 = (GNODE) GetFillers(_gna593,"line");
}

if (_gna592 != (GNODE) NULL)
  if (VALIDTYPE(_gna592->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna592,""); 
  else fprintf(stderr,"\n At line 1627 attempt to unparse node of invalid type %d", _gna592->node_type);
else fprintf(stderr,"\n At line 1627 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"for)\n");

}

}
else {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1628;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  (");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna594;
_gna594 = (GNODE) fileName;

if (_gna594 != (GNODE) NULL)
  if (VALIDTYPE(_gna594->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna594,""); 
  else fprintf(stderr,"\n At line 1628 attempt to unparse node of invalid type %d", _gna594->node_type);
else fprintf(stderr,"\n At line 1628 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna594;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1628;
_Cur_Node = TheRootNode;
{

GNODE _gna595;


_gna595 = getlocnode(TheRootNode);

_gna594 = (GNODE) GetFillers(_gna595,"line");
}

if (_gna594 != (GNODE) NULL)
  if (VALIDTYPE(_gna594->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna594,""); 
  else fprintf(stderr,"\n At line 1628 attempt to unparse node of invalid type %d", _gna594->node_type);
else fprintf(stderr,"\n At line 1628 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,")\n");

}
}
}

}
}


#if __STDC__ || __cplusplus

void GatherContainedStatements (GNODE TheRootNode	)
#else

void GatherContainedStatements ( TheRootNode )

 GNODE TheRootNode;
#endif

{

  if (!(OfType(TheRootNode, Statement))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure GatherContainedStatements called with node of type %s, not of type %d Statement",WhatType(TheRootNode->node_type),Statement);
	else printf("\n Procedure GatherContainedStatements called with invalid node  type %d, not of type %d Statement",TheRootNode->node_type,Statement);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return;
  }

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1639;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna596;
{

GNODE _gna597;
_gna597 = TheRootNode;



_gna596 =  OfType(_gna597,Block);
}

if (_gna596) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1640;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
GatherStatementsInBlock (TheRootNode);  


}

}
else {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1641;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
GatherSingleStatement (TheRootNode);  


}
}
}

}
}


#if __STDC__ || __cplusplus

void StmtFlow (GNODE TheRootNode,GNODE GivenNext,GNODE ContinueLoc,GNODE BreakLoc	)
#else

void StmtFlow ( TheRootNode,GivenNext,ContinueLoc,BreakLoc )

 GNODE TheRootNode;
	GNODE GivenNext;
	GNODE ContinueLoc;
	GNODE BreakLoc;
#endif

{
	GNODE TheNext;
	GNODE be;
	GNODE TmpLoc;
	GNODE TheLoc;
	GNODE tmpt;
	GNODE bf;
	GNODE cl;
	GNODE bl;
	GNODE flt;
	GNODE fli;
	GNODE forbridge;

  if (!(OfType(TheRootNode, Statement))) {
        if (VALIDTYPE(TheRootNode->node_type))
	  printf("\n Procedure StmtFlow called with node of type %s, not of type %d Statement",WhatType(TheRootNode->node_type),Statement);
	else printf("\n Procedure StmtFlow called with invalid node  type %d, not of type %d Statement",TheRootNode->node_type,Statement);
	fprintf(stderr,"\n Procedure Type error at Line %d while executing construct beginning %s ", _Cur_SpecLine, _Cur_Constr);
	return;
  }

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1667;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */  /* Clip the format string at percent sign */
	fprintf(stdout,"(Statement : ");  /* Clip the format string at percent sign */
	fprintf(stdout,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna598;


_gna598 = getlocnode(TheRootNode);

if (_gna598 != (GNODE) NULL)
  if (VALIDTYPE(_gna598->node_type))
    gunparse(stdout,_gna598,""); 
  else fprintf(stderr,"\n At line 1667 attempt to unparse node of invalid type %d", _gna598->node_type);
else fprintf(stderr,"\n At line 1667 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf(stdout," :type "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna598;

_gna598 = (GNODE) gmalloc ();
_gna598->node_flag = GBUILTIN | GSIMPLENODE;
_gna598->node_type = C_String;
_gna598->node_data.l_dv = NodeTable[TheRootNode->node_type]->nodename;

if (_gna598 != (GNODE) NULL)
  if (VALIDTYPE(_gna598->node_type))
    gunparse(stdout,_gna598,""); 
  else fprintf(stderr,"\n At line 1667 attempt to unparse node of invalid type %d", _gna598->node_type);
else fprintf(stderr,"\n At line 1667 attempt to unparse null node");
	}
        fprintf(stdout,")\n");

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1676;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna599;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna600;

_gna600 = (GNODE) gmalloc ();
_gna600->node_flag = GBUILTIN | GSIMPLENODE;
_gna600->node_type = C_String;
_gna600->node_data.l_dv = "";
	_gna599 = LOCSTRING (TheRootNode,_gna600);




	



}

if (_gna599 != (GNODE) NULL && (GSLOT(_gna599) != (AXS_ENTRY) NULL))
	MarkUsed(_gna599);


TheLoc = _gna599;


}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1677;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna601;
_gna601 = gcopy((GNODE) GivenNext);

if (_gna601 != (GNODE) NULL && (GSLOT(_gna601) != (AXS_ENTRY) NULL))
	MarkUsed(_gna601);


TheNext = _gna601;


}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1678;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna602;
_gna602 = gcopy((GNODE) TheNext);

if (_gna602 != (GNODE) NULL && (GSLOT(_gna602) != (AXS_ENTRY) NULL))
	MarkUsed(_gna602);


tmpt = _gna602;


}

}

_Cur_Constr = "(?Block...";
_Cur_SpecLine = 1682;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Block */		

if (OfType(TheRootNode,Block)) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1684;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna603;
_gna603 = gcopy((GNODE) TheNext);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna604;
_gna604 = gcopy((GNODE) ContinueLoc);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna605;
_gna605 = gcopy((GNODE) BreakLoc);
	
CompoundFlow (TheRootNode,_gna603,_gna604,_gna605);  
}}}

}

}

}

_Cur_Constr = "(?Return\n\t(PRINT...";
_Cur_SpecLine = 1686;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Return */		

if (OfType(TheRootNode,Return)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1687;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna606;
_gna606 = (GNODE) TheLoc;

if (_gna606 != (GNODE) NULL)
  if (VALIDTYPE(_gna606->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna606,""); 
  else fprintf(stderr,"\n At line 1687 attempt to unparse node of invalid type %d", _gna606->node_type);
else fprintf(stderr,"\n At line 1687 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna606;
_gna606 = (GNODE) finish_stmt;

if (_gna606 != (GNODE) NULL)
  if (VALIDTYPE(_gna606->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna606,""); 
  else fprintf(stderr,"\n At line 1687 attempt to unparse node of invalid type %d", _gna606->node_type);
else fprintf(stderr,"\n At line 1687 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1693;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna607;
_gna607 = (GNODE) TheLoc;

if (_gna607 != (GNODE) NULL)
  if (VALIDTYPE(_gna607->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna607,""); 
  else fprintf(stderr,"\n At line 1693 attempt to unparse node of invalid type %d", _gna607->node_type);
else fprintf(stderr,"\n At line 1693 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1694;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithReturn (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1695;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1696;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
VariableReference (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1697;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,")\n");

}

_Cur_Constr = "(RETURN)...";
_Cur_SpecLine = 1699;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
return;

}

}

}

_Cur_Constr = "(?If...";
_Cur_SpecLine = 1703;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE If */		

if (OfType(TheRootNode,If)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1704;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna610;
_gna610 = (GNODE) fileName;

if (_gna610 != (GNODE) NULL)
  if (VALIDTYPE(_gna610->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna610,""); 
  else fprintf(stderr,"\n At line 1704 attempt to unparse node of invalid type %d", _gna610->node_type);
else fprintf(stderr,"\n At line 1704 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna610;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1704;
_Cur_Node = TheRootNode;
{

GNODE _gna611;


_gna611 = getlocnode(TheRootNode);

_gna610 = (GNODE) GetFillers(_gna611,"line");
}

if (_gna610 != (GNODE) NULL)
  if (VALIDTYPE(_gna610->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna610,""); 
  else fprintf(stderr,"\n At line 1704 attempt to unparse node of invalid type %d", _gna610->node_type);
else fprintf(stderr,"\n At line 1704 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1705;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithIf (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1706;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n)\n");

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1708;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna613;
{


GNODE _gna614;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1708;
_Cur_Node = TheRootNode;
{

GNODE _gna615;
_gna615 = TheRootNode;

_gna614 = (GNODE) GetFillers(_gna615,"ifTbranch");
}
_gna613 = (_gna614== (GNODE) NULL);
}

if (_gna613) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1709;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna616;
_gna616 = gcopy((GNODE) TheNext);

if (_gna616 != (GNODE) NULL && (GSLOT(_gna616) != (AXS_ENTRY) NULL))
	MarkUsed(_gna616);


bl = _gna616;


}

}

}
else {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1712;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna617;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna618;

_gna618 = (GNODE) gmalloc ();
_gna618->node_flag = GBUILTIN | GSIMPLENODE;
_gna618->node_type = C_String;
_gna618->node_data.l_dv = "then";
	_gna617 = LOCSTRING (TheRootNode,_gna618);




	



}

if (_gna617 != (GNODE) NULL && (GSLOT(_gna617) != (AXS_ENTRY) NULL))
	MarkUsed(_gna617);


bl = _gna617;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1713;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna619;
_gna619 = (GNODE) bl;

if (_gna619 != (GNODE) NULL)
  if (VALIDTYPE(_gna619->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna619,""); 
  else fprintf(stderr,"\n At line 1714 attempt to unparse node of invalid type %d", _gna619->node_type);
else fprintf(stderr,"\n At line 1714 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n (\n("); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna619;

_gna619 = (GNODE) gmalloc ();
_gna619->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna619->node_type = 3;

_gna619->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna619 != (GNODE) NULL)
  if (VALIDTYPE(_gna619->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna619,""); 
  else fprintf(stderr,"\n At line 1715 attempt to unparse node of invalid type %d", _gna619->node_type);
else fprintf(stderr,"\n At line 1715 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna619;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1716;
_Cur_Node = TheRootNode;
{

GNODE _gna620;


_gna620 = getlocnode(TheRootNode);

_gna619 = (GNODE) GetFillers(_gna620,"line");
}

if (_gna619 != (GNODE) NULL)
  if (VALIDTYPE(_gna619->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna619,""); 
  else fprintf(stderr,"\n At line 1716 attempt to unparse node of invalid type %d", _gna619->node_type);
else fprintf(stderr,"\n At line 1716 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," (NullBridge))\n )\n)\n");

}
}
}

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1720;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna621;
{


GNODE _gna622;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1720;
_Cur_Node = TheRootNode;
{

GNODE _gna623;
_gna623 = TheRootNode;

_gna622 = (GNODE) GetFillers(_gna623,"ifFbranch");
}
_gna621 = (_gna622== (GNODE) NULL);
}

if (_gna621) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1721;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna624;
_gna624 = gcopy((GNODE) TheNext);

if (_gna624 != (GNODE) NULL && (GSLOT(_gna624) != (AXS_ENTRY) NULL))
	MarkUsed(_gna624);


cl = _gna624;


}

}

}
else {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1723;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna625;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna626;

_gna626 = (GNODE) gmalloc ();
_gna626->node_flag = GBUILTIN | GSIMPLENODE;
_gna626->node_type = C_String;
_gna626->node_data.l_dv = "else";
	_gna625 = LOCSTRING (TheRootNode,_gna626);




	



}

if (_gna625 != (GNODE) NULL && (GSLOT(_gna625) != (AXS_ENTRY) NULL))
	MarkUsed(_gna625);


cl = _gna625;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1724;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna627;
_gna627 = (GNODE) cl;

if (_gna627 != (GNODE) NULL)
  if (VALIDTYPE(_gna627->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna627,""); 
  else fprintf(stderr,"\n At line 1725 attempt to unparse node of invalid type %d", _gna627->node_type);
else fprintf(stderr,"\n At line 1725 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n (\n("); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna627;

_gna627 = (GNODE) gmalloc ();
_gna627->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna627->node_type = 3;

_gna627->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna627 != (GNODE) NULL)
  if (VALIDTYPE(_gna627->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna627,""); 
  else fprintf(stderr,"\n At line 1726 attempt to unparse node of invalid type %d", _gna627->node_type);
else fprintf(stderr,"\n At line 1726 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna627;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1727;
_Cur_Node = TheRootNode;
{

GNODE _gna628;


_gna628 = getlocnode(TheRootNode);

_gna627 = (GNODE) GetFillers(_gna628,"line");
}

if (_gna627 != (GNODE) NULL)
  if (VALIDTYPE(_gna627->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna627,""); 
  else fprintf(stderr,"\n At line 1727 attempt to unparse node of invalid type %d", _gna627->node_type);
else fprintf(stderr,"\n At line 1727 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," (NullBridge))\n )\n)\n");

}
}
}

}

_Cur_Constr = "<ifcondition...";
_Cur_SpecLine = 1731;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ifcondition */
{


GNODE _gna629;	

_gna629 = (GNODE) GetFillers(TheRootNode,"ifcondition");

 if (_gna629 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1731;
_Cur_Node = _gna629;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna630;
_gna630 = gcopy((GNODE) TheLoc);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna631;
_gna631 = gcopy((GNODE) bl);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna632;
_gna632 = gcopy((GNODE) cl);
	
CondFlow (_gna629,_gna630,_gna631,_gna632);  
}}}

}

 }	  /* Balances if (_gna629 != (GNODE) NULL )*/

} /* Balances GNODE _gna629; */

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1733;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna633;
{


GNODE _gna634;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1733;
_Cur_Node = TheRootNode;
{

GNODE _gna635;
_gna635 = TheRootNode;

_gna634 = (GNODE) GetFillers(_gna635,"ifTbranch");
}
_gna633 = (_gna634== (GNODE) NULL);
}

if (_gna633) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1734;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna636;
_gna636 = gcopy((GNODE) TheNext);

if (_gna636 != (GNODE) NULL && (GSLOT(_gna636) != (AXS_ENTRY) NULL))
	MarkUsed(_gna636);


bl = _gna636;


}

}

}
else {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1737;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna637;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna638;

_gna638 = (GNODE) gmalloc ();
_gna638->node_flag = GBUILTIN | GSIMPLENODE;
_gna638->node_type = C_String;
_gna638->node_data.l_dv = "then";
	_gna637 = LOCSTRING (TheRootNode,_gna638);




	



}

if (_gna637 != (GNODE) NULL && (GSLOT(_gna637) != (AXS_ENTRY) NULL))
	MarkUsed(_gna637);


bl = _gna637;


}

}

_Cur_Constr = "<ifTbranch...";
_Cur_SpecLine = 1738;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ifTbranch */
{


GNODE _gna639;	

_gna639 = (GNODE) GetFillers(TheRootNode,"ifTbranch");

 if (_gna639 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1739;
_Cur_Node = _gna639;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna640;
_gna640 = gcopy((GNODE) TheNext);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna641;
_gna641 = gcopy((GNODE) ContinueLoc);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna642;
_gna642 = gcopy((GNODE) BreakLoc);
	
StmtFlow (_gna639,_gna640,_gna641,_gna642);  
}}}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1742;
_Cur_Node = _gna639;

{				

  /* EXECUTE ITEM */
{


GNODE _gna643;
	_gna643 = BlockFirst (_gna639);




	





if (_gna643 != (GNODE) NULL && (GSLOT(_gna643) != (AXS_ENTRY) NULL))
	MarkUsed(_gna643);


bf = _gna643;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1743;
_Cur_Node = _gna639;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna644;
_gna644 = (GNODE) bl;

if (_gna644 != (GNODE) NULL)
  if (VALIDTYPE(_gna644->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna644,""); 
  else fprintf(stderr,"\n At line 1743 attempt to unparse node of invalid type %d", _gna644->node_type);
else fprintf(stderr,"\n At line 1743 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna644;
_gna644 = (GNODE) bf;

if (_gna644 != (GNODE) NULL)
  if (VALIDTYPE(_gna644->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna644,""); 
  else fprintf(stderr,"\n At line 1743 attempt to unparse node of invalid type %d", _gna644->node_type);
else fprintf(stderr,"\n At line 1743 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

 }	  /* Balances if (_gna639 != (GNODE) NULL )*/

} /* Balances GNODE _gna639; */

}
}
}

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1745;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna645;
{


GNODE _gna646;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1745;
_Cur_Node = TheRootNode;
{

GNODE _gna647;
_gna647 = TheRootNode;

_gna646 = (GNODE) GetFillers(_gna647,"ifFbranch");
}
_gna645 = (_gna646== (GNODE) NULL);
}

if (_gna645) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1746;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna648;
_gna648 = gcopy((GNODE) TheNext);

if (_gna648 != (GNODE) NULL && (GSLOT(_gna648) != (AXS_ENTRY) NULL))
	MarkUsed(_gna648);


cl = _gna648;


}

}

}
else {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1748;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna649;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna650;

_gna650 = (GNODE) gmalloc ();
_gna650->node_flag = GBUILTIN | GSIMPLENODE;
_gna650->node_type = C_String;
_gna650->node_data.l_dv = "else";
	_gna649 = LOCSTRING (TheRootNode,_gna650);




	



}

if (_gna649 != (GNODE) NULL && (GSLOT(_gna649) != (AXS_ENTRY) NULL))
	MarkUsed(_gna649);


cl = _gna649;


}

}

_Cur_Constr = "<ifFbranch...";
_Cur_SpecLine = 1749;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  ifFbranch */
{


GNODE _gna651;	

_gna651 = (GNODE) GetFillers(TheRootNode,"ifFbranch");

 if (_gna651 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1750;
_Cur_Node = _gna651;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna652;
_gna652 = gcopy((GNODE) TheNext);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna653;
_gna653 = gcopy((GNODE) ContinueLoc);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna654;
_gna654 = gcopy((GNODE) BreakLoc);
	
StmtFlow (_gna651,_gna652,_gna653,_gna654);  
}}}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1753;
_Cur_Node = _gna651;

{				

  /* EXECUTE ITEM */
{


GNODE _gna655;
	_gna655 = BlockFirst (_gna651);




	





if (_gna655 != (GNODE) NULL && (GSLOT(_gna655) != (AXS_ENTRY) NULL))
	MarkUsed(_gna655);


be = _gna655;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1754;
_Cur_Node = _gna651;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna656;
_gna656 = (GNODE) cl;

if (_gna656 != (GNODE) NULL)
  if (VALIDTYPE(_gna656->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna656,""); 
  else fprintf(stderr,"\n At line 1754 attempt to unparse node of invalid type %d", _gna656->node_type);
else fprintf(stderr,"\n At line 1754 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna656;
_gna656 = (GNODE) be;

if (_gna656 != (GNODE) NULL)
  if (VALIDTYPE(_gna656->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna656,""); 
  else fprintf(stderr,"\n At line 1754 attempt to unparse node of invalid type %d", _gna656->node_type);
else fprintf(stderr,"\n At line 1754 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

 }	  /* Balances if (_gna651 != (GNODE) NULL )*/

} /* Balances GNODE _gna651; */

}
}
}

}

}

}

_Cur_Constr = "(?ExprStmt\n/*...";
_Cur_SpecLine = 1759;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE ExprStmt */		

if (OfType(TheRootNode,ExprStmt)) {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1763;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna657;
{


GNODE _gna658;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1763;
_Cur_Node = TheRootNode;
{

GNODE _gna659;
_gna659 = TheRootNode;

_gna658 = (GNODE) GetFillers(_gna659,"expr");
}



_gna657 =  OfType(_gna658,UserCall);
}

if (_gna657) {

_Cur_Constr = "<expr...";
_Cur_SpecLine = 1765;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  expr */
{


GNODE _gna660;	

_gna660 = (GNODE) GetFillers(TheRootNode,"expr");

 if (_gna660 != (GNODE) NULL) {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1766;
_Cur_Node = _gna660;

{				

  /* EXECUTE ITEM */
{

int _gna661;

{

int _gna662;
{


GNODE _gna663;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1766;
_Cur_Node = _gna660;
{

GNODE _gna664;
_gna664 = _gna660;

_gna663 = (GNODE) GetFillers(_gna664,"callname");
}
_gna662 = (_gna663== (GNODE) NULL);
}

_gna661 = !_gna662;
}

if (_gna661) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1767;
_Cur_Node = _gna660;

{				

  /* EXECUTE ITEM */
{


GNODE _gna665;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1767;
_Cur_Node = _gna660;
{

GNODE _gna666;
_gna666 = _gna660;

_gna665 = (GNODE) GetFillers(_gna666,"callname");
}

if (_gna665 != (GNODE) NULL && (GSLOT(_gna665) != (AXS_ENTRY) NULL))
	MarkUsed(_gna665);


cl = _gna665;


}

}

}
else {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1768;
_Cur_Node = _gna660;

{				

  /* EXECUTE ITEM */
{


GNODE _gna667;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1768;
_Cur_Node = _gna660;
{

GNODE _gna668;
_gna668 = _gna660;

_gna667 = (GNODE) GetFillers(_gna668,"callexpr");
}

if (_gna667 != (GNODE) NULL && (GSLOT(_gna667) != (AXS_ENTRY) NULL))
	MarkUsed(_gna667);


cl = _gna667;


}

}
}
}

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1769;
_Cur_Node = _gna660;

{				

  /* EXECUTE ITEM */
{


GNODE _gna669;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna670;

_gna670 = (GNODE) gmalloc ();
_gna670->node_flag = GBUILTIN | GSIMPLENODE;
_gna670->node_type = C_String;
_gna670->node_data.l_dv = "";
	_gna669 = LOCSTRING (_gna660,_gna670);




	



}

if (_gna669 != (GNODE) NULL && (GSLOT(_gna669) != (AXS_ENTRY) NULL))
	MarkUsed(_gna669);


be = _gna669;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1771;
_Cur_Node = _gna660;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna671;
_gna671 = (GNODE) fileName;

if (_gna671 != (GNODE) NULL)
  if (VALIDTYPE(_gna671->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna671,""); 
  else fprintf(stderr,"\n At line 1771 attempt to unparse node of invalid type %d", _gna671->node_type);
else fprintf(stderr,"\n At line 1771 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna671;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1771;
_Cur_Node = _gna660;
{

GNODE _gna672;


_gna672 = getlocnode(_gna660);

_gna671 = (GNODE) GetFillers(_gna672,"line");
}

if (_gna671 != (GNODE) NULL)
  if (VALIDTYPE(_gna671->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna671,""); 
  else fprintf(stderr,"\n At line 1771 attempt to unparse node of invalid type %d", _gna671->node_type);
else fprintf(stderr,"\n At line 1771 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1772;
_Cur_Node = _gna660;

{				

  /* EXECUTE ITEM */
	
DealWithFunCall (_gna660);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1773;
_Cur_Node = _gna660;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n)\n");

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1776;
_Cur_Node = _gna660;

{				

  /* EXECUTE ITEM */
{

int _gna674;

_gna674 = 0;	

{
if( _gna674 == 0 ){

int _gna675;
{

GNODE _gna676;
_gna676 = (GNODE) cl;
  {

GNODE _gna677;

_gna677 = (GNODE) gmalloc ();
_gna677->node_flag = GBUILTIN | GSIMPLENODE;
_gna677->node_type = C_String;
_gna677->node_data.l_dv = "exit";
_gna675 = gequal(_gna676, _gna677);
}
}
_gna674 = _gna675 || _gna674;
}
}	

{
if( _gna674 == 0 ){

int _gna678;
{

GNODE _gna679;
_gna679 = (GNODE) cl;
  {

GNODE _gna680;

_gna680 = (GNODE) gmalloc ();
_gna680->node_flag = GBUILTIN | GSIMPLENODE;
_gna680->node_type = C_String;
_gna680->node_data.l_dv = "abort";
_gna678 = gequal(_gna679, _gna680);
}
}
_gna674 = _gna678 || _gna674;
}
}

if (_gna674) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1781;
_Cur_Node = _gna660;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna681;
_gna681 = (GNODE) TheLoc;

if (_gna681 != (GNODE) NULL)
  if (VALIDTYPE(_gna681->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna681,""); 
  else fprintf(stderr,"\n At line 1781 attempt to unparse node of invalid type %d", _gna681->node_type);
else fprintf(stderr,"\n At line 1781 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna681;
_gna681 = (GNODE) be;

if (_gna681 != (GNODE) NULL)
  if (VALIDTYPE(_gna681->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna681,""); 
  else fprintf(stderr,"\n At line 1781 attempt to unparse node of invalid type %d", _gna681->node_type);
else fprintf(stderr,"\n At line 1781 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv," )\n");

}

}
else {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1788;
_Cur_Node = _gna660;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna682;
_gna682 = (GNODE) be;

if (_gna682 != (GNODE) NULL)
  if (VALIDTYPE(_gna682->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna682,""); 
  else fprintf(stderr,"\n At line 1788 attempt to unparse node of invalid type %d", _gna682->node_type);
else fprintf(stderr,"\n At line 1788 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna682;
_gna682 = (GNODE) TheNext;

if (_gna682 != (GNODE) NULL)
  if (VALIDTYPE(_gna682->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna682,""); 
  else fprintf(stderr,"\n At line 1788 attempt to unparse node of invalid type %d", _gna682->node_type);
else fprintf(stderr,"\n At line 1788 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}
}
}

}

 }	  /* Balances if (_gna660 != (GNODE) NULL )*/

} /* Balances GNODE _gna660; */

}

}
else {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1792;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna683;
_gna683 = (GNODE) fileName;

if (_gna683 != (GNODE) NULL)
  if (VALIDTYPE(_gna683->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna683,""); 
  else fprintf(stderr,"\n At line 1792 attempt to unparse node of invalid type %d", _gna683->node_type);
else fprintf(stderr,"\n At line 1792 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna683;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1792;
_Cur_Node = TheRootNode;
{

GNODE _gna684;


_gna684 = getlocnode(TheRootNode);

_gna683 = (GNODE) GetFillers(_gna684,"line");
}

if (_gna683 != (GNODE) NULL)
  if (VALIDTYPE(_gna683->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna683,""); 
  else fprintf(stderr,"\n At line 1792 attempt to unparse node of invalid type %d", _gna683->node_type);
else fprintf(stderr,"\n At line 1792 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1793;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithExprStmt (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1794;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1795;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
VariableReference (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1796;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,")\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1798;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna687;
_gna687 = gcopy((GNODE) TheNext);
	
PrintNext (TheRootNode,_gna687);  
}

}
}
}

}

}

}

_Cur_Constr = "(?Default\n\t(CALL...";
_Cur_SpecLine = 1802;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Default */		

if (OfType(TheRootNode,Default)) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1803;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna688;
_gna688 = gcopy((GNODE) TheNext);
	
PrintNext (TheRootNode,_gna688);  
}

}

}

}

_Cur_Constr = "(?Case\n\t(CALL...";
_Cur_SpecLine = 1804;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Case */		

if (OfType(TheRootNode,Case)) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1805;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna689;
_gna689 = gcopy((GNODE) TheNext);
	
PrintNext (TheRootNode,_gna689);  
}

}

}

}

_Cur_Constr = "(?For\n\n\t(PRINT...";
_Cur_SpecLine = 1807;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE For */		

if (OfType(TheRootNode,For)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1809;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna690;
_gna690 = (GNODE) fileName;

if (_gna690 != (GNODE) NULL)
  if (VALIDTYPE(_gna690->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna690,""); 
  else fprintf(stderr,"\n At line 1810 attempt to unparse node of invalid type %d", _gna690->node_type);
else fprintf(stderr,"\n At line 1810 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna690;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1811;
_Cur_Node = TheRootNode;
{

GNODE _gna691;


_gna691 = getlocnode(TheRootNode);

_gna690 = (GNODE) GetFillers(_gna691,"line");
}

if (_gna690 != (GNODE) NULL)
  if (VALIDTYPE(_gna690->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna690,""); 
  else fprintf(stderr,"\n At line 1811 attempt to unparse node of invalid type %d", _gna690->node_type);
else fprintf(stderr,"\n At line 1811 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"\n (\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1813;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna692;

_gna692 = (GNODE) gmalloc ();
_gna692->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna692->node_type = 3;

_gna692->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna692 != (GNODE) NULL)
  if (VALIDTYPE(_gna692->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna692,""); 
  else fprintf(stderr,"\n At line 1814 attempt to unparse node of invalid type %d", _gna692->node_type);
else fprintf(stderr,"\n At line 1814 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna692;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1815;
_Cur_Node = TheRootNode;
{

GNODE _gna693;


_gna693 = getlocnode(TheRootNode);

_gna692 = (GNODE) GetFillers(_gna693,"line");
}

if (_gna692 != (GNODE) NULL)
  if (VALIDTYPE(_gna692->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna692,""); 
  else fprintf(stderr,"\n At line 1815 attempt to unparse node of invalid type %d", _gna692->node_type);
else fprintf(stderr,"\n At line 1815 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," (NullBridge))\n )\n)\n");

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1817;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna694;
{


GNODE _gna695;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1817;
_Cur_Node = TheRootNode;
{

GNODE _gna696;
_gna696 = TheRootNode;

_gna695 = (GNODE) GetFillers(_gna696,"forbody");
}
_gna694 = (_gna695== (GNODE) NULL);
}

if (_gna694) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1819;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna697;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna698;

_gna698 = (GNODE) gmalloc ();
_gna698->node_flag = GBUILTIN | GSIMPLENODE;
_gna698->node_type = C_String;
_gna698->node_data.l_dv = "nullbody";
	_gna697 = LOCSTRING (TheRootNode,_gna698);




	



}

if (_gna697 != (GNODE) NULL && (GSLOT(_gna697) != (AXS_ENTRY) NULL))
	MarkUsed(_gna697);


bf = _gna697;


}

}

}
else {

_Cur_Constr = "<forbody...";
_Cur_SpecLine = 1821;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forbody */
{


GNODE _gna699;	

_gna699 = (GNODE) GetFillers(TheRootNode,"forbody");

 if (_gna699 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1821;
_Cur_Node = _gna699;

{				

  /* EXECUTE ITEM */
{


GNODE _gna700;
	_gna700 = BlockFirst (_gna699);




	





if (_gna700 != (GNODE) NULL && (GSLOT(_gna700) != (AXS_ENTRY) NULL))
	MarkUsed(_gna700);


bf = _gna700;


}

}

 }	  /* Balances if (_gna699 != (GNODE) NULL )*/

} /* Balances GNODE _gna699; */

}
}
}

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1823;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna701;
{


GNODE _gna702;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1823;
_Cur_Node = TheRootNode;
{

GNODE _gna703;
_gna703 = TheRootNode;

_gna702 = (GNODE) GetFillers(_gna703,"forcondition");
}
_gna701 = (_gna702== (GNODE) NULL);
}

if (_gna701) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1825;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna704;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna705;

_gna705 = (GNODE) gmalloc ();
_gna705->node_flag = GBUILTIN | GSIMPLENODE;
_gna705->node_type = C_String;
_gna705->node_data.l_dv = "nulltest";
	_gna704 = LOCSTRING (TheRootNode,_gna705);




	



}

if (_gna704 != (GNODE) NULL && (GSLOT(_gna704) != (AXS_ENTRY) NULL))
	MarkUsed(_gna704);


flt = _gna704;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1826;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n((");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna706;
_gna706 = (GNODE) flt;

if (_gna706 != (GNODE) NULL)
  if (VALIDTYPE(_gna706->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna706,""); 
  else fprintf(stderr,"\n At line 1826 attempt to unparse node of invalid type %d", _gna706->node_type);
else fprintf(stderr,"\n At line 1826 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna706;
_gna706 = (GNODE) bf;

if (_gna706 != (GNODE) NULL)
  if (VALIDTYPE(_gna706->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna706,""); 
  else fprintf(stderr,"\n At line 1826 attempt to unparse node of invalid type %d", _gna706->node_type);
else fprintf(stderr,"\n At line 1826 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1827;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna707;
_gna707 = (GNODE) flt;

if (_gna707 != (GNODE) NULL)
  if (VALIDTYPE(_gna707->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna707,""); 
  else fprintf(stderr,"\n At line 1827 attempt to unparse node of invalid type %d", _gna707->node_type);
else fprintf(stderr,"\n At line 1827 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna707;
_gna707 = (GNODE) TheNext;

if (_gna707 != (GNODE) NULL)
  if (VALIDTYPE(_gna707->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna707,""); 
  else fprintf(stderr,"\n At line 1827 attempt to unparse node of invalid type %d", _gna707->node_type);
else fprintf(stderr,"\n At line 1827 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv," [style = dotted])\n");

}

}
else {

_Cur_Constr = "<forcondition...";
_Cur_SpecLine = 1829;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forcondition */
{


GNODE _gna708;	

_gna708 = (GNODE) GetFillers(TheRootNode,"forcondition");

 if (_gna708 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1830;
_Cur_Node = _gna708;

{				

  /* EXECUTE ITEM */
{


GNODE _gna709;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna710;

_gna710 = (GNODE) gmalloc ();
_gna710->node_flag = GBUILTIN | GSIMPLENODE;
_gna710->node_type = C_String;
_gna710->node_data.l_dv = "test";
	_gna709 = LOCSTRING (_gna708,_gna710);




	



}

if (_gna709 != (GNODE) NULL && (GSLOT(_gna709) != (AXS_ENTRY) NULL))
	MarkUsed(_gna709);


flt = _gna709;


}

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1832;
_Cur_Node = _gna708;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna711;
_gna711 = gcopy((GNODE) flt);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna712;
_gna712 = gcopy((GNODE) bf);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna713;
_gna713 = gcopy((GNODE) TheNext);
	
CondFlow (_gna708,_gna711,_gna712,_gna713);  
}}}

}

 }	  /* Balances if (_gna708 != (GNODE) NULL )*/

} /* Balances GNODE _gna708; */

}
}
}

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1834;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna714;
{


GNODE _gna715;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1834;
_Cur_Node = TheRootNode;
{

GNODE _gna716;
_gna716 = TheRootNode;

_gna715 = (GNODE) GetFillers(_gna716,"forinit");
}
_gna714 = (_gna715== (GNODE) NULL);
}

if (_gna714) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1835;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna717;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna718;

_gna718 = (GNODE) gmalloc ();
_gna718->node_flag = GBUILTIN | GSIMPLENODE;
_gna718->node_type = C_String;
_gna718->node_data.l_dv = "nullinit";
	_gna717 = LOCSTRING (TheRootNode,_gna718);




	



}

if (_gna717 != (GNODE) NULL && (GSLOT(_gna717) != (AXS_ENTRY) NULL))
	MarkUsed(_gna717);


fli = _gna717;


}

}

}
else {

_Cur_Constr = "<forinit...";
_Cur_SpecLine = 1839;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forinit */
{


GNODE _gna719;	

_gna719 = (GNODE) GetFillers(TheRootNode,"forinit");

 if (_gna719 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1839;
_Cur_Node = _gna719;

{				

  /* EXECUTE ITEM */
{


GNODE _gna720;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna721;

_gna721 = (GNODE) gmalloc ();
_gna721->node_flag = GBUILTIN | GSIMPLENODE;
_gna721->node_type = C_String;
_gna721->node_data.l_dv = "init";
	_gna720 = LOCSTRING (_gna719,_gna721);




	



}

if (_gna720 != (GNODE) NULL && (GSLOT(_gna720) != (AXS_ENTRY) NULL))
	MarkUsed(_gna720);


fli = _gna720;


}

}

 }	  /* Balances if (_gna719 != (GNODE) NULL )*/

} /* Balances GNODE _gna719; */

}
}
}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1844;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna722;
_gna722 = (GNODE) flt;

if (_gna722 != (GNODE) NULL)
  if (VALIDTYPE(_gna722->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna722,""); 
  else fprintf(stderr,"\n At line 1845 attempt to unparse node of invalid type %d", _gna722->node_type);
else fprintf(stderr,"\n At line 1845 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"\n (\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1847;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna723;

_gna723 = (GNODE) gmalloc ();
_gna723->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna723->node_type = 3;

_gna723->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna723 != (GNODE) NULL)
  if (VALIDTYPE(_gna723->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna723,""); 
  else fprintf(stderr,"\n At line 1848 attempt to unparse node of invalid type %d", _gna723->node_type);
else fprintf(stderr,"\n At line 1848 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna723;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1849;
_Cur_Node = TheRootNode;
{

GNODE _gna724;


_gna724 = getlocnode(TheRootNode);

_gna723 = (GNODE) GetFillers(_gna724,"line");
}

if (_gna723 != (GNODE) NULL)
  if (VALIDTYPE(_gna723->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna723,""); 
  else fprintf(stderr,"\n At line 1849 attempt to unparse node of invalid type %d", _gna723->node_type);
else fprintf(stderr,"\n At line 1849 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," (NullBridge))\n )\n)\n");

}

_Cur_Constr = "<forinit...";
_Cur_SpecLine = 1852;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forinit */
{


GNODE _gna725;	

_gna725 = (GNODE) GetFillers(TheRootNode,"forinit");

 if (_gna725 != (GNODE) NULL) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1853;
_Cur_Node = _gna725;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna726;
_gna726 = (GNODE) fli;

if (_gna726 != (GNODE) NULL)
  if (VALIDTYPE(_gna726->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna726,""); 
  else fprintf(stderr,"\n At line 1853 attempt to unparse node of invalid type %d", _gna726->node_type);
else fprintf(stderr,"\n At line 1853 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1854;
_Cur_Node = _gna725;

{				

  /* EXECUTE ITEM */
	
DealWithStatement (_gna725);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1855;
_Cur_Node = _gna725;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1856;
_Cur_Node = _gna725;

{				

  /* EXECUTE ITEM */
	
VariableReference (_gna725);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1857;
_Cur_Node = _gna725;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,")\n");

}

 }	  /* Balances if (_gna725 != (GNODE) NULL )*/

} /* Balances GNODE _gna725; */

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1865;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna729;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna730;

_gna730 = (GNODE) gmalloc ();
_gna730->node_flag = GBUILTIN | GSIMPLENODE;
_gna730->node_type = C_String;
_gna730->node_data.l_dv = "for";
	_gna729 = LOCSTRING (TheRootNode,_gna730);




	



}

if (_gna729 != (GNODE) NULL && (GSLOT(_gna729) != (AXS_ENTRY) NULL))
	MarkUsed(_gna729);


forbridge = _gna729;


}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1866;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna731;
_gna731 = (GNODE) TheLoc;

if (_gna731 != (GNODE) NULL)
  if (VALIDTYPE(_gna731->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna731,""); 
  else fprintf(stderr,"\n At line 1866 attempt to unparse node of invalid type %d", _gna731->node_type);
else fprintf(stderr,"\n At line 1866 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna731;
_gna731 = (GNODE) fli;

if (_gna731 != (GNODE) NULL)
  if (VALIDTYPE(_gna731->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna731,""); 
  else fprintf(stderr,"\n At line 1866 attempt to unparse node of invalid type %d", _gna731->node_type);
else fprintf(stderr,"\n At line 1866 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1867;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna732;
_gna732 = (GNODE) fli;

if (_gna732 != (GNODE) NULL)
  if (VALIDTYPE(_gna732->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna732,""); 
  else fprintf(stderr,"\n At line 1867 attempt to unparse node of invalid type %d", _gna732->node_type);
else fprintf(stderr,"\n At line 1867 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna732;
_gna732 = (GNODE) forbridge;

if (_gna732 != (GNODE) NULL)
  if (VALIDTYPE(_gna732->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna732,""); 
  else fprintf(stderr,"\n At line 1867 attempt to unparse node of invalid type %d", _gna732->node_type);
else fprintf(stderr,"\n At line 1867 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1868;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna733;
_gna733 = (GNODE) forbridge;

if (_gna733 != (GNODE) NULL)
  if (VALIDTYPE(_gna733->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna733,""); 
  else fprintf(stderr,"\n At line 1868 attempt to unparse node of invalid type %d", _gna733->node_type);
else fprintf(stderr,"\n At line 1868 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna733;
_gna733 = (GNODE) flt;

if (_gna733 != (GNODE) NULL)
  if (VALIDTYPE(_gna733->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna733,""); 
  else fprintf(stderr,"\n At line 1868 attempt to unparse node of invalid type %d", _gna733->node_type);
else fprintf(stderr,"\n At line 1868 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1870;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna734;
_gna734 = (GNODE) forbridge;

if (_gna734 != (GNODE) NULL)
  if (VALIDTYPE(_gna734->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna734,""); 
  else fprintf(stderr,"\n At line 1870 attempt to unparse node of invalid type %d", _gna734->node_type);
else fprintf(stderr,"\n At line 1870 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,"\n (\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1872;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{ 
GNODE _gna735;

_gna735 = (GNODE) gmalloc ();
_gna735->node_flag = (GSIMPLENODE | GBUILTIN);	

_gna735->node_type = 3;

_gna735->node_data.l_dv = ( (char *)( (char *) newElem(getCstring(fileName), getCstring(fname)))) ;

if (_gna735 != (GNODE) NULL)
  if (VALIDTYPE(_gna735->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna735,""); 
  else fprintf(stderr,"\n At line 1873 attempt to unparse node of invalid type %d", _gna735->node_type);
else fprintf(stderr,"\n At line 1873 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," "); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna735;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1874;
_Cur_Node = TheRootNode;
{

GNODE _gna736;


_gna736 = getlocnode(TheRootNode);

_gna735 = (GNODE) GetFillers(_gna736,"line");
}

if (_gna735 != (GNODE) NULL)
  if (VALIDTYPE(_gna735->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna735,""); 
  else fprintf(stderr,"\n At line 1874 attempt to unparse node of invalid type %d", _gna735->node_type);
else fprintf(stderr,"\n At line 1874 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," (Loop For \n");

}

_Cur_Constr = "<forcondition...";
_Cur_SpecLine = 1875;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forcondition */
{


GNODE _gna737;	

_gna737 = (GNODE) GetFillers(TheRootNode,"forcondition");

 if (_gna737 != (GNODE) NULL) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1875;
_Cur_Node = _gna737;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"  (");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna738;
_gna738 = (GNODE) fileName;

if (_gna738 != (GNODE) NULL)
  if (VALIDTYPE(_gna738->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna738,""); 
  else fprintf(stderr,"\n At line 1875 attempt to unparse node of invalid type %d", _gna738->node_type);
else fprintf(stderr,"\n At line 1875 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_cond"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna738;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1875;
_Cur_Node = _gna737;
{

GNODE _gna739;


_gna739 = getlocnode(_gna737);

_gna738 = (GNODE) GetFillers(_gna739,"line");
}

if (_gna738 != (GNODE) NULL)
  if (VALIDTYPE(_gna738->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna738,""); 
  else fprintf(stderr,"\n At line 1875 attempt to unparse node of invalid type %d", _gna738->node_type);
else fprintf(stderr,"\n At line 1875 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv,")\n");

}

 }	  /* Balances if (_gna737 != (GNODE) NULL )*/

} /* Balances GNODE _gna737; */

}

_Cur_Constr = "<forbody...";
_Cur_SpecLine = 1876;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forbody */
{


GNODE _gna740;	

_gna740 = (GNODE) GetFillers(TheRootNode,"forbody");

 if (_gna740 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1876;
_Cur_Node = _gna740;

{				

  /* EXECUTE ITEM */
	
GatherContainedStatements (_gna740);  


}

 }	  /* Balances if (_gna740 != (GNODE) NULL )*/

} /* Balances GNODE _gna740; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1877;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"))\n )\n)");

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1880;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna742;
{


GNODE _gna743;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1880;
_Cur_Node = TheRootNode;
{

GNODE _gna744;
_gna744 = TheRootNode;

_gna743 = (GNODE) GetFillers(_gna744,"forincrement");
}
_gna742 = (_gna743== (GNODE) NULL);
}

if (_gna742) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1881;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{


GNODE _gna745;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna746;

_gna746 = (GNODE) gmalloc ();
_gna746->node_flag = GBUILTIN | GSIMPLENODE;
_gna746->node_type = C_String;
_gna746->node_data.l_dv = "nullincr";
	_gna745 = LOCSTRING (TheRootNode,_gna746);




	



}

if (_gna745 != (GNODE) NULL && (GSLOT(_gna745) != (AXS_ENTRY) NULL))
	MarkUsed(_gna745);


fli = _gna745;


}

}

}
else {

_Cur_Constr = "<forincrement...";
_Cur_SpecLine = 1883;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forincrement */
{


GNODE _gna747;	

_gna747 = (GNODE) GetFillers(TheRootNode,"forincrement");

 if (_gna747 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1884;
_Cur_Node = _gna747;

{				

  /* EXECUTE ITEM */
{


GNODE _gna748;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna749;

_gna749 = (GNODE) gmalloc ();
_gna749->node_flag = GBUILTIN | GSIMPLENODE;
_gna749->node_type = C_String;
_gna749->node_data.l_dv = "incr";
	_gna748 = LOCSTRING (_gna747,_gna749);




	



}

if (_gna748 != (GNODE) NULL && (GSLOT(_gna748) != (AXS_ENTRY) NULL))
	MarkUsed(_gna748);


fli = _gna748;


}

}

 }	  /* Balances if (_gna747 != (GNODE) NULL )*/

} /* Balances GNODE _gna747; */

}
}
}

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1886;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna750;
_gna750 = (GNODE) fli;

if (_gna750 != (GNODE) NULL)
  if (VALIDTYPE(_gna750->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna750,""); 
  else fprintf(stderr,"\n At line 1886 attempt to unparse node of invalid type %d", _gna750->node_type);
else fprintf(stderr,"\n At line 1886 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna750;
_gna750 = (GNODE) flt;

if (_gna750 != (GNODE) NULL)
  if (VALIDTYPE(_gna750->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna750,""); 
  else fprintf(stderr,"\n At line 1886 attempt to unparse node of invalid type %d", _gna750->node_type);
else fprintf(stderr,"\n At line 1886 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

_Cur_Constr = "<forincrement\n\t(PRIN...";
_Cur_SpecLine = 1888;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forincrement */
{


GNODE _gna751;	

_gna751 = (GNODE) GetFillers(TheRootNode,"forincrement");

 if (_gna751 != (GNODE) NULL) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1889;
_Cur_Node = _gna751;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna752;
_gna752 = (GNODE) fli;

if (_gna752 != (GNODE) NULL)
  if (VALIDTYPE(_gna752->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna752,""); 
  else fprintf(stderr,"\n At line 1889 attempt to unparse node of invalid type %d", _gna752->node_type);
else fprintf(stderr,"\n At line 1889 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1890;
_Cur_Node = _gna751;

{				

  /* EXECUTE ITEM */
	
DealWithExpression (_gna751);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1891;
_Cur_Node = _gna751;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1892;
_Cur_Node = _gna751;

{				

  /* EXECUTE ITEM */
	
VariableReference (_gna751);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1893;
_Cur_Node = _gna751;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,")\n");

}

 }	  /* Balances if (_gna751 != (GNODE) NULL )*/

} /* Balances GNODE _gna751; */

}

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1896;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

int _gna755;
{


GNODE _gna756;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1896;
_Cur_Node = TheRootNode;
{

GNODE _gna757;
_gna757 = TheRootNode;

_gna756 = (GNODE) GetFillers(_gna757,"forbody");
}
_gna755 = (_gna756== (GNODE) NULL);
}

if (_gna755) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1897;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna758;
_gna758 = (GNODE) bf;

if (_gna758 != (GNODE) NULL)
  if (VALIDTYPE(_gna758->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna758,""); 
  else fprintf(stderr,"\n At line 1897 attempt to unparse node of invalid type %d", _gna758->node_type);
else fprintf(stderr,"\n At line 1897 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna758;
_gna758 = (GNODE) fli;

if (_gna758 != (GNODE) NULL)
  if (VALIDTYPE(_gna758->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna758,""); 
  else fprintf(stderr,"\n At line 1897 attempt to unparse node of invalid type %d", _gna758->node_type);
else fprintf(stderr,"\n At line 1897 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

}
else {

_Cur_Constr = "<forbody\n\t...";
_Cur_SpecLine = 1899;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  forbody */
{


GNODE _gna759;	

_gna759 = (GNODE) GetFillers(TheRootNode,"forbody");

 if (_gna759 != (GNODE) NULL) {

_Cur_Constr = "(IF...";
_Cur_SpecLine = 1900;
_Cur_Node = _gna759;

{				

  /* EXECUTE ITEM */
{

int _gna760;
{

GNODE _gna761;
_gna761 = _gna759;



_gna760 =  OfType(_gna761,Block);
}

if (_gna760) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1901;
_Cur_Node = _gna759;

{				

  /* EXECUTE ITEM */
{


GNODE _gna762;
	_gna762 = BlockEnd (_gna759);




	





if (_gna762 != (GNODE) NULL && (GSLOT(_gna762) != (AXS_ENTRY) NULL))
	MarkUsed(_gna762);


be = _gna762;


}

}

}
else {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1902;
_Cur_Node = _gna759;

{				

  /* EXECUTE ITEM */
{


GNODE _gna763;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna764;

_gna764 = (GNODE) gmalloc ();
_gna764->node_flag = GBUILTIN | GSIMPLENODE;
_gna764->node_type = C_String;
_gna764->node_data.l_dv = "";
	_gna763 = LOCSTRING (_gna759,_gna764);




	



}

if (_gna763 != (GNODE) NULL && (GSLOT(_gna763) != (AXS_ENTRY) NULL))
	MarkUsed(_gna763);


be = _gna763;


}

}
}
}

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1904;
_Cur_Node = _gna759;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna765;
_gna765 = gcopy((GNODE) fli);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna766;
_gna766 = gcopy((GNODE) fli);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna767;
_gna767 = gcopy((GNODE) TheNext);
	
StmtFlow (_gna759,_gna765,_gna766,_gna767);  
}}}

}

 }	  /* Balances if (_gna759 != (GNODE) NULL )*/

} /* Balances GNODE _gna759; */

}
}
}

}

}

}

_Cur_Constr = "(?Continue\n\t(PRINT...";
_Cur_SpecLine = 1906;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Continue */		

if (OfType(TheRootNode,Continue)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1907;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna768;
_gna768 = (GNODE) fileName;

if (_gna768 != (GNODE) NULL)
  if (VALIDTYPE(_gna768->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna768,""); 
  else fprintf(stderr,"\n At line 1907 attempt to unparse node of invalid type %d", _gna768->node_type);
else fprintf(stderr,"\n At line 1907 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna768;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1907;
_Cur_Node = TheRootNode;
{

GNODE _gna769;


_gna769 = getlocnode(TheRootNode);

_gna768 = (GNODE) GetFillers(_gna769,"line");
}

if (_gna768 != (GNODE) NULL)
  if (VALIDTYPE(_gna768->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna768,""); 
  else fprintf(stderr,"\n At line 1907 attempt to unparse node of invalid type %d", _gna768->node_type);
else fprintf(stderr,"\n At line 1907 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1908;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithContinue (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1909;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n)\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1911;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna771;
_gna771 = (GNODE) fileName;

if (_gna771 != (GNODE) NULL)
  if (VALIDTYPE(_gna771->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna771,""); 
  else fprintf(stderr,"\n At line 1911 attempt to unparse node of invalid type %d", _gna771->node_type);
else fprintf(stderr,"\n At line 1911 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna771;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1911;
_Cur_Node = TheRootNode;
{

GNODE _gna772;


_gna772 = getlocnode(TheRootNode);

_gna771 = (GNODE) GetFillers(_gna772,"line");
}

if (_gna771 != (GNODE) NULL)
  if (VALIDTYPE(_gna771->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna771,""); 
  else fprintf(stderr,"\n At line 1911 attempt to unparse node of invalid type %d", _gna771->node_type);
else fprintf(stderr,"\n At line 1911 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna771;
_gna771 = (GNODE) ContinueLoc;

if (_gna771 != (GNODE) NULL)
  if (VALIDTYPE(_gna771->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna771,""); 
  else fprintf(stderr,"\n At line 1911 attempt to unparse node of invalid type %d", _gna771->node_type);
else fprintf(stderr,"\n At line 1911 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

}

}

_Cur_Constr = "(?Break\n\t(PRINT...";
_Cur_SpecLine = 1913;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Break */		

if (OfType(TheRootNode,Break)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1914;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna773;
_gna773 = (GNODE) fileName;

if (_gna773 != (GNODE) NULL)
  if (VALIDTYPE(_gna773->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna773,""); 
  else fprintf(stderr,"\n At line 1914 attempt to unparse node of invalid type %d", _gna773->node_type);
else fprintf(stderr,"\n At line 1914 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna773;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1914;
_Cur_Node = TheRootNode;
{

GNODE _gna774;


_gna774 = getlocnode(TheRootNode);

_gna773 = (GNODE) GetFillers(_gna774,"line");
}

if (_gna773 != (GNODE) NULL)
  if (VALIDTYPE(_gna773->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna773,""); 
  else fprintf(stderr,"\n At line 1914 attempt to unparse node of invalid type %d", _gna773->node_type);
else fprintf(stderr,"\n At line 1914 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1915;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithBreak (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1916;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n)\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1918;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna776;
_gna776 = (GNODE) fileName;

if (_gna776 != (GNODE) NULL)
  if (VALIDTYPE(_gna776->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna776,""); 
  else fprintf(stderr,"\n At line 1918 attempt to unparse node of invalid type %d", _gna776->node_type);
else fprintf(stderr,"\n At line 1918 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna776;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1918;
_Cur_Node = TheRootNode;
{

GNODE _gna777;


_gna777 = getlocnode(TheRootNode);

_gna776 = (GNODE) GetFillers(_gna777,"line");
}

if (_gna776 != (GNODE) NULL)
  if (VALIDTYPE(_gna776->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna776,""); 
  else fprintf(stderr,"\n At line 1918 attempt to unparse node of invalid type %d", _gna776->node_type);
else fprintf(stderr,"\n At line 1918 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna776;
_gna776 = (GNODE) BreakLoc;

if (_gna776 != (GNODE) NULL)
  if (VALIDTYPE(_gna776->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna776,""); 
  else fprintf(stderr,"\n At line 1918 attempt to unparse node of invalid type %d", _gna776->node_type);
else fprintf(stderr,"\n At line 1918 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

}

}

_Cur_Constr = "(?Goto...";
_Cur_SpecLine = 1920;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Goto */		

if (OfType(TheRootNode,Goto)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1921;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna778;
_gna778 = (GNODE) fileName;

if (_gna778 != (GNODE) NULL)
  if (VALIDTYPE(_gna778->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna778,""); 
  else fprintf(stderr,"\n At line 1921 attempt to unparse node of invalid type %d", _gna778->node_type);
else fprintf(stderr,"\n At line 1921 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna778;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1921;
_Cur_Node = TheRootNode;
{

GNODE _gna779;


_gna779 = getlocnode(TheRootNode);

_gna778 = (GNODE) GetFillers(_gna779,"line");
}

if (_gna778 != (GNODE) NULL)
  if (VALIDTYPE(_gna778->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna778,""); 
  else fprintf(stderr,"\n At line 1921 attempt to unparse node of invalid type %d", _gna778->node_type);
else fprintf(stderr,"\n At line 1921 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1922;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithGoto (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1923;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n)\n");

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1925;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna781;
_gna781 = (GNODE) fileName;

if (_gna781 != (GNODE) NULL)
  if (VALIDTYPE(_gna781->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna781,""); 
  else fprintf(stderr,"\n At line 1925 attempt to unparse node of invalid type %d", _gna781->node_type);
else fprintf(stderr,"\n At line 1925 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna781;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1926;
_Cur_Node = TheRootNode;
{

GNODE _gna782;


_gna782 = getlocnode(TheRootNode);

_gna781 = (GNODE) GetFillers(_gna782,"line");
}

if (_gna781 != (GNODE) NULL)
  if (VALIDTYPE(_gna781->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna781,""); 
  else fprintf(stderr,"\n At line 1926 attempt to unparse node of invalid type %d", _gna781->node_type);
else fprintf(stderr,"\n At line 1926 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna781;
_gna781 = (GNODE) fileName;

if (_gna781 != (GNODE) NULL)
  if (VALIDTYPE(_gna781->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna781,""); 
  else fprintf(stderr,"\n At line 1926 attempt to unparse node of invalid type %d", _gna781->node_type);
else fprintf(stderr,"\n At line 1926 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna781;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1926;
_Cur_Node = TheRootNode;
{
GNODE _gna783;
_Cur_Constr = "(LOCATION...";
_Cur_SpecLine = 1926;
_Cur_Node = TheRootNode;

{


GNODE _gna784;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1926;
_Cur_Node = TheRootNode;
{


GNODE _gna785;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1926;
_Cur_Node = TheRootNode;
{

GNODE _gna786;
_gna786 = TheRootNode;

_gna785 = (GNODE) GetFillers(_gna786,"gotoname");
}

_gna784 = (GNODE) GetFillers(_gna785,"stmt");
}

_gna783 = getlocnode(_gna784);
}

_gna781 = (GNODE) GetFillers(_gna783,"line");
}

if (_gna781 != (GNODE) NULL)
  if (VALIDTYPE(_gna781->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna781,""); 
  else fprintf(stderr,"\n At line 1926 attempt to unparse node of invalid type %d", _gna781->node_type);
else fprintf(stderr,"\n At line 1926 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

}

}

_Cur_Constr = "(?Do\n\t(PRINT...";
_Cur_SpecLine = 1928;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Do */		

if (OfType(TheRootNode,Do)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1929;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna787;
_gna787 = (GNODE) fileName;

if (_gna787 != (GNODE) NULL)
  if (VALIDTYPE(_gna787->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna787,""); 
  else fprintf(stderr,"\n At line 1929 attempt to unparse node of invalid type %d", _gna787->node_type);
else fprintf(stderr,"\n At line 1929 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna787;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1929;
_Cur_Node = TheRootNode;
{

GNODE _gna788;


_gna788 = getlocnode(TheRootNode);

_gna787 = (GNODE) GetFillers(_gna788,"line");
}

if (_gna787 != (GNODE) NULL)
  if (VALIDTYPE(_gna787->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna787,""); 
  else fprintf(stderr,"\n At line 1929 attempt to unparse node of invalid type %d", _gna787->node_type);
else fprintf(stderr,"\n At line 1929 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1930;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithDo (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1931;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n)\n");

}

_Cur_Constr = "<dobody...";
_Cur_SpecLine = 1933;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  dobody */
{


GNODE _gna790;	

_gna790 = (GNODE) GetFillers(TheRootNode,"dobody");

 if (_gna790 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1933;
_Cur_Node = _gna790;

{				

  /* EXECUTE ITEM */
{


GNODE _gna791;
	_gna791 = BlockFirst (_gna790);




	





if (_gna791 != (GNODE) NULL && (GSLOT(_gna791) != (AXS_ENTRY) NULL))
	MarkUsed(_gna791);


bf = _gna791;


}

}

 }	  /* Balances if (_gna790 != (GNODE) NULL )*/

} /* Balances GNODE _gna790; */

}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1934;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna792;
_gna792 = (GNODE) TheLoc;

if (_gna792 != (GNODE) NULL)
  if (VALIDTYPE(_gna792->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna792,""); 
  else fprintf(stderr,"\n At line 1934 attempt to unparse node of invalid type %d", _gna792->node_type);
else fprintf(stderr,"\n At line 1934 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna792;
_gna792 = (GNODE) bf;

if (_gna792 != (GNODE) NULL)
  if (VALIDTYPE(_gna792->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna792,""); 
  else fprintf(stderr,"\n At line 1934 attempt to unparse node of invalid type %d", _gna792->node_type);
else fprintf(stderr,"\n At line 1934 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

_Cur_Constr = "<docondition...";
_Cur_SpecLine = 1935;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  docondition */
{


GNODE _gna793;	

_gna793 = (GNODE) GetFillers(TheRootNode,"docondition");

 if (_gna793 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1935;
_Cur_Node = _gna793;

{				

  /* EXECUTE ITEM */
{


GNODE _gna794;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna795;

_gna795 = (GNODE) gmalloc ();
_gna795->node_flag = GBUILTIN | GSIMPLENODE;
_gna795->node_type = C_String;
_gna795->node_data.l_dv = "";
	_gna794 = LOCSTRING (_gna793,_gna795);




	



}

if (_gna794 != (GNODE) NULL && (GSLOT(_gna794) != (AXS_ENTRY) NULL))
	MarkUsed(_gna794);


flt = _gna794;


}

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1936;
_Cur_Node = _gna793;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna796;
_gna796 = gcopy((GNODE) flt);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna797;
_gna797 = gcopy((GNODE) bf);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna798;
_gna798 = gcopy((GNODE) TheNext);
	
CondFlow (_gna793,_gna796,_gna797,_gna798);  
}}}

}

 }	  /* Balances if (_gna793 != (GNODE) NULL )*/

} /* Balances GNODE _gna793; */

}

_Cur_Constr = "<dobody\n\t\t(CALL...";
_Cur_SpecLine = 1938;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  dobody */
{


GNODE _gna799;	

_gna799 = (GNODE) GetFillers(TheRootNode,"dobody");

 if (_gna799 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1939;
_Cur_Node = _gna799;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna800;
_gna800 = gcopy((GNODE) flt);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna801;
_gna801 = gcopy((GNODE) flt);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna802;
_gna802 = gcopy((GNODE) TheNext);
	
StmtFlow (_gna799,_gna800,_gna801,_gna802);  
}}}

}

 }	  /* Balances if (_gna799 != (GNODE) NULL )*/

} /* Balances GNODE _gna799; */

}

}

}

_Cur_Constr = "(?While\n\t(PRINT...";
_Cur_SpecLine = 1942;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE While */		

if (OfType(TheRootNode,While)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1943;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna803;
_gna803 = (GNODE) fileName;

if (_gna803 != (GNODE) NULL)
  if (VALIDTYPE(_gna803->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna803,""); 
  else fprintf(stderr,"\n At line 1943 attempt to unparse node of invalid type %d", _gna803->node_type);
else fprintf(stderr,"\n At line 1943 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna803;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1943;
_Cur_Node = TheRootNode;
{

GNODE _gna804;


_gna804 = getlocnode(TheRootNode);

_gna803 = (GNODE) GetFillers(_gna804,"line");
}

if (_gna803 != (GNODE) NULL)
  if (VALIDTYPE(_gna803->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna803,""); 
  else fprintf(stderr,"\n At line 1943 attempt to unparse node of invalid type %d", _gna803->node_type);
else fprintf(stderr,"\n At line 1943 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1944;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithWhile (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1945;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n)\n");

}

_Cur_Constr = "<whilebody...";
_Cur_SpecLine = 1947;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  whilebody */
{


GNODE _gna806;	

_gna806 = (GNODE) GetFillers(TheRootNode,"whilebody");

 if (_gna806 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1947;
_Cur_Node = _gna806;

{				

  /* EXECUTE ITEM */
{


GNODE _gna807;
	_gna807 = BlockFirst (_gna806);




	





if (_gna807 != (GNODE) NULL && (GSLOT(_gna807) != (AXS_ENTRY) NULL))
	MarkUsed(_gna807);


bf = _gna807;


}

}

 }	  /* Balances if (_gna806 != (GNODE) NULL )*/

} /* Balances GNODE _gna806; */

}

_Cur_Constr = "<whilecondition...";
_Cur_SpecLine = 1951;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  whilecondition */
{


GNODE _gna808;	

_gna808 = (GNODE) GetFillers(TheRootNode,"whilecondition");

 if (_gna808 != (GNODE) NULL) {

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1951;
_Cur_Node = _gna808;

{				

  /* EXECUTE ITEM */
{


GNODE _gna809;
{
	

/* A new variable nested level for each arg (to make code generation easier) */

GNODE _gna810;

_gna810 = (GNODE) gmalloc ();
_gna810->node_flag = GBUILTIN | GSIMPLENODE;
_gna810->node_type = C_String;
_gna810->node_data.l_dv = "";
	_gna809 = LOCSTRING (_gna808,_gna810);




	



}

if (_gna809 != (GNODE) NULL && (GSLOT(_gna809) != (AXS_ENTRY) NULL))
	MarkUsed(_gna809);


flt = _gna809;


}

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1952;
_Cur_Node = _gna808;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna811;
_gna811 = gcopy((GNODE) flt);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna812;
_gna812 = gcopy((GNODE) bf);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna813;
_gna813 = gcopy((GNODE) TheNext);
	
CondFlow (_gna808,_gna811,_gna812,_gna813);  
}}}

}

 }	  /* Balances if (_gna808 != (GNODE) NULL )*/

} /* Balances GNODE _gna808; */

}

_Cur_Constr = "<whilebody\n\t\t(CALL...";
_Cur_SpecLine = 1957;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  whilebody */
{


GNODE _gna814;	

_gna814 = (GNODE) GetFillers(TheRootNode,"whilebody");

 if (_gna814 != (GNODE) NULL) {

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1958;
_Cur_Node = _gna814;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna815;
_gna815 = gcopy((GNODE) flt);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna816;
_gna816 = gcopy((GNODE) flt);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna817;
_gna817 = gcopy((GNODE) TheNext);
	
StmtFlow (_gna814,_gna815,_gna816,_gna817);  
}}}

}

 }	  /* Balances if (_gna814 != (GNODE) NULL )*/

} /* Balances GNODE _gna814; */

}

}

}

_Cur_Constr = "(?Switch\n\t(PRINT...";
_Cur_SpecLine = 1964;
_Cur_Node = TheRootNode;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Switch */		

if (OfType(TheRootNode,Switch)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1965;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna818;
_gna818 = (GNODE) fileName;

if (_gna818 != (GNODE) NULL)
  if (VALIDTYPE(_gna818->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna818,""); 
  else fprintf(stderr,"\n At line 1965 attempt to unparse node of invalid type %d", _gna818->node_type);
else fprintf(stderr,"\n At line 1965 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna818;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1965;
_Cur_Node = TheRootNode;
{

GNODE _gna819;


_gna819 = getlocnode(TheRootNode);

_gna818 = (GNODE) GetFillers(_gna819,"line");
}

if (_gna818 != (GNODE) NULL)
  if (VALIDTYPE(_gna818->node_type))
    gunparse((FILE *)component->node_data.l_dv,_gna818,""); 
  else fprintf(stderr,"\n At line 1965 attempt to unparse node of invalid type %d", _gna818->node_type);
else fprintf(stderr,"\n At line 1965 attempt to unparse null node");
	}
        fprintf((FILE *)component->node_data.l_dv," \n (\n");

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1966;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
	
DealWithSwitch (TheRootNode);  


}

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1967;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(component->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file component at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)component->node_data.l_dv," )\n)\n");

}

_Cur_Constr = "(ASSIGN...";
_Cur_SpecLine = 1969;
_Cur_Node = TheRootNode;

{				

  /* EXECUTE ITEM */
{

GNODE _gna821;


_gna821 = getlocnode(TheRootNode);

if (_gna821 != (GNODE) NULL && (GSLOT(_gna821) != (AXS_ENTRY) NULL))
	MarkUsed(_gna821);


TmpLoc = _gna821;


}

}

_Cur_Constr = "<switchcondition...";
_Cur_SpecLine = 1970;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  switchcondition */
{


GNODE _gna822;	

_gna822 = (GNODE) GetFillers(TheRootNode,"switchcondition");

 if (_gna822 != (GNODE) NULL) {

 }	  /* Balances if (_gna822 != (GNODE) NULL )*/

} /* Balances GNODE _gna822; */

}

_Cur_Constr = "<switchbody...";
_Cur_SpecLine = 1972;
_Cur_Node = TheRootNode;

{
	
	



/* ACCESS DOWN ON SLOT  switchbody */
{


GNODE _gna823;	

_gna823 = (GNODE) GetFillers(TheRootNode,"switchbody");

 if (_gna823 != (GNODE) NULL) {

_Cur_Constr = "(?Block\n...";
_Cur_SpecLine = 1973;
_Cur_Node = _gna823;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Block */		

if (OfType(_gna823,Block)) {

_Cur_Constr = "<blockbody\n...";
_Cur_SpecLine = 1974;
_Cur_Node = _gna823;

{
	
	



/* ACCESS DOWN ON SLOT  blockbody */
{


GNODE _gna824;	

_gna824 = (GNODE) GetFillers(_gna823,"blockbody");

 if (_gna824 != (GNODE) NULL) {

_Cur_Constr = "{Statement\n...";
_Cur_SpecLine = 1975;
_Cur_Node = _gna824;

{

_Cur_Constr = "{Statement\n...";
_Cur_SpecLine = 1975;
_Cur_Node = _gna824;

{

GNODE _gna825;

/* LIST ITERATION ACCESS over LIST MEMBERS of type Statement */
 
if (_gna824->node_flag  & (GLIST_OF_PROPERTIES | GLIST_OF)) {
	_gna825 = (GNODE)( _gna824->node_data.l_dv);
  for(;_gna825 != (GNODE) NULL;_gna825=_gna825->gnext) {
    if (OfType(_gna825,Statement)) {

_Cur_Constr = "(?Case...";
_Cur_SpecLine = 1976;
_Cur_Node = _gna825;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Case */		

if (OfType(_gna825,Case)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1976;
_Cur_Node = _gna825;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna827;
_gna827 = (GNODE) fileName;

if (_gna827 != (GNODE) NULL)
  if (VALIDTYPE(_gna827->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna827,""); 
  else fprintf(stderr,"\n At line 1977 attempt to unparse node of invalid type %d", _gna827->node_type);
else fprintf(stderr,"\n At line 1977 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna827;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1977;
_Cur_Node = _gna825;
{

GNODE _gna828;
_gna828 = (GNODE) TmpLoc;

_gna827 = (GNODE) GetFillers(_gna828,"line");
}

if (_gna827 != (GNODE) NULL)
  if (VALIDTYPE(_gna827->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna827,""); 
  else fprintf(stderr,"\n At line 1977 attempt to unparse node of invalid type %d", _gna827->node_type);
else fprintf(stderr,"\n At line 1977 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna827;
_gna827 = (GNODE) fileName;

if (_gna827 != (GNODE) NULL)
  if (VALIDTYPE(_gna827->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna827,""); 
  else fprintf(stderr,"\n At line 1977 attempt to unparse node of invalid type %d", _gna827->node_type);
else fprintf(stderr,"\n At line 1977 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna827;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1977;
_Cur_Node = _gna825;
{

GNODE _gna829;


_gna829 = getlocnode(_gna825);

_gna827 = (GNODE) GetFillers(_gna829,"line");
}

if (_gna827 != (GNODE) NULL)
  if (VALIDTYPE(_gna827->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna827,""); 
  else fprintf(stderr,"\n At line 1977 attempt to unparse node of invalid type %d", _gna827->node_type);
else fprintf(stderr,"\n At line 1977 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

}

}

_Cur_Constr = "(?Default...";
_Cur_SpecLine = 1978;
_Cur_Node = _gna825;

{	




/* CONDITIONAL ACCESS If parent is of NODE TYPE Default */		

if (OfType(_gna825,Default)) {

_Cur_Constr = "(PRINT...";
_Cur_SpecLine = 1978;
_Cur_Node = _gna825;

{				

  /* EXECUTE ITEM */


/* Print out stuff here */
if(control->node_type != C_File)
{
fprintf(stderr,"\n ***ERROR*** Attempt to print to non-file control at line %d",
 _Cur_SpecLine);
exit(0);
}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"\n(");  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,""); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna830;
_gna830 = (GNODE) fileName;

if (_gna830 != (GNODE) NULL)
  if (VALIDTYPE(_gna830->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna830,""); 
  else fprintf(stderr,"\n At line 1979 attempt to unparse node of invalid type %d", _gna830->node_type);
else fprintf(stderr,"\n At line 1979 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna830;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1979;
_Cur_Node = _gna825;
{

GNODE _gna831;
_gna831 = (GNODE) TmpLoc;

_gna830 = (GNODE) GetFillers(_gna831,"line");
}

if (_gna830 != (GNODE) NULL)
  if (VALIDTYPE(_gna830->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna830,""); 
  else fprintf(stderr,"\n At line 1979 attempt to unparse node of invalid type %d", _gna830->node_type);
else fprintf(stderr,"\n At line 1979 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"  "); /* Skip over percent and "s". Always percent s in print statements */
{

GNODE _gna830;
_gna830 = (GNODE) fileName;

if (_gna830 != (GNODE) NULL)
  if (VALIDTYPE(_gna830->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna830,""); 
  else fprintf(stderr,"\n At line 1979 attempt to unparse node of invalid type %d", _gna830->node_type);
else fprintf(stderr,"\n At line 1979 attempt to unparse null node");
	}  /* Clip the format string at percent sign */
	fprintf((FILE *)control->node_data.l_dv,"_stmt"); /* Skip over percent and "s". Always percent s in print statements */
{


GNODE _gna830;
_Cur_Constr = "(SLOT...";
_Cur_SpecLine = 1979;
_Cur_Node = _gna825;
{

GNODE _gna832;


_gna832 = getlocnode(_gna825);

_gna830 = (GNODE) GetFillers(_gna832,"line");
}

if (_gna830 != (GNODE) NULL)
  if (VALIDTYPE(_gna830->node_type))
    gunparse((FILE *)control->node_data.l_dv,_gna830,""); 
  else fprintf(stderr,"\n At line 1979 attempt to unparse node of invalid type %d", _gna830->node_type);
else fprintf(stderr,"\n At line 1979 attempt to unparse null node");
	}
        fprintf((FILE *)control->node_data.l_dv,")\n");

}

}

}
	}
    else printf("\n**WARNING** Members of list in iteration on linenumber 1975 is %s not type %d---Statement",NodeTable[_gna825->node_type]->nodename,Statement);
	continue;
    }
} else printf("\n***WARNING** List iteration starting on linenumber 1975- Parent NOT a LIST !");


}

}

 }	  /* Balances if (_gna824 != (GNODE) NULL )*/

} /* Balances GNODE _gna824; */

}

}

}

_Cur_Constr = "(CALL...";
_Cur_SpecLine = 1980;
_Cur_Node = _gna823;

{				

  /* EXECUTE ITEM */
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna833;
_gna833 = gcopy((GNODE) TheNext);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna834;
_gna834 = gcopy((GNODE) TheNext);
{
	  /* This turned out to be necessary to avoid Cpp errors */

/* A new variablele nested level for each arg (to make code generation easier) */

GNODE _gna835;
_gna835 = gcopy((GNODE) TheNext);
	
StmtFlow (_gna823,_gna833,_gna834,_gna835);  
}}}

}

 }	  /* Balances if (_gna823 != (GNODE) NULL )*/

} /* Balances GNODE _gna823; */

}

}

}
}
