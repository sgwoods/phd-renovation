/* 	$Id: init_particles.c,v 1.2 1995/06/26 18:39:16 npkonrad Exp $	 */

#ifndef lint
static char vcid[] = "$Id: init_particles.c,v 1.2 1995/06/26 18:39:16 npkonrad Exp $";
#endif /* lint */

#include "init_particles.h"

/************************************************************************

  For each particle, find the cell it is in.  Use particle's x,y,z to
  determine which cell it is in.


************************************************************************/

void find_initial_cell(ParticleInfo *particle, 
		      CellTransforms *cell_trans,
		      UCD_structure *ucd_input,
		      CellNeighbours *cell_conn,
		      int Ncells,
		      int* flag_array)
{
  Mat44 *to_bary,  *to_cart;
  Vect4 cart, bary;
  /* the current cell, and a possible new current cell */
  int currentCell, potCurrentCell;      
  int found;
  int nextCellFound;
  int i,j;

  int num_negative_co;
  int negative_co_indeces[3];
  double negative_co[3];
  int temp_indx;
  double temp_co;
  int cellCount = 0;
  int numberOfRestarts = 0;

  /* get an initial guess for the current cell */
  init_random_cell_generator(Ncells);
  currentCell = next_random_cell();
  

  found = FALSE;
  while (!found) {
    /* we now use this array to look for a cell for the current ptcle */
    flag_array[currentCell] = particle->id;
    cellCount++;

    get_cell_trans(cell_trans, currentCell, &to_cart, &to_bary);
    
    cart[0] = particle->x;
    cart[1] = particle->y;
    cart[2] = particle->z;
    cart[3] = 1.0;
    vect4_transform(*to_bary, cart, bary);
   
    /* find the negative barycentric coordinates and sort */

    num_negative_co = 0;
   
    
    for (i=0;i<4;i++) {
      if (bary[i] < 0.0) {
	negative_co[num_negative_co] = bary[i];
	negative_co_indeces[num_negative_co] = i;
	num_negative_co++;
      }
    }

    /* bubble sort (of at most 3 elements) */

    for (i=0;i<num_negative_co-1;i++) {
      for (j=num_negative_co-1;j>i;j--) {
	if (negative_co[j] < negative_co[j-1]) {
	  /* swap element j, j-1 */
	  temp_indx = negative_co_indeces[j];
	  temp_co = negative_co[j];
	  negative_co_indeces[j] = negative_co_indeces[j-1];
	  negative_co[j] = negative_co[j-1];
	  negative_co_indeces[j-1] = temp_indx;
	  negative_co[j-1] = temp_co;
	}
      }
    }  
    
    /* check if right cell has been reached */
    if (num_negative_co == 0) {
      found = TRUE;
      particle->cell = currentCell;
    } else {  
      if (numberOfRestarts == 5 || cellCount == Ncells) {   
	/* game over, we lose.  Particle is not in any cell. */
	particle->state = DEAD_PARTICLE;
	break;
      }
      nextCellFound = FALSE;

      /* try advancing opposite to the most negative direction */
      for (i=0;i<num_negative_co;i++) {
	/* if a closer cell can be found, move to that cell. */
	potCurrentCell = cell_conn[currentCell][negative_co_indeces[i]];
	if (potCurrentCell != -1 && flag_array[potCurrentCell] != particle->id) {
	    currentCell = potCurrentCell;
	    nextCellFound = TRUE;
	    break;
	} 
      } /* end for */

      while (!nextCellFound) {
	currentCell = next_random_cell();
	/* check if cell has not been visited before */
	if (flag_array[currentCell] != particle->id) {
	    numberOfRestarts++;
	    nextCellFound = TRUE;
	}
      }
    }


  }
}


void find_initial_cells(ParticleList *particle_list_head, 
		      CellTransforms *cell_trans,
		      UCD_structure *ucd_input,
		      CellNeighbours *cell_conn)
		      
{
  int* flag_array;
  int i;
  ParticleInfo *particle;
  ParticleList *particle_list;

  char name[80];
  int data_veclen, name_flag, Ncells, cell_veclen;
  int Nnodes, node_veclen, util_flag;


  UCDstructure_get_header(ucd_input, name, &data_veclen, &name_flag,
			  &Ncells, &cell_veclen, &Nnodes, &node_veclen,
			  &util_flag);

  flag_array = (int *) malloc(Ncells*sizeof(int));
  /* get Ncells */

  for (i=0;i<Ncells;i++)
    flag_array[i] = -1;

  
  particle_list = particle_list_head;

  /* advance each particle in the list */
  while (particle_list!=NULL) {			  
    particle = particle_list->first;
    while (particle!=NULL) {
      find_initial_cell(particle, cell_trans, ucd_input, cell_conn, 
			Ncells, flag_array);
      particle = particle->next;
    }
    particle_list = particle_list->next;
  }
  
  free(flag_array);
}

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:50 */
/* End: */


