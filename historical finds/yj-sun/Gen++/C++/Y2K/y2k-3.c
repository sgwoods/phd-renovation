From sgwoods Thu Apr 24 16:36:18 1997
Return-Path: <sgwoods>
Received: by spectra.eng.hawaii.edu (4.1/SMI-4.1)
	id AA24159; Thu, 24 Apr 97 16:36:17 HST
Date: Thu, 24 Apr 97 16:36:17 HST
From: sgwoods (Steven Woods)
Message-Id: <9704250236.AA24159@spectra.eng.hawaii.edu>
To: yjzhang@spectra
Status: RO

/* 
  y2k-3.c
  Derivative from ARIE COBOL Y2K example 1
  note the logic is now correct according to the description,
   with the conditions separated as best as possible similar to original
*/

#include <stdio.h>

main()
{
int year; 
int cc, yy;
int r1, r2, q;

scanf("%i", &year);

cc = (int) ( year / 100 );
yy = year - cc * 100;
printf("Century = %i, Year = %i.\n", cc, yy);

q  = (int) (year / 4);
r1 = year - q * 4;          

/* divisible by   4 iff r1 == 0 */
/* divisible by 100 iff yy == 00 */
/* divisible by 400 iff r2 == 0 */

if (r1 == 0)
  if (yy == 0)
    {
      q = (int) (year / 400);       /* note code could be outside cond'n */
      r2 = year - q * 400;        
      if (r2 == 0)
	{
	  printf("Case r1, yy, r2 :   Year %i is a leap year.\n", year);
	}
      else
	{
	  printf("Case r1, yy, !r2:  Year %i is not a leap year.\n", year);
	}
    }
  else
    {
    printf("Case r1, !yy    :  Year %i is a leap year.\n", year);
    }
else
  {
    printf("Case !r1        :  Year %i is not a leap year.\n", year);
  }

printf("End of program #3.\n");

} /* end of main */

/* Local Variables: */
/* compile-command: "gcc -ansi -o y2k-3 y2k-3.c -lm" */
/* End: */

