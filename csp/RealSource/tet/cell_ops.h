/* 	$Id: cell_ops.h,v 1.2 1995/06/26 17:56:40 npkonrad Exp $	 */
/*************************************************************************/
/*     This file is part of a particle advection package. It provides support */
/*     for cell operations, special functions which are called when a particle */
/*     enters a given cell.  */

/*     This file, cell_ops.h contains the definitions to accompany cell_ops.c */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211,                       */
/*  Date Created: Mon Feb 13 16:37:04 EST 1995  */
/*************************************************************************/

#ifndef CELL_OPS_H				  /* prevent multiple inclusions */
#define CELL_OPS_H

/*************************************************************************/
/* Cell operations can be defined for any cell in the mesh.  An array is defined */
/* containing a pointer for each cell in the mesh.  If it is non-null, it points */
/* to a list of cellFunc structures, each of which contains an operation id and */
/* a pointer to a data block which is to be used to store any data required by */
/* the operation. */
/* When a particle enters a new cell, the corresponding list can be checked, */
/* and if entries exist, they can be calculated. */
/*************************************************************************/

/*********** Include files  ***********/

#include <string.h>
#include <math.h>

#include <avs/ucd_defs.h>

#include "matrix.h"
#include "particle.h"

/*********** Constant Definitions ***********/

#define NO_FUNCTION	(0)		/* cell operation codes */
#define PARTICLE_SINK	(1)		/* defined by PARTICLE_SINK */
#define FACE_NORMAL	(2)		/* store normal vector for a face of this cell */

#define PARTICLE_SINK_LABEL	"PARTICLE_SINK"	/* component name used to identify */
					/* particle sink nodes */
#define SINK_NODE	(1)		/* flags used in SinkData type */
#define NON_SINK_NODE	(0)

#define MAX_LABEL_SIZE	(16)

/*********** Structure Definitions ***********/

/*** cell operation specific structures ***/

/** this type is for sink node cell operations **/
/* See the code for init_cell_ops and apply_cell_ops for an explanation of */
/* the various fields */
typedef struct sinkData {		/* for sink nodes */
    char flag;				/* flags non-sink nodes for this cell */
    Mat44 height;			/* height vectors of non-sink nodes */
					/* above sink element (vertex, plane, face) */
    double tol_sq;			/* square of the tolerence for this cell */
} SinkData;

/** This type stores the normal to a face in the mesh.  It is generally used to store */
/** normals for boundary faces, which are used to extract the normal velocity */
/** component from particles at the boundary. */
typedef struct faceNormalData {
    int face;
    Vect4 normal;
} FaceNormalData;

/*** general data types ***/

/* The CellFunc structure describes the function to be performed on the */
/* current cell.  It contains a function code (function) which identifies */
/* the function to be performed, a pointer to a data record which will be */
/* used to evaluate the function, and a pointer to another CellFunc */
/* structure, in case there is more than one function to be applied to */
/* particles in this cell. */

/* Possible Extensions: */
/*   - add a entry/exit flag, to indicate whether the function should */
/*     be called when the particle enters the cell or when it exits */
/*   - add a flag to indicate course of action after this function */
/*     has been performed, ie. if it's a particle sink, don't bother */
/*     performing any other cell functions which may follow this one. */
typedef struct cellFunc {
    int		function;
    union {
	SinkData	*sink;
	FaceNormalData	*face_normal;
	/* add other data pointers here */
    } data;
    struct cellFunc	*next;
} CellFunc;

/*********** Function Definitions ***********/
int init_cell_ops(UCD_structure *ucd_input, CellFunc ***cell_ops);

int apply_cell_op(ParticleInfo *particle, CellFunc *operation, Vect4 L);

double *get_cell_face_normal(int cell,
			     int face,
			     CellFunc **cell_ops,
			     UCD_structure *ucd_input);

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:40 */
/* End: */

#endif CELL_OPS_H

