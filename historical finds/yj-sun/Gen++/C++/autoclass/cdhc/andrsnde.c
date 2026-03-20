#include<stdio.h>
#include<stdlib.h>
#include<math.h>

double *anderson_darling_exp (x, n)
  double *x;
  int n;
{
  static double y[2];
  double sqrt2, mean = 0.0, *xcopy, fx, sum3 = 0.0;
  int i, dcmp(const void *, const void *);

  mean = 0.0;
  sum3 = 0.0; 

  if ((xcopy = (double *) malloc (n * sizeof (double))) == NULL)
    fprintf (stderr, "Memory error in anderson_darling\n"), exit (-1);

  sqrt2 = sqrt ((double) 2.0);

  for (i = 0; i < n; ++i)
  {
    xcopy[i]= x[i];
    mean += x[i];
  }
  mean /= n;
  qsort (xcopy, n, sizeof (double), dcmp);
  for (i = 0; i < n; ++i)
  {
    fx = 1-exp(-xcopy[i]/mean);
    sum3 += (2.0 * i + 1) * (log (fx) -xcopy[n-i-1]/mean);
  }
  y[0] = (1.0+0.3/n)*(-n-sum3/n);
#ifdef NOISY
  printf ("  TEST20 AD(E)  =%10.4f\n", y[0]);
#endif				/* NOISY */
  free((char* )xcopy);
  return y;
}
