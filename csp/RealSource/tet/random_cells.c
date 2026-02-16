/* 	$Id: random_cells.c,v 1.2 1995/06/26 18:42:24 npkonrad Exp $	 */

#ifndef lint
static char vcid[] = "$Id: random_cells.c,v 1.2 1995/06/26 18:42:24 npkonrad Exp $";
#endif /* lint */

#include "random_cells.h"

/* gloabal variables */

int Ncells;
int lastGeneratedCell;


void init_random_cell_generator(int num_cells) {
  Ncells = num_cells;
  lastGeneratedCell = 0;
}

int next_random_cell() {
  const long p = 15229867;
  lastGeneratedCell = (lastGeneratedCell + p) % Ncells;
  return(lastGeneratedCell);
}
