/* 	$Id: advance.c,v 1.5 1995/06/26 17:35:54 npkonrad Exp $	 */

#ifndef lint
static char vcid[] = "$Id: advance.c,v 1.5 1995/06/26 17:35:54 npkonrad Exp $";
#endif /* lint */
/*************************************************************************/
/*     This file is part of a particle advection package It provides */
/*     functions for advancing particles within a vector field. */

/*     This file, advance.c contains the code for supporting functions. */
/*     Declarations and function prototypes are included in matrix.h. */
/*     Functions include: */
/*       - advance_particles - given a list of particles and some */
/*                   controlling parameters, advances each particle */
/*                   one step (this is just a stub at this point) */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211 */
/*  Date Created: Thu Jan 26 10:37:30 EST 1995 */
/*************************************************************************/

#include "advance.h"

#define CELL_STACK_SIZE 30
#define TRUE 1
#define FALSE 0

typedef struct{
    int cell;
    int faces[3];
    int last_face;
} searchInfo;

typedef struct{
    int active;
    int top;
    searchInfo *info; 
} Search;


/*********** Function Definitions ***********/
      
void init_search(Search *search, int *next_cell_array, int s_count,
		 int particle_cell, int* next_cell_ptr);

int cell_in_stack(Search *search, int cell);

int get_next_from_stack(Search *search, int *cell, int *next_cell);

/************************************************************************
 
  INPUT :
     (0) Time_Step - a real value
     (1) integration_choice - linear for now
     (2) data_choice - which field data (eg for which material) is used
     (3) ucd_input - stores the mesh information
     (4) cell_conn - a list of cell neighbours indexed like the ucd cell list.
                     each element in the list is a list of 4 cells.
     (5) cell_trans - a list of transform matrices indexed like the ucd.
     (6) particle_list - a list of particle structures, and id info for them
 
************************************************************************/






/************************************************************************

  Advance each particle according to the following scheme :
  
  (1) find the barycentric co-ordinates of the particle's current pos.
  (2) find the velocities at the nodes of the current cell
  (3) from (2) & (1) interpolate the current velocity (linearly)

  (4) find the new position in barycentric coordinates

  (5) find what fraction of the time left is to be spent in the current  
      cell.  That is, the fraction of the distance the particle travels
      in the current cell from the total distance the particle should
      travel during the time step.
      
  (6) if position found in (4) is not in the current cell then the 
      particle should change cells.  In case only one nbr exists
      (i.e. the particle is in the "middle" of a face) move to that nbr.
      However, if there are several nbrs the particle may move to, 
      (when at an edge/node) then both directions must be explored.
      Once one nbr is chosen, say randomly, the process of choosing
      a nbr might reocurr which could cause an infinite loop (a particle
      just switching between 2 nbrs, neither of which can let the 
      particle advance in the velocity's direction).  This section, makes
      sure this problem won't happen by keeping track of all the 
      cells visited (while trying to find a cell where the particle
      can move).

      The idea is to turn on a search flag whenever a particle has
      more than one possible neighbour to move to. This flag remains TRUE
      until a nbr can be found s.t. the particle can advance in this
      nbr.  When that happens, the search becomes inactive.

      When the search is already active, (i.e. current cell is a nbr
      of the previous cell-which couldn't move the particle), then the
      current cell is either (i) added to the stack if it is not there,
      or (ii) if it already on the stack (been visited before), the next 
      available cell is pulled from the stack.

      (i)  adding to the stack: record the current cell, and the possible
           nbs the particle may move to.

      (ii) pulling from the stack: based on the top record in the stack
           update the current cell, the next cell index, and delete info
	   from the stack.  

      NOTE: when pulling a next_cell from the stack, along with the
      updated current cell, the particle's cell will be updated (8i) using
      next cell by the time it reaches here (6) again. In this case,
      it may be possible that this new current cell is already on the
      stack (i.e. has been visited) which explains the need for (i)
      above.  Also, if it actually reaches here (6), it is because the 
      particle could not advance in this new current cell, so the only
      options are (i) to look at its nbs if it's a fresh cell, or (ii)
      throw it away, and go to previous decision point in selecting a 
      cell.

      In case the next cell is NULL, then changes to current cell 
      will take place in (8iii) in case the particle can't slide along
      the edge.  This change will occur in (8.4).
      
      When the particle finally moves (fraction found in (5) is 
      nonzero), the search is turned off in case it's on.  If a 
      particle doesn't move in the original direction, but slides along
      the boundary instead, search is also turned off (see (8.3)).

  (7) update particles position, time, and check if any other updates
      need to take place (like disappearing in case ptcle is at sink).


  (8) if in (5) it was found that particle should change cell (before
      the total advance time ends) then 

      (i) if it can't move in the current cell anymore, and it is not at 
      the end of the domain, move to the neighbouring cell.  

      (ii) If it can move in the current cell (i.e. it did move in (7)) 
      then do nothing.

      (iii) The last possibility is that the particle can't advance, and
      it also has no nbr to try and move to.  In that case, the particle
      should slide along the boundary face which is done as follows:

      (8.1) calculate the particle's final position by killing the
            component perpendicular to the boundary face.  This final
	    position might be outside of the current cell.

      (8.2) find what fraction of time left is to be spent in current
            cell.  Basically, this is the same as (5).

      (8.3) update particle's position, time, like (7).  In addition,
            if the particle has moved in the current cell, then turn
	    off search in case one is in progress.

      (8.4) if particle is stuck at a node, and has no nbr, just leave
            it there and kill the rest of the time.  Otherwise, if it
	    needs to change a cell, do it.


Wasted calculations :  if cell is already on the stack, it is discovered
at 6 after going throgh 1-5.  However, if it is not on stack then we
need neighbour information which is available only after performing 
calculations 1-5.  

Possible solution :  when recording the next_cells (in local index format)
check first if their global index is already in the stack.  In this case,
putting on stack may sometimes fail if none of the nbs are new (0 new nbs)
and then we regress to a previous decision point on the stack and pick a
new current cell, and erase it from stack.  With these modifications it
is not necessary to check whether the current cell is on the stack.
However, the case where the nbr does not change nor advance because it
is null will cause the same cell to try and add itself, so perhaps leave
the code the same, just add a check before putting on the stack.


***********************************************************************/

void advance_particles(float *Time_Step,
		       int integration_choice,
		       UCD_structure *ucd_input,
		       CellNeighbours *cell_conn,
		       CellTransforms *cell_trans,
		       CellFunc **cell_ops,
		       ParticleList *particle_list_head)
    
{    
    const float SMALL_DISTANCE = 0.00001;  /* this relates to the data values (their magnitude) */
    const int UNCHANGED = -1;
    int i, j;

    /* variables to hold cell information */
    int cell_name, material_type, cell_type, mid_edge_flags;
    char element_type;
    int *nodes;


    /* variable definitions */
    ParticleInfo *particle;
    ParticleList *particle_list;
    Mat44 *to_cart, *to_bary;
    Vect4 cart, bary;
    Vect4 newCart, newBary; /* for the new position */
    Vect4 killed_comp_bary, killed_comp_cart, displacement;
    /* s=fraction of the "change in position" vector, that's in present cell */
    float s, new_s, s2;    
    /* used in case the particle goes to a next cell. next_cell2 is used to check another */
    /* possible cell in case the particle is stuck at the boundary of the domain. */
    int next_cell, next_cell2;

    float *data;  /* will point to an array of vectors containing data */
    float Velocities[4][3];  /* 4 velocities, and 3 values */
    float velocity[3];
    int *node_list;
    float newX, newY, newZ;
    float time_left;
    double *normal;
    double VdotN;
    int offset;

    int s_count;
    int next_cell_array[3];

    Search *search;

    char name[80];
    int data_veclen, name_flag, Ncells, cell_veclen;
    int Nnodes, node_veclen, util_flag;
    

    search = (Search *) malloc (sizeof(Search));
    search->top = 3;
    search->info = (searchInfo*) malloc (sizeof(searchInfo) * CELL_STACK_SIZE);
    
    UCDstructure_get_header(ucd_input, name, &data_veclen, &name_flag,
			    &Ncells, &cell_veclen, &Nnodes, &node_veclen,
			    &util_flag);
			    
    /* get the data for all the nodes */
    UCDstructure_get_node_data(ucd_input, &data);

    particle_list = particle_list_head;

    /* advance each particle in the list */
    while (particle_list!=NULL) {			  
	particle = particle_list->first;
	while (particle!=NULL) {
	    time_left = *Time_Step;
	    /* No search is in progress */
	    search->active = FALSE;
	    search->top = 0;
	    do {
		if (particle->state == NEW_PARTICLE) break;
		if (particle->state == OLD_PARTICLE) particle->state = MOVED_PARTICLE;

	
		/* (1) */
		
		get_cell_trans(cell_trans, particle->cell, &to_cart, &to_bary);
		
		/* construct a 4-vector from the current particle's position */
		cart[0] = particle->x;
		cart[1] = particle->y;
		cart[2] = particle->z;
		cart[3] = 1.0;
 		vect4_transform(*to_bary, cart, bary);
		
		/* (2) */
		
		/* get the nodes in the cell */
		UCDcell_get_information(ucd_input, particle->cell,
					&cell_name, &element_type,
					&material_type, &cell_type, 
					&mid_edge_flags, &node_list);
		
		
				
		/* (2) & (3) */
		velocity[0] = velocity[1] = velocity[2] = 0.0;
		for (i=0;i<4;i++) {
		    /* get the 3 components for the velocities of each node i */

		    offset = particle_list->offset * Nnodes;
		    Velocities[i][0] = data[0+offset + 3*node_list[i]];
		    Velocities[i][1] = data[1+offset + 3*node_list[i]];
		    Velocities[i][2] = data[2+offset + 3*node_list[i]];
	
		    /* weight each of the velocities at the nodes using bary-co. */
		    /* to give the velocity at the current position */
		    velocity[0] += bary[i]*Velocities[i][0];		
		    velocity[1] += bary[i]*Velocities[i][1];		
		    velocity[2] += bary[i]*Velocities[i][2];
		}
		
		/* update the position of the particles */
		newX = particle->x + velocity[0]*time_left;
		newY = particle->y + velocity[1]*time_left;
		newZ = particle->z + velocity[2]*time_left;
		
	
		/* (4) */
	
		/* get bary-co. of the new position */
		newCart[0] = newX;
		newCart[1] = newY;
		newCart[2] = newZ;
		newCart[3] = 1.0;
		vect4_transform(*to_bary, newCart, newBary); 
		
		/* (5) */
		
		/* find what fraction of the time left is to be spent in this cell. */
		/* if particle is about to change cell, find what possible nbs it can */
		/* move to. */

		next_cell = UNCHANGED;
		s = 1.0;
	
		/* counts the number of possible nbrs the ptcle may move to, if particle must change cell */
		s_count = 0;
		for (i=0;i<4;i++) {
		    if (newBary[i] < -SMALL_DISTANCE) {
			if (bary[i] < 0.0) {
			    /* This happened because of round off */
			    new_s = 0.0;
			} else {
			    new_s = bary[i]/(bary[i]-newBary[i]);
			}
			if (new_s < s) {
			    s = new_s;
			    next_cell = i;
			}
			if (new_s < SMALL_DISTANCE) {
			    /* there may be several possible nbs to try */
			    next_cell_array[s_count] = i;
			    s_count++;
			}
		    }
		}
		
		/* (6) */

		if (s > SMALL_DISTANCE && search->active) {
		    /* the current cell can advance the particle */
		    search->active = FALSE;
		}

		/* if there are several possible adjacent cells (eg. at a vertex) */
		/* build stack to enable exhaustive search for the right cell */

		if (s_count > 1 && !search->active) {
		    /* start a search */
		    init_search(search, next_cell_array, s_count, particle->cell, &next_cell);
		} else if (search->active) {
		    /* haven't found right cell yet. Check if current cell valid */
		    if (cell_in_stack(search, particle->cell)) {
			/* current cell invalid. look for next face at top of stack */
			if (!get_next_from_stack(search, &(particle->cell), &next_cell)) {
			    printf("particle is stuck -- see advance.c\n");
			    time_left = 0.0;
			    break;
			}
		    } else {
			/* current cell is ok, add it to stack */
			if (search->top == CELL_STACK_SIZE) {
			    printf("out of stack space -- see advance.c\n");
			    time_left = 0.0;
			    break;
			} 
			search->info[search->top].cell = particle->cell;
			search->info[search->top].last_face = s_count-1;
			for (i=0;i<s_count-1;i++) {
			    search->info[search->top].faces[i] = next_cell_array[i];
			}
			search->top++;
			next_cell = next_cell_array[s_count-1];
		    }
		}    
				
		/* (7) */		
		
		particle->x += velocity[0]*time_left*s;
		particle->y += velocity[1]*time_left*s;
		particle->z += velocity[2]*time_left*s;
		time_left = time_left*(1-s);
		/* particle is either leaving current cell, or finishing a time step */
		if (cell_ops[particle->cell] != NULL) {
		    apply_cell_op(particle, 
				  cell_ops[particle->cell], 
				  newBary);
		}

		/* (8) */

                if (next_cell != UNCHANGED) {

		    /* need to update cell, new_cell is a neighbour found from next_cell */
		    if (cell_conn[particle->cell][next_cell] != -1) {
			particle->cell = cell_conn[particle->cell][next_cell];
		    } else if (s > SMALL_DISTANCE){ 
			/* do nothing, particle will advance toward the edge */
		    } else {

			/* (8.1) */

			/* a particle should slide along edge */
			/* calculate killed_component_cart, using normal info */

			normal = get_cell_face_normal(particle->cell,
						      next_cell,
						      cell_ops,
						      ucd_input);
			
			Vect4diff3(displacement, newCart, cart);
			VdotN = Vect4dot3(normal, displacement);
			for (i=0;i<3;i++) {
			    killed_comp_cart[i] = cart[i]+displacement[i]-VdotN*normal[i];
			}
			killed_comp_cart[3] = 1.0;
			
			/* convert final position to barycentric */
			vect4_transform(*to_bary, killed_comp_cart, killed_comp_bary); 

			/* (8.2) */

			next_cell2 = UNCHANGED;
			s2 = 1.0;
			
			for (i=0;i<4;i++) {
			    if (killed_comp_bary[i] < -SMALL_DISTANCE && i != next_cell) {
				if (bary[i] < 0.0) {
				    /* roundoff error */
				    s2 = 0.0;
				    next_cell2 = i;
				    break;
				} else {    
				    new_s = bary[i]/(bary[i]-killed_comp_bary[i]);
				    if (new_s < s2) {
					s2 = new_s;
					next_cell2 = i;
				    }
				}
			    }
			}

			/* (8.3) */
	
			particle->x += s2*(killed_comp_cart[0]-particle->x);
			particle->y += s2*(killed_comp_cart[1]-particle->y);
			particle->z += s2*(killed_comp_cart[2]-particle->z);
			time_left = time_left*(1-s2);

/* 			if (s2 > 0.0) { */
			if (s2 > SMALL_DISTANCE) {
			    search->active = 0;
			}

			/* particle is leaving the current cell, or finishing a time step */
			if (cell_ops[particle->cell] != NULL) {
			    apply_cell_op(particle, 
					  cell_ops[particle->cell], 
					  killed_comp_bary);
			}

			/* (8.4) */

			if (next_cell2 != UNCHANGED) {

			    if (s2 <= SMALL_DISTANCE && 
				cell_conn[particle->cell][next_cell2] == -1) {
				/* particle is stuck in a corner edge. for now, it won't */
				/* slide along that edge (i.e. killing 2 comps.) */
				time_left = 0.0;
			    } else if (cell_conn[particle->cell][next_cell2] != -1) {
				/* no need to advance, just move a cell */
				particle->cell = cell_conn[particle->cell][next_cell2];
			    } 
			}
		    } 	
		}    
		else {
		
		}
		
		
	    } while (time_left > 0.0); 
	    
	    
	    particle = particle->next;
	}
	particle_list = particle_list->next;
    }
    
}

void init_search(Search *search, int *next_cell_array, int s_count, int cell, int *next_cell) {
    int i;

    search->active = TRUE;
    search->info[0].cell = cell;
    search->info[0].last_face = s_count-1;
    for (i=0;i<s_count-1;i++) {
	search->info[0].faces[i] = next_cell_array[i];
    }
    search->top = 1;
    *next_cell = next_cell_array[s_count-1];
}    


int cell_in_stack(Search *search, int cell) {
    int i;
    
    for (i=0;i<search->top;i++) {
	if (cell == search->info[i].cell) {
	    return TRUE;
	}
    }
    return FALSE;
}

/* returns 1 if it can return values from stack, 0 otherwise */

int get_next_from_stack(Search *search, int *cell, int *next_cell) {
    while (search->top > 0) {
	if (search->info[search->top-1].last_face > 0) {
	    search->info[search->top-1].last_face--;
	    *next_cell = search->info[search->top-1].faces
		[search->info[search->top-1].last_face];
	    *cell = search->info[search->top-1].cell;
	    return 1;
	} else {
	    search->top--;
	}
    }
    return 0;
}



/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:50 */
/* End: */















