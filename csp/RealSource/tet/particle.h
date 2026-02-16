/* 	$Id: particle.h,v 1.5 1995/06/26 18:21:49 npkonrad Exp $	 */
/*************************************************************************/
/* This file contains declarations for the Particles */
/* structure.  The structure contains a list of initialized particles, */
/* along with their (x,y,z) location, and the current cell within which */
/* they are located.  Each particle also includes a particle ID which */
/* uniquely identifies the particle to downstream modules. */
/* Functions for accessing, initializing, destroying, and modifying particles */
/* are included. */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211                           */
/*  Date Created: Mon Jan  2 17:25:24 EST 1995 */
/*************************************************************************/

/*************************************************************************/
/* Data Structures and Algorithms: */

/*     Particle information is stored in a linked list, each node */
/*     (particleInfo) of which contains the cartesian coordinates, the */
/*     barycentric coordinates (?), the index of the cell within which it */
/*     lies, and its unique cell identifier.  The list is ordered */
/*     according to particle id numbers, and has a head block */
/*     (ParticleList) which maintains a count of the number of currently */
/*     active particles, and a pointer to the first node of the list. */

/*************************************************************************/
#ifndef PARTICLE_H
#define PARTICLE_H

/*********** Include files ***********/

#include <stdio.h>				  /* system stuff */

#include <avs/avs.h>				  /* AVS stuff */
#include <avs/port.h>
#include <avs/field.h>
#include <avs/ucd_defs.h>
#include <avs/udata.h>
#include <avs/geom.h>

#include "matrix.h"				  /* local stuff */

/*********** Define Constants ***********/
/* particle state values */
#define NEW_PARTICLE	(1)	/* This is a new particle */
#define OLD_PARTICLE	(2)	/* This is an existing particle */
#define MOVED_PARTICLE	(3)	/* particle moved, but not updated in geometry */
#define DEAD_PARTICLE	(4)	/* this particle has been removed */
#define PARTICLE_SOURCE	(5)	/* this is a particle source location */

#define	X_COORD			(0)	/* indices into points array */
#define	Y_COORD			(1)
#define	Z_COORD			(2)

#define DEFAULT_SOURCE_SIZE	(0.2) /* source is scaled to this fraction */
				      /* of input mesh size by default */
#define DEF_PARTICLE_CLASS	(-1)		  /* the id for the default particle */
						  /* class */
#define MIN_SOURCE		(1.0e-5)/* if the source maximum dimension */
				      /* is less than this, the source will */
				      /* not be automatically scaled. Note: */
				      /* this is the case if there is only one */
				      /* point in the source */
/*********** Structure Definitions ***********/
/* The ParticleInfo type contains all information for one particle as */
/*   shown in the fields below.  The state field contains a value as */
/*   defined above. The particle identification is subdivided into a */
/*   group id and a particle id, to support the case where groups of */
/*   particles released at the same time are mapped together in any */
/*   number of ways.  The class of a particle can be defined by the user for any */
/*   particle source, and is used to differentiate particles to be mapped in */
/*   different ways.  */

typedef struct particleInfo {
    float	x,y,z;				  /* physical location */
    int		class;				  /* particle class */
    int		cell;				  /* current cell */
    int		grp,id;				  /* particle ident. */
    int		state;				  /* current state of particle */
    struct particleInfo *next;			  /* link to next particle */
} ParticleInfo;

typedef struct particleList {
    int		class;				  /* the class for this segment of */
						  /* the list */
    int		count;				  /* number of particles of this class */
    int		grp_count;			  /* only used for sources: used to */
						  /* associate particles released at */
						  /* the same time */
    int		offset;				  /* the offset into the data vector */
						  /* for the data used to advect this */
						  /* class of particles (placed here */
						  /* for efficiency of the particle */
						  /* advect routine). */
    struct particleList *next;			  /* points to the list for the next */
						  /* class  */
    ParticleInfo *first;			  /* points to first particle record */
} ParticleList;

typedef float Vertex[3];		/* list of vertices for geom object */

/*********** function prototypes ***********/
int init_particle_list(ParticleList **new_list);

int clear_particle_list(ParticleList **list);

int destroy_particle_list(ParticleList **list);

int reset_particles(ParticleList *particle_list);

ParticleList *get_class_particles(ParticleList **list,
				  int class);

int create_source(AVSfield *Source, Mat44 source_placement,
		  Mat44 user_transform, ParticleList **source_list);

int source_geometry(ParticleList *source_list, GEOMedit_list Geometry);

int generate_source_xfm(UCD_structure *ucd_input,
			AVSfield *Source,
			Mat44 source_placement);

int inject_particles(ParticleList *source_list,
		     ParticleList **particle_list);

/* Set up local variables to compile for the current host */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* comment-column:50 */
/* End: */

#endif
