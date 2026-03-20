#include "2func1.h"

main()
{
	int i, j, k;
	char A[20];
	i = 0;
	k = 1;
	k = i = j = 1;
        i = func1( k ); 

	while( i<20 )
	{
		A[i] = 32;
		i++;
	};

}  
