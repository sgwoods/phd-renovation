
main()
{
	char temp; 
	int result = 1; 
	char A[20] = "This is a test.";
	char *ptr; 
	int i;
	i = 0;

	ptr = &A[0]; 

	while( result )
	{
		temp = *ptr++; 
		temp = *ptr--;
		temp = ++(*ptr);
		temp = --(*ptr); 	

		result = (temp != '\0');
		temp = A[i];
		i++;
	}
	while( result )
		A[0] = 'a';  
}

