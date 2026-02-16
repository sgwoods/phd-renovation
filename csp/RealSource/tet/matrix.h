/* 	$Id: matrix.h,v 1.5 1995/04/12 19:43:07 npkonrad Exp $	 */
/*************************************************************************/
/*     This file is part of a matrix/vector package.  A 4x4 matrix data */
/* type and a 4x1 vector type are defined, and routines are included to */
/* copy, multiply, and invert 4x4 matrices, and to manipulate 4x1 */
/* vectors.  Vectors can be multiplied by matrices, and column vectors */
/* can be inserted or extracted from matrices.  The LU decomposition of a */
/* matrix can be taken, and used to solve linear systems, or to invert */
/* the matrix. */

/*     This file, matrix.h, contains the data declarations, constants */
/*     and function prototypes.  code is included in matrix.c */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211,                       */
/*  Date Created: Thu Dec 15 13:27:35 EST 1994
/*************************************************************************/

/* wrapper to prevent multiple definitions */
#ifndef MATRIX_H
#define MATRIX_H

/*********** Include files ***********/
#include <math.h>

/*********** Define Constants ***********/

#define MATRIX_DIM	4
#define EPSILON		1.0E-10

/*********** Data definitions ***********/

/* The main data types for this package are Vector4, a 4 element vector, */
/* and Matrix44, a 4x4 doubly subscripted array.  Note that Matrix44 is */
/* defined as an array of 4 Vector4's, so that indices for a Matrix44 are */
/* given in an order reverse of the usual (ie. column first, then row). */
/* This allows whole columns to be addressed as entities, speeding up */
/* vector manipulation operations somewhat. */

typedef double	Vect4[MATRIX_DIM];		  /* a 4 element vector */

typedef	Vect4	Mat44[MATRIX_DIM];		  /* 4x4 matrix to hold transformations */

typedef struct {
    Mat44	lu;				  /* decomposition, with implicit */
						  /* lower unit diagonal */
    int		index[MATRIX_DIM];		  /* row permutation indices */
    int		row_swap;			  /* even/odd number of row swaps flag */
} Mat44LU;

/*********** Macro Definitions ***********/

/******************************/
/* The following is a set of macro definitions used to manipulate */
/* the Vect4 vector type.  Definitions ending in "3" only deal */
/* with the first three elements (x,y,z).  The fourth element is */
/* ignored. */
/******************************/

/* read a node coordinate vector from an AVS coordinate list */
#define Vect4readAVSnode(dest, node, Ix, Iy, Iz) \
	(dest)[0] = (Ix)[node]; \
	(dest)[1] = (Iy)[node]; \
	(dest)[2] = (Iz)[node]

/* compute the difference of two vectors */
#define Vect4diff3(a_b, a, b)  \
	(a_b)[0] = ((a)[0] - (b)[0]); \
	(a_b)[1] = ((a)[1] - (b)[1]); \
	(a_b)[2] = ((a)[2] - (b)[2])

/* compute the dot product of two vectors */
#define Vect4dot3(x, y) \
    ((x)[0]*(y)[0]+(x)[1]*(y)[1]+(x)[2]*(y)[2])
#define Vect4dot4(x, y) \
    ((x)[0]*(y)[0]+(x)[1]*(y)[1]+(x)[2]*(y)[2]+(x)[3]*(y)[3])

/* compute the cross product of two vectors */
#define Vect4cross3(axb, a, b) \
    ((axb)[0] = (a)[1]*(b)[2] - (a)[2]*(b)[1]); \
    ((axb)[1] = (a)[2]*(b)[0] - (a)[0]*(b)[2]); \
    ((axb)[2] = (a)[0]*(b)[1] - (a)[1]*(b)[0])

/* copy one vector into another (a to b) */
#define Vect4copy(b, a) \
    ((b)[0] = (a)[0]); \
    ((b)[1] = (a)[1]); \
    ((b)[2] = (a)[2]); \
    ((b)[3] = (a)[3])

/* Add a scalar times a vector to another vector */
/* ie. y = y+a*x */
#define Vect4LinAccum3(y, a, x) \
    (y)[0] += (a)*(x)[0]; \
    (y)[1] += (a)*(x)[1]; \
    (y)[2] += (a)*(x)[2]

/* multiply a vector by a scaling factor */
/* ie. y = a*x */
#define Vect4Scale3(y, a, x) \
    (y)[0] = (a)*(x)[0]; \
    (y)[1] = (a)*(x)[1]; \
    (y)[2] = (a)*(x)[2]

/*********** Function Prototypes ***********/

int mat44_LUdecomp(Mat44 A,
		      Mat44LU *decomp);

int mat44_LUbacksub(Mat44LU *decomp,
		  Vect4 x);

int mat44_invert(Mat44 source,
		  Mat44 inverse);

void vect4_transform(Mat44 A,
		     Vect4 x,
		     Vect4 b);

void mat44_mult(Mat44 a,
		Mat44 b,
		Mat44 c);

void AVSxfm2Mat44(Mat44 mat,
		  float xfm[4][4]);

void Mat44Eye(Mat44 a);

void Vect4Scale(Vect4 y, double a, Vect4 x);

double Vect4Norm3(Vect4 x);

/* Set up local variables to compile for the current host */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:50 */
/* End: */
#endif
