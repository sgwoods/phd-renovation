#include <stdio.h>

int function( int i, int j )
{
	int k;
	k = i * i + j * j;
	return k;
}

main( int argc, char **argv )
{
	int i, j, k;
	if( argc < 1 )
	{
		exit(0);
	}
				
	i = 10; 	
	j = 20;

	k = function(i, j);
 
	switch( k )
	{
		case 100:
			i += j;
			i -= 10;
			break;
		case 200:
			i-= j;
			for( j=0; j<5; j++)
			{
				i+=10;
				if( i>100 )
				{
					continue;
				}	
				i += 10;

			}
			break;
		default:
			i = j;
			break; 	
	}
 
	if( k == 0 )
	{
		k = 10;
	}
	else if( k==5 )
	{
		k = 20;
	}
	else
	{
		k = 30;
	}

	do {
		k += 10;
		k = i + 10;
		i = k; 
	} while( k < 100 );

}  


