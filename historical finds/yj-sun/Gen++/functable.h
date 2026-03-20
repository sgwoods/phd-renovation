/*ident	"@(#)gen++:functable.h	1.2" */
/* axs_entry is a node in a list of entries that hang off each node type
   (alternate) that tell you what slots there are under a node, and how
   to pull them out. (typedefs in gtypedefs.h, included by gnode.h)  */

struct ndtstr {
  char *nt_fname;
  NDTFUN nt_fun;
};

struct ndgtr {
  char *ng_fname;
  NDGFUN ng_fun;
};



struct ndeq {
  char *ne_fname;
  EQTFUN ne_fun;
};



struct axs_entry {

  char *slotname; /* Name of the slot */
  GFLAGS filler_flag;  /* Flag for filler - is it list, (what kind), atom etc*/
  int filler_type;  /* What filler type to stuff in */

  NDGTR getfun;     /* Get first (or only filler) */
  NDGTR nextgetfun;  /* Get next element */
/*   NDGTR finalfun; Not really needed for array */
  AXS_HEAD ae_parent;  /* The parent descriptor */
  AXS_ENTRY ae_next;
#ifdef DOCLIST
  char *ae_comment;
#endif
/*  AXS_ENTRY ae_prev;  NOT USED */
};



struct axs_head {
  GFLAGS node_flag;   /* True if this node has alternatives */
  char *nodename;
  int node_type;  /* Type of node (filled in by the code) */
  NDEQ neq_fun;    /* Equality testing function for this kind of node */
  NDTSTR test_fun;    /* How to find if a node is of this type */
  AXS_ENTRY fld_list;  /* list of fields in this node */
  AXS_HEAD ah_next;  /* List of alternatives at this level */
  AXS_HEAD ah_children;  /* List of children */
  AXS_HEAD ah_parent;
  int num_slots;
  GNODE prt_list;
#ifdef DOCLIST
  char *ah_comment;
#endif
};



