#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include <malloc.h>

double *chi_square_exp (x, n)
  double *x;
  int n;
{
  static double y[2];
  double mean = 0.0, sum3 = 0.0, *v;
  int i, j, k, *f;

  sum3 = 0.0;

  k = rint(4.0 * pow (0.75 * (n - 1.0) * (n - 1.0), 0.2));

  while ((double) (n/k) < 5.0)
   --k;

  if ((f = (int *) calloc (k, sizeof (int))) == NULL)
    fprintf (stderr, "Memory error in chi_square\n"), exit (-1);
  if ((v = (double *) malloc ( (k+1) * sizeof (double))) == NULL)
    fprintf (stderr, "Memory error in chi_square\n"), exit (-1);

  for (i = 0; i < n; ++i)
    mean += x[i];
  mean = n/mean;

  v[0]=0.0;
  for (i = 1; i < k; ++i)
    v[i] = - log (1.0 - (double) i / k) / mean;
  v[k]=1e9;

  for (i = 0; i < n; ++i)
  {
    j=0;
    while(j<k)
    {
      if (x[i] > v[j] && x[i] <= v[j+1])
      {
	f[j]++;
        j=k;
      }
     j++;
    }
  }

  for (i = 0; i < k; ++i)
    sum3 += f[i] * f[i];

  y[0] = sum3 * k / n - n;
  y[1] = (double) k - 2.0;
#ifdef NOISY
  printf ("  TEST21 CS(E)  =%10.4f   DOF    =%10.4f\n", y[0], y[1]);
#endif /* NOISY */
  free((char*) f);
  free((char*) v);
  return y;
}
