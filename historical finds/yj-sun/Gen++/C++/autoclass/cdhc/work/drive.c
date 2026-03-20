#include<stdio.h>
#include<stdlib.h>

void main()
{
   double x[1000],*y, *royston();
   int i,n=0, dcmp();

   /* x=(double *) malloc (1000*sizeof(double)); */
   while(scanf("%lf",&x[n++]) != EOF);
   n--;  
   printf("N=%d\n",n);

   y=royston (x, n); 

   printf("W=%g p=%g\n",y[0],y[1]);
}
