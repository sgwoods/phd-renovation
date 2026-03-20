main()
{
	int i, j, k;
    i = 10;
    j = 1;  
	if( i==10 && j != 0 || i > j)
		i += 10;
	else if( i==20 )
	{
		i += 40;

	}
	else
		i += 60; 
	
    while ( i > 100 )
    {
        i--;
        i--;
		for(k=0; k<10; k++)
			i--;  

    } 

	for( i=0; i<10; i++ )
	{
		j = j + 1;

	} 

	do {
		j = j + 1;
		j++;
	} while ( i < 1000 ); 

} 	
