main()
{
	int i, mean;
	int a[20]; 

	for(i=0; i<20; i++)
		a[i] = i; 

	mean = 0;
	i = 0;
	while( i<20)
	{
		mean += a[i];
		i++; 
	} 
	mean /= 20; 
}  
