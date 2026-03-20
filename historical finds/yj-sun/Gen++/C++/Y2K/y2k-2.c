From sgwoods Thu Apr 24 16:36:16 1997
Return-Path: <sgwoods>
Received: by spectra.eng.hawaii.edu (4.1/SMI-4.1)
	id AA24152; Thu, 24 Apr 97 16:36:15 HST
Date: Thu, 24 Apr 97 16:36:15 HST
From: sgwoods (Steven Woods)
Message-Id: <9704250236.AA24152@spectra.eng.hawaii.edu>
To: yjzhang@spectra
Status: RO

/* 
  y2k-2.c
  Derivative from ARIE COBOL Y2K example 1
  note the logic is now correct according to the description,
   however the tests are centralized in a single logical condition
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

q = (int) (year / 400);
r2 = year - q * 400;        

/* divisible by   4 iff r1 == 0 */
/* divisible by 100 iff yy == 00 */
/* divisible by 400 iff r2 == 0 */

if ( (r1 ==0) && ( !(yy == 0) || (r2 == 0) ))
  {
    printf("Year %i is a leap year.\n", year);
  }
else
  {
    printf("Year %i is not a leap year.\n", year);
  }

printf("End of program #2.\n");

} /* end of main */

/* Local Variables: */
/* compile-command: "gcc -ansi -o y2k-2 y2k-2.c -lm" */
/* End: */

