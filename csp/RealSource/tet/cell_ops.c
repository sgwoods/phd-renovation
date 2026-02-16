/* 	$Id: cell_ops.c,v 1.3 1995/06/26 17:38:55 npkonrad Exp $	 */

#ifndef lint
static char vcid[] = "$Id: cell_ops.c,v 1.3 1995/06/26 17:38:55 npkonrad Exp $";
#endif /* lint */
/*************************************************************************/
/*     This file is part of a particle advection package. It provides support */
/*     for cell operations, special functions which are called when a particle */
/*     enters a given cell.  */

/*     This file, cell_ops.c contains the code to support the functions */
/*     declared in cell_ops.h */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211,                       */
/*  Date Created: Mon Feb 13 16:37:04 EST 1995  */
/*************************************************************************/

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

#include "cell_ops.h"

/*********** Function Definitions ***********/

/*************************************************************************/
/* int init_cell_ops(UCDstructure *ucd_input, CellFunc ***cell_ops) */

/*     This function takes an input ucd and examines its data to see if any */
/*     special cell operations are defined.  If so, a cell_ops array is created */
/*     with a pointer for each cell in the mesh.  The array is initialized */
/*     with the appropriate structures, so that the appropriate functions will */
/*     be called when a particle enters the related cell. */

/*     The PARTICLE_SINK function takes four forms, depending on how many of */
/*     the nodes of the cell are designated to be SINK nodes, as follows: */
/*       - one node: (POINT_SINK) any particle within the given tolerance */
/*                   of the node will be removed */
/*       - two nodes: (LINE_SINK) any particle within the tolerance of the */
/*                    edge formed by the two nodes is removed.  The tolerance */
/*                    used is the arithmetic average of the two node tolerances */
/*       - three nodes: (FACE_SINK) particles within tolerance of the face formed */
/*                    by the three nodes are removed.  Tolerance is the mean of */
/*                    the three tolerances */
/*       - four nodes: (CELL_SINK) Any particle entering this cell is removed */
/*************************************************************************/
int init_cell_ops(UCD_structure *ucd_input, CellFunc ***cell_ops)
{
    char	Iname[80];			  /* params for ucd_input ucd */
    int		Idata_veclen, Iname_flag, Incells, Icell_veclen;
    int		Innodes, Inode_veclen, Iutil_flag;

    int		elem_id, mat_id, cell_type, me_flags; /* cell parameters */
    char	int_cell_name;
    int		*nodes;
    
    float	*Ix, *Iy, *Iz;			  /* node position vectors */

    
    int		*Inode_components, Inode_comp_count;
    char	*Inode_labels, Idelim[8];
    float	*Inode_data;
    char	*comp_label;	        /* label for the current component */
    int		sink_comp;	        /* component number for sink component */
    int		sink_offset;	        /* location of sink component in node */
				        /* data vector */

    int		cell;			/* current cell */
    int		local_node;		/* counts through cell nodes */
    int		sink_count;	        /* number of sinks in current cell */
    char	sink_flag;		/* sink/non-sink 1 bit per node */
    double	this_tol;		/* tolerance of current node */
    double	tolerance;		/* used to compute tolerance for cell */
    double	*node;			/* pointer to current node vector */
    double	*vector[4];		/* a list of pointers to vectors used */
					/* to initialize sink cell data */
    CellFunc	*operation;		/* pointer to a cell operation */

    /* get the parameters of the input mesh */
    /*   it's assumed that the mesh is homogenous (all one cell type) */
    /*   for the purposes of allocating memory for the output mesh */
    if (!UCDstructure_get_header (ucd_input, Iname, &Idata_veclen, &Iname_flag,
				  &Incells, &Icell_veclen, &Innodes,
				  &Inode_veclen, &Iutil_flag)) {
	AVSerror ("tetravect: can't get data header.\n");
	return;
    }
    /* get the data component sizes */
    if (!UCDstructure_get_node_components ( ucd_input, &Inode_components)) {
	AVSerror ("tetravect: can't get data node components.\n");
	exit(1);
    }

    /* and allocate memory for labels */
    Inode_labels = (char *) malloc(Inode_veclen * MAX_LABEL_SIZE * sizeof(char));
    
    /* get data labels */
    if (!UCDstructure_get_node_labels(ucd_input,Inode_labels,Idelim)) {
	AVSerror ("tetravect: can't get data node labels.\n");
	exit(1);
    }
    comp_label = strtok(Inode_labels, Idelim);	  /* get the first label */
    sink_comp = 0;				  /* find particle sink field */
    sink_offset = 0;				  /* and offset in data vector */
    while ((comp_label!=NULL) &&		  /* if there is one */
	   (strcmp(comp_label, PARTICLE_SINK_LABEL)!=0)) {
	comp_label = strtok(NULL, Idelim);	  /*    go to next component */
	sink_offset += Inode_components[sink_comp];
	sink_comp++;
    }

    /* clear away any previosly allocated memory */
    if (*cell_ops!=NULL) {
	AVSerror("init_cell_ops: memory leak");
	/* if cell_ops was previously allocated, I can't deallocate */
	/* the actual CellFunc's here, because I don't know how many */
	/* cells were in the previous structure */
	free(*cell_ops);
	*cell_ops = NULL;
    }
    /* allocate some memory for the cell_ops list */
    *cell_ops = (CellFunc **) malloc(Incells*sizeof(CellFunc *));
    /* and initialize it to no ops at all */
    for (cell = 0 ; cell < Incells ; cell++) {
	(*cell_ops)[cell] = NULL;
    }

    if (comp_label!=NULL) {			  /* if found SINK component */
	/* get the data for node postions */
	UCDstructure_get_node_positions (ucd_input, &Ix, &Iy, &Iz);

	/* get the actual data vectors for nodes */
	UCDstructure_get_node_data (ucd_input, &Inode_data);

	for (cell=1; cell<=Incells ; cell++) {	  /* for each cell */
	    UCDcell_get_information (ucd_input,	  /*    get cell info  */
				     cell, (char *) &elem_id,
				     &int_cell_name,
				     &mat_id, &cell_type,
				     &me_flags, &nodes);
	    /* node indices are given in: nodes[i] */

	    /* count the sink nodes for this cell */
	    sink_count = 0;			  /*    start with no sinks */
	    sink_flag = 0;			  /*    ditto */
	    this_tol = tolerance = 0.0;
						  /*    for each node in cell */
	    for (local_node = 0; local_node<4 ; local_node++) {
		this_tol =			  /*       get tolerance */
		    Inode_data[Innodes*sink_offset + nodes[local_node]];
		sink_flag <<= 1;		  /*       shift flag left */
		if (this_tol>0.0) {		  /*       if it's a sink */
		    sink_count++;		  /*         count it */
		    sink_flag |= 0x01;		  /*         set the sink bit */
		    tolerance += this_tol;	  /*         and add tolerance */
		}
	    }
	    /* set up a cell function for this node if there are SINK nodes */
	    if ((sink_count>0) &&		  /* if there are sink nodes */
		(sink_count<5)) {
		tolerance /= sink_count;	  /*    take average tolerance */

		/* allocate a cell_op node */
		operation = (CellFunc *) malloc(sizeof(CellFunc));
		operation->data.sink = (SinkData *) malloc(sizeof(SinkData));
		operation->function = PARTICLE_SINK;
		operation->data.sink->flag = sink_flag;
		operation->data.sink->tol_sq = tolerance*tolerance;

		/* now get the actual node positions from the UCD, and create */
		/* a list of node vectors with the sinks at the beginning, */
		/* and the non-sinks at the end */
		sink_count = 0;
		for (local_node=0 ; local_node<4 ; local_node++) {
		    node = operation->data.sink->height[local_node];
		    Vect4readAVSnode(node, nodes[local_node], Ix, Iy, Iz); 
		    if ((sink_flag & 0x08)!=0) {  /*    if it's a sink */
			vector[sink_count] = node; /*      put at beginning */
			sink_count ++;
		    } else {			  /*    else */
						  /*       put at the end */
			vector[3 - local_node + sink_count] = node;
		    }
		    sink_flag <<= 1;		  /*    shift the sink flag */
						  /*    so we're looking at the */
						  /*    next bit */
		}
		
		/* now compute the edge vectors from the first sink to the */
		/* other nodes */
		Vect4diff3(vector[1], vector[1], vector[0]);
		Vect4diff3(vector[2], vector[2], vector[0]);
		Vect4diff3(vector[3], vector[3], vector[0]);

		/* and initialize based on number of sinks */
		switch (sink_count) {
		case 1:				  /* point sink case */
		    /* we're done already (the appropriate height entries */
		    /* contain vectors from the sink node to the non-sink */
		    /* nodes). */
		    break;
		case 2:				  /* line sink case */
		    /* v1 is our sink edge vector.  v2 goes from the */
		    /* first sink node to the first non-sink node. */
		    /* Subtract the projection of v2 onto v1 from v2 to */
		    /* get the perpendicular vector from v1 to the first */
		    /* non-sink.  Do the same for the second non-sink */
		    /* node. */
		    Vect4LinAccum3(vector[2],
				   -Vect4dot3(vector[1], vector[2]) /
				      Vect4dot3(vector[1],vector[1]),
				   vector[1]);
		    Vect4LinAccum3(vector[3],
				   -Vect4dot3(vector[1], vector[3]) /
				      Vect4dot3(vector[1],vector[1]),
				   vector[1]);
		    break;
		case 3:
		    /* v1 and v2 are edges of the sink face.  v1xv2 is */
		    /* normal to the sink face.  v3 goes from the first */
		    /* sink node to the non-sink node.  The projection of */
		    /* v3 onto v1xv2 is the normal vector from the face to */
		    /* the non-sink node */
		    Vect4cross3(vector[0],	  /* use v0 for scratch */
				vector[1],
				vector[2]);
		    Vect4Scale3(vector[3],
				Vect4dot3(vector[0], vector[3]) /
				    Vect4dot3(vector[0], vector[0]),
				vector[0]);
		    break;
		case 4:
		    operation->function = PARTICLE_SINK;
		    /* TODO */
		    break;
		}
		/* add the operation to the current cell operation list */
		operation->next = (*cell_ops)[cell];
		(*cell_ops)[cell] = operation;
	    }
	}
    }
    
    /*** Add code for other cell functions here ***/
    /* free any memory allocated in this routine */
    free(Inode_labels);
}

/*************************************************************************/
/* int apply_cell_op(ParticleInfo *particle, CellFunc *operation)  */
/*   The apply_cell_op function takes a pointer to a particle record, */
/*   a pointer to a cell function record, and the barycentric coordinates */
/*   of the particle and applies the operation to the particle. */
/* Computation of sink function: */
/*     The height of each non-sink node above the sink element (point, */
/*     edge or node) is pre-computed and stored in the corresponding */
/*     column of height in the operation data field.  A linear */
/*     combination of these heights is taken based on the barycentric */
/*     coordinate corresponding to the non-sink node.  This is the */
/*     perpendicular vector from the sink element to the particle */
/*     position.  The length of this vector is compared with the */
/*     tolerance to determine if the particle should be removed. */
/*     See Design documentation for more explanation. */
/*************************************************************************/
int apply_cell_op(ParticleInfo *particle, CellFunc *operation, Vect4 L)
{
    double	d_sq;
    int		j;
    Vect4	h;
    char	sink_flag;

    while (operation!=NULL) {			  /* for each operation on this cell */
	switch (operation->function) {
	case PARTICLE_SINK:
	    h[0] = h[1] = h[2] = 0;		  /* init height to zero */
	    sink_flag = operation->data.sink->flag; /* get sink flag */
	    for (j=0 ; j<4 ; j++) {		  /* for each node in the cell */
		if ((sink_flag & 0x08)==0) {	
		    Vect4LinAccum3(h,L[j], operation->data.sink->height[j]);
		}
		sink_flag <<=1;			  /*    shift the sink flag so we're */
						  /*    looking at the next flag bit */
	    }
	    d_sq = Vect4dot3(h,h);

	    if (d_sq<operation->data.sink->tol_sq) { /* if particle within tol of */
		particle->state = DEAD_PARTICLE;  /* vertex, kill it */
	    }
	    break;
	case FACE_NORMAL:
	    /* don't do anything, */
	    /*  just store the data to be used by get_face_normal */
	    break;
	case NO_FUNCTION:
	default:
	    /* don't do anything */
	    break;
	}
	operation = operation->next;		  /* advance to the next op */
    }
}

/************************************************************/
/* double *get_cell_face_normal(int cell, */
/* 			 int face, */
/* 			 CellFunc **cell_ops, */
/* 			 UCD_structure *ucd_input); */

/* This function retrieves a normal vector for the requested face of the given */
/* cell. This normal is guaranteed to face outward from the cell.  The routine */
/* operates on a "compute on demand" principle, storing its result in the */
/* appropriate cell_ops entry, so that it only need be computed once.  It first looks */
/* in cell_ops to see if the required normal is present, and returns it if it is.  If */
/* not, the normal is computed from information in ucd_input, and is stored in */
/* cell_ops before returning. A pointer to the beginning of the vector is returned */

/************************************************************/
double *get_cell_face_normal(int cell,
			     int face,
			     CellFunc **cell_ops,
			     UCD_structure *ucd_input)
{
    int		elem_id, mat_id, cell_type, me_flags; /* cell parameters */
    char	int_cell_name;
    int		*nodes;
    float	*Ix, *Iy, *Iz;			  /* node position vectors */

    int		local_node;		/* counts through cell nodes */
    int		face_node;
    Mat44	vector;			/* temporary vectors */
    double	inv_norm;

    CellFunc	*op;
    
    op = cell_ops[cell];			  /* see if face normal is present */
    while ((op!=NULL) &&			  /*    in cell_ops, */
	   ((op->function!=FACE_NORMAL) ||
	    (op->data.face_normal->face!=face))) {
	op = op->next;
    }
    if (op==NULL) {				  /* if it's not there, compute it */
	/* get the data for node postions */
	UCDstructure_get_node_positions (ucd_input, &Ix, &Iy, &Iz);
	/*    get cell info  */
	UCDcell_get_information (ucd_input,
				 cell, (char *) &elem_id,
				 &int_cell_name,
				 &mat_id, &cell_type,
				 &me_flags, &nodes);
	/* allocate a cell_op node */
	op = (CellFunc *) malloc(sizeof(CellFunc));
	op->function = FACE_NORMAL;
	op->data.face_normal =
	    (FaceNormalData *) malloc(sizeof(FaceNormalData));
	op->data.face_normal->face = face;

	/* copy the face vertices into local vectors */
	face_node = 0;
	for (local_node=0 ; local_node<4 ; local_node++) {
	    if (local_node!=face) {
		Vect4readAVSnode(vector[face_node],
				 nodes[local_node],
				 Ix, Iy, Iz); 
		face_node ++;
	    } else {
		Vect4readAVSnode(vector[3],
				 nodes[local_node],
				 Ix, Iy, Iz);
	    }
	}
		
	/* compute the edge vectors on the face */
	/* v1 contains p0p1 and v2 contains p0p2 */
	Vect4diff3(vector[1], vector[1], vector[0]);
	Vect4diff3(vector[2], vector[2], vector[0]);
	Vect4diff3(vector[3], vector[3], vector[0]);

	/* place the cross product of v1 and v2 into v0 */
	Vect4cross3(vector[0], vector[1], vector[2]);
	inv_norm = 1.0 / sqrt(Vect4dot3(vector[0], vector[0]));
	if (Vect4dot3(vector[0], vector[3])<0.0) {
	    inv_norm *= -1.0;
	}

	/* normalize it and place it in cell_ops */
	Vect4Scale3( op->data.face_normal->normal,
		     inv_norm, vector[0]);

	/* add the op to the current cell op list */
	op->next = cell_ops[cell];
	cell_ops[cell] = op;
    }
    return(op->data.face_normal->normal);  /*    return that normal */
}

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:50 */
/* End: */


