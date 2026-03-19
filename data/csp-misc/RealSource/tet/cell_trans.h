/* 	$Id: cell_trans.h,v 1.3 1995/02/01 16:06:43 npkonrad Exp $	 */
/*************************************************************************/
/* This file contains declarations for the CellTransforms structure.  It */
/* provides a facility to compute and store transformation matrices between */
/* cartesian and barycentric coordinates for cells in an unstructured, */
/* tetrahedral mesh.  It is designed to be used with AVS UCD data structures. */
/* Functions for accessing, initializing, generating etc. are found in */
/* cell_trans.c and are summarized here: */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211 */
/*  Date Created: Tue Dec  6 10:10:02 EST 1994 */
/*************************************************************************/

#ifndef CELL_TRANS_H		/* prevent multiple inclusions of this file */
#define CELL_TRANS_H

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

/*********** Include files ***********/

#include <stdio.h>		/* system stuff */

#include <avs/avs.h>		/* AVS stuff */
#include <avs/port.h>
#include <avs/field.h>
#include <avs/ucd_defs.h>

#include "matrix.h"		/* local stuff */

/*********** Define Constants ***********/

/*********** Structure Definitions ***********/
typedef struct cellTransforms {
    UCD_structure	*ucd_input;		  /* original UCD structure */
    float		*x, *y, *z;		  /* vertex coordinate lists */
    int			ncells;			  /* number of cells */
    Mat44		**to_bary,		  /* transformation to barycentric coords */
			**to_cart;		  /* transformation to Cartesian coords */
} CellTransforms;

/*********** function prototypes ***********/

int    init_cell_trans(UCD_structure *ucd_input,
		       int	Incells,
		       float	*Ix,
		       float	*Iy,
		       float	*Iz,
		       CellTransforms **cell_ctrans);

int	destroy_cell_trans(CellTransforms **cell_ctrans);

int	get_cell_trans(CellTransforms *cell_ctrans,
		       int cell,
		       Mat44 **to_cart,
		       Mat44 **to_bary);

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:50 */
/* End: */

#endif CELL_TRANS_H
