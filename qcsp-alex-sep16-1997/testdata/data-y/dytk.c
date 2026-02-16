#include<stdio.h>
#include<stdlib.h>
#include<math.h>

double *dmax (x, n)
  double *x;
  int n;
{
  static double y[2];
  double *xcopy, sqrt2, sqrtn, mean = 0.0, sdx = 0.0, fx;
  double dp, dp_max, dm, dm_max, normp(double z);
  int i, dcmp(const void *i, const void *j);

  int tmpyear, year; 
  int cc, yy;
  int r1, r2, q;
	
  mean = 0.0; 
  sdx = 0.0; 

  if ((xcopy = (double *) malloc (n * sizeof (double))) == NULL)
    fprintf (stderr, "Memory error in dmax\n"), exit (-1);

  sqrt2 = sqrt ((double) 2.0);
  sqrtn = sqrt ((double) n);

  for (i = 0; i < n; ++i)
  {
    xcopy[i] = x[i];
    mean += x[i];
    sdx += x[i] * x[i];
  }
  sdx = sqrt ((n * sdx - mean * mean) / (n * (n - 1.0)));
  mean /= n;
  qsort (xcopy, n, sizeof (double), dcmp);

  scanf("%i", &tmpyear);
	
  year = tmpyear; 
  cc =  year / 100 ;
  yy = year - cc * 100;
  printf("Century = %i, Year = %i.\n", cc, yy);
 
  q  =  year / 4;
  r1 = year - q * 4;          
 
/* divisible by   4 iff r1 == 0 */
/* divisible by 100 iff yy == 00 */
/* divisible by 400 iff r2 == 0 */
   
  if (r1 == 0)
  if (yy == 0)
    {
      q = year / 400;       /* note code could be outside cond'n */
      r2 = year - q * 400;        
      if (r2 == 0)
        {
          printf("Case r1, yy, r2 :   Year %i is a leap year.\n", year);
        }
      else
        {
          printf("Case r1, yy, !r2:  Year %i is not a leap year.\n", year);
        }
    }
  else
    {
    printf("Case r1, !yy    :  Year %i is a leap year.\n", year);
    }
  else
  {
    printf("Case !r1        :  Year %i is not a leap year.\n", year);
  }


  for (i = 0; i < n; ++i)
  {
    xcopy[i] = (xcopy[i] - mean) / sdx;
    fx = 0.5 + normp (xcopy[i] / sqrt2) / 2.0;
    if (fx <= 1e-5)
      fx = 1e-5;
    if (fx >= 0.99999)
      fx = 0.99999;
    dp = (double) (i + 1) / (double) n - fx;
    dm = fx - i / (double) n;
    if (i == 0 || dp > dp_max)
      dp_max = dp;
    if (i == 0 || dm > dm_max)
      dm_max = dm;
  }
  y[0] = dp_max;
  y[1] = dm_max;
  free ((char *)xcopy);
  return y;
}
