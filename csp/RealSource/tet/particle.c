/* 	$Id: particle.c,v 1.5 1995/06/26 18:19:46 npkonrad Exp $	 */

#ifndef lint
static char vcid[] = "$Id: particle.c,v 1.5 1995/06/26 18:19:46 npkonrad Exp $";
#endif /* lint */
/*************************************************************************/
/* This file contains code for supporting functions of the Particles */
/* structure.  The structure contains a list of initialized particles, */
/* along with their (x,y,z) location, and the current cell within which */
/* they are located.  Each particle also includes a particle ID which */
/* uniquely identifies the particle to downstream modules. */
/* Functions for accessing, initializing, destroying, and modifying particles */
/* are included. */
/* Also included are routines related to the source: */
/*    - source_geometry - updates the geometry which displays the source */
/*      locations */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211		*/
/*  Date Created: Mon Jan  2 17:25:24 EST 1995 */

/*************************************************************************/

/*************************************************************************/
/* Data structures and Algorithms: */
/*************************************************************************/

#include "particle.h"

/*************************************************************************
int init_particle_list(particleList **new_list)
int clear_particle_list(particleList **list)
int destroy_particle_list(particleList **list)

These functions initialize and destroy particle lists respectively.

*************************************************************************/
int init_particle_list(ParticleList **new_list)
{
    ParticleList *particles;

    *new_list = NULL;				  /* assume new_list is */
						  /* un-initialized and add an entry */
						  /* for the default class */
    get_class_particles(new_list, DEF_PARTICLE_CLASS);
}

int clear_particle_list(ParticleList **list)
{
    destroy_particle_list(list);
    init_particle_list(list);
}

int destroy_particle_list(ParticleList **list)
{
    ParticleInfo *node, *temp;
    ParticleList *front;

    front = *list;
    while (front!=NULL) {			  /* if the header exists */
	node = front->first;			  /*    clear out particle nodes */
	while (node!=NULL) {
	    temp = node->next;
	    free(node);
	    node = temp;
	}
	*list = front->next;
	free(front);
	front = *list;
    }
    *list = NULL;				  /* then return a null pointer */
    return(1);					  /* and success flag */
}

/**********************************************************************/
/* ParticleList *get_class_particles(ParticleList **list, */
/* 				     int class) */
/* This routine retrieves the header of the segment of the particle list for */
/* the given class.  If there is no such header, a new header is inserted for */
/* particles of the class.  */
/**********************************************************************/
ParticleList *get_class_particles(ParticleList **list,
				  int class)
{
    ParticleList *this_class;

    this_class = *list;
    while ((this_class!=NULL) &&
	   (this_class->class!=class)) {
	this_class = this_class->next;
    }
    if (this_class==NULL) {			  /* if there exists no such class */
	this_class = (ParticleList *) malloc(sizeof(ParticleList));
	this_class->class = class;		  /*    add it to the spec */
	this_class->first = NULL;		  /*    no particles in this class */
						  /*    yet */
	this_class->count = 0;
	this_class->grp_count = 0;
	this_class->offset = -1;		  /*    init to an impossible offset */
	this_class->next = *list;		  /*    at the front of the list */
	*list = this_class;
    }
    return(this_class);				  /* and return the mapping */
}


/*************************************************************************
int reset_particles(ParticleList *particle_list)

    Any particles currently in the particle list are marked as dead. They will
    be removed by the generate output routine upon the next invocation.
*************************************************************************/
int reset_particles(ParticleList *particle_list)
{
    ParticleList	*particle_class;
    ParticleInfo	*particle;

    if (particle_list==NULL) {
	AVSerror("Null list in reset_particles");
	return(0);
    }
    particle_class = particle_list;		  /* for each class */
    while (particle_class!=NULL) {
	particle = particle_class->first;	  /* and each particle in the class */
	while (particle!=NULL) {
	    particle->state = DEAD_PARTICLE;	  /*    mark it as dead */
	    particle = particle->next;		  /*    next particle */
	}
	particle_class = particle_class->next;	  /*    next class */
    }
    return(1);
}

/*************************************************************************/
/* int create_source(AVSfield *Source, Mat44 source_placement, */
/* 		  Mat44 user_transform, ParticleList **source_list); */

/*     This routine takes the raw source specification, transforms it */
/*     using a centering/scaling transform and then a user specified */
/*     transform and then creates a particle list of the new positions. */

/*     For now, all sources have the default particle mapping class. */
/*************************************************************************/
int create_source(AVSfield *Source, Mat44 source_placement,
		  Mat44 user_transform, ParticleList **source_list)
{
    int		ndim, nspace, uniform;
    int		nsources;			  /* number of points */
    Vect4	raw_vert, cent_vert, final_vert; /* temporary vertex variables */
    int		pindex;
    ParticleInfo *new_source;
    int		class;				  /* class for current particle */
    int		class_source;			  /* boolean - indicates if class */
						  /* info is included in source file */
    ParticleList *class_list;

    /* get particulars of source field */
    ndim = AVSfield_get_int(Source,AVS_FIELD_NDIM);
    nspace = AVSfield_get_int(Source,AVS_FIELD_NSPACE);
    uniform = AVSfield_get_int(Source,AVS_FIELD_UNIFORM);
    if ((ndim!=1) || (nspace!=3) || (uniform!=IRREGULAR)) {
	AVSwarning("Source input is not a 3D scatter field");
    } else {
	nsources = Source->dimensions[0];
	/* see if class info included in input */
	class_source = (Source->type == AVS_TYPE_INTEGER) &&
	    (Source->veclen==1);

	clear_particle_list(source_list);	  /* first clear the list */
	/*** create a vertex list from the input field */
	for (pindex = 0 ; pindex<nsources ; pindex++) {
	    raw_vert[X_COORD] = Source->points[X_COORD*nsources + pindex];
	    raw_vert[Y_COORD] = Source->points[Y_COORD*nsources + pindex];
	    raw_vert[Z_COORD] = Source->points[Z_COORD*nsources + pindex];
	    raw_vert[3] = 1.0;

	    if (class_source) {			  /* set the source based on the */
						  /* input if it's there */
		class = ((AVSfield_int *)Source)->data[pindex];
	    } else {
		class = DEF_PARTICLE_CLASS;
	    }
	    if (class==DEF_PARTICLE_CLASS) {	  /* if it's a default class source */
		/* apply a centering/scaling transform */
		vect4_transform(source_placement, raw_vert, cent_vert);
		/* and then the user specified position */
		vect4_transform(user_transform, cent_vert, final_vert);
	    } else {				  /* otherwise */
		/* just apply the user specified one */
		vect4_transform(user_transform, raw_vert, final_vert);
	    }

	    /* and add it to the list */
	    new_source = (ParticleInfo *) malloc(sizeof(ParticleInfo));
	    /* find particle list segment for this class */
	    class_list = get_class_particles(source_list, class);
	    class_list->count++;		  /* increment its counter */
	    new_source->next = class_list->first; /* and add the new particle */
	    class_list->first = new_source;

	    new_source->state = PARTICLE_SOURCE;  /* initialize the particle */
	    new_source->x = final_vert[0];
	    new_source->y = final_vert[1];
	    new_source->z = final_vert[2];
	    new_source->class = class;		  /* TODO: this shouldn't be needed */
	    new_source->cell = -1;		  /* TODO: initialize source cell */
	    new_source->grp = 0;
	    new_source->id = pindex;
	}
    }
}

/*************************************************************************
int source_geometry(ParticleList *source_list, GEOMedit_list Geometry)

    This routine takes the list of particle source locations and
    generates a geometry object of spheres and adds it to the current
    (given) geometry edit list.

*************************************************************************/
int source_geometry(ParticleList *source_list, GEOMedit_list Geometry)
{
    int		nsources;			  /* number of points */
    Vertex	*vert;				  /* list of vertices for geometry */
    int		pindex;
    GEOMobj	*obj0;				  /* geometry object for sources */
    ParticleInfo	*source;		  /* pointer to individual source */
    ParticleList	*class_list;

    obj0 = GEOMcreate_obj(GEOM_SPHERE, GEOM_NULL); /* init GEOM object */

    class_list = source_list;
    while (class_list!=NULL) {

	nsources = class_list->count;
	source = class_list->first;
	pindex = 0;
	vert = (Vertex *) malloc(nsources * sizeof(Vertex));

	while (source!=NULL) {			  /* create a vertex array from the */
	    vert[pindex][X_COORD] = source->x;	  /* input list */ 
	    vert[pindex][Y_COORD] = source->y;
	    vert[pindex][Z_COORD] = source->z;
	    source = source->next;
	    pindex += 1;
	}
	/* then add the vertices to the sphere geom object */
	GEOMadd_vertices(obj0, (float *) vert, nsources, GEOM_DONT_COPY_DATA);

	class_list = class_list->next;		  /* go to next class */
    }
    
    /* and add the points to the edit list */
    GEOMedit_geometry(Geometry, "ParticleSource", obj0);
    GEOMdestroy_obj(obj0);
    GEOMedit_transform_mode(Geometry,	  /* tell geom viewer to pass back transforms */
			    "ParticleSource", "redirect",
			    BUTTON_MOVING | BUTTON_UP);
    return(1);
}


/*************************************************************************
int generate_source_xfm(ucd_input, Source, source_placement);

    Given the current input mesh and the list of source points, this
    routine computes a transform which will center the source on the
    data mesh, and scale it to about 5% of the input mesh size.

*************************************************************************/
int generate_source_xfm(UCD_structure *ucd_input, AVSfield *Source, Mat44 source_placement)
{
    float	min_ext[3], max_ext[3];
    float	data_center[3], data_range;
    float	src_center[3], src_range;
    float	scale;
    int		i;

    /* find the maximum range and center of the ucd_input */
    UCDstructure_get_extent(ucd_input, min_ext, max_ext);
    data_range = 0.0;
    for (i=0 ; i<3 ; i++) {
	data_center[i] = (min_ext[i]+max_ext[i])/2.0;
	if (max_ext[i]-min_ext[i]>data_range) {
	    data_range = max_ext[i]-min_ext[i];
	}
    }
    /* find the maximum range and center of the source points */
    AVSfield_get_extent(Source, min_ext, max_ext);
    src_range = 0.0;
    for (i=0 ; i<3 ; i++) {
	src_center[i] = (min_ext[i]+max_ext[i])/2.0;
	if (max_ext[i]-min_ext[i]>src_range) {
	    src_range = max_ext[i]-min_ext[i];
	}
    }
    /* scale and shift the Source points to 5% of the input range */
    /* and into the center of the input mesh */
    if (src_range>MIN_SOURCE) {
	scale = DEFAULT_SOURCE_SIZE*data_range/src_range;
    } else {
	scale = 1.0;
    }
    Mat44Eye(source_placement);
    source_placement[0][0] = scale;
    source_placement[1][1] = scale;
    source_placement[2][2] = scale;
    source_placement[3][0] = data_center[0]-scale*src_center[0];
    source_placement[3][1] = data_center[1]-scale*src_center[1];
    source_placement[3][2] = data_center[2]-scale*src_center[2];
}

/*************************************************************************/
/* int inject_particles(ParticleList *source_list, */
/* 		     ParticleList **particle_list); */

/*     This routine takes the the current source, after centering/scaling */
/* and the user applied transformations, and creates a new particle for */
/* each position in the source.  The new particles are added as a new */
/* group in the current particle list. */
/*************************************************************************/
int inject_particles(ParticleList *source_list,
		     ParticleList **particle_list)
{
    int		group;
    ParticleInfo	*particle;
    ParticleInfo	*source;
    ParticleList	*source_class;
    ParticleList	*particle_class;

    source_class = get_class_particles(&source_list, DEF_PARTICLE_CLASS);
    group = ++(source_class->grp_count);	  /* get group count from def class */
    source_class = source_list;
    while (source_class!=NULL) {
	if (source_class->count>0) {
	    /* find the particle list segment for this class */
	    particle_class = get_class_particles(particle_list,
						 source_class->class);
	    /* update the advection offset for this particle class */
	    particle_class->offset = source_class->offset;

	    source = source_class->first;	  /* and for each source */
	    while (source!=NULL) {
		if (source->state != DEAD_PARTICLE) { /*  that is inside the domain */
		    particle = (ParticleInfo *) malloc(sizeof(ParticleInfo));
		    particle->x = source->x;	  /*    create a new particle record */
		    particle->y = source->y;	  /*    and fill in the fields */
		    particle->z = source->z;
		    particle->class = source->class;
		    particle->cell = source->cell;
		    particle->grp = group;
		    particle->id = source->id;
		    particle->state = NEW_PARTICLE; /*    add it to the particle list */
		    particle->next = particle_class->first;
		    particle_class->first = particle;
		    particle_class->count += 1;	  /*    update particle list */
						  /*    counter */
		}
		source = source->next;		  /*    and advance to next source  */
	    }
	}
	source_class = source_class->next;	  /* advance to next source class */
    }
}

/* Set up local variables to compile for the current host */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* End: */
