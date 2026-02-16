/* 	$Id: cell_trans.c,v 1.4 1995/03/15 16:46:52 npkonrad Exp $	 */

#ifndef lint
static char vcid[] = "$Id: cell_trans.c,v 1.4 1995/03/15 16:46:52 npkonrad Exp $";
#endif /* lint */
/*************************************************************************/
/* This file contains code for supporting functions of the CellTransforms */
/* structure.  It provides a facility to compute and store transformation */
/* matrices between cartesian and barycentric coordinates for cells in an */
/* unstructured, tetrahedral mesh.  It is designed to be used with AVS */
/* UCD data structures.  Functions for accessing, initializing, */
/* generating etc. are found in cell_trans.c and are summarized here: */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211 */
/*  Date Created: Tue Dec  6 10:10:02 EST 1994 */
/*************************************************************************/

/*************************************************************************/

/* The CellTransforms structure contains two lists of pointers.  One */
/* points to transform matrices which go from cartesian to barycentric */
/* coordinates, and the other points to the inverse of these.  The lists */
/* are filled in on a lazy evaluation scheme by the routine */
/* get_transform, to avoid having to evaluate transforms for all cells in */
/* a mesh, and to avoid costly re-computation when the transforms are */
/* required repeatedly (as will be the case with particle advection). */

/* Also included in the structure are pointers to the original UCD */
/* structure, and x,y and z node position lists for that mesh.  These are */
/* also included to speed up the computation. */

/*************************************************************************/

#include "cell_trans.h"

/*************************************************************************/
/* status = init_cell_trans(ucd_input, ncells, Ix, Iy, Iz, cell_ctrans); */

/*     This function initializes the cell_ctrans data structure.  It contains */
/*     two lists of pointers to coordinate transform matrices which will be */
/*     filled in as necessary.  The pointers to the original ucd structure */
/*     and the node coordinate data are also supplied for convenience (speed) */
/*     when the transforms are computed. */
/*************************************************************************/
int    init_cell_trans(UCD_structure *ucd_input,
		       int	Incells,
		       float	*Ix,
		       float	*Iy,
		       float	*Iz,
		       CellTransforms **cell_ctrans)
{
    int	i;					  /* utility counter */
    CellTransforms	*transforms;		  /* temp var */

    if (*cell_ctrans!=NULL) {
	AVSerror("init_cell_trans: memory leak");
	/* if cell_ctrans has been previously allocated, */
	/* I can't de-allocate all of the transforms it points to, */
	/* since I no longer know how many cells there were. */
	free(*cell_ctrans);
    }
    *cell_ctrans =				  /* allocate memory for transform structure */
    transforms = (CellTransforms *) malloc( sizeof( CellTransforms ));

    transforms->ncells = Incells;

    /* allocate memory for each transform array */
    transforms->to_bary = (Mat44 **) malloc( Incells * sizeof(Mat44 *));
    transforms->to_cart = (Mat44 **) malloc( Incells * sizeof(Mat44 *));

    /* quit if we didn't get the memory */
    if ((transforms->to_bary==NULL) || (transforms->to_cart==NULL)) {
	AVSerror("No Memory for cell_trans structure");
	return(0);
    }

    /* initialize the lists */
    for (i=0 ; i<Incells ; i++) {
	transforms->to_bary[i] = NULL;
	transforms->to_cart[i] = NULL;
    }

    /* fill in the reference data */
    transforms->ucd_input = ucd_input;
    transforms->x = Ix;
    transforms->y = Iy;
    transforms->z = Iz;

    return(1);					  /* that's it */
}

/*************************************************************************/
/* status = destroy_cell_trans(&cell_ctrans) */

/*     This procedure deallocates all memory used for the cell_ctrans */
/*     structure. */

/*     Actually, this is never called.  It's assumed that when the module is */
/*     "hammered" it's locally allocated data is freed when it's process */
/*     dies.  The rest of the code ensures that it doesn't consume memory */
/*     indescriminantly.  Only one instance of any of these data structures */
/*     exists at any one time. */
/*     The routine is just include for completeness, incase this is used in a */
/*     context other than AVS. */
/*************************************************************************/
int	destroy_cell_trans(CellTransforms **cell_ctrans)
{
    /* local variables */
    int	i;
    CellTransforms	*transforms;

    transforms = *cell_ctrans;			  /* for the sake of cleaner looking code... */

    /* first destroy any transforms */
    for (i=transforms->ncells-1 ; i>=0 ; i--) {
	free(transforms->to_bary[i]);		  /* assuming it's okay to  */
	free(transforms->to_cart[i]);		  /* call free with NULL  */
    }
    /* then free the lists too */
    free(transforms->to_bary);
    free(transforms->to_cart);

    /* and finally the transform structure itself */
    free(transforms);

    *cell_ctrans = NULL;			  /* and clean up the pointer */

    return(1);
}

/*************************************************************************/
/* status = get_cell_trans(cell_ctrans, cell, to_cart, to_bary) */

/*     This function retrieves the coordinate transformations for a given */
/*     cell either from the list of already computed transformations, or by */
/*     computing them from the cell node coordinates. */
/*************************************************************************/
int	get_cell_trans(CellTransforms *cell_ctrans,
		       int cell,
		       Mat44 **to_cart,
		       Mat44 **to_bary)
{
    int  elem_id, mat_id, cell_type, me_flags;	  /* cell parameters */
    char int_cell_name;				  /* (mostly not used...) */
    int	*nodes;

    if (cell_ctrans->to_bary[cell]!=NULL) {	  /* if already computed */
	*to_bary = cell_ctrans->to_bary[cell];	  /*    return results */
	*to_cart = cell_ctrans->to_cart[cell];
    } else {					  /* else */
	/* get the cell information */
	UCDcell_get_information (cell_ctrans->ucd_input,/*    get cell info */
				 cell, &elem_id,
				 &int_cell_name,
				 &mat_id, &cell_type,
				 &me_flags, &nodes);

	/* construct the to_cart transform */
	cell_ctrans->to_cart[cell] =		  /* allocate memory for transform */
	    *to_cart = (Mat44 *) malloc( sizeof(Mat44) );

	(**to_cart)[0][0] = cell_ctrans->x[nodes[0]]; /* transform to cartesian coords */
	(**to_cart)[1][0] = cell_ctrans->x[nodes[1]];
	(**to_cart)[2][0] = cell_ctrans->x[nodes[2]];
	(**to_cart)[3][0] = cell_ctrans->x[nodes[3]];
	(**to_cart)[0][1] = cell_ctrans->y[nodes[0]];
	(**to_cart)[1][1] = cell_ctrans->y[nodes[1]];
	(**to_cart)[2][1] = cell_ctrans->y[nodes[2]];
	(**to_cart)[3][1] = cell_ctrans->y[nodes[3]];
	(**to_cart)[0][2] = cell_ctrans->z[nodes[0]];
	(**to_cart)[1][2] = cell_ctrans->z[nodes[1]];
	(**to_cart)[2][2] = cell_ctrans->z[nodes[2]];
	(**to_cart)[3][2] = cell_ctrans->z[nodes[3]];
	(**to_cart)[0][3] = 1.0;
	(**to_cart)[1][3] = 1.0;
	(**to_cart)[2][3] = 1.0;
	(**to_cart)[3][3] = 1.0;

	/* invert to get to_bary transform */
	cell_ctrans->to_bary[cell] =		  /* allocate memory for transform */
	    *to_bary = (Mat44 *) malloc( sizeof(Mat44) );
	mat44_invert(**to_cart, **to_bary);	  /* to_bary is inverse of to_cart */
    }
    return(1);
}

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:50 */
/* End: */
