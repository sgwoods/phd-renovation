     1
     2  main()
     3  {
     4      char temp;
     5      Boolean result = 1;
     6      char A[20] = "This is a test.";
     7      int i;
     8      i = 0;
     9
    10      while( result )
    11      {
    12          temp = A[i];
    13          result = (temp != '\0');
    14          temp = A[i];
    15          i++;
    16      }
    17
    18  }
    19

