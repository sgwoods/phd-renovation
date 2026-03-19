/* 	$Id: cell_connect.c,v 1.3 1995/02/01 16:05:30 npkonrad Exp $	 */

#ifndef lint
static char vcid[] = "$Id: cell_connect.c,v 1.3 1995/02/01 16:05:30 npkonrad Exp $";
#endif /* lint */
/*************************************************************************/
/* This file contains code for generating a cell neighbour list given a */
/* cell_to_node list.  It assumes data in the AVS ucd format, and was */
/* written to be used with the tetravect AVS module. */

/* The function prototypes, defines and data type declarations reside in */
/* cell_connect.h */

/* Author: Nathan P. Konrad,DC3129,x4468,519-885-1211,                   */
/* Date Created: Fri Dec  9 10:34:45 EST 1994 */
/*************************************************************************/

/*************************************************************************/
/* Algorithm description: */

/* We are given a list of nodes for each cell, and require a list of */
/* neighbour cells for each cell (those cells which share a face with any */
/* given cell). */

/* First, a node_to_cell list is constructed, which contains, for each */
/* node, a list of incident cells.  This list is traversed, node by node, */
/* and for each node the cells are examined pairwise to see if they share */
/* a second and third node.  If so, they are neighbours and are added to the */
/* cell_neighbour list. */

/* We avoid finding each pair twice by only looking at second nodes whose */
/* indices are greater than the current central node (see code). */
/*************************************************************************/

#include "cell_connect.h"

/***********************************************************************************
* void generate_cell_conn(ucd_input, ncells, nnodes, &cell_connect)
*   Generates the cell connectivity list for the given input ucd.  It also returns
*   an error if it encounters a non-tetrahedral cell.
*   The cell connectivity list is allocated in this routine.
***********************************************************************************/
void generate_cell_conn(UCD_structure *ucd_input,
			int ncells,
			int nnodes,
			CellNeighbours **cell_connect)
{
    int i, j, node1, node2, node3;

    int face_count;				  /* counts the faces in cell1 incident on a node1 */
						  /* whose other nodes have not yet been examined. */
    struct {					  /* face is a list of these faces. */
	int n2,n3;				  /* together with node1, n2 and n3 define the face */
	int index;				  /* the index within cell1 of the face */
    }	face[3];				  /* up to 3 such faces will be incident on node1 */

    int cell1_index, cell1;			  /* indices into node_to_cell list and */
    int cell2_index, cell2;			  /* UCD cell list respectively */
    CellNeighbours *conn_list;			  /* local var for connection list */
    NodeToCellEntry	*node_to_cell;		  /* the node_to_cell list */
    CellToNodeEntry	*cell_to_node;

    int match2, match3, i2, i3;			  /* temp vars for comparing faces */
    int	face_index1, face_index2;		  /* face between cell1 and cell2 is */
						  /* face_index1 for cell1 and face_index2 for cell2 */

    /* first allocate the required memory */
    if ((*cell_connect)!=NULL) {		  /* deallocate previously allocated */
	free(*cell_connect);
    }
    conn_list =					  /* allocate the connectivity list */
    *cell_connect = (CellNeighbours *) malloc(ncells*sizeof(CellNeighbours));
    for (cell1=0 ; cell1<ncells ; cell1++) {
	for (node1=0 ; node1<4 ; node1++) {
	    conn_list[cell1][node1] = -1;		  /* initialize list to no neighbours */
	}
    }

    /* get the node to cell and cell to node relationships from the ucd */
    get_cell_node_lists(ucd_input, ncells, nnodes, &node_to_cell, &cell_to_node);

    for (node1=0 ; node1<nnodes ; node1++) {	  /* for each node, node1 */
	AVSmodule_status("Cell connectivity", (100*node1)/nnodes);
	if (node_to_cell[node1].cell!=-1) {	  /*    if there are more than one cell */
	    cell1_index = node1;		  /*       get beginning of cell list for node1 */
	    while (node_to_cell[cell1_index].next>0 ) {	/* for each cell, cell1, incident on node1 */
		cell1 = node_to_cell[cell1_index].cell;	/*   (up to the next-to-last) */
		face_count = 0;			  /*          enumerate faces in cell1 at node1*/
						  /*           with nodes that haven't been looked at yet */
		for (i=0; i<3 ; i++) {		  /*          for each other node in cell1 */
		    if (cell_to_node[cell1][i]>node1) {	/*       if it's beyond node1 */
			for (j=i+1 ; j<4 ; j++) { /*                for each remaining node */
			    if (cell_to_node[cell1][j]>node1) {	/*     if it's also greater than node1 */
				face[face_count].n2 = cell_to_node[cell1][i];
				face[face_count].n3 = cell_to_node[cell1][j];
				face[face_count].index = FACE_INDEX(i,j,node_to_cell[cell1_index].cell_node);
				face_count++;	  /*                      record the face with face index */
			    }
			}
		    }
		}
		for (i=0 ; i<face_count ; i++) {  /*       for each face */
		    cell2_index = cell1_index;	  /*          for each remaining cell at node1 */
		    while (node_to_cell[cell2_index].next!=-1) {
			cell2_index = node_to_cell[cell2_index].next;
			cell2 = node_to_cell[cell2_index].cell;
			match2 = match3 = 0;
			for (j=0 ; j<4 ; j++) {
			    if (cell_to_node[cell2][j]==face[i].n2) {
				match2 = 1;
				i2 = j;
			    }
			    if (cell_to_node[cell2][j]==face[i].n3) {
				match3 = 1;
				i3 = j;
			    }
			}
			if (match2 && match3) {
			    /* add (cell1,cell2) to neighbour list */
			    face_index1 = face[i].index;
			    face_index2 = FACE_INDEX(node_to_cell[cell2_index].cell_node,i2,i3);
			    if ((conn_list[cell1][face_index1]!=-1) || /* if either have been assigned before */
				(conn_list[cell2][face_index2]!=-1)) { /*     we have an error */
				AVSwarning("multiple neighbour assignment");
			    }
			    conn_list[cell1][face_index1]=cell2;
			    conn_list[cell2][face_index2]=cell1;
			}
		    }
		}
		cell1_index = node_to_cell[cell1_index].next;
	    }
	}
    }
    free(node_to_cell);				  /* free up temp memory */
    free(cell_to_node);
}

/*************************************************************************************/
/* void get_cell_node_lists(ucd_input, ncells, nnodes, &node2cell, &cell2node) */

/*    Constructs node to cell and cell to node lists from a UCD structure. */
/*************************************************************************************/
int get_cell_node_lists(UCD_structure *ucd_input,
			int ncells,
			int nnodes,
			NodeToCellEntry **node2cell,
			CellToNodeEntry	**cell2node)
{
    /* local variables */
    int		i, j, cell1, cell2, node1, node2, node3;
    int		node_index;		  /* index of node in cell node list */
    
    CellToNodeEntry	*cell_to_node;

    int			free_entry;		  /* pointer to next free entry */
    NodeToCellEntry	*node_to_cell;

    int  elem_id, mat_id, cell_type, me_flags;	  /* cell parameters */
    char int_cell_name;
    int	*nodes;
    
    int	list_size;

    /* retrieve cell_to_node list from ucd structure for convenient access */
    *cell2node =
    cell_to_node = (CellToNodeEntry *) malloc(ncells*4*sizeof(int));
    for (cell1=0; cell1<ncells ; cell1++) {	  /* for each cell */
	UCDcell_get_information (ucd_input,	  /*    get cell info  */
				 cell1, &elem_id,
				 &int_cell_name,
				 &mat_id, &cell_type,
				 &me_flags, &nodes);
	cell_to_node[cell1][0] = nodes[0];	  /*    and copy node info to list */
	cell_to_node[cell1][1] = nodes[1];
	cell_to_node[cell1][2] = nodes[2];
	cell_to_node[cell1][3] = nodes[3];
    }
	
    /*   initialize node_to_cell list */
    list_size = nnodes+ncells*4;		  /* upper bound four number of entries */
						  /* (it's more than ncells*4 because there */
						  /* may be nodes not referenced by any of the */
						  /* cells) */
    *node2cell =
    node_to_cell = (NodeToCellEntry *) malloc(list_size*sizeof(NodeToCellEntry));
    for (i=0 ; i<nnodes ; i++) {
	node_to_cell[i].cell = -1;		  /* no cell at all yet */
	node_to_cell[i].next = -1;		  /* and no additional cells */
    }
    free_entry = nnodes;			  /* free entries start after the first nnodes entries */

    /* now fill it in */
    for (cell1=0 ; cell1<ncells ; cell1++) {	  /* for each cell, */
	for (node_index=0 ; node_index<4 ; node_index++) {
	    node1 = cell_to_node[cell1][node_index]; /*  for each node in the cell */
	    /* add cell to the node entry in node_to_cell */
	    if (node_to_cell[node1].cell==-1) {	  /*         if this is the first entry for this node */
		node_to_cell[node1].cell = cell1; /*            just add it */
		node_to_cell[node1].cell_node = node_index;
	    } else {				  /*         else  */
		if (free_entry>=list_size) {	  /*            this shouldn't happen */
		} else {
		    node_to_cell[free_entry].cell = cell1; /*       get the next free entry */
		    node_to_cell[free_entry].cell_node = node_index;
		    node_to_cell[free_entry].next = node_to_cell[node1].next;
		    node_to_cell[node1].next = free_entry;
		}
		free_entry++;
	    }
	}
    }
    if (free_entry>=list_size) {
	AVSerror("Node to cell list overflow by %d", free_entry-list_size);
	return(0);
    } else {
	return(1);
    }
}

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:50 */
/* End: */
