#include<stdio.h>
#include<math.h>

double *kolmogorov_smirnov (x, n)
  double *x;
  int n;
{
  static double y[2];
  double *d,sqrtn, *dmax(double*, int);

  sqrtn = sqrt ((double) n);
  d=dmax(x,n);

  y[1] = (d[0] > d[1]) ? d[0] : d[1];
  y[0] = y[1] * (sqrtn + 0.85 / sqrtn - 0.01);
#ifdef NOISY
  printf ("  TEST10 KSD(N) =%10.4f\n", y[0]);
  printf ("  TEST11 KSD    =%10.4f\n", y[1]);
#endif				/* NOISY */
  return y;
}
