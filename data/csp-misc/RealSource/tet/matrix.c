/* 	$Id: matrix.c,v 1.4 1995/03/15 16:50:39 npkonrad Exp $	 */

#ifndef lint
static char vcid[] = "$Id: matrix.c,v 1.4 1995/03/15 16:50:39 npkonrad Exp $";
#endif /* lint */
/*************************************************************************/
/*     This file is part of a matrix/vector package.  A 4x4 matrix data */
/* type and a 4x1 vector type are defined, and routines are included to */
/* copy, multiply, and invert 4x4 matrices, and to manipulate 4x1 */
/* vectors.  Vectors can be multiplied by matrices, and column vectors */
/* can be inserted or extracted from matrices.  The LU decomposition of a */
/* matrix can be taken, and used to solve linear systems, or to invert */
/* the matrix. */

/*     This file, matrix.c contains the code for supporting functions. */
/* Declarations and function prototypes are included in matrix.h. */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211 */
/*  Date Created: Thu Dec 15 13:27:35 EST 1994
/*************************************************************************/

#include "matrix.h"

/*********** Static Data ***********/

/*********** Function Definitions ***********/
      
/*************************************************************************/
/* void mat44_LUdecomp(Mat44 *A, Mat44LU *decomp) */
/*     This routine computes the LU decomposition of the given matrix */
/*     according to the algorithm given in "Numerical Recipes: The Art of */
/*     Scientific Computing" by Press, Flannery, Teukolsky and Vetterling, */
/*     c. 1986, Cambridge University Press, pp. 33-38.  The original routine, */
/*     given in a Fortran-like pseudocode has been translated to C.  It */
/*     implements Crout's algorithm with implicit partial pivoting.  The */
/*     routine returns the LU decomposition of a row permutation of the input */
/*     matrix, along with a vector which describes the permutation, and a */
/*     flag indicating the parity of the number of row swaps required to */
/*     reach this permutation. */
/*************************************************************************/
int mat44_LUdecomp(Mat44 A,
		      Mat44LU *decomp)
{
    /* local variables */
    double	row_scale[MATRIX_DIM];		  /* implicit row scaling */
    double	max_row_mag;

    int		i,j,k,pivot_i;			  /* loop counters */
    double	sum, temp;			  /* temporary doubles */
    double	pivot_mag, entry_mag;		  /* used for selecting pivots */

    decomp->row_swap = 1;			  /* init even/odd row swap toggle */

    for (i=0 ; i<MATRIX_DIM ; i++) {		  /* copy matrix to result */
	max_row_mag = 0;			  /* and find max in each row */
	for (j=0 ; j<MATRIX_DIM ; j++) {
	    decomp->lu[j][i] = (A)[j][i];
	    if (fabs(decomp->lu[j][i])>max_row_mag) {
		max_row_mag = fabs(decomp->lu[j][i]);
	    }
	}
	if (max_row_mag<EPSILON) {
	    AVSerror("Matrix is singular");
	    return(0);
	}
	row_scale[i] = 1.0/max_row_mag;
    }
    for (j=0 ; j<MATRIX_DIM ; j++) {		  /* For each column of the matrix */
	for (i=0 ; i<j ; i++) {			  /*    compute strictly upper triangular */
	    sum = decomp->lu[j][i];		  /*    part of column (beta_ij's, but not */
	    for (k=0 ; k<i ; k++) {		  /*    beta_ii's) */
		sum -= decomp->lu[k][i] * decomp->lu[j][k];
	    }
	    decomp->lu[j][i] = sum;
	}

	pivot_mag = 0.0;			  /*    compute the summation part for the lower */
	for (i=j ; i<MATRIX_DIM ; i++) {	  /*    and a_ii element */
	    sum = decomp->lu[j][i];
	    for (k=0 ; k<j ; k++) {
		sum -= decomp->lu[k][i] * decomp->lu[j][k];
	    }
	    decomp->lu[j][i] = sum;
	    entry_mag = row_scale[i] * fabs(sum);
	    if (entry_mag>pivot_mag) {		  /*    select one to be the pivot element */
		pivot_i = i;
		pivot_mag = entry_mag;
	    }
	}
	if (j!=pivot_i) {			  /*    if it's not the a_ii'th element, */
	    for (k=0; k<MATRIX_DIM ; k++) {	  /*       swap the pivot into position */
		temp = decomp->lu[k][pivot_i];
		decomp->lu[k][pivot_i] = decomp->lu[k][j];
		decomp->lu[k][j] = temp;
	    }
	    decomp->row_swap *= -1;		  /*       toggle the row_swap flag */
	    row_scale[pivot_i] = row_scale[j];	  /*       and update the row scale vector */
	}
	decomp->index[j] = pivot_i;		  /*    update the row permutation vector */
	if (j!=MATRIX_DIM-1) {			  /*    if we're not at the last row/column */
	    if (decomp->lu[j][j]<EPSILON) {	  /*        ensure pivot isn't zero */
		if (decomp->lu[j][j]>-EPSILON) {
		    if (decomp->lu[j][j]<0.0) {
			decomp->lu[j][j] = -EPSILON;
		    } else {
			decomp->lu[j][j] = EPSILON;
		    }
		}
	    }
	    temp = 1.0/decomp->lu[j][j];	  /*        divide the remainder of the column */
	    for (i=j+1 ; i<MATRIX_DIM ; i++) {	  /*        by the pivot */
		decomp->lu[j][i] *= temp;
	    }
	}
    }
    return(1);
}
		
/*************************************************************************/
/* int mat44_LUbacksub(&decomp, x) */

/* This routine computes the solution of a system of linear equations */
/* given the LU decomposition of the system matrix as returned by the */
/* mat44_LUdecomp function, and a right-hand side vector, x.  The result */
/* is returned in the same vector, x. */

/* The implementation is based on the same reference as for */
/* mat44_LUdecomp, pp. 36-38. */

/* Notes: */
/*      If the first ii-1 elements of b are zero, as is common when */
/* inverting a matrix, we have the following in the forward substitution */
/* case:                               */
/* 	|A00 0  | |X0| = |0 |                               */
/* 	|A10 A11| |X1|   |B1|                               */
/* Looking at the top half, X0 = 0, so in solving the bottom block, we */
/* can ignore A10 and just solve A11 X1 = B1.  The routine takes */
/* advantage of this by recording the index of the first non-zero entry */
/* in B in start_col. */
/*************************************************************************/
int mat44_LUbacksub(Mat44LU *decomp,
		  Vect4 x)
{
    int	i,j,start_col,swap;			  /* array indices */
    double	sum;

    start_col = -1;				  /* do the forward substitution: Ly = b */
    for (i=0 ; i<MATRIX_DIM ; i++) {		  /* for each row */
	swap = decomp->index[i];		  /*     take into account the permutation */
	sum = x[swap];
	x[swap] = x[i];
	if (start_col!=-1) {			  /*     if we've found first non-zero b[i] */
	    for (j=start_col ; j<i ; j++) {	  /*         do forward sub */
		sum -= decomp->lu[j][i]*x[j];
	    }
	} else if (sum!=0.0) {			  /*     else if this is first non-zero */
	    start_col = i;			  /*         record the column */
	}
	x[i] = sum;				  /*     save result */
    }
    for (i=MATRIX_DIM-1 ; i>=0 ; i--) {		  /* now do back substitution on each row */
	sum = x[i];
	if (i<MATRIX_DIM-1) {			  /*    for all but first iteration (last row)*/
	    for (j=i+1 ; j<MATRIX_DIM ; j++) {	  /*       accumulate the sum */
		sum -= decomp->lu[j][i]*x[j];
	    }
	}
	x[i] = sum/decomp->lu[i][i];		  /*    and divide by the diagonal element */
    }
    return(1);
}
	    
/*************************************************************************/
/* void mat44_invert(to_cart, to_bary); */

/*     This routine takes a 4x4 matrix, to_cart, and computes its inverse */
/*     which is returned in to_bary. */
/*************************************************************************/
int mat44_invert(Mat44 source,
		  Mat44 inverse)
{
    Mat44LU	sourceLU;			  /* temp for storing LU decomp */
    int		i,j;

    for (j=0 ; j<MATRIX_DIM ; j++) {		  /* first init inverse to identity */
	for (i=0 ; i<MATRIX_DIM ; i++) {
	    inverse[j][i] = 0.0;
	}
	inverse[j][j] = 1.0;
    }
    if (mat44_LUdecomp(source, &sourceLU)) {	  /* if can find the LU decomposition of source */
	for (j=0 ; j<MATRIX_DIM ; j++) {	  /*    for each column of identity */
	    mat44_LUbacksub(&sourceLU, inverse[j]); /*       do an in-place solve */
	}
	return(1);
    } else {					  /* else */
	return(0);				  /*    return error */
    }
}


/*************************************************************************/
/* void vect4_transform(A, x, b); */

/* This routine takes a vector and multiplies it by a matrix, returning */
/* the result. */

/*************************************************************************/
void vect4_transform(Mat44 A,
		     Vect4 x,
		     Vect4 b)
{
    int	i,j;

    for (i=0 ; i<MATRIX_DIM ; i++) {
	b[i] = A[0][i]*x[0];
	for (j=1 ; j<MATRIX_DIM ; j++) {
	    b[i] += A[j][i]*x[j];
	}
    }
}

/*************************************************************************/
/* void Mat44_mult(a,b,c); */
/*     This routine multiplies two matrices and returns the result. */
/*************************************************************************/
void mat44_mult(Mat44 a,
		Mat44 b,
		Mat44 c)
{
    int	i;

    /* do the multiplication columnwise and store the results */
    /* in the columns of c */
    for (i=0 ; i<MATRIX_DIM ; i++) {
	vect4_transform(a,b[i],c[i]);
    }
}

/*************************************************************************/
/* void AVSxfm2Mat44(Mat44 mat, float xfm[4][4]) */

/*     This routine copies an avs format transformation matrix (4x4) into */
/*     a Mat44 stucture. */

/*************************************************************************/

void AVSxfm2Mat44(Mat44 mat, float xfm[4][4])
{
    int	i,j;

    for (i=0; i<MATRIX_DIM; i++) {
	for (j=0; j<MATRIX_DIM; j++) {
	    mat[i][j] = xfm[i][j];
	}
    }
}

/*************************************************************************/
/* void Mat44Eye(Mat44 a) */

/*     Assigns a to be the identity matrix. */
/*************************************************************************/
void Mat44Eye(Mat44 a)
{
    int i,j;

    for (i=0 ; i<MATRIX_DIM ; i++) {
	for (j=0 ; j<MATRIX_DIM ; j++) {
	    a[j][i] = 0.0;
	}
	a[i][i] = 1.0;
    }
}
	
/*************************************************************************/
/* void Vect4Scale(Vect4 y, double a, Vect4 x) */
/*     Scales the input x by the scalar a and returns the result in y. */
/* void Vect4LinAccum(Vect4 y, double a, Vect4 x) */
/*     Adds the vector x scaled by a factor of a to the vector y, leaving */
/*     the result in y. */
/* double Vect4Norm3(Vect4 x) */
/*     assumes the input vector, x, contains an x,y,z triplet, and computes */
/*     it's Euclidean norm. */
/* void Vect4cross3(Vect4 axb, Vect4 a, Vect4 b) */
/*     Computes the cross product of the 3-space vectors in a and b */
/*************************************************************************/
void Vect4Scale(Vect4 y, double a, Vect4 x)
{
    y[0] = a*x[0];
    y[1] = a*x[1];
    y[2] = a*x[2];
    y[3] = a*x[3];
}

double Vect4Norm3(Vect4 x)
{
    return(sqrt(Vect4dot3(x,x)));
}


/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:50 */
/* End: */
