#include <stdio.h>

main()
{
	int i, j, k; 
	k = 10; 	
	scanf("%d", &i);
 
	switch(i)
	{
		case 0:
			j = 1;
			k = 5; 
			break;
		case 10:
			j = 2;
			k = 10;
			break;
		default:
			j = 3;
			break; 
	}

	for( i=0; i<10; i++ )
	{
		j=1;
		if( i<5 )
			continue;
		j=5;
	} 

}
