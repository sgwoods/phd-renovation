#include<math.h>
#include<stdio.h>
main()
{
  int i;
  for(i=1;i<=10;++i)
   printf("%g %g\n",log((double)i),log10((double)i));

   printf("%g \n",log(0.0681756));
}
