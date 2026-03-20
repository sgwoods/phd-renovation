#include <math.h>

main()
{
  int x1, y1;
  int x2, y2;
  int val1, val2;
  int result;
 
  x1 = y1 = 1;
  x2 = y2 = 4;

  val1 = (x2 - x1) * (x2 - x1);
  val2 = (y2 - y1) * (y2 - y1);

  result = sqrt(val1+val2);


}


