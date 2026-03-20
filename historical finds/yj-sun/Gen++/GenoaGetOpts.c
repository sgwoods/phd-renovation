

/*===================================================================================*/
/* This product produced by sgwoods on Thu Oct  9 14:51:49 1997 from file                     */
/*    /tmp_mnt/proj/seg/team/sgwoods/yj-sun/Gen++/myquery/compound-contain.query using   */
/* the gen++ applications generator, Unknown version                        */
/*                                                                                   */
/*  The gen++ applications Generator was written by Prem Devanbu,                 */
/* of the Artificial Intelligence principles Research Department,                    */
/* in collaboration with Laura Eaves of the Object Oriented Technologies group */
/* AT&T Bell Labs. Murray Hill, Telno (201) 582-2062, prem@research.att.com          */
/*===================================================================================*/


#include <sys/param.h>
#include <stdlib.h>
#include <strings.h>
#include <stdio.h>

#define OPTYES  43
#define OPTNO   44


typedef int INTEGER;
typedef char *STRING;
typedef float FLOAT;


/* The following routine processes the command line option and
   gets the value. We assume that options format is "-opt value"  
   Both options and env vgen++bles are handled here, in a similar
   way. Note the #defines above. We hope the values are filled
   in by Stage when creating Genoa */

#if __STDC__ || __cplusplus
char *GetTheOpt(char  *OptTab[],int Cnt,int Optp,char *OptStr)
#else
char *GetTheOpt(OptTab,Cnt,Optp, OptStr)
char *OptTab[];
int Cnt;
int Optp;
char *OptStr;
#endif
{
  while (--Cnt > 0)  
    if (**++OptTab == '-')
      if (strcmp(OptStr,(char *)(1+*OptTab)) == 0)
	return (*++OptTab);
  if (Optp != OPTYES)
    printf("\n *** Error *** The Option %s is not preset", OptStr);
  return((char *) NULL);
}

#if __STDC__ || __cplusplus
char *GetTheEnv(int Optp, char *OptStr)
#else
char *GetTheEnv(Optp, OptStr)
int Optp;
char *OptStr;
#endif
{
  char *TheVal;
  if ((TheVal = getenv(OptStr)) == (char *) NULL) {
    if (Optp != OPTYES)
      printf("\n *** Error *** The Environment variable %s is not set", OptStr);
    return((char *) NULL);
  }
  else return ((char *) TheVal);
}
