/* 	$Id: mapper.c,v 1.4 1995/06/26 18:14:36 npkonrad Exp $	 */

#ifndef lint
static char vcid[] = "$Id: mapper.c,v 1.4 1995/06/26 18:14:36 npkonrad Exp $";
#endif /* lint */
/*************************************************************************/
/*     This file is part of a particle advection package It provides */
/*     functions for mapping shapes, colour, orientation onto particles */
/*     based on selected data fields */

/*     This file, mapper.c contains the code for supporting functions. */
/*     Declarations and function prototypes are included in mapper.h. */
/*     Functions include: */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211,                       */
/*  Date Created: Fri Jan 27 14:27:36 EST 1995 */

/*************************************************************************/

#include "mapper.h"

/* this file contains definitions of the individual shapes which can */
/* be mapped onto particles */
#include "map_shapes.h"

/*********** Function Definitions ***********/

/**********************************************************************/
/* int parse_mapping(DataSelection *scalar_sel, */
/*                   DataSelection *vector_sel, */
/*                   int default_shape, */
/*		     float default_size, */
/* 		     AVScolormap *Colour_Map, */
/* 		     float Colour_Value, */
/* 		     char *map_input, */
/* 		     MapperData **map_spec) */

/*     Parses ascii input of a mapping specification, and builds the */
/*     MapperData structure which is used by map_particles to apply the */
/*     specified mappings to the active particles.  Also includes a default mapping */
/*     based on the values from the default mapping user interface inputs. */
/**********************************************************************/
int parse_mapping(DataSelection *scalar_sel,
		  DataSelection *vector_sel,
		  int default_shape,
		  float default_size,
		  AVScolormap *Colour_Map,
		  float Colour_Value,
		  char *map_input,
		  MapperData **map_spec)
{
    FILE	*map_fp;			  /* file pointer for input file */
    int		file_error = 0;			  /* keep track of file errors */
    char	*err_msg;
    int		in_count;
    char	c;
    char	in_command[BUF_LEN];		  /* input line from the file */
    char	buf[BUF_LEN];			  /* temp string buffer */
    char	shape_name[16];
    char	*op;
    int		mode;
    MapperData	*class_spec;
    int		class;
    int		offset;
    double	lo, hi, min, max;

    int		mapsize;			  /* size of colour map to be created */
    float	hue, sat, val, alpha;		  /* colour values */
    float	*hues, *sats, *vals, *alphas;	  /* colour value arrays for colourmaps */
    AVScolormap	*new_colour_map;

    /* first reset the mapping to default */
    clear_mapperData(map_spec, default_shape, default_size,
		     Colour_Map, Colour_Value,
		     vector_sel->current);
    

    file_error = 0;
    err_msg = NULL;
    /* initialize the input stream (be it string data or file input) */
    if ((strcmp(map_input, "")!=0) &&
	(sscanf(map_input, "%s", buf)==1) &&
	(buf[strlen(buf)-1]!='/')) {		  /* if non-null filename */
	map_fp = fopen(map_input, "r");		  /*    open it, if possible */
	if (map_fp==NULL) {
	    file_error = 1;
	    err_msg = "can't open Map Spec file";
	}
	while ((!file_error) &&			  /* get a line from the file */
	       (fgets(in_command, BUF_LEN, map_fp)!=NULL)) {
	    if ((in_command[0] != '#') &&	  /*    if not a comment */
		(sscanf(in_command, "%s", buf)==1)) { /* get first word */
		if ((op=strstr(buf, "shape"))!=NULL) {
		    mode = MAPPER_OP_SHAPE;	  /*       try to extract operation */
		} else if ((op=strstr(buf, "size"))!=NULL) {
		    mode = MAPPER_OP_SIZE;
		} else if ((op=strstr(buf, "colour"))!=NULL) {
		    mode = MAPPER_OP_COLOUR;
		} else if ((op=strstr(buf, "orient"))!=NULL) {
		    mode = MAPPER_OP_ORIENT;
		} else if ((op=strstr(buf, "advect"))!=NULL) {
		    mode = MAPPER_OP_ADVECT;
		} else {			  /*        error if can't */
		    file_error = 1;
		    err_msg = "unknown mapper mode";
		    break;			  /*           so get out of the loop */
		}
		if (op==buf) {			  /*       if no particle class */ 
		    class = DEF_PARTICLE_CLASS;	  /*          set to default */
		} else {			  /*    else  */
		    if (sscanf(buf, "%d", &class)!=1) { /*     read the class */
			file_error = 1;
			err_msg = "can not read mapping class";
			break;
		    }
		}
		switch (mode) {
		case MAPPER_OP_SHAPE:
		    if (sscanf(in_command, "%*s %s %s %lf %lf",
			       shape_name, buf, &min, &max) == 4) {
			offset = get_selection_offset(scalar_sel, buf);
			if (offset == NO_DATA_OFFSET) {
			    file_error = 1;
			    err_msg = "unknown data field";
			    break;
			}
		    } else if (sscanf(in_command, "%*s %s", shape_name) == 1) {
			offset = NO_DATA_OFFSET;
			min = max = 0.0;
		    } else {
			file_error = 1;
			err_msg = "bad shape syntax";
			break;
		    }
		    /* get the specification for this particle class */
		    class_spec = get_class_map(map_spec, class);
		    file_error = add_shape_mapping(class_spec, shape_name,
						   offset, min, max);
		    if (file_error) err_msg = "unknown shape";
		    break;
		case MAPPER_OP_SIZE:
		    if (sscanf(in_command, "%*s %lf %lf %s %lf %lf",
			       &lo, &hi, buf, &min, &max) == 5) {
			offset = get_selection_offset(scalar_sel, buf);
			if (offset == NO_DATA_OFFSET) {
			    file_error = 1;
			    err_msg = "unknown data field";
			    break;
			}
		    } else if (sscanf(in_command, "%*s %lf", &lo) == 1) {
			offset = NO_DATA_OFFSET;
			hi =  lo;
			min = max = 0.0;
		    } else {
			file_error = 1;
			err_msg = "bad size syntax";
			break;
		    }
		    /* get the specification for this particle class */
		    class_spec = get_class_map(map_spec, class);
		    file_error = add_size_mapping(class_spec,
						  lo, hi,
						  offset, min, max);
		    if (file_error) err_msg = "size mapping";
		    break;
		case MAPPER_OP_COLOUR:
		    if (sscanf(in_command, "%*s {%f,%f,%f,%f}",
			       &hue, &sat, &val, &alpha)==4) {
			mapsize = 1;		  /* set up a 1 entry colourmap */
			new_colour_map = (AVScolormap *)
			    AVSdata_alloc("colormap", &mapsize);
			new_colour_map->size = mapsize;
			new_colour_map->lower = 0.0;
			new_colour_map->upper = 1.0;
			new_colour_map->hue[0] = hue;
			new_colour_map->saturation[0] = sat;
			new_colour_map->value[0] = val;
			new_colour_map->alpha[0] = alpha;

			/* get the spec for this particle class */
			class_spec = get_class_map(map_spec, class);
			file_error = add_colour_mapping(class_spec,
							new_colour_map,
							NO_DATA_OFFSET);
		    } else if (sscanf(in_command, "%*s {{%f,%f,%f,%f}",
				      &hue, &sat, &val, &alpha)==4) {
#ifndef READ_COLOUR_MAPS
			/* allocate arrays for h, s, v, a */
			hues = (float *) malloc(MAPPER_MAX_COLOURS*sizeof(float));
			sats = (float *) malloc(MAPPER_MAX_COLOURS*sizeof(float));
			vals = (float *) malloc(MAPPER_MAX_COLOURS*sizeof(float));
			alphas = (float *) malloc(MAPPER_MAX_COLOURS*sizeof(float));
			mapsize = 0;
			/* read many more lines of {h,s,v,a} into the arrays */
			while (1) {
			    hues[mapsize] = hue;  /* copy colour into colourmap */
			    sats[mapsize] = sat;  /* arrays  */
			    vals[mapsize] = val;
			    alphas[mapsize] = alpha;
			    mapsize++;
			    /* get next line of mapfile */
			    if (fgets(in_command, BUF_LEN, map_fp)==NULL) {
				file_error = 1;
				err_msg = "error reading colour map";
				break;
			    }
			    if (sscanf(in_command, "{%f,%f,%f,%f}} %s %lf %lf",
				       &hue, &sat, &val, &alpha, buf, &min, &max)==7) {
				break;		  /* end of colourmap */
			    } else if (sscanf(in_command, "{%f,%f,%f,%f}",
					      &hue, &sat, &val, &alpha)!=4) {
				/* colourmap syntax error */
				file_error = 1;
				err_msg = "colourmap syntax error";
				break;
			    }
			}
			if (!file_error) {
			    hues[mapsize] = hue;  /* copy colour into colourmap */
			    sats[mapsize] = sat;  /* arrays  */
			    vals[mapsize] = val;
			    alphas[mapsize] = alpha;
			    mapsize++;
			    /* allocate a colourmap for the size read */
			    new_colour_map = (AVScolormap *)
				AVSdata_alloc("colormap", &mapsize);
			    /* transfer hsva values to new structure */
			    new_colour_map->size = mapsize;
			    new_colour_map->lower = min;
			    new_colour_map->upper = max;
			    while (mapsize>0) {
				new_colour_map->hue[mapsize] =  hues[mapsize];
				new_colour_map->saturation[mapsize] = sats[mapsize];
				new_colour_map->value[mapsize] = vals[mapsize];
				new_colour_map->alpha[mapsize] = alphas[mapsize];
				mapsize--;
			    }
			    /* install colour map in map_spec */
			    offset = get_selection_offset(scalar_sel, buf);
			    if (offset == NO_DATA_OFFSET) {
				file_error = 1;
				err_msg = "unknown data field";
			    } else {
				class_spec = get_class_map(map_spec, class);
				file_error = add_colour_mapping(class_spec,
								new_colour_map,
								offset);
				if (file_error) err_msg = "colour mapping";
			    }
			}
			free(hues);		  /* free colour arrays */
			free(vals);
			free(sats);
			free(alphas);
#else
			file_error = 1;
			err_msg = "file based colour maps not yet supported";
#endif
		    } else {
			file_error = 1;
			err_msg = "bad colour syntax";
		    }
		    break;
		case MAPPER_OP_ORIENT:
		    if (sscanf(in_command, "%*s %s", buf) == 1) {
			offset = get_selection_offset(vector_sel, buf);
			if (offset == NO_DATA_OFFSET) {
			    file_error = 1;
			    err_msg = "unknown data field for orient";
			    break;
			}
		    } else {
			file_error = 1;
			err_msg = "bad orient syntax";
			break;
		    }
		    /* get the specification for this particle class */
		    class_spec = get_class_map(map_spec, class);
		    file_error = add_orient_mapping(class_spec, offset);
		    if (file_error) err_msg = "orient mapping";
		    break;
		case MAPPER_OP_ADVECT:
		    if (sscanf(in_command, "%*s %s", buf) == 1) {
			offset = get_selection_offset(vector_sel, buf);
			if (offset == NO_DATA_OFFSET) {
			    file_error = 1;
			    err_msg = "unknown data field for advect";
			    break;
			}
		    } else {
			file_error = 1;
			err_msg = "bad advect syntax";
			break;
		    }
		    /* get the specification for this particle class */
		    class_spec = get_class_map(map_spec, class);
		    file_error = add_advect_mapping(class_spec, offset);
		    if (file_error) err_msg = "advect mapping";
		    break;
		default:
		    ;
		}
	    }
	    if (in_command[strlen(in_command)-1]  /*    if didn't read to EOL */
		!='\n') {
		while (((c=fgetc(map_fp))!=EOF) && /*       read to end of file */
		       (c!='\n'));		  /*          or end of line */
	    }
	}
	if (map_fp!=NULL) fclose(map_fp);	  /* close the file */
	if (file_error) {			  /* if an error was encountered, */
	    clear_mapperData(map_spec,		  /*    just return the default */
			     default_shape, default_size,
			     Colour_Map, Colour_Value,
			     vector_sel->index[vector_sel->current]);
    AVSwarning("parse_mapping: %s", err_msg);
						  /*    mapping */ 
	}
    }
}
      
/*************************************************************************/
/* int map_particles(UCD_structure *ucd_input, */
/* 		  ParticleList *particle_list, */
/* 		  MapperData **map_spec, */
/*                double global_scale, */
/* 		  GEOMedit_list Geometry) */

/*     This routine takes input data, a particle list, and various mapping */
/*     parameters and creates the geometry of the particles according to the */
/*     given parameters. */

/*     This routine is also responsible for removing DEAD particles from the */
/*     particle list and removing their geometry objects at the same time. */

/*     Currently, it simply maps the vertices onto points which are plotted */
/*     in the geometry window. */

/*************************************************************************/
int map_particles(UCD_structure *ucd_input,
		  CellTransforms *cell_ctrans,
		  ParticleList *particle_list,
		  MapperData **map_spec,
		  double global_scale,
		  GEOMedit_list Geometry)
{
    ParticleList *particle_class;
    ParticleInfo *particle;
    ParticleInfo *temp;
    int		count;				  /* number of active particles */

    float	*node_data;			  /* pointer to data for each node */

    Vertex	*sphere_vert;			  /* list of vertices for geometry */ 
    float	*radii;				  /* list of radii for each sphere */
    Vertex	*sphere_colour;			  /* colour values for spheres */
    GEOMobj	*objSphere;			  /* sphere geom */

    Vertex	*poly_vert;			  /* polyhedron vertices */
    int		*faces;				  /* list of node indices for the */
						  /* faces of a polyhedron */
    Vertex	*poly_colour;			  /* colour values for other shapes */
    GEOMobj	*objPoly;			  /* polyhedral geom */


    MapperData	*default_mapping, *mapping;
    MapShapeData	*map_shape;
    MapSizeData		*map_size;
    MapColourData	*map_colour;
    MapOrientData	*map_orient;

    int		sphere_count;			  /* number of spheres added to */
						  /* sphere object */
    int		poly_pt_count;			  /* number of vertices previously */
						  /* added to current polygon object */

    double	scale;				  /* computed scale for the current */
    int		colour_index;			  /* index into the colour map for */
						  /* the current particle */
    float	red, green, blue;		  /* colour values for the current */
						  /* particle  */
    int		i, j;				  /* loop counters */

    particle_class = particle_list;
    count = 0;
    while (particle_class!=NULL) {		  /* for each class */
	particle = particle_class->first;
	while ((particle!=NULL) &&		  /*    delete deads at front */
	       (particle->state==DEAD_PARTICLE)){ /*    of list */
	    particle_class->first = particle->next;
	    free(particle);
	    particle = particle_class->first;
	    particle_class->count--;		  /*    and decrement count */
	}
	while ((particle!=NULL) &&		  /* if more than one left, */
	       (particle->next!=NULL)) {
	    if (particle->next->state==DEAD_PARTICLE) {
		temp = particle->next;		  /*    remove the "one after" if */
		particle->next = temp->next;	  /*    it's DEAD */ 
		free(temp);
		particle_class->count--;	  /*    and decrement count */
	    }
	    particle = particle->next;
	}
	count += particle_class->count;		  /*    accumulate the remaining */
						  /*    count */
	particle_class = particle_class->next;	  /*    move to next class */
    }

    /* At this point, it's a bit of a problem to have a mapping that can create */
    /* both spheres and polyhedra--TODO: resolve this. */
    /* Two objects are created: ParticlePoly and ParticleSphere, containing */
    /* polyhedral and spherical particles respectively. */

    /* create two geometry objects to hold the particle geometry */
    objPoly = GEOMcreate_obj(GEOM_POLYHEDRON, GEOM_NULL);
    objSphere = GEOMcreate_obj(GEOM_SPHERE, GEOM_NULL);

    if (count>0) {				  /* if there are active particles */
	/* get data over which to map */
	UCDstructure_get_node_data (ucd_input, &node_data);
		/* allocate some memory to store object information */

	/* allocate memory for sphere objects */
	sphere_vert = (Vertex *) malloc(count * sizeof(Vertex));
	radii = (float *) malloc(count * sizeof(float));
	sphere_colour = (Vertex *) malloc(count * sizeof(Vertex));

	/* allocate memory for polyhedron objects */
	poly_vert = (Vertex *) malloc(MAP_MAX_VERTS * sizeof(Vertex));
	/* allocate 5 ints for each face, as each face needs */
	/* a count and up to 4 node indices */
	faces = (int *) malloc(MAP_MAX_FACES*5*sizeof(int));

	/* allocate some memory to accumulate colour values */
	poly_colour = (Vertex *) malloc(count *
					MAP_MAX_VERTS * sizeof(Vertex));

	/* find the default mapping */
	default_mapping = get_class_map(map_spec, DEF_PARTICLE_CLASS);

	sphere_count = 0;			  /* accumulation of vertices for */
	poly_pt_count = 0;			  /* spheres and polygon objects */

	particle_class = particle_list;
	while (particle_class!=NULL) {		  /* for each particle class */
	    /* find the mapping specification for this class */
	    mapping = get_class_map(map_spec, particle_class->class);
	    map_shape = (mapping->shape==NULL ?
			 default_mapping->shape :
			 mapping->shape);
	    map_size = (mapping->size==NULL ?
			default_mapping->size :
			mapping->size);
	    map_colour = (mapping->colour==NULL ?
			  default_mapping->colour :
			  mapping->colour);
	    map_orient = (mapping->orient==NULL ?
			  default_mapping->orient :
			  mapping->orient);

	    /* now, for each particle in the class */
	    particle = particle_class->first;
	    while (particle!=NULL) {
		if ((particle->state==MOVED_PARTICLE) || /*    update the state */
		    (particle->state==NEW_PARTICLE)) {
		    particle->state = OLD_PARTICLE;
		}

		/* find the scale for this particle */
		if (map_size->offset==NO_OFFSET) {
		    scale = global_scale * map_size->lo;
		} else {
		    /***** TODO : This needs massive optimization */
		    scale = global_scale *
			(map_size->lo + (map_size->hi - map_size->lo) *
			 (interp_data(ucd_input, map_size->offset,
				      particle, cell_ctrans) -
			  map_size->min)/(map_size->max-map_size->min));
		}
		
		/* find the colour for this particle */
		if (map_colour->offset==NO_OFFSET) {
		    colour_index = 0;
		} else {
		    colour_index = AVScmap_index(map_colour->map,
						 interp_data(ucd_input,
							     map_colour->offset,
							     particle, cell_ctrans));
		}
		FILTERhsv_to_rgb(&red, &green, &blue,
				 map_colour->map->hue[colour_index],
				 map_colour->map->saturation[colour_index],
				 map_colour->map->value[colour_index]);

		/*    create the geometry for the particle */
		if (map_shape->code==MAPPER_SHAPE_SPHERE) {/* sphere particle */
		
		    sphere_vert[0][X_COORD] = particle->x; /* get the locations */
		    sphere_vert[0][Y_COORD] = particle->y;
		    sphere_vert[0][Z_COORD] = particle->z;
		
		    radii[0] = scale;		  /* apply the global scale */
		    /*    add it to the sphere geometry object */
		    GEOMadd_vertices(objSphere, (float *) sphere_vert, 1,
				     GEOM_COPY_DATA);
		    GEOMadd_radii(objSphere, radii, 1, GEOM_COPY_DATA);

		    /* add the current colour to the vertex colour list */
		    sphere_colour[sphere_count][0] = red;
		    sphere_colour[sphere_count][1] = green;
		    sphere_colour[sphere_count][2] = blue;
		    sphere_count++;
		} else {				  /* polyhedral particle */
		    i = 0;				  /*    create the polygon */
							  /*    face node list, */
							  /*    shifting the node */ 
							  /*    indices to account */
							  /*    for previously added */
							  /*    nodes */ 
		    faces[i] = map_shape_topo[map_shape->code][i];
		    while (faces[i]!=0) {
			for (j = faces[i], i++ ; j>0 ; j--, i++) {
			    faces[i] = map_shape_topo[map_shape->code][i]
				+ poly_pt_count;
			}
			faces[i] = map_shape_topo[map_shape->code][i];
		    }
		    for (i=0 ;			  /*    and create the node list, */
						  /*    applying the current scale */
						  /*    and particle position */
			 i<map_shape_num_nodes[map_shape->code] ; i++) {
			poly_vert[i][X_COORD] = particle->x +
			    scale*map_shape_nodes[map_shape->code][i][X_COORD];
			poly_vert[i][Y_COORD] = particle->y +
			    scale*map_shape_nodes[map_shape->code][i][Y_COORD];
			poly_vert[i][Z_COORD] = particle->z +
			    scale*map_shape_nodes[map_shape->code][i][Z_COORD];
			poly_colour[poly_pt_count][0] = red; /* and add colour to the */
			poly_colour[poly_pt_count][1] = green; /* colour list for this */
			poly_colour[poly_pt_count][2] = blue; /* node  */ 
			poly_pt_count++;
		    }
		    /*    add vertices to the poly geometry object */
		    GEOMadd_vertices(objPoly, (float *) poly_vert,
				     map_shape_num_nodes[map_shape->code], 
				     GEOM_COPY_DATA);
		    GEOMadd_polygons(objPoly, faces, GEOM_CONVEX, GEOM_COPY_DATA);
		}
		particle = particle->next;	  /* next particle */
	    }
	    /* on to the next particle class */
	    particle_class = particle_class->next;
	}
	if (sphere_count>0) {
	    GEOMadd_float_colors(objSphere, sphere_colour,
				 sphere_count, GEOM_COPY_DATA);
	}
	if (poly_pt_count>0) {
	    GEOMadd_float_colors(objPoly, poly_colour,
				 poly_pt_count, GEOM_COPY_DATA);
	}
	free(sphere_vert);			  /* and free the memory */
	free(poly_vert);
	free(radii);
	free(faces);
	free(sphere_colour);
	free(poly_colour);
    }
    GEOMedit_geometry(Geometry, "ParticleSpheres", objSphere);
    GEOMdestroy_obj(objSphere);
    GEOMedit_geometry(Geometry, "ParticlePoly", objPoly);
    GEOMdestroy_obj(objPoly);

    return(count);				  /* return number of active */
						  /* particles  */
}

/**********************************************************************/
/* double interp_data(UCD_structure *ucd_input, */
/* 		   int offset, */
/* 		   ParticleInfo *particle, */
/* 		   CellTransforms *cell_ctrans) */
/* Given a pointer to a particle, a data component offset, and the current data set, */
/* this routine returns the interpolated value for the indicated data component at */
/* the location of the particle.  */
/**********************************************************************/
double interp_data(UCD_structure *ucd_input,
		   int offset,
		   ParticleInfo *particle,
		   CellTransforms *cell_ctrans)
{
    Vect4	pos;				  /* cartesian coords of particle */
    Mat44	*to_cart, *to_bary;		  /* transforms to/from barycentric */
    Vect4	pos_bary;			  /* barycentric coords of particle */
    Vect4	node_val;			  /* data value at cell nodes */
    double	interp_value;			  /* interp'ed data value at particle */

    int  	elem_id, mat_id, cell_type, me_flags; /* cell parameters */
    char	int_cell_name;
    int		*nodes;
    float	*node_data;

    char	name[80];			  /* params for ucd header */
    int		data_veclen, name_flag, ncells, cell_veclen;
    int		nnodes, node_veclen, util_flag;

    pos[0] = particle->x;			  /* find the barycentric position */
    pos[1] = particle->y;
    pos[2] = particle->z;
    pos[3] = 1;

    get_cell_trans(cell_ctrans, particle->cell,	  /* get transformation to barycentric */
		   &to_cart, &to_bary);

    vect4_transform(*to_bary, pos, pos_bary);

    UCDcell_get_information (ucd_input,		  /*    get cell info  (ie. nodes) */
			     particle->cell, (char *) &elem_id,
			     &int_cell_name,
			     &mat_id, &cell_type,
			     &me_flags, &nodes);

    UCDstructure_get_node_data (ucd_input, &node_data);	/* get node data vector */

    if (!UCDstructure_get_header (ucd_input, name, &data_veclen, &name_flag,
				  &ncells, &cell_veclen, &nnodes,
				  &node_veclen, &util_flag)) {
	AVSerror ("tetravect: can't get data header.\n");
	return;
    }

    node_val[0] = node_data[ nnodes*offset + nodes[0]];
    node_val[1] = node_data[ nnodes*offset + nodes[1]];
    node_val[2] = node_data[ nnodes*offset + nodes[2]];
    node_val[3] = node_data[ nnodes*offset + nodes[3]];

    interp_value = Vect4dot4(pos_bary, node_val);
    return(interp_value);
}

/**********************************************************************/
/* The following section contains definitions for functions associated */
/* with the MapperData type.  They include constructors and */
/* destructors, and other functions for modifying the structure. */
/**********************************************************************/
/**********************************************************************/
/* int destroy_mapperData(MapperData **map_spec); */
/*    destructor for MapperData.  Assumes map_spec has been previosly */
/*    initialized with init_mapperData, and releases all memory allocated */
/*    within it. */
/**********************************************************************/
int destroy_mapperData(MapperData **map_spec)
{
    MapperData *local_spec;

    clear_mapperData(map_spec, 0, 0.0, NULL, 0.0, 0); /* first get rid of */
						  /* all but the */
						  /* default mapping */
    local_spec = *map_spec;
    free(local_spec->shape);			  /* Then get rid of its */
    free(local_spec->size);			  /* mapping values */
    free(local_spec->colour);
    free(local_spec->orient);
    free(local_spec->advect);
    free(local_spec);

    *map_spec = NULL;				  /* finally, return NULL */
}

/**********************************************************************/
/* int clear_mapperData(MapperData **map_spec, */
/*                      int default_shape, */
/*                      float default_size, */
/*                      AVScolormap *Colour_Map, */
/*                      float Colour_Value, */
/*                      int advect_offset); */
/*     Given a mapping specification, removes all non-default mapping */
/*     specifications, and frees the associated memory. It assumes that map_spec has */
/*     been previously initialized with init_mapperData, and only modified using the */
/*     functions provided in this module. */
/**********************************************************************/
int clear_mapperData(MapperData **map_spec,
		     int default_shape,
		     float default_size,
		     AVScolormap *Colour_Map,
		     float Colour_Value,
		     int advect_offset)
{
    MapperData	*this_spec;
    AVScolormap	*new_colour_map;
    int		colour_index;
    int		mapsize;

    if (*map_spec!=NULL) {			  /* if a previous mapping exists */
	this_spec = *map_spec;			  /* remove it, starting at the */
	while (this_spec!=NULL) {		  /* for each class specification */
	    clear_shape_mapping(this_spec);	  /*    clear out the individual */
	    clear_size_mapping(this_spec);		  /*    mappings  */
	    clear_colour_mapping(this_spec);
	    clear_orient_mapping(this_spec);
	    clear_advect_mapping(this_spec);
	    *map_spec = this_spec->next;	  /*    and remove the */
	    free(this_spec);			  /*    class mapping itself */
	    this_spec = *map_spec;
	}
    }
    /* add a default class mapping */
    this_spec = get_class_map(map_spec, DEF_PARTICLE_CLASS);

    /* add a sphere shape mapping connected to no data field */
    add_shape_mapping(this_spec,		  /* use default shape */
		      map_shape_names[default_shape],
		      NO_DATA_OFFSET,		  /* no data mapping */
		      0.0, 0.0);		  /* no data range */

    add_size_mapping(this_spec,
		     default_size,		  /* constant default size */
		     default_size,
		     NO_DATA_OFFSET,		  /* no data mapping */
		     0.0, 0.0);			  /* no data range */

    /* define a colourmap for the default colour mapping */
    if (Colour_Map==NULL) {			  /* allow for possible null colourmap */
	new_colour_map = NULL;
    } else {
	colour_index = AVScmap_index(Colour_Map, Colour_Value);
	/* allocate a colourmap with one colour in it */
	mapsize = 1;
	new_colour_map = (AVScolormap *) AVSdata_alloc("colormap", &mapsize);
	new_colour_map->size = mapsize;
	new_colour_map->lower = 0.0;
	new_colour_map->upper = 1.0;
	new_colour_map->hue[0] = Colour_Map->hue[colour_index];
	new_colour_map->saturation[0] = Colour_Map->saturation[colour_index];
	new_colour_map->value[0] = Colour_Map->value[colour_index];
	new_colour_map->alpha[0] = 0.0;
    }
    add_colour_mapping(this_spec,
		       new_colour_map,
		       NO_DATA_OFFSET);		  /* no data mapping */

    add_orient_mapping(this_spec,
		       NO_DATA_OFFSET);		  /* no data mapping */

    add_advect_mapping(this_spec,		  /* default data field for advection */
		       advect_offset);

    return(1);
}

/**********************************************************************/
/* MapperData *find_class_map(MapperData *map_spec, int class); */
/*    Given a mapping specification and a particle class, returns a pointer */
/*    to the spec for that class or NULL if none exists in the specification */
/**********************************************************************/
MapperData *find_class_map(MapperData *map_spec, int class)
{
    MapperData *this_class;

    this_class = map_spec;
    while ((this_class!=NULL) &&
	   (this_class->class!=class)) {
	this_class = this_class->next;
    }
    return(this_class);
}

/**********************************************************************/
/* MapperData *get_class_map(MapperData **map_spec); */
/*     Given a mapping specification and class, finds the class mapping entry in the */
/*     specification if there is one, or adds an entry to the specification for that */
/*     class if there isn't.  It returns a pointer to the class spec in either */
/*     case. */ 
/**********************************************************************/
MapperData *get_class_map(MapperData **map_spec, int class)
{
    MapperData *this_class;

    this_class = find_class_map(*map_spec, class);
    if (this_class==NULL) {			  /* if there exists no such class */
	this_class = (MapperData *) malloc(sizeof(MapperData));
	this_class->class = class;		  /*    add it to the spec */
	this_class->shape = NULL;		  /*    with null values */
	this_class->size = NULL;
	this_class->colour = NULL;
	this_class->orient = NULL;
	this_class->advect = NULL;
	this_class->next = *map_spec;		  /*    at the front of the list */
	*map_spec = this_class;
    }
    return(this_class);				  /* and return the mapping */
}

/**********************************************************************/
/* The following routines provide a means to add particular mappings to the mapping */
/* structure, and conversely, to removethe existing mappings from a class mapping. */
/**********************************************************************/
int add_shape_mapping(MapperData *map_spec,	  /* add to this map spec */
		      char *shape_name,		  /* shape used */
		      int offset,		  /* data field used */
		      double min,		  /* range of data field to map to */
		      double max)		  /* this shape */
{
    MapShapeData	*this_shape;
    int		shape_code;

    shape_code = 0;
    while ((strcmp(shape_name, map_shape_names[shape_code])!=0) &&
	   (shape_code < MAPPER_SHAPE_COUNT)) {
	shape_code++;
    }
    if (shape_code==MAPPER_SHAPE_COUNT) {
	AVSwarning("add_shape_mapping: Unknown shape name: %s", shape_name);
	return(1);
    }
						  /* allocate memory */
    this_shape = (MapShapeData *) malloc( sizeof(MapShapeData));
    this_shape->code = shape_code;		  /* set the shape code */
    this_shape->offset = offset;		  /* and the mapping offset */
    this_shape->min = min;			  /* add range of mapping */
    this_shape->max = max;
    this_shape->next = map_spec->shape;		  /* and add it to the list */
    map_spec->shape = this_shape;
    
    return(0);
}

int clear_shape_mapping(MapperData *map_spec)
{
    MapShapeData *this_shape;

    while (map_spec->shape!=NULL) {	  /*   remove the shape, */
	this_shape = map_spec->shape;
	map_spec->shape = this_shape->next;
	free(this_shape);
    }
}

int add_size_mapping(MapperData *map_spec,
		     double lo,
		     double hi,
		     int offset,
		     double min,
		     double max)
{
    MapSizeData	*this_size;

    this_size = (MapSizeData *) malloc( sizeof(MapSizeData));
    this_size->lo = lo;				  /* fill in the fields */
    this_size->hi = hi;
    this_size->offset = offset;
    this_size->min = min;
    this_size->max = max;
    this_size->next = map_spec->size;		  /* and link into the current mapping */
    map_spec->size = this_size;
    return(0);
}

int clear_size_mapping(MapperData *map_spec)
{
    MapSizeData *this_size;

    while (map_spec->size!=NULL) {	  /*   remove the size, */
	this_size = map_spec->size;
	map_spec->size = this_size->next;
	free(this_size);
    }
}

int add_colour_mapping(MapperData *map_spec,
		       AVScolormap *colourmap,
		       int offset)
{
    MapColourData	*this_colour;

    /* allocate colour block */
    this_colour = (MapColourData *) malloc( sizeof(MapColourData));
    this_colour->map = colourmap;
    this_colour->offset = offset;		  /* init values */
    this_colour->next = map_spec->colour;	  /* and add to list */
    map_spec->colour = this_colour;
    return(0);
}

int clear_colour_mapping(MapperData *map_spec)
{
    MapColourData *this_colour;

    while (map_spec->colour!=NULL) {		  /*   remove the colour, */
	this_colour = map_spec->colour;
	if (this_colour->map!=NULL) {		  /* free the colourmap if there is */
	    AVSdata_free("colormap", (char *) this_colour->map); /* one */ 
	}
	map_spec->colour = this_colour->next;
	free(this_colour);
    }
}

int add_orient_mapping(MapperData *map_spec, int offset)
{
    MapOrientData	*this_orient;

    this_orient = (MapOrientData *) malloc( sizeof(MapOrientData));
    this_orient->offset = offset;		  /* init values */
    this_orient->next = map_spec->orient;	  /* and add it to the list */
    map_spec->orient = this_orient;
}

int clear_orient_mapping(MapperData *map_spec)
{
    MapOrientData *this_orient;

    while (map_spec->orient!=NULL) {	  /*   remove the orient, */
	this_orient = map_spec->orient;
	map_spec->orient = this_orient->next;
	free(this_orient);
    }
}

int add_advect_mapping(MapperData *map_spec, int offset)
{
    MapAdvectData	*this_advect;

    if (map_spec->advect==NULL) {
	this_advect = (MapAdvectData *) malloc( sizeof(MapAdvectData));
    } else {
	this_advect = map_spec->advect;
    }
    this_advect->offset = offset;		  /* init values */
    map_spec->advect = this_advect;
    return(0);
}

int clear_advect_mapping(MapperData *map_spec)
{
    MapAdvectData *this_advect;

    if (map_spec->advect!=NULL) {	  /*   remove the advect, */
	free(map_spec->advect);
    }
}

/**********************************************************************/
/* void update_advect_offsets(MapperData **map_spec, */
/* 			   ParticleList *source_list) */
/* This routine traverses the mapping specification, and updates the given list of */
/* source locations, updating the offset entry for each class. */
/**********************************************************************/
void update_advect_offsets(MapperData **map_spec,
			   ParticleList *source_list)
{
    MapperData *class_map;
    MapperData *default_map;
    ParticleList *source_class;

    default_map = *map_spec;
    default_map = get_class_map(map_spec, DEF_PARTICLE_CLASS);

    if (default_map==NULL) {
	AVSerror("update_advect_offsets: No default mapping!");
	exit(1);
    }
    source_class = source_list;
    while (source_class!=NULL) {
	class_map = get_class_map(map_spec, source_class->class);
	if (class_map->advect!=NULL) {
	    source_class->offset = class_map->advect->offset;
	} else {
	    source_class->offset = default_map->advect->offset;
	}
	source_class = source_class->next;
    }
}

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command: "make -k ARCH=$HOSTTYPE G=-g" */
/* End: */
