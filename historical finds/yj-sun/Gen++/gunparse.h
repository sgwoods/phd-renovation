/*ident	"@(#)gen++:gunparse.h	1.3" */

#if __STDC__ || __cplusplus || c_plusplus
/* #if __cplusplus || c_plusplus
 * extern "C" {
 * #endif
 */
void gunparse(FILE *,GNODE,char*);
GNODE gunpexpr(GNODE, GNODE);
int guncond (GNODE, GNODE);
void gunparsit(FILE *,GNODE,GNODE);
void gdump(GNODE,int,FILE *);   /* dump with initial tabs */
void dodump(GNODE,int,FILE *);  /* dump without initial tabs */
/* #if __cplusplus || c_plusplus
 * }
 * #endif
 */
#else
extern void gunparse(/* GNODE,char* */);
GNODE gunpexpr(/* GNODE *, GNODE* */);
int guncond (/* GNODE, GNODE */);
void gunparsit(/* GNODE,GNODE */) ;
void gdump(/*GNODE,int,FILE * */);
void dodump(/*GNODE,int,FILE * */);
#endif


