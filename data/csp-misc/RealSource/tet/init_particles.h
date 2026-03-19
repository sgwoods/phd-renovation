/* 	$Id: init_particles.h,v 1.2 1995/06/26 18:40:56 npkonrad Exp $	 */
#ifndef INIT_PARTICLE_CELLS
#define INIT_PARTICLE_CELLS

/******** Include files ***********/

#include "advance.h"
#include "random_cells.h"
#define FALSE 0
#define TRUE 1

/******** functions ***********/

void find_initial_cells(ParticleList *particle_list, 
		      CellTransforms *cell_trans,
		      UCD_structure *ucd_input,
		      CellNeighbours *cell_conn);

void find_initial_cell(ParticleInfo *particle, 
		      CellTransforms *cell_trans,
		      UCD_structure *ucd_input,
		      CellNeighbours *cell_conn,
		      int Ncells,
		      int* flag_array);

#endif INIT_PARTICLE_CELLS



