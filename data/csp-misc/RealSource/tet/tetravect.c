/* 	$Id: tetravect.c,v 1.7 1995/06/26 18:27:00 npkonrad Exp $	 */

#ifndef lint
static char vcid[] = "$Id: tetravect.c,v 1.7 1995/06/26 18:27:00 npkonrad Exp $";
#endif /* lint */
/* mod_gen Version 1                                                     */
/* Module Name: "tetravect" (Filter) (Coroutine)                         */
/* Author: Nathan P. Konrad,DC3129,x4468,885-1211,                       */
/* Date Created: Tue Nov 22 12:34:53 1994                                */
/*                                                                       */

#include "tetravect.h"

/* *****************************************/
/* Coroutine Main Routine                  */
/* *****************************************/
int main(argc, argv)
	int argc;
	char **argv;
{
    /* i/o variables */
    UCD_structure	*ucd_input = NULL;	  /* vector field ucd */
    AVSfield		*Source = NULL;		  /* particle source locations */
    upstream_transform	*Transform_in = NULL;		  /* incoming transform from */
						  /* downstream */ 
    GEOMedit_list	Geometry;		  /* outgoing particle geometry */

    /* Parameter Specifications                */
    int		Run = 0;
    int		Step_Once = 0;			  /* oneshot */
    float	*Time_Step = NULL;
    float	*Time_Scale = NULL;
    int		Missed_Steps = 0;

    int		Release_Once = 0;		  /* oneshot */
    int		Release_Cont = 0;
    int		Release_Rate = 0;

    int		Reset_Particles = 0;		  /* oneshot */

    char	*Integration = NULL;		  /* choice */

    char	*Data = NULL;			  /* choice */

    char	*Default_Shape = NULL;		  /* choice */
    float	*Default_Size = NULL;
    char	*Map_File = NULL;		  /* file name for mapper input */
    AVScolormap	*Colour_Map = NULL;		  /* colourmap input */
    float	*Colour_Value = NULL;		  /* selected input into colourmap */
    

    /* local variables */
    struct timeval	Now;			  /* the time after the corout_wait */
						  /* call */ 
    struct timezone	timeZone;		  /* time zone info */
    struct timeval	inext_step;		  /* time of next step */
    struct timeval	itime_step;		  /* step time in timeval format */
    int			step_count = 0;		  /* keeps track of number of steps */
						  /* between particle releases for */
						  /* continuous particle release */
    CellNeighbours	*cell_connect = NULL;	  /* pointer to list of neighbours */
    CellTransforms	*cell_ctrans = NULL;	  /* transfroms to and from */
						  /* barycentric coords */ 
    CellFunc		**cell_ops = NULL;	  /* list of pointers to cell */
						  /* functions */ 
    ParticleList	*particle_list = NULL;	  /* list of currently active */
						  /* particles */ 
    ParticleList	*source_list = NULL;	  /* list of source points */
    int			data_choice = 0;	  /* data component choice number */
    DataSelection	advect_selection;	  /* info about current, and possible */
    DataSelection	scalar_selection;	  /* selections for data fields */
    int			integration_choice = 0;	  /* integration method choice number */
    Mat44		source_placement;	  /* center and scale the particle */
						  /* source */ 
    Mat44		user_transform;		  /* current user transform from */
						  /* downstream */ 
    int			missed_steps = 0;	  /* keeps track of missed particle */

    int			shape_choice = 0;	  /* default shape choice number */
    MapperData		*map_spec = NULL;	  /* mapping specification */
    double		global_scale = 1.0;	  /* defined as 0.01 of the largest */
						  /* dimension of the domain.  Used */
						  /* to scale default particle sizes */
						  /* to an appropriate size. */
    int			particle_count = 0;	  /* number of active particles */

    /* initialize the module */
    AVScorout_init(argc,argv,tetravect_desc);

    /* initialize local variables */
    init_particle_list(&particle_list);		  /* init list of particles */
    init_particle_list(&source_list);		  /*    and list of source locations */
    Mat44Eye(source_placement);			  /* init source transforms to */
    Mat44Eye(user_transform);			  /* identity */ 
    Geometry = GEOMinit_edit_list(GEOM_NULL);	  /* initialize the geometry edit list */
    update_misses(missed_steps);
    init_time_step(Time_Step, Time_Scale,
		    &itime_step);
    initDataSelection(&advect_selection);
    initDataSelection(&scalar_selection);

    while (1) {
	/* Clear the GEOM Edit List for Geometry output */
	Geometry = GEOMinit_edit_list(Geometry);

	if (Run &&				  /* if we're running and there are */
	    (Release_Cont || particle_count>0)) {	/* particles */ 
	    AVScorout_mark_changed();		  /*     inhibit the corout_wait */
	}
	AVScorout_wait();			  /* wait for something new to happen */

	AVScorout_input( &ucd_input, &Source,	  /* get the new input data */
			 &Transform_in,
			 &Run, &Step_Once, &Time_Step, &Time_Scale, &Missed_Steps,
			 &Release_Once, &Release_Cont, &Release_Rate,
			 &Reset_Particles,
			 &Integration, &Data,
			 &Default_Shape, &Default_Size,
			 &Map_File, &Colour_Map, &Colour_Value);
	data_choice = AVSchoice_number("Data", Data);
	integration_choice = AVSchoice_number("Integration", Integration);
	shape_choice = AVSchoice_number("Default Shape", Default_Shape);

	/**** Operation: Initialize data set if necessary ****/
	/* Condition: */
	/*   i) new primary mesh */
	/* What: */
	/*   i) initialize cell data (cell connectivity and transform array) */
	if (AVSinput_changed("ucd_input", 0)) {
	    init_cell_data(ucd_input, &advect_selection, &scalar_selection,
			   &cell_connect, &cell_ctrans, &cell_ops, &global_scale);
	}

	/**** Operation: switch to new advection data set if requested *****/
	if (AVSparameter_changed("Data")) {
	    setDataSelection(data_choice, &advect_selection);
	}

	/**** compute new source transform ***/
	/* Condition: i) new source */
	/*            ii) new data */
	/* What: Compute a transform to center and scale the source */
	/*     within the data mesh */
	if (AVSinput_changed("ucd_input", 0) ||
	    AVSinput_changed("Source", 0)) {
	    generate_source_xfm(ucd_input, Source, source_placement);
	}

	/**** take care of possible upstream transform ***/
	/* Condition: i) new transform data */
	/*            ii) new source information */
	/* What: i) apply the model transform (scaling and centering) to the source, */
	/*       ii) apply the downstream transform to that to get model coordinate */
	/*           source positions */
	/* This code assumes that only the ParticleSource geometry object */
	/* will send back transform information */
	if (AVSinput_changed("Transform in", 0)) {/* if we recieve a transform from */
	    if (Transform_in==NULL) {		  /* downstream */ 
		Mat44Eye(user_transform);	  /*    place it in user_transform */
	    } else {
		AVSxfm2Mat44(user_transform, Transform_in->msxform);
	    }
	}

	/*** Operation: update source & source geometry */
	/*** Condition: */
	/*   i) if new source geometry */
	/*   ii) if new primary mesh */
	/*   iii) new user transform */
	/*   What: */
	/*    i) create new list of source particles */
	/*    ii) create geometry for source particles */
	if (AVSinput_changed("Source", 0) ||
	    AVSinput_changed("Transform in", 0) ||
	    AVSinput_changed("ucd_input", 0)) {	  /* if new source info */
	    create_source(Source,		  /*    build source list */
			  source_placement,
			  user_transform,
			  &source_list);
	    find_initial_cells(source_list,	  /*    find cells for source */
			       cell_ctrans,	  /*    locations */ 
			       ucd_input,
			       cell_connect);
	    source_geometry(source_list,	  /*    update the source geometry */
			    Geometry);
	}

	/**** Operation: Initialize the mapping function ***/
	/**** Conditions:  */
	/*     i) if a new mapping spec. file is given */
	/*     ii) any ui supplied default mapping is changed */
	/*     ii) if a new data input (ucd) is given */
	/*   What to do: */
	/*     i) call parse_mapping() */
	/*   Note: scalar_selection and advect_selection should be updated according */
	/*   to any relevant parameter changes before this call  (ie. the calls to */
	/*   init_cell_data and set_data_selection should be made before this point */
	/*   in the loop). Also, the call to create_source should be made before this */
	/*   point since we call update_advect_offsets. */
	if (AVSparameter_changed("Map File") ||
	    AVSparameter_changed("Default Shape") ||
	    AVSparameter_changed("Default Size") ||
	    AVSparameter_changed("Colour Map") ||
	    AVSparameter_changed("Colour Value") ||
	    AVSparameter_changed("Data") ||
	    AVSinput_changed("ucd_input", 0)) {
	    parse_mapping(&scalar_selection,
			  &advect_selection,
			  shape_choice-1,	  /* shape_choice is 1 based, we want */
						  /* 0 based */
			  *Default_Size,
			  Colour_Map,
			  *Colour_Value,
			  Map_File,
			  &map_spec);
	}

	/***** Operation: set the advection offsets in the particle source list */
	/***** Conditions: */
	/*  i) if the source has been re-built */
	/*  ii) if the advection mapping changes */
	/* Do: */
	/*  i) retrieve the data offset from the map_spec and copy it */
	/*     into the source_list. */
	
	if (AVSinput_changed("Source", 0) ||	  /* if the source has been re-built */
	    AVSinput_changed("Transform in", 0) ||
	    AVSparameter_changed("Map File") ||	  /*    OR the advection mapping may */
	    AVSparameter_changed("Data") ||	  /*        have changed */
	    AVSinput_changed("ucd_input", 0)) {
						  /*    reset the advection offsets */
	    update_advect_offsets(&map_spec, source_list); /* for the source */
	}

	/**** Operation: Reset particles
	*   Conditions:	i) reset_input
	*               ii) new Data field
	*   What: remove particles from particle list
	****/
	if (AVSparameter_changed("Reset Particles") ||
	    AVSinput_changed("ucd_input", 0)) {
	    reset_particles(particle_list);
	    missed_steps = 0;
	    update_misses(missed_steps);
	}

	gettimeofday(&Now,&timeZone);		  /* get the current time */

	/**** update stepping parameter ***/
	if (AVSparameter_changed("Time Step") ||  /* if the time step has changed */
	    AVSparameter_changed("Time Scale")) {
	    init_time_step(Time_Step, Time_Scale,
			    &itime_step);
	}
	/**** Check run_state parameters ****/
	if ((AVSparameter_changed("Run")) &&	  /* if Run state has just changed */
	    (Run)) {				  /*                to Run */
	    inext_step.tv_sec =  Now.tv_sec;	  /*     reset next_step to Now */
	    inext_step.tv_usec =  Now.tv_usec;
	}

	/**** Operation: Inject particles
	*   Conditions:	i) valid data (1st two  conditions are assumed)
	*		ii) valid source
	*		iii) Rel_Once OR (Rel_Cont AND enough steps have been taken)
	*   What: i) add a group of particles corresponding to the current source
	*            positions to the particle list
	*         ii) reset the step counter
	****/
	if (AVSparameter_changed("Release Once") ||
	     (Release_Cont && step_count>=Release_Rate)) {
	    if (particle_count==0) {		  /* if there are no particles */
		inext_step.tv_sec =  Now.tv_sec; /*   reset next_step to start */
		inext_step.tv_usec =  Now.tv_usec; /* stepping from Now */
	    }
	    inject_particles(source_list, &particle_list);
	    step_count = 0;
	}

	/**** Operation: Advance particles
	*   Conditions: i) Step_Once OR (Run AND Now > inext_step)
	*		ii) valid data
	*		iii) particles exist
	*   Note: if Running, advance inext_step in spite of (ii) and (iii)
	****/
	if ((Step_Once) ||
	     (Run && (timercmp(&Now, &inext_step, >)))) {
	    if (particle_count > 0) {
		advance_particles(Time_Step, integration_choice,
				  ucd_input, cell_connect, cell_ctrans, cell_ops,
				  particle_list);
	    }
	    if (Run) {
		add_time(&inext_step, &itime_step);
		while (timercmp(&inext_step, &Now, <)) {
		    add_time(&inext_step, &itime_step);
		    missed_steps += 1;
		    update_misses(missed_steps);
		}
	    }
	    if (Release_Cont) {			  /* if continuously releasing */
		step_count++;			  /*    keep track of steps between */
	    }
	}

	/**** Operation: generate output
	 * Add changes to particles to geometry edit list
	 * including: - creating new particles
	 *     - moving existing particles
	 *     - removing dead particle geometries
	 ****/
	particle_count = map_particles(ucd_input,
		      cell_ctrans,
		      particle_list,
		      &map_spec,
		      global_scale,
		      Geometry);
 
	/* send results on to next module(s) */
	AVScorout_output(Geometry);
    }
}

/* *****************************************/
/*  Module Description                     */
/* *****************************************/
int tetravect_desc()
{

    int in_port, out_port, param, iresult;

    AVSset_module_name("tetravect", MODULE_FILTER);

    /* Input Port Specifications               */
    in_port = AVScreate_input_port("ucd_input", "ucd", REQUIRED);
    in_port = AVScreate_input_port("Source", "field 3-space irregular", 
				   REQUIRED);
    in_port = AVScreate_input_port("Transform in", 
				   "struct upstream_transform", 
				   OPTIONAL | INVISIBLE);
    AVSset_input_class(in_port, "upstream_transform");

    /* Output Port Specifications              */
    out_port = AVScreate_output_port("Geometry", "geom");

    /* Parameter Specifications                */
    param = AVSadd_parameter("Run", "boolean", 0, 0, 1);
    AVSconnect_widget(param, "toggle");

    param = AVSadd_parameter("Step Once", "oneshot", 0, 0, 1);
    AVSconnect_widget(param, "oneshot");

    param = AVSadd_float_parameter("Time Step", DEF_TIME_STEP, MIN_TIME_STEP, MAX_TIME_STEP);
    AVSconnect_widget(param, "typein_real");

    param = AVSadd_float_parameter("Time Scale", DEF_TIME_SCALE, MIN_TIME_SCALE, MAX_TIME_SCALE);
    AVSconnect_widget(param, "typein_real");

    param = AVSadd_parameter("Missed Steps", "integer", 0, 0, 10000);
    AVSconnect_widget(param, "typein_integer");

    param = AVSadd_parameter("Release Once", "oneshot", 0, 0, 1);
    AVSconnect_widget(param, "oneshot");
    
    param = AVSadd_parameter("Release Continuous", "boolean", 0, 0, 1);
    AVSconnect_widget(param, "toggle");
    
    param = AVSadd_parameter("Release Rate", "integer",
			     DEF_REL_RATE, MIN_REL_RATE, MAX_REL_RATE); 
    AVSconnect_widget(param, "typein_integer");


    param = AVSadd_parameter("Reset Particles", "oneshot", 0, 0, 1);
    AVSconnect_widget(param, "oneshot");

    param = AVSadd_parameter("Integration", "choice", "linear", "linear", ":");
    AVSconnect_widget(param, "radio_buttons");

    param = AVSadd_parameter("Data", "choice", "data1", 
			     DATA_CHOICE_DEFAULTS, ":");
    AVSconnect_widget(param, "radio_buttons");

    param = AVSadd_parameter("Default Shape", "choice", "Sphere", 
			     MAPPER_SHAPE_NAMES, ":");
    AVSconnect_widget(param, "radio_buttons");

    param = AVSadd_float_parameter("Default Size", MAPPER_DEF_SCALE,
				   MAPPER_MIN_SCALE, MAPPER_MAX_SCALE);
    AVSconnect_widget(param, "dial");

    param = AVSadd_parameter("Map File", "string", "", "", ".map");
    AVSconnect_widget(param, "browser");

    param = AVSadd_parameter("Colour Map", "colormap", 0, 0, 0);
    AVSconnect_widget(param, "color_editor");

    param = AVSadd_float_parameter("Colour Value", 0.0, 0.0, 255.0);
    AVSconnect_widget(param, "slider");

    /* adjust the control panel layout */
    /* this command is generated using the procedure outlined on p. 5-46 fo the AVS */
    /* developers guide */
    AVSadd_parameter_prop(param, "layout", "string_block",
   "panel $Module -w panel -p \"Top Level Stack\" -xy 0,62 -wh 259,795\n\
    panel stack.7 -w stack -p $Module -xy 0,9 -wh 251,776 -P columns integer 1 -P title string \"Tetravect Stack\"\n\
     panel page.0 -w panel -p stack.7 -xy 0,128 -wh 238,622 -P title string \"Particles\"\n\
      manipulator \"$Module:Step Once\" -w oneshot -p page.0 -xy 7,15 -wh 116,21\n\
      manipulator $Module:Run -w toggle -p page.0 -xy 7,35 -wh 116,21\n\
      manipulator \"$Module:Time Step\" -w typein_real -p page.0 -xy 6,65 -wh 233,21\n\
      manipulator \"$Module:Time Scale\" -w typein_real -p page.0 -xy 3,87 -wh 233,21\n\
      manipulator \"$Module:Missed Steps\" -w typein_integer -p page.0 -xy 2,121 -wh 233,21\n\
      manipulator \"$Module:Release Once\" -w oneshot -p page.0 -xy 3,166 -wh 116,21\n\
      manipulator \"$Module:Release Continuous\" -w toggle -p page.0 -xy 3,188 -wh 116,21\n\
      manipulator \"$Module:Release Rate\" -w typein_integer -p page.0 -xy 2,225 -wh 233,21\n\
      manipulator \"$Module:Reset Particles\" -w oneshot -p page.0 -xy 2,293 -wh 116,21\n\
     panel page.1 -w panel -p stack.7 -xy 0,128 -wh 223,603 -P title string \"Advection Data\"\n\
      panel page.2 -w panel -p page.1 -xy 3,5 -wh 135,65 -P title string \"Integration:\"\n\
       manipulator $Module:Integration -w radio_buttons -p page.2 -xy 11,34 -wh 116,21\n\
      panel page.3 -w panel -p page.1 -xy 3,146 -wh 135,151 -P title string \"Data:\"\n\
       manipulator $Module:Data -w radio_buttons -p page.3 -xy 8,34 -wh 116,109\n\
     panel page.4 -w panel -p stack.7 -xy 0,128 -wh 249,648 -P title string \"Mapping Defaults\"\n\
      panel page.5 -w panel -p page.4 -xy -1,-2 -wh 135,173 -P title string \"Default Shape:\"\n\
       manipulator \"$Module:Default Shape\" -w radio_buttons -p page.5 -xy 8,34 -wh 116,131\n\
      manipulator \"$Module:Default Size\" -w dial -p page.4 -xy 139,8 -wh 89,129\n\
      manipulator \"$Module:Colour Map\" -w color_editor -p page.4 -xy 6,173 -wh 234,427\n\
      manipulator \"$Module:Colour Value\" -w slider -p page.4 -xy 6,607 -wh 234,31\n\
     panel page.6 -w panel -p stack.7 -xy 0,128 -wh 238,622 -P title string \"Mapping File\"\n\
      manipulator \"$Module:Map File\" -w browser -p page.6 -xy 1,5 -wh 232,206\n\
manipulator page.2!title -w text -p page.2 -xy 8,9 -wh 116,21\n\
manipulator page.3!title -w text -p page.3 -xy 8,9 -wh 116,21\n\
manipulator page.5!title -w text -p page.5 -xy 8,9 -wh 116,21");

    return(1);
}
 
/***********************************************************************************
* void show_time(struct timeval time)
*   given a timeval structure, extracts the time in terms of days, hours, minutes, seconds
*   and milliseconds and prints it out to the standard output
*   (Used for debugging purposes)
* void add_time(struct timeval *time, struct timeval *increment)
*   given a timeval and an increment, add the increment to the value.
***********************************************************************************/
void show_time(struct timeval time)
{
    long	seconds, minutes,  hours, days, mseconds;

    seconds = time.tv_sec % 60;
    minutes = time.tv_sec / 60;
    hours = minutes / 60;
    days = hours / 24;
    minutes = minutes % 60;
    hours = hours % 24;
    mseconds = time.tv_usec / 1000;
    AVSinformation("%ld days, %ld hours, %ld minutes, %ld seconds, %ld ms",
					days, hours,  minutes, seconds, mseconds);
}

void add_time(struct timeval *time, struct timeval *increment)
{
    time->tv_sec += increment->tv_sec;		  /* add the seconds */
    time->tv_usec += increment->tv_usec;	  /* add the microseconds */
    if (time->tv_usec > 1000000) {		  /* if the micros overflow */
	time->tv_usec -= 1000000;		  /*    carry over into seconds */
	time->tv_sec += 1;
    }
}

/***********************************************************************************
 * void init_time_step(float *Time_Step,
 * 			float *Time_Scale,
 * 			struct timeval *itime_step)

 *   Converts the format of Time_Step and Time_Scale and places the result in
 *   itime_step.  Time_Step is used for advancing the particles through the domain,
 *   and Time_Step*Time_Scale is used as the suggested real-time interval between
 *   particle steps on the display.  It is this value which is placed in itime_step
 *   to be used to increment the inext_step value.

 *********************************************************************************/
void init_time_step(float *Time_Step,
		     float *Time_Scale,
		     struct timeval *itime_step)
{
    float	iseconds, fseconds;

    if (Time_Step==NULL) {			  /* if Time_Step not yet defined */
	fseconds = modff(DEF_TIME_STEP*DEF_TIME_SCALE,
			 &iseconds);		  /*    just initialize itime_step */
    } else {
	if (*Time_Step<MIN_TIME_STEP) {		  /*    check the bounds */
	    *Time_Step = MIN_TIME_STEP;
	    AVSmodify_float_parameter("Time Step", AVS_VALUE | AVS_MINVAL | AVS_MAXVAL,
				      *Time_Step, MIN_TIME_STEP, MAX_TIME_STEP);
	}
	if (*Time_Step>MAX_TIME_STEP) {		  /*    check the bounds */
	    *Time_Step = MAX_TIME_STEP;
	    AVSmodify_float_parameter("Time Step", AVS_VALUE | AVS_MINVAL | AVS_MAXVAL,
				      *Time_Step, MIN_TIME_STEP, MAX_TIME_STEP);
	}
#ifdef DEBUG
	AVSinformation("Time Step: %f", *Time_Step);
#endif
	if (*Time_Scale<MIN_TIME_SCALE) {	  /*    check the bounds */
	    *Time_Scale = MIN_TIME_SCALE;
	    AVSmodify_float_parameter("Time Scale", AVS_VALUE | AVS_MINVAL | AVS_MAXVAL,
				      *Time_Scale, MIN_TIME_SCALE, MAX_TIME_SCALE);
	}
	if (*Time_Scale>MAX_TIME_SCALE) {	  /*    check the bounds */
	    *Time_Scale = MAX_TIME_SCALE;
	    AVSmodify_float_parameter("Time Scale", AVS_VALUE | AVS_MINVAL | AVS_MAXVAL,
				      *Time_Scale, MIN_TIME_SCALE, MAX_TIME_SCALE);
	}
	fseconds = modff(*Time_Step * (*Time_Scale),
			 &iseconds);		  /*    get integer and fractional parts */
    }
    itime_step->tv_sec = (int) iseconds;
    itime_step->tv_usec = (int) (1.0e6 * fseconds);
}

/***********************************************************************************
 * void update_misses(int steps)
 * 
 *     Updates the widgets which display the number of missed steps.
 **********************************************************************************/
void update_misses(int steps)
{
    AVSmodify_parameter ("Missed Steps",  AVS_VALUE,
			     steps, 0, 0);
}

/* Set up emacs local variables to compile for the current host */
/* ie. the command line is make -k ARCH=[sun4|alpha|iris4d] G=-g */
/*    the G=-g is for debugging */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* End: */
