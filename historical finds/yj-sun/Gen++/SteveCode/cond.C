main()
{
	int i, j;
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
    } 

} 	
