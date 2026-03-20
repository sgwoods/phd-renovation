#include<stdio.h>
#include<stdlib.h>
#include<math.h>

/*-
 * driver program for AS 181: Royston's extension of the Shapiro-Wilk
 * W statistic to n=2000
 * needs as181.c as177.c as241.c dcmp.c as66.c 
 */

double *royston(x,n)
double *x;
int n;
{
  static double y[2];
  double *a, eps, w, pw, mean=0, ssq=0, *xcopy;
  int i, ifault, n2; 
  int dcmp(const void*, const void*);
  void wcoef (double a[], int n, int n2, double* eps, int* ifault);  

  void wext(double x[], int n, double ssq, double a[], int n2, double eps, 
               double* w, double* pw, int* ifault);

  n2=(int)floor((double)n/2);
  mean = 0;
  ssq = 0;

#ifndef lint
  if ((a=(double *) malloc(n2*sizeof(double)))==NULL)
    fprintf (stderr, "Memory error in royston\n"), exit (-1);
  if ((xcopy = (double *) malloc (n * sizeof (double))) == NULL)
    fprintf (stderr, "Memory error in shapiro_wilk\n"), exit (-1);
#endif /* lint */
 

  for (i = 0; i < n; ++i)
  {
    xcopy[i] = x[i];
    mean += x[i];
  }
  mean /=n ;

  qsort (xcopy, n, sizeof (double), dcmp);

  for (i = 0; i < n; ++i)
    ssq += (mean-x[i])*(mean-x[i]);

  wcoef (a, n, n2, &eps, &ifault);

  if (ifault==0)
    wext (xcopy, n, ssq, a, n2, eps, &w, &pw, &ifault);
  else
  {
    fprintf (stderr, "Error in wcoef()\n");
    return (double *) NULL;
  }

  if (ifault==0)
  {
    y[0]=w;
    y[1]=pw;
  }
  else
  {
    fprintf (stderr, "Error in wcoef()\n");
    return (double *) NULL;
  }

  free( (char*) a);
  free( (char*) xcopy);
  return y;
}
