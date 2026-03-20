/*ident	"@(#)gen++:gnode.h	1.10" */
/* This is the type of node that's goinna have all the
   nodes in the intermediate form as a part of it. */


#define MAXINH 50 /* Maximum number of indepdent inherited slots considered */

typedef union  {
    double l_fv;  /* Float */
    long l_iv;    /* Integer */
    char l_cv;    /* Character */
    void *l_dv;   /* Arbitrary (Pointer) */
    PRINTFUN l_pfv;  /* Unparsing function (used in gnodes that encode Unp. Inst */
  } GDATA;

typedef union {
    AXS_ENTRY gslot;
    GNODE listhead;
  } GLINK;

struct gnode {
  long  node_flag;
  int  node_type;
  GDATA  node_data;    /* This will have all the stuff in it */
  GNODE    gnext;        /* Next node on the list (for children of List-type nodes ) */
  GLINK  glink;
/*   SLOTHEAD gslots; */
  GNODE gkids;
  GNODE glast;
  GNODE    gparent;
};


#define GNEXT(X)   X->gnext
#define GLAST(X)   X->glast

#define GCONDFREE(X) if (!(X->node_flag & GINUSE ) ) gfree(X);


#define getCstring(X) ((char *)(X)->node_data.l_dv)
#define getCint(X) ((int)(X)->node_data.l_iv)
#define getCfloat(X) ((float) (X)->node_data.l_fv)
#define getCvoid(X) ((void *)(X)->node_data.l_dv)
#define getCfile(X) ((FILE *)((X)->node_data.l_dv))



/* These flags determine what kind of gnode we have. */
/* Do these have to be flags, can they be enum ? */

/* Some of these flags at the time of generating the code that
   builds the tables of accessor functions, and some are actually
   used at runtime while traversing cnodes and building  gtrees */

#define GSIMPLENODE              0x000001    /* This is a simple node */
#define GLIST_OF                 0x000002    /* Node is head of a list */
#define GSET_OF                 0x000002    /* Set of things, order unimportant (for equality) */
#define GLIST_OF_PROPERTIES      0x000004    /* List of properties head*/
#define GCUSTOM_LIST             0x000008    /* Custom List head */ 
#define GCHOICENODE             0x000010    /* This node has alternates */
#define GALTERNATE              0x000020    /* This node is one of an alternate */
#define GLEAFNODE               0x000040    /* This node is one of an alternate */
#define GLOCATION               0x000080    /* This is THE location node */
#define GDEFINEDNODE            0x000100    /*  This is a defined node (descriptor) */
#define GBUILTIN                0x000200    /* This is String, Integer, Float Or List */
#define GLISTMEMBER             0x000400    /* This is amember of a list */
#define GPROPERTY               0x000800   /* A property */
#define GSETMEMBER             0x001000    /* This is amember of a list */
#define GPRINTSTUFF            0x002000    /* This is print stuff (used in a slot) */
#define GITER_OF              0x004000    /* This is an iteration set */
#define GITERMEMBER           0x008000     /* Member of an iteration set */



#define GNOEXPAND            0x010000        /* Don't expand this slot if in a "[]" search */
#define GTERMINATEDITER      0x020000    /* This iterator has a special terminating test */
#define GSHADOW              0x040000    /* This node shadows another (for search DFS/BFS) */
#define GSEARCHROOT          0x080000    /* This node shadows a root (for search DFS/BFS) */
#define GINUSE               0x100000    /* This node is use by an assign */
#define GTHREADED GSEARCHROOT /* This flag indicates a threaded node (new version of DFS) */
#define GDONE GSHADOW   /* This repeated flag is used to initalize slot counts during set up ONLY */


#define DOCLIST 1
