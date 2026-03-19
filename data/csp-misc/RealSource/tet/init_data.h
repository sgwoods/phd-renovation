/* 	$Id: init_data.h,v 1.4 1995/06/26 18:08:20 npkonrad Exp $	 */
/*************************************************************************/
/*     This file is part of a particle advection package It provides */
/*     functions for initializing the simulation data and it's associated */
/*     component selection widgets */

/*     This file, init_data.h contains the definitions to accompany init_data.c */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211,                       */
/*  Date Created: Mon Feb  6 16:53:21 EST 1995 */
/*************************************************************************/

#ifndef INIT_DATA_H				  /* prevent multiple inclusions */
#define INIT_DATA_H

/*********** Include files  ***********/

#include <string.h>
      
#include <avs/avs.h>				  /* AVS stuff */
#include <avs/ucd_defs.h>

#include "cell_connect.h"
#include "cell_trans.h"
#include "cell_ops.h"

/*********** Constant Definitions ***********/
#define MAX_DATA_LABEL_SIZE	16

#define NO_SELECTION	(0)			  /* default selection to first one */
						  /* */
#define NO_OFFSET	(-1)			  /* used by get_selection_offset to */
						  /* indicate the selection is not */
						  /* present (this should be the same */
						  /* as NO_DATA_OFFSET as defined in */
						  /* mapper.h, but is defined here to */
						  /* prevent recursive includes */

#define RELATIVE_GLOBAL_SCALE	(0.08)		  /* This value is multiplied by the */
						  /* size of a bounding box for the */
						  /* problem domain to get the */
						  /* global_scale. Particle shapes */
						  /* are defined within a [-1,1] box */
						  /* and are multiplied by */
						  /* global_scale before being */
						  /* positioned.  */

#define SELECT_1DIM	(0x01)			  /* flags indicating allowable */
#define SELECT_2DIM	(0x02)			  /* component sizes for the current */
#define SELECT_3DIM	(0x04)			  /* data selector */ 
#define SELECT_ALL	(SELECT_1DIM | SELECT_2DIM | SELECT_3DIM)

/*********** Structure Definitions ***********/

/* What is a DataSelection?  */
/* A data selection structure contains information about the data fields of a given */
/* data set (ie. AVS UCD stucture).  This includes mainly names of various components */
/* of the node data vector and their locations in the vector, but also includes a */
/* "current" component pointer.  This allows for convenient access to the various */
/* fields based on their names during computation, and also for maintaining user */
/* interface components.  A DataSelection may be initialized to contain only */
/* components of a given size (scalar, vector) and specific data fields may be */
/* specifically excluded from a selection if desired.  initialization functions are */
/* provided to this purpose */

typedef struct dataSelection {
    int	count;					  /* number of available selections */
    int current;				  /* the current selection */
    int *index;					  /* for each selection, lists the */
						  /* location of the first dimension */
						  /* of the component */ 
    char **label;				  /* list of pointers to labels for */
						  /* selections each pointer points */
						  /* into label_string, or to a */
						  /* string constant */ 
    char *label_string;				  /* original label string, saved */
						  /* here so it can be deallocated */
						  /* later */ 
    char *choice_labels;			  /* a string of labels corresponding */
						  /* to the choices allowed by the */
						  /* current state of the selection, */
						  /* which can be used to initialize */
						  /* an AVS choice widget */
    char *delim;				  /* the delimiter used in */
						  /* choice_labels  */
} DataSelection;

/*********** Function Definitions ***********/
int init_cell_data(UCD_structure *ucd_input,
		   DataSelection *advect_sel,
		   DataSelection *scalar_sel,
		   CellNeighbours **cell_connect,
		   CellTransforms **cell_ctrans,
		   CellFunc	***cell_ops,
		   double *global_scale);

void init_selection(UCD_structure *ucd_input,
			   int select_flags,
			   char *exclude,
			   DataSelection *selection);

void initDataSelection(DataSelection *selection);

void allocDataSelection(DataSelection *selection, int size);

void freeDataSelection(DataSelection *selection);

void setDataWidget(DataSelection *selection,
		   char* data_widget);

void setDataSelection(int choice, DataSelection *selection);

int get_selection_offset(DataSelection *selection,
			 char *label);

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* End: */

#endif INIT_DATA_H
