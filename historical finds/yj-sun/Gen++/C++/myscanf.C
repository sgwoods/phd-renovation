#include <stdio.h>

main() 
{
  int count;
  int sum; 
  int value;
  count = 0;
  sum = 0; 
  while( scanf( "%i", &value ) == 1 )
  {
    sum += value;
    count++;
  }

}  
