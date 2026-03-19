/* 	$Id: advance.h,v 1.4 1995/05/25 20:42:20 npkonrad Exp $	 */
/*************************************************************************/
/*     This file is part of a particle advection package It provides */
/*     functions for advancing particles within a vector field. */

/*     This file, advance.h contains the definitions to accompany advance.c */
/*     Functions include: */
/*       - advance_particles - given a list of particles and some */
/*                   controlling parameters, advances each particle */
/*                   one step (this is just a stub at this point) */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211 */
/*  Date Created: Thu Jan 26 10:37:30 EST 1995 */
/*************************************************************************/

#ifndef ADVANCE_H				  /* prevent multiple inclusions */
#define ADVANCE_H

/*********** Include files  ***********/
      
#include <sys/time.h>				  /* system stuff */

#include <avs/avs.h>				  /* AVS stuff */
#include <avs/ucd_defs.h>

#include "cell_trans.h"				  /* local stuff */
#include "cell_connect.h"
#include "particle.h"
#include "init_data.h"
#include "cell_ops.h"

/*********** Function Definitions ***********/
      
void advance_particles(float *Time_Step,
		       int integration_choice,
		       UCD_structure *ucd_input,
		       CellNeighbours *cell_conn,
		       CellTransforms *cell_trans,
		       CellFunc **cell_ops,
		       ParticleList *particle_list);

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:50 */
/* End: */

#endif ADVANCE_H
