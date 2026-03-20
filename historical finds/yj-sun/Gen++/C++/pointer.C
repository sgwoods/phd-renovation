
main()
{
	char temp; 
	int result = 1; 
	char A[20] = "This is a test.";
	char *ptr; 
	int i;
	i = 0;

	while( result )
	{
		temp = A[i]; 
		result = (temp != '\0');
		temp = A[i];
		i++;
	}
}

