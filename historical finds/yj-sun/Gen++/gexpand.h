/*ident	"@(#)gen++:gexpand.h	1.5" */
#if __STDC__  || __cplusplus || c_plusplus
/* #if __cplusplus || c_plusplus
 * extern "C" {
 * #endif
 */
GNODE gslotfillers(GNODE,AXS_ENTRY);
AXS_ENTRY FindTheSlot(NODETYPE,char*);
AXS_ENTRY Funiqslot(NODETYPE,NODETYPE);
int OnPath(GNODE,GNODE );
NDGTR FindTheFun(NODETYPE,char*);
NDGTR FindTheNFun(NODETYPE,char*);
GNODE GetFillers(GNODE,char *);
GNODE gfullyexpand(GNODE);
GNODE ThreadList(GNODE);
GNODE ExpandAll(GNODE);
GNODE ShadowThis(GNODE);
GNODE getlocnode(GNODE);
char *getlocation(GNODE);
char *WhatType(int);
int gtypeof(GNODE);
int TypeCovers(int,int);
int OfType(GNODE, NODETYPE);
void StampType(GNODE);
void MarkUsed(GNODE);
/* #if __cplusplus || c_plusplus
 * }
 * #endif
 */
#else
extern GNODE gslotfillers();
extern AXS_ENTRY FindTheSlot();
extern AXS_ENTRY Funiqslot();
int OnPath( );
extern NDGTR FindTheFun();
extern NDGTR FindTheNFun();
extern GNODE GetFillers();
extern GNODE gfullyexpand();
GNODE ThreadList();
GNODE ExpandAll();
extern GNODE ShadowThis();
extern GNODE getlocnode();
extern char *getlocation();
extern char *WhatType();
extern int gtypeof();
extern int TypeCovers();
extern int OfType();
extern void StampType();
extern void MarkUsed();
#endif


