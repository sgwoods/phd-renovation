/*ident	"@(#)gen++:gtypedefs.h	1.3" */
/* Typedefs of all the data structures used in Genoa */


typedef struct gnode *GNODE;  /* See gnode.h for def */

 /* This is the type of function that will get nodes */
#if __STDC__ || __cplusplus || c_plusplus
/* #if __cplusplus || c_plusplus
 * extern "C" {
 * #endif
 */
typedef GNODE (*NDGFUN) (GNODE) ;  
typedef void (* ERRORFUN) ();
typedef int (*NDTFUN) (GNODE);  /* The function that will test nodes */
typedef int (* EQTFUN) (GNODE,GNODE);
typedef void (* PRINTFUN) (FILE * ,GNODE);
/* #if __cplusplus || c_plusplus
 * }
 * #endif
 */
#else
typedef GNODE (*NDGFUN) () ;  
typedef int (*NDTFUN) ();  /* The function that will test nodes */
typedef int (* EQTFUN) ();
typedef void (* PRINTFUN) ();
typedef void (* ERRORFUN) ();
#endif
typedef long GFLAGS;

typedef struct ndgtr *NDGTR;
typedef struct ndtstr *NDTSTR;
typedef struct ndeq *NDEQ;

typedef struct axs_entry* AXS_ENTRY;  /* in functabe.h */
typedef struct axs_head* AXS_HEAD;   /* in functabe.h */

typedef struct prtstuff *PPOOP;

typedef struct slot_head *SLOTHEAD;   /* in Slothead.h */


