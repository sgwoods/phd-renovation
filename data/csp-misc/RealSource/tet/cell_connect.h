/* 	$Id: cell_connect.h,v 1.3 1995/02/01 16:05:49 npkonrad Exp $	 */
/*************************************************************************/
/* This file contains declarations for code which produces a */
/* cell_to_node list.  It assumes data in the AVS ucd format, and was */
/* written to be used with the tetravect AVS module. */

/* The code resides in the file cell_connect.h */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211 */
/* Date Created: Fri Dec  9 10:34:45 EST 1994 */
/*************************************************************************/

#ifndef CELL_CONNECT_H		/* prevent multiple inclusions of this file */
#define CELL_CONNECT_H

/*********** Include files ***********/

#include <stdio.h>		/* system stuff */

#include <avs/avs.h>		/* AVS stuff */
#include <avs/port.h>
#include <avs/field.h>
#include <avs/ucd_defs.h>

/*********** Define Constants ***********/

/*********** Macro Definitions ***********/

/* FACE_INDEX - given the indices of three nodes of a tetrahedron, this */
/* macro returns the index of the fourth.  It is assumed that the nodes */
/* are indexed with integers [0..3].  The fourth node index is the same */
/* as the face index for the face defined by the other three nodes. */
#define FACE_INDEX(n1,n2,n3)	(6-((n1)+(n2)+(n3)))

/*********** structure Definitions ***********/

/* The node_to_cell list will be implemented as an array of 4*ncells */
/* entries each containing a cell index and a "next" pointer.  Entries 0 */
/* to nnodes-1 contain cell indices for nodes with corresponding indices, */
/* and the "next" pointer is the index of the next additional entry for */
/* that node.  If the next pointer is -1, there are no more incident */
/* cells. */

typedef struct {				  /* entry in node_to_cell list */
    int	cell;					  /* which cell */
    int cell_node;				  /* which node of this cell is it */
    int	next;					  /* where to find the next neighbour cell */
} NodeToCellEntry;

/* The cell_to_node list simply holds the node indices for each cell */
/* These can be retrieved from theh UCD structure, but to do so requires a call */
/* to an AVS function.  To save many such calls, cell_to_node is built by calling */
/* the function once for each cell at the beginning. The first index is the cell */
/* number, and the second is the node number for that cell.  The entry contains */
/* the node index from the node list. */

typedef int	CellToNodeEntry[4];		  /* contains one index for each node */

typedef int	CellNeighbours[4];		  /* list of adjacent cells */
						  /* -1 indicates no neighbour */
						  /* index i contains cell index of */
						  /* cell opposite ith node of this cell */

/*********** Function Prototypes ***********/

void generate_cell_conn(UCD_structure *ucd_input,
			int ncells,
			int nnodes,
			CellNeighbours **cell_connect);

int get_cell_node_lists(UCD_structure *ucd_input,
			int ncells,
			int nnodes,
			NodeToCellEntry **node2cell,
			CellToNodeEntry	**cell2node);

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:50 */
/* End: */

#endif CELL_CONNECT_H
