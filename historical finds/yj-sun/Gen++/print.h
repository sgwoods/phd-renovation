/*ident	"@(#)gen++:print.h	1.1" */
/************************************************************************/
/*  print.h - define nodetypes to be used by printing code              */
/************************************************************************/





typedef enum {
  GPLiteral,
  GPSimpleSlot,
  GPStringSlot,
  GPSlotSeq,
  GPListPrint,
  GPCondPrint,
  GPExec,
  GPStrHead,
  GPAllHead
  } GPPrintCodes;

typedef enum {
  GPEqCond,
  GPNullCond,
  GPEmptyCond,
  GPTypeCond,
  GPSameType
  } GPCondCodes;


typedef enum {
  GPSlotExpr,
  } GPExprCodes;


#define GPTRUE(X)   X->gkids->node_data.l_dv
#define GPFALSE(X)  X->gkids->gnext->node_data.l_dv
#define GPTESTEXPR(X)  X->gkids->gnext->gnext->node_data.l_dv
#define GPTESTEXPR2(X) X->gkids->gnext->gnext->gnext->node_data.l_dv
