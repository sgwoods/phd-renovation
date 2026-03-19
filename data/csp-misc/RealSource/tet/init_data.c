/* 	$Id: init_data.c,v 1.4 1995/06/26 17:58:22 npkonrad Exp $	 */

#ifndef lint
static char vcid[] = "$Id: init_data.c,v 1.4 1995/06/26 17:58:22 npkonrad Exp $";
#endif /* lint */
/*************************************************************************/
/*     This file is part of a particle advection package It provides */
/*     functions for initializing the simulation data and it's associated */
/*     component selection widgets */

/*     This file, init_data.c contains the code for supporting functions. */
/*     Declarations and function prototypes are included in init_data.h. */
/*     Functions include: */

/* Author: Nathan P. Konrad,DC3129,x4468,885-1211,                       */
/*  Date Created: Mon Feb  6 16:53:21 EST 1995 */


/*************************************************************************/

#include "init_data.h"

/*********** Function Definitions ***********/
      
/*************************************************************************/
/*  int init_cell_data(UCD_structure *ucd_input, */
/* 		    DataSelection *advect_sel, */
/* 		    DataSelection *scalar_sel, */
/* 		    CellNeighbours **cell_connect, */
/* 		    CellTransforms **cell_ctrans, */
/* 		    CellFunc	***cell_ops */
/*                  double *global_scale) */

/*    Called whenever new cellular data is recieved to initialize various internal */
/*    data structures and states: */
/*      a) initialize Data selection widget based on ucd data */
/*      b) check ucd validity--tetrahedral, valid data, etc. */
/*      c) create new cell neighbour lists */
/*      d) initialize cell barycentric coordinate transformations */
/*         ie. find 3-vectors in data, and reset widget */
/*      e) initialize secondary function pointers (for sinks, etc.) */
/*      f) set the global scale factor */
/***************************************************************************/
int init_cell_data(UCD_structure *ucd_input,
		   DataSelection *advect_sel,	  /* current state and chosen */
						  /* component */ 
		   DataSelection *scalar_sel,	  /* available scalar selections */
		   CellNeighbours **cell_connect, /* pointer to list of neighbours */
		   CellTransforms **cell_ctrans,  /* transforms to and from */
						  /* barycentric coordinates */ 
		   CellFunc	***cell_ops,	  /* cell based operations */
		   double  *global_scale)
{
    /* local variables */
    char	Iname[80];			  /* parameters for ucd_input ucd */
    int		Idata_veclen, Iname_flag, Incells, Icell_veclen;
    int		Innodes, Inode_veclen, Iutil_flag;
    float	*Ix, *Iy, *Iz;			  /* pointers to node coordinates */
    Mat44	*to_cart, *to_bary;		  /* temp variables to test */
						  /* get_cell_trans */ 
    float	min[3], max[3];			  /* used to store the extents */
    
    /* get the parameters of the input mesh */
    /*   it's assumed that the mesh is homogenous (all one cell type) */
    /*   for the purposes of allocating memory for the output mesh */
    if (!UCDstructure_get_header (ucd_input, Iname, &Idata_veclen,
				  &Iname_flag, &Incells, &Icell_veclen,
				  &Innodes, &Inode_veclen, &Iutil_flag)) {
	AVSerror ("tetravect: can't get header.\n");
	return;
    }
    
    /* initialize the advection data selections */
    init_selection(ucd_input,
		   SELECT_3DIM,			  /* only 3-space components for */
						  /* advection data */ 
		   "",				  /* exclude no fields at this point */
		   advect_sel);			  /* resulting selection */

    /* now initialize the advection data widget */
    setDataWidget(advect_sel, "Data");

    /* initialize the scalar data selections */
    init_selection(ucd_input,
		   SELECT_1DIM,			  /* only scalars */
		   "PARTICLE_SINK",		  /* exclude PARTICLE SINKs */
		   scalar_sel);			  /* resulting selection */

    if (advect_sel->count==0) {			  /* if we have no choices for data */
	AVSwarning("Data set has no 3-space components");
	return(0);				  /*    forget the rest of the */
						  /*    initialization */ 
    }

    /* generate the cell connectivity list */
    generate_cell_conn(ucd_input, Incells, Innodes, cell_connect);

    if (!UCDstructure_get_node_positions (ucd_input, &Ix, &Iy, &Iz)) {
	AVSerror ("ucd extrude: can't get node positions.\n");
	return (0);
    }

    /* */
    /* initialize the cell barycentric coordinate list */
    /* */
    init_cell_trans(ucd_input, Incells, Ix, Iy, Iz, cell_ctrans);

    /* */
    /* initialize the cell operations structure */
    /* */
    init_cell_ops(ucd_input, cell_ops);

    /* */
    /* initialize domain global scaling value */
    /* */
    if (!UCDstructure_get_extent (ucd_input, min, max)) {
	AVSerror ("ucd extrude: can't get node extents.\n");
	return (0);
    }
    *global_scale = max[0] - min[0];		  /* first find the max range */
    if (*global_scale < max[1]-min[1]) {
	*global_scale = max[1]-min[1];
    }
    if (*global_scale < max[2]-min[2]) {
	*global_scale = max[2]-min[2];
    }
    *global_scale *= RELATIVE_GLOBAL_SCALE;	  /* then scale it to a preset value */

    return(1);					  /* return success */
}

/***********************************************************************************/
/* void init_selection(UCD_structure *ucd_input, */
/* 			   int select_flags, */
/* 			   char *exclude, */
/* 			   int **selections, */

/*     Given a list of selection criteria (selection_flags), and a list of */
/*     data names to ignore (exclude), and an input data set (ucd_input), */
/*     this routine builds a list of qualifying selections and their labels. */

/***********************************************************************************/
void init_selection(UCD_structure *ucd_input,/* input data */
			   int select_flags,	  /* selection criteria */
			   char *exclude,	  /* exclusion list */
			   DataSelection *selection) /* resulting selection */
{
    char	Iname[80];			  /* parameters for ucd_input ucd */
    int		Idata_veclen, Iname_flag, Incells, Icell_veclen;
    int		Innodes, Inode_veclen, Iutil_flag;

    int		*Inode_components, Inode_comp_count;
    char	*Inode_labels, *Idelim;
    char	*data_lab_ptr;			  /* a pointer to a label for the */
						  /* current component */ 
    char	*choice_labels;			  /* accumulates labels for */
						  /* initializing widget */ 
    int		this_comp_size;			  /* size of the current component */
						  /* (dimensions) */ 

    int		comp_count;			  /* accumulates number of components */
    int		comp_position;			  /* accumulates total number of data */
						  /* dimensions */ 
    
    /* get the parameters of the input mesh */
    /*   it's assumed that the mesh is homogenous (all one cell type) */
    /*   for the purposes of allocating memory for the output mesh */
    if (!UCDstructure_get_header (ucd_input, Iname, &Idata_veclen,
				  &Iname_flag, &Incells, &Icell_veclen,
				  &Innodes, &Inode_veclen, &Iutil_flag)) {
	AVSerror ("tetravect: can't get data header.\n");
	return;
    }
    /* get the data component sizes */
    if (!UCDstructure_get_node_components ( ucd_input, &Inode_components)) {
	AVSerror ("tetravect: can't get data node components.\n");
	exit(1);
    }

    /* free up any previously allocated selections if they are there */
    /* and allocate memory for a new selection list */
    allocDataSelection(selection, Inode_veclen);
    /* put the data labels in the selection label_string */
    Inode_labels = selection->label_string;
    Idelim = selection->delim;
    
    /* get data labels */
    if (!UCDstructure_get_node_labels(ucd_input,Inode_labels,Idelim)) {
	AVSerror ("tetravect: can't get data node labels.\n");
	exit(1);
    }

    /* initialize some counters */
    comp_position = 0;				  /* indicates the position in the */
						  /* whole data vector where the */
						  /* current component starts */ 
    comp_count = 0;				  /* the current component number */
    data_lab_ptr = strtok(Inode_labels, Idelim);  /* start of label for the current */
						  /* component */ 
    choice_labels = selection->choice_labels;	  /* accumulates control string for */
						  /* selection widget */ 

    while (comp_position<Inode_veclen) {	  /* until we reach the end of the */
						  /* component list */ 
	this_comp_size = Inode_components[comp_count];

						  /*    get a label for it */
	if (data_lab_ptr==NULL) {		  /*    if there's no label */
	    data_lab_ptr = "unnamed component";
	}

	/* now see if this component satisfies the current criteria */
	if (strstr(exclude,			  /*    if label is not in exclusion */
						  /*    list */ 
		   data_lab_ptr)==NULL) {	  /*       and is of correct size */
	    if (((select_flags&SELECT_1DIM) && (this_comp_size==1)) ||
		((select_flags&SELECT_2DIM) && (this_comp_size==2)) ||
		((select_flags&SELECT_3DIM) && (this_comp_size==3))) {
		selection->index[selection->count] = comp_position;
		selection->label[selection->count] = data_lab_ptr;
		selection->count++;		  /*       add to the selection list */
		if (choice_labels[0]==NULL) {	  /*       add to widget label list */
		    strcpy(choice_labels, data_lab_ptr);
		} else {
		    strcat(choice_labels, Idelim);
		    strcat(choice_labels, data_lab_ptr);
		}
	    }
	}
	comp_count++;				  /*    move on to next component */
	comp_position += this_comp_size;	  /*    update position of this comp */
	data_lab_ptr = strtok(NULL, Idelim);	  /*    and to the next label */
    }
}

/***********************************************************************************/
/* void initDataSelection(DataSelection *selection) */
/* void allocDataSelection(DataSelection *selection, int size) */
/* void freeDataSelection(DataSelection *selection) */

/*     These functions initialize, allocate memory, and clear a data selection */
/*     object respectively.  alloc... first clears any previously allocated memory */
/*     by calling free..., and then allocates enough memory for each list on the */
/*     assumption that each list will not exceed size elements. */

/*     It is assumed that initDataSelection will be called first, then the selection */
/*     may be reused any number of times by calling allocDataSelection (it frees any */
/*     previously allocated memory), and then freeDataSelection should be called to */
/*     free allocated data before exiting. */

/***********************************************************************************/
void initDataSelection(DataSelection *selection)
{
    selection->count = 0;			  /* no possible selections */
    selection->current = NO_SELECTION;		  /* no selection */
    selection->label = NULL;			  /* no labels */
    selection->index = NULL;			  /* no selection indices */
    selection->label_string = NULL;		  /* no source string for labels */
    selection->choice_labels = NULL;		  /* no widget init string */
    selection->delim = NULL;			  /* or a delimiter for it */
}

void allocDataSelection(DataSelection *selection, int size)
{
    /* first free any previously allocated memory */
    freeDataSelection(selection);

    /* and then allocate memory for the lists */
    selection->index = (int *) malloc(size *sizeof(int));
    selection->label = (char **) malloc(size * sizeof(char *));
    selection->label_string =
	(char *) malloc(size * MAX_DATA_LABEL_SIZE * sizeof(char));
    selection->choice_labels =
	(char *) malloc(size * MAX_DATA_LABEL_SIZE*sizeof(char));
    selection->delim = (char *) malloc(8*sizeof(char));
}

void freeDataSelection(DataSelection *selection)
{
    /* now initialize the selection structure and the wiget */
    if (selection->label!=NULL) {		  /* free the list of labels */
	free(selection->label);			  /* note that this is an array of */
						  /* pointers into label_string, so */
						  /* we don't have to worry about */
						  /* freeing what they point to. */
    }
    if (selection->index!=NULL) {
	free(selection->index);			  /* free the list of indices */
    }
    if (selection->label_string!=NULL) {
	free(selection->label_string);		  /* free the label string */
    }
    if (selection->choice_labels!=NULL) {
	free(selection->choice_labels);		  /* free the widget initialization */
    }						  /* string */
    if (selection->delim!=NULL) {
	free(selection->delim);			  /* free the widget initialization */
    }						  /* string delimiter */
    initDataSelection(selection);		  /* and initialize all fields */
}

/***********************************************************************************/
/* void setDataSelection(int choice, DataSelection *selection) */
/*     setDataSelection takes a choice number, and sets the currently selected */
/*     component to the corresponding index, if it is within the correct range. */
/***********************************************************************************/
void setDataSelection(int choice, DataSelection *selection)
{
    if ((choice <= selection->count) &&		  /* if in range */
	(choice > 0)) {				  /*    set the selection */
	selection->current = selection->index[choice-1];
    } else {					  /* else */
	if (selection->count>0) {		  /*    if there are selections */
	    selection->current = selection->index[0]; /*    set to the first one */
	} else {				  /*    else  */
	    selection->current = NO_SELECTION;	  /*        set to no selection */
	}
    }
}

/**********************************************************************/
/* int get_selection_offset(DataSelection *selection, */
/* 			 char *label); */

/*    Given a DataSelection and the name of a data field, this routine will return */
/*    the offset of the named field in the data vector for which the DataSelection is */
/*    currently initialized  IF the field is in the current list of allowable */
/*    choices.  If not, the routine will return NO_DATA_OFFSET */
/*********************************************************************/
int get_selection_offset(DataSelection *selection,
			 char *label)
{
    int i;

    i = 0;
    while ((i<selection->count) &&
	   (strcmp(label, selection->label[i])!=0)) {
	i++;
    }
    if (i < selection->count) {
	return(selection->index[i]);
    } else {
	return(NO_OFFSET);
    }
}

/***********************************************************************************/
/* void setDataWidget(DataSelection *selection, */
/* 		   char* data_widget) */
/*     The setDataWidget function takes the data in a DataSelection */
/*     structure, and the name of a choice widget/label pair, and initializes */
/*     them according to the current choice in the selection. */
/***********************************************************************************/
void setDataWidget(DataSelection *selection,
		   char* data_widget)
{
    if (selection->count<=0) {			  /*    if there are no data choices */
 	AVSparameter_visible(data_widget,0);	  /*       remove the widget */
    } else {					  /*    else */
	AVSparameter_visible(data_widget,1 );	  /*          display the widget */
	AVSmodify_parameter (data_widget,  AVS_VALUE | AVS_MINVAL | AVS_MAXVAL,
			     selection->label[0], /*          and re-paint menu list */
			     selection->choice_labels,
			     selection->delim);
    }
}

/* Set up local variables to compile for the current host under emacs */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* End: */



