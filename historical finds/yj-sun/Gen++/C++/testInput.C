int input(char *format, int* i)
{
	return 1;  
} 
main() 
{
  int count;
  int sum; 
  int value;
  count = 0;
  sum = 0; 
  while( input( "%i", &value ) == 1 )
  {
    sum += value;
    count++;
  }

}  
