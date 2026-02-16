/* 	$Id: tetravect.h,v 1.5 1995/06/26 18:29:54 npkonrad Exp $	 */

/* Module Name: "tetravect" (Filter) (Coroutine)                         */
/* Author: Nathan P. Konrad,DC3129,x4468,885-1211,                       */
/* Date Created: Tue Nov 22 12:34:53 1994                                */
/* This file contains definitions required for tetravect.c, and */
/* prototypes of functions defined therein. */

#ifndef TETRAVECT_H
#define TETRAVECT_H

/************* include files ***************/
#include <stdlib.h>				  /* system includes */
#include <sys/time.h>
#include <stdio.h>

#include <avs/avs.h>				  /* avs related includes */
#include <avs/port.h>
#include <avs/field.h>
#include <avs/geom.h>
#include <avs/ucd_defs.h>
#include <avs/udata.h>

#include "cell_trans.h"				  /* locally defined */
#include "cell_connect.h"
#include "particle.h"
#include "advance.h"
#include "mapper.h"
#include "init_data.h"
#include "cell_ops.h"

/************* constant definitions ***************/
#define	MIN_TIME_STEP	(0.001)			  /* min time step */
#define	MAX_TIME_STEP	(100.0)			  /* max time step */
#define DEF_TIME_STEP	(0.1)			  /* default time step */
#define	MIN_TIME_SCALE	(0.1)			  /* min time scale */
#define	MAX_TIME_SCALE	(10000.0)		  /* max time scale */
#define DEF_TIME_SCALE	(5.0)			  /* default time scale */
#define	MIN_REL_RATE	(1)			  /* release at most once per step */
#define	MAX_REL_RATE	(100)			  /* release at least once per 100 */
						  /* steps */
#define DEF_REL_RATE	(5)			  /* default release once per 5 steps */
#define MAX_DATA_CHOICES	(5)		  /* maximum number of entries in */
						  /* data choice list */ 
						  /* default choices for widget */
						  /* (must match MAX_DATA_CHOICES) */
#define DATA_CHOICE_DEFAULTS	"data1:data2:data3:data4:data5"
#define MAX_COMP		(16)		  /* maximum number of node components */
#define MAX_COMP_LABELS		(16)		  /* maximum length of component label */

/************* structure definitions ***************/

/************* Function prototypes ***************/
/* this section contains prototypes of functions defined in tetravect.c */
/* not including main() */

int tetravect_desc();

void show_time(struct timeval time);

void add_time(struct timeval *time, struct timeval *increment);

void init_time_step(float *Time_Step,
		     float *Time_Scale,
		     struct timeval *itime_step);

void update_misses(int steps);

/* Set up local variables to compile for the current host */
/* Local Variables: */
/* compile-command:"make -k ARCH=$HOSTTYPE G=-g" */
/* End: */

#endif TETRAVECT_H
