#include <iomanip.h>
#include <iostream.h>
#include <fstream.h>
#include <stdlib.h>

main( int argc, char *argv[] )
{
	ifstream input( argv[1] , ios::in);
	int posi = atoi( argv[2] );
	int i = 0, j = 0;
	char temp[20];
	char ch; 

	while( i < posi && input.get( ch ))
	{
		cout<<ch; 
		i++;
		if( i< posi && i >= posi - 18 )
			temp[j++] = ch;
	
	}
//	temp[j] = '\0';
	cout << endl; 
}

 
			
