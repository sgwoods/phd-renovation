/*-Algorithm AS 111
 * Produces normal deviate corresponding to lower tail area = p.
 * by ??, 1977.
 * Applied Statistics, 26(?):118-121.
 *
 * Translation to C by James Darrell McCauley, mccauley@ecn.purdue.edu.
 *
 * See also AS 241 which contains alternative routines accurate to
 * about 7 and 16 decimal digits.
 */
#include<math.h>
#include<stdio.h>

double ppnd (p)
  double p;
{
  static double split = 0.42;
  static double a[4] = {2.50662823884, -18.61500062529, 41.39119773534,
  -25.44106049637};
  static double b[4] = {-8.47351093090, 23.08336743743, -21.06224101826,
  3.13082909833};
  static double c[4] = {-2.78718931138, -2.29796479134, 4.85014127135,
  2.32121276858};
  static double d[2] = {3.54388924762, 1.63706781897};
  double q, r, ret;

  q = p - 0.5;
  if (fabs (q) <= split)	/* 0.08 < P < 0.92 */
  {
    r = q * q;
    ret = q * (((a[3] * r + a[2]) * r + a[1]) * r + a[0]) /
      ((((b[4] * r + b[3]) * r + b[2]) * r + b[1]) * r + 1.0);
    return ret;
  }
  else
    /* P < 0.08 OR P > 0.92, SET R = MIN(P,1-P) */
  {
    r = p;
    if (q > 0.0)
      r = 1.0 - p;
    if (r > 0.0)
    {
      r = sqrt (-log (r));
      ret = (((c[3] * r + c[2]) * r + c[1]) * r + c[0]) /
	((d[1] * r + d[0]) * r + 1.0);
      if (q < 0.0)
	ret = -ret;
      return ret;
    }
  }
  ret = 0.0;
  return ret;
}
