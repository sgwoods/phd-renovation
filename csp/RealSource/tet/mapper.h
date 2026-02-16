/* 	$Id: mapper.h,v 1.4 1995/06/26 18:17:12 npkonrad Exp $	 */
/*************************************************************************/
/*     This file is part of a particle advection package It provides */
/*     functions for mapping shapes, colour, orientation onto particles */
/*     based on selected data fields */

/*     This file, mapper.h contains the definitions to accompany mapper.c */
/*     Functions include: */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211,                       */
/*  Date Created: Fri Jan 27 14:27:36 EST 1995 */

/*************************************************************************/


#ifndef MAPPER_H				  /* prevent multiple inclusions */
#define MAPPER_H

/*********** Include files  ***********/
      
#include <sys/time.h>				  /* system stuff */

#include <avs/avs.h>				  /* AVS stuff */
#include <avs/ucd_defs.h>
#include <avs/geom.h>
#include <avs/colormap.h>

#include "matrix.h"				  /* local stuff */
#include "particle.h"
#include "init_data.h"

/*********** Constant Definitions ***********/

#define BUF_LEN		(128)			  /* buffer length used for char input */
#define NO_DATA_OFFSET	(-1)			  /* Two uses: */
						  /* get_selection_offset returns this */
						  /*    value if the requested data */
						  /*    label is not in the given */
						  /*    data set, OR */
						  /* used to specify an attribute */
						  /*     value with no associated */
						  /*     data field (constant */
						  /*     attribute) */

#define MAPPER_OP_SHAPE		(1)		  /* OPs for mapper mode */
#define MAPPER_OP_SIZE		(2)
#define MAPPER_OP_COLOUR	(3)
#define MAPPER_OP_ORIENT	(4)
#define MAPPER_OP_ADVECT	(5)

#define MAPPER_SHAPE_SPHERE	(0)		  /* choices in shape mode */
#define MAPPER_SHAPE_CUBE	(1)		  /* details of mapper shape */
#define MAPPER_SHAPE_TETRA	(2)		  /* definitions are in  */
#define MAPPER_SHAPE_TUBE	(3)		  /* map_shapes.h */
#define MAPPER_SHAPE_PLUS	(4)
#define MAPPER_SHAPE_ARROW	(5)
#define MAPPER_SHAPE_COUNT	(6)		  /* number of available choices */
#define MAPPER_SHAPE_DEFAULT	MAPPER_SHAPE_SPHERE

#define MAPPER_SHAPE_NAMES	"Sphere:Cube:Tetra:Tube:Plus:Arrow"

#define MAPPER_MIN_SCALE	(0.1)		  /* used mainly by the ui mapping */
#define MAPPER_MAX_SCALE	(10.0)
#define MAPPER_DEF_SCALE	(1.0)		  /* default scale for particles */
						  /* relative to the global_scale */
#define MAPPER_MAX_COLOURS	(256)		  /* largest allowable colourmap */

/*********** Data Definitions ***********/

/* The mapper data structure contains all parameters for the mapper function */
/* The mapper has four essentially orthogonal mappings: */
/*    - shape - various shapes can be mapped to various ranges of the input data */
/*    - colour - select a data field to map to the colour of the particles */
/*    - size - select a data field to scale the colour */
/*    - orientation - select a data field to map to the particle orientation */
/* SHAPE: */
/*  Various shapes are available (or are planned): */
/*   Sphere, cube, tetrahedron, tube, plus, arrow, ribbon, wave */
/*     The first few are fairly intuitive, the  plus is envisioned to be a */
/*      "jack" type of shape, the arrow some sort of cone, maybe with a stem, */
/*      while the ribbon and wave mappings take advantage of the grouping */
/*      component of the particles.  With ribbons, particles released from */
/*      the same location are mapped to one object like a stream line, */
/*      and with waves, particles released at the same time are mapped together. */
/*  A Data selection is made for shape, so that shapes can be mapped to various */
/*     data ranges. Each shape has a range defined for which it will be mapped to */
/*     the particles. Each shape also has a default scale defined, so that when */
/*     multiple shapes are used, their relative sizes can be defined. */
/* COLOUR: */
/* SIZE: */
/* ORIENTATION: */
/*  Data selections are made to allow a data field to be mapped to colour, */
/*     size and orientation */

/* The MapperData data structure is essentially a list of mapping */
/* specifications, one each for an arbitrary number of user defined */
/* particle "classes".  The classes may be used to differentiate */
/* particles of differing origin, different material, different phase, */
/* etc..  For each class, a separate shape, size, colour, and orientation */
/* mapping may be defined, and if one isn't, a default mapping is used. */

/* data for shape mapping - contains mapping information for shape mapping. */
typedef struct mapShapeData {
    int code;					  /* which shape to map */
    int		offset;				  /* offset into current data field */
						  /* of the scalar to map to shape */
    double	min,max;			  /* range of data to map to the shape */
    struct mapShapeData *next;			  /* pointer to another shape mapping */
						  /* for this class (more than one */
						  /* range may be defined) */
} MapShapeData;

/* data for size mapping */
typedef struct mapSizeData {
    double	lo, hi;				  /* range of size scale factors */
    int		offset;				  /* offset into current data field */
						  /* of scalar to map to size */
    double	min, max;			  /* data range to map */
    struct mapSizeData *next;			  /* pointer to another size mapping */
						  /* for this class */
} MapSizeData;

/* data for orientation mapping */
typedef struct mapOrientData {
    int		offset;				  /* offset into current data field */
						  /* of first coordinate of vector */
						  /* to be mapped to orientation. */
    struct mapOrientData *next;			  /* pointer to another orient */
						  /* mapping  for this class */
} MapOrientData;

/* data for colour mapping */
typedef struct mapColourData {
    AVScolormap	*map;				  /* this contains arrays of hsv */
						  /* colours as well as lower/upper */
						  /* values which are used to map */
						  /* parameters onto the colourmap */
    int offset;					  /* offset into mapping data field */
    struct mapColourData *next;			  /* pointer to another colour */
						  /* mapping for this class */
} MapColourData;

/* data for advection */
typedef struct mapAdvectData {			  /* contains offset of data field to */
    int offset;					  /* be used to advect the particles */
} MapAdvectData;				  /* of this class */

/* overall mapping list data structure */
typedef struct mapperData {
    int class;					  /* the class of particle to which */
						  /* this mapping applies */
    struct mapperData *next;			  /* pointer to next particle class */
						  /* mapping */
    MapShapeData	*shape;			  /* pointer to shape mapping */
    MapSizeData		*size;			  /* pointer to size mapping */
    MapColourData	*colour;		  /* pointer to colour mapping */
    MapOrientData	*orient;		  /* pointer to orientation mapping */
    MapAdvectData	*advect;		  /* pointer to advection mapping */
} MapperData;

/*********** Function Definitions ***********/

/***  This routine is included in <avs/lib/libutil.a> but not included */
/***  in any include files from AVS.  I discovered it by looking at the public domain */
/***  module, ucd_cell_geom, which uses it.  It returns the rgb values corresponding */
/***  to the given hsv values, and is required to use the output of a colormap. */
/* I include a note of it here, simply because it doesn't seem to be documented */
/* anywhere else.  */

/*    FILTERhsv_to_rgb (float *red, float *green, float *blue,   */
/*                      float hue, float sat, float val );   */

/***** Operations on MapperData *****/
/* destructor */
int destroy_mapperData(MapperData **map_spec);
/* utility */
MapperData *find_class_map(MapperData *map_spec, int class);

int clear_mapperData(MapperData **map_spec,
		     int default_shape,
		     float default_size,
		     AVScolormap *Colour_Map,
		     float Colour_Value,
		     int advect_offset);

MapperData *get_class_map(MapperData **map_spec, int class);

int clear_shape_mapping(MapperData *map_spec);
int add_shape_mapping(MapperData *map_spec,
		      char *shape_name,
		      int offset,
		      double min,
		      double max);

int clear_size_mapping(MapperData *map_spec);
int add_size_mapping(MapperData *map_spec,
		     double lo,
		     double hi,
		     int offset,
		     double min,
		     double max);

int clear_colour_mapping(MapperData *map_spec);
int add_colour_mapping(MapperData *map_spec,
		       AVScolormap *colourmap,
		       int offset);

int clear_orient_mapping(MapperData *map_spec);
int add_orient_mapping(MapperData *map_spec,
		       int offset);

int clear_advect_mapping(MapperData *map_spec);
int add_advect_mapping(MapperData *map_spec,
		       int offset);

/*** general functions ***/
int parse_mapping(DataSelection *scalar_sel,
		  DataSelection *vector_sel,
		  int default_shape,
		  float default_size,
		  AVScolormap *Colour_Map,
		  float Colour_Value,
		  char *map_input,
		  MapperData **map_spec);

int map_particles(UCD_structure *ucd_input,
		  CellTransforms *cell_ctrans,
		  ParticleList *particle_list,
		  MapperData **map_spec,
		  double global_scale,
		  GEOMedit_list Geometry);

double interp_data(UCD_structure *ucd_input,
		   int offset,
		   ParticleInfo *particle,
		   CellTransforms *cell_ctrans);

void update_advect_offsets(MapperData **map_spec,
			   ParticleList *source_list);

/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* End: */

#endif MAPPER_H



