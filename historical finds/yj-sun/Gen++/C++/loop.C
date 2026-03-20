
main()
{
	char temp; 
	int checkResult = 1; 
	char A[20] = "This is a test.";
	int i;
	i = 0;

	while( checkResult )
	{
		temp = A[i]; 
		checkResult = (temp != '\0');
		temp = A[i];
		i++;
	}
	for( i=0; i<20; i++)
	{
		temp = A[i];
	}  
} 
