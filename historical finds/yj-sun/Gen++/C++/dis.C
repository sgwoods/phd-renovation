#include <math.h>

double Distance( int x1, int y1, int x2, int y2 )
{
  int val1, val2;
  double result;
  val1 = (x2 - x1) * (x2 - x1);
  val2 = (y2 - y1) * (y2 - y1);
  result = sqrt(val1+val2);
  return result;
} 
main()
{
  int x1, y1;
  int x2, y2;
  double result;
  x1 = y1 = 1;
  x2 = y2 = 4;
  result = sqrt( (x1-x2) * (x1-x2) + (y1-y2) * (y1-y2) ); 
  result = Distance(x1, y1, x2, y2); 
}


