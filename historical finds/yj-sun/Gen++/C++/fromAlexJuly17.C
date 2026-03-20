#include <math.h>

main()
{
  int x1, y1;
  int x2, y2;

  x1 = y1 = 1;
  x2 = y2 = 4;

  int val1 = (x2 - x1) * (x2 - x1);
  int val2 = (y2 - y1) * (y2 - y1);

  double result = sqrt(val1 + val2);
}


