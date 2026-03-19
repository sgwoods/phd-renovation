/* 
 * grab.c
 *       Reads in an output file from MOTORS single line override format
 *       and outputs a data file for GNUPLOT
 *       
 *  Confidence Interval Version
 *  Constraint Check version
 *
 * example ...   grab < file.input > file.output
 *
 * Steve Woods,Dec 1994
 */

#include <stdio.h>
#include <string.h>
#include <math.h>

#define ITERS 10           /* number of tests at each point */
#define ITERS_SQRT 3.16    /* note also that the sqrt of ITERS = 10 is 3.16 */
#define TIMES 20           /* number of testing values , ie 50 to 1000 inc by 50 gives 20 diff value points */

main()
{
    int  Size;
    char Overf[2];
    char Ident[10];

/*    float Dsize;        this is the problem !!! */
    char  Dsize[7]; 

    int NCC;
    int TCC;
    int BT;
    int V;
    float AP;
    float S;
    float Total;
    int NumS;

    int i,j;

    double max, min, low, high, t, t_sqrt, ci;
    double sum, sqrsum;
    double s2, s;
    double avg;

    double TCCf;
    double iter_s;

    char* tcase[10];

    tcase[0] = "default";
    tcase[1] = "1783960706";
    tcase[2] = "6148712495";
    tcase[3] = "8261581571";
    tcase[4] = "4705297406";
    tcase[5] = "6724813580";
    tcase[6] = "8798969000";
    tcase[7] = "0805098560";
    tcase[8] = "4767135635";
    tcase[9] = "7685437293";

    /* loop for all cases */

    for (j=0;j<TIMES;j++) {

	sum = 0.0;
	sqrsum = 0.0;
	max = 0.0;
	min = 100000.0;

	/* read in case X, ITERS runs into an array */
	for (i=0; i<ITERS; i++)	{

	    scanf("%d %s %*s %*s %*s %*s %*s %s %f %d %d %d %*s %d %f %f %f %d %*s %*s %*s %*s %*s %*s",
		  &Size,&Overf,   &Ident,&Dsize,&NCC,&TCC,&BT,    &V,&AP,&S,&Total,&NumS);

	    if ( strcmp(Ident,tcase[i]) )
		printf("Sequence error at [%d] [%s] [%s].\n",i,Ident,tcase[i]);
	    
	    /* calc sum, sqr'd sum, max, min */
	    TCCf = TCC;
	    sum = sum + TCCf;
	    sqrsum = sqrsum + (TCCf * TCCf);

	    if (max < TCCf) max = TCCf;
	    if (min > TCCf) min = TCCf;
	}

	/* compute average, know max and min also */
	iter_s = ITERS;
	avg = sum / iter_s;
	
	/* from  table, value of t for sample size 10, 95% conf int is 2.26 */
	t = 2.26;
        t_sqrt = ITERS_SQRT;

	/* calc sample variance s2 */
	s2 = (sqrsum - (iter_s * (avg * avg)))/(iter_s - 1.0);
	s  = sqrt( s2 );

	ci = t * s / t_sqrt;
	low = avg - ci;
	high = avg + ci;

/*
	printf("Testing s2[%f] s[%f]  ci[%f] low[%f] high[%f]\n",
                    	s2,    s,     ci,    low,    high);
*/

	/* print out with data point Size, the point (x bar), x-ci and c+ci */
	printf("%d   %f   %f   %f\n", Size, avg, low, high);
    }
}

/* Local Variables: */
/* compile-command: "gcc grab-ci-both.c" */
/* End: */
