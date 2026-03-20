/*ident	"@(#)gen++:glistops.h	1.4" */

#if __STDC__ || __cplusplus || c_plusplus
/* #if __cplusplus || c_plusplus
 * extern "C" {
 * #endif
 */
extern GNODE lcons(GNODE,GNODE),lndcons(GNODE,GNODE),lconc(GNODE,GNODE),lcar(GNODE),lcdr(GNODE),lnext(GNODE);
extern int glength(GNODE),IsList(GNODE),gnull(GNODE),gmember(GNODE,GNODE),gemember_eq(GNODE,GNODE),gequal(GNODE,GNODE),geq(GNODE,GNODE);
extern GNODE gcopy(GNODE),newnull(),ldpop(GNODE);
extern void gcollect(GNODE);
/* #if __cplusplus || c_plusplus
 * }  
 * #endif
 */
#else
extern GNODE lcons(),lndcons(),lconc(),lcar(),lcdr(),lnext();
extern int glength(),IsList(),gnull(),gmember(),gemember_eq(),gequal(),geq();
extern GNODE gcopy(),newnull(),ldpop();
extern void gcollect();
#endif


#define GCAR(X) lcar(X)
#define GCDR(X) lcdr(gcopy(X))
#define GDCDR(X) lcdr(X)
#define GAPPEND(X,Y) lconc(gcopy(X),gcopy(Y))
#define GCONC(X,Y) lconc(X,Y)
#define GLENGTH(X) glength(X)
#define GCONS(X,Y) lndcons(X,Y)
#define GEQUAL(X,Y) gequal(X,Y)
#define GEQ(X,Y) ge(X,Y)
#define GMEMBER(X,Y) gmember(X,Y)
#define GMEMBER_EQ(X,Y) gmember_eq(X,Y)
#define GEMPTY(X) gnull(X)
#define GPOP(X) ldpop(X)
#define GPUSH(X,Y) lcons(X,Y)
#define GSLOT(X) ((X->node_flag & (GLISTMEMBER | GPROPERTY | GITERMEMBER)) ? X->glink.listhead->glink.gslot : X->glink.gslot)




