/* 	$Id: map_shapes.h,v 1.2 1995/04/12 19:25:30 npkonrad Exp $	 */
/*************************************************************************/
/*     This file is part of a particle advection package It provides */
/*     definitions for use by mapper.c and mapper.h which define the */
/*     shapes and topologies of the various shape mappings available */
/*     to the mapper module.  */
/*     The shapes currently defined are as follows: */
/*  MAPPER_SHAPE_SPHERE */
/*  MAPPER_SHAPE_CUBE	 */
/*  MAPPER_SHAPE_TETRA	 */
/*  MAPPER_SHAPE_TUBE	 */
/*  MAPPER_SHAPE_PLUS	 */
/*  MAPPER_SHAPE_ARROW	 */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211,                       */
/*  Date Created: Mon Mar 27 14:25:25 EST 1995 */

/*************************************************************************/


#ifndef MAP_SHAPES_H
#define MAP_SHAPES_H

/*********** Include files  ***********/
      
#include "mapper.h"

/*********** Constant Definitions ***********/

/*********** Data Definitions ***********/

/******* Shape topologies ******/
/* The following definitions give the topologies of the various shapes.  They are */
/* defined in terms of their polygons, and the polygons are defined in terms of the */
/* nodes of the shape as defined below.  The polygons are defined in AVS Geometry */
/* format: as a list of integers alternating between a polygon vertex count, and the */
/* vertex indices.  For example, in map_cube_topo, the cube is made up of 6 faces, */
/* each a polygon with 4 vertices.  The first 4 indicates 4 vertices in the first */
/* face, which are vertices 1, 2, 4 and 3. */

/* there is no topology for the sphere shape */
static int map_cube_sphere[] = {		  /* no sphere topology */
    0 };

static int map_cube_topo[] = {			  /* cube topology */
    4, 1, 2, 4, 3,
    4, 1, 3, 7, 5,
    4, 1, 5, 6, 2,
    4, 2, 6, 8, 4,
    4, 3, 4, 8, 7,
    4, 5, 7, 8, 6,
    0
};

static int map_tetra_topo[] = {			  /* tetra topology */
    3, 1, 2, 3,
    3, 1, 3, 4,
    3, 1, 4, 2,
    3, 2, 4, 3,
    0
};

static int map_tube_topo[] = {			  /* tube topology */
    4, 1, 2, 10, 9,
    4, 2, 3, 11, 10,
    4, 3, 4, 12, 11,
    4, 4, 5, 13, 12,
    4, 5, 6, 14, 13,
    4, 6, 7, 15, 14,
    4, 7, 8, 16, 15,
    4, 8, 1, 9, 16,
    8, 8, 7, 6, 5, 4, 3, 2, 1,
    8, 9, 10, 11, 12, 13, 14, 15, 16,
    0
};

static int map_plus_topo[] = {			  /* plus topology */
    3, 1, 2, 5,
    3, 1, 3, 2,
    3, 1, 4, 3,
    3, 1, 5, 4,
    3, 2, 3, 6,
    3, 2, 6, 10,
    3, 2, 9, 5,
    3, 2, 10, 9,
    3, 3, 4, 7,
    3, 3, 7, 10,
    3, 3, 10, 6,
    3, 4, 5, 8,
    3, 4, 8, 12,
    3, 4, 12, 7,
    3, 5, 9, 13,
    3, 5, 13, 8,
    3, 6, 11, 10,
    3, 7, 12, 11,
    3, 8, 13, 12,
    3, 9, 10, 13,
    3, 10, 11, 14,
    3, 10, 14, 13,
    3, 11, 12, 14,
    3, 12, 13, 14,
    0
};

static int map_arrow_topo[] = {			  /* arrow topology */
    3, 1, 2, 3,
    3, 1, 3, 4,
    3, 1, 4, 5,
    3, 1, 5, 6,
    3, 1, 6, 7,
    3, 1, 7, 8,
    3, 1, 8, 9,
    3, 1, 9, 2,
    4, 2, 9, 17, 10,
    4, 2, 10, 11, 3,
    4, 3, 11, 12, 4,
    4, 4, 12, 13, 5,
    4, 5, 13, 14, 6,
    4, 6, 14, 15, 7,
    4, 7, 15, 16, 8, 
    4, 8, 16, 17, 9,
    4, 10, 17, 25, 18,
    4, 10, 18, 19, 11,
    4, 11, 19, 20, 12,
    4, 12, 20, 21, 13,
    4, 13, 21, 22, 14,
    4, 14, 22, 23, 15,
    4, 15, 23, 24, 16,
    4, 16, 24, 25, 17,
    8, 25, 24, 23, 22, 21, 20, 19, 18,
    0
};

/***** the following define the node positions of the various shapes */
/* Each shape is defined inside a [-1,1] cube, so that uniform scaling values can be */
/* applied to any shape. Further, the "direction" of the shape is defined to be along */
/* the positive x-axis.  This direction will be considered the home direction for */
/* orientation mappings. */

static double map_sphere_nodes[][3] = {
    { 0.0, 0.0, 0.0 }
};

static double map_cube_nodes[][3] = {
    { -0.5, -0.5, -0.5 },
    { -0.5, -0.5, 0.5 },
    { -0.5, 0.5, -0.5 },
    { -0.5, 0.5, 0.5 },
    { 0.5, -0.5, -0.5 },
    { 0.5, -0.5, 0.5 },
    { 0.5, 0.5, -0.5 },
    { 0.5, 0.5, 0.5 }
};

static double map_tetra_nodes[][3] = {
    { 3*0.25, 0.0, 0.0 }, 
    { -0.25, -0.6124, -0.35355 },
    { -0.25, 0.6124, -0.35355 },
    { -0.25, 0.0, 2*0.35355 }
};

static double map_tube_nodes[][3] = {
    { 1, 0.5, 0.0 },
    { 1, 0.35355, 0.35355 },
    { 1, 0.0, 0.5 },
    { 1, -0.35355, 0.35355 },
    { 1, -0.5, 0.0 },
    { 1, -0.35355, -0.35355 },
    { 1, 0.0, -0.5 },
    { 1, 0.35355, -0.35355 },
    { -1, 0.5, 0.0 },
    { -1, 0.35355, 0.35355 },
    { -1, 0.0, 0.5 },
    { -1, -0.35355, 0.35355 },
    { -1, -0.5, 0.0 },
    { -1, -0.35355, -0.35355 },
    { -1, 0.0, -0.5 },
    { -1, 0.35355, -0.35355 }
};

static double map_plus_nodes[][3] = {
    { 1.0, 0.0, 0.0 },
    { 0.25, 0.25, 0.25 },
    { 0.25, 0.25, -0.25 },
    { 0.25, -0.25, -0.25 },
    { 0.25, -0.25, 0.25 },
    { 0.0, 1.0, 0.0 },
    { 0.0, 0.0, -1.0 },
    { 0.0, -1.0, 0.0 },
    { 0.0, 0.0, 1.0 },
    { -0.25, 0.25, 0.25 },
    { -0.25, 0.25, -0.25 },
    { -0.25, -0.25, -0.25 },
    { -0.25, -0.25, 0.25 },
    {-1.0, 0.0, 0.0 }
};

static double map_arrow_nodes[][3] = {
    { 1.0, 0.0, 0.0},
    { 0.0, 0.5, 0.0 },
    { 0.0, 0.3536, 0.3536 },
    { 0.0, 0.0, 0.5 },
    { 0.0, -0.3536, 0.3536 },
    { 0.0, -0.5, 0.0 },
    { 0.0, -0.3536, -0.3536 },
    { 0.0, 0.0, -0.5},
    { 0.0, 0.3536, -0.3536 },

    { 0.0, 0.25, 0.0 },
    { 0.0, 0.1768, 0.1768 },
    { 0.0, 0.0, 0.25 },
    { 0.0, -0.1768, 0.1768 },
    { 0.0, -0.25, 0.0 },
    { 0.0, -0.1768, -0.1768 },
    { 0.0, 0.0, -0.25},
    { 0.0, 0.1768, -0.1768 },

    { -1.0, 0.25, 0.0 },
    { -1.0, 0.1768, 0.1768 },
    { -1.0, 0.0, 0.25 },
    { -1.0, -0.1768, 0.1768 },
    { -1.0, -0.25, 0.0 },
    { -1.0, -0.1768, -0.1768 },
    { -1.0, 0.0, -0.25},
    { -1.0, 0.1768, -0.1768 }
};

/* the following arrays define attributes of each shape, the topology, */
/* the number of faces, etc..  Each array has entries for each shape, */
/* in the following order as defined in mapper.h: */
/*  MAPPER_SHAPE_SPHERE */
/*  MAPPER_SHAPE_CUBE	 */
/*  MAPPER_SHAPE_TETRA	 */
/*  MAPPER_SHAPE_TUBE	 */
/*  MAPPER_SHAPE_PLUS	 */
/*  MAPPER_SHAPE_ARROW	 */

static int *map_shape_topo[MAPPER_SHAPE_COUNT] = {
    NULL,
    map_cube_topo,
    map_tetra_topo,
    map_tube_topo,
    map_plus_topo,
    map_arrow_topo
};

static int map_shape_num_faces[MAPPER_SHAPE_COUNT] = {
    0, 6, 4, 10, 24, 25
};
#define MAP_MAX_FACES	(25)			  /* no shape has more than this many faces */

static double (*(map_shape_nodes[MAPPER_SHAPE_COUNT]))[3] = {
    map_sphere_nodes,
    map_cube_nodes,
    map_tetra_nodes,
    map_tube_nodes,
    map_plus_nodes,
    map_arrow_nodes
};

static int map_shape_num_nodes[MAPPER_SHAPE_COUNT] = {
    1, 8, 4, 16, 14, 25
};
#define MAP_MAX_VERTS	(25)			  /* no shape has more than this */
						  /* many vertices */

static char *map_shape_names[MAPPER_SHAPE_COUNT] = {
    "sphere",
    "cube",
    "tetra",
    "tube",
    "plus",
    "arrow"
};

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* End: */

#endif MAP_SHAPES_H




