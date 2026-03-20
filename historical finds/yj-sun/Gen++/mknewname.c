/*ident	"@(#)gen++:mknewname.c	1.2" */

#include "Gmainheader.h"
#include <string.h> 
/*
char *newname ()  {
  static int cnt=0;
  return(mystrconcat("Cond",myitoa(++cnt)));
}
*/

char *newname (char *fname)  {
  static int cnt=0;
  return(mystrconcat( mystrconcat( fname, "_Cond"),myitoa(++cnt)));
}

char *newBlock ()  {
  static int cnt=0;
  return(mystrconcat("Block",myitoa(++cnt)));
}
/*
char *newElem (char *fname)  {
  static int cnt=0;
  int i = 0; 
  char *buf = mystrconcat(fname, "");
  while (buf[i] != '.' && buf[i] != '\0') i++;
  buf[i] = '\0';
  return (mystrconcat ( mystrconcat( mystrconcat(buf,"_"), myitoa(++cnt)), 
				mystrconcat( " ", myitoa(cnt)) ));
}
*/

char *newElem (char *fileName, char *funcName)  {
  static int cnt=0;
  int i = 0; 
  char *buf = mystrconcat(fileName, "");
  char *buf1 = mystrconcat(funcName, ""); 
  while (buf[i] != '.' && buf[i] != '\0') i++;
  buf[i] = '\0';
  return ( mystrconcat(

              mystrconcat ( 
                  mystrconcat( 
                       mystrconcat(buf,"_"), 
                       myitoa(++cnt)), 
				  mystrconcat( " ", myitoa(cnt)) ),

              mystrconcat (" ", buf1))

         );

}

char *newFileName (char *fname)  {
  static int cnt=0;
  int i = 0; 
  char *buf = mystrconcat(fname, "");
  while (buf[i] != '.' && buf[i] != '\0') i++;
  if( buf[i] == '\0' )
	return ( buf ); 

  while (buf[i] != '\0' ) {
		buf[i] = buf[i+1];
		i++;
	} 
  return ( buf );
}


char *newRangeFileName (char *fname)  {
  static int cnt=0;
  int i = 0; 
  char *buf = mystrconcat(fname, "");
  while (buf[i] != '.' && buf[i] != '\0') i++;
  if( buf[i] == '\0' )
	return ( buf ); 

  while (buf[i] != '\0' ) {
		buf[i] = buf[i+1];
		i++;
	} 
  return ( mystrconcat(buf, ".range" ));
}

char *newControlFileName (char *fname)  {
  static int cnt=0;
  int i = 0; 
  char *buf = mystrconcat(fname, "");
  while (buf[i] != '.' && buf[i] != '\0') i++;
  if( buf[i] == '\0' )
	return ( buf ); 

  while (buf[i] != '\0' ) {
		buf[i] = buf[i+1];
		i++;
	} 
  return ( mystrconcat(buf, ".control" ));
}

char *newComponentFileName (char *fname)  {
  static int cnt=0;
  int i = 0; 
  char *buf = mystrconcat(fname, "");
  while (buf[i] != '.' && buf[i] != '\0') i++;
  if( buf[i] == '\0' )
	return ( buf ); 

  while (buf[i] != '\0' ) {
		buf[i] = buf[i+1];
		i++;
	} 
  return ( mystrconcat(buf, ".component") );
}

char *newResult (char* fname)  {
  static int cnt=0;
  return(mystrconcat( mystrconcat (fname, "_R_"),myitoa(++cnt)));
}

char *newConstraint ()  {
  static int cnt=0;
  return(mystrconcat("constraint",myitoa(++cnt)));
}

char *newsuf (char *fname, char *suf)  {
char *buf = mystrconcat(fname, "");
int i = 0;
while (buf[i] != '.' && buf[i] != 0) i++;
buf[i] = 0;
return (mystrconcat(buf,suf));
}



int IsHeader(char *fname)  {
  int len = strlen(fname);
/*   fprintf(stderr,"***FILE%s**%c**\n",fname,fname[len-1]); 
  fflush(stderr); */
  return (!( (fname[len-1] == 'c') || (fname[len-1] == 'C')));
}

int issubstr(char *s1, char *s2) {
/*  fprintf(stderr,"%s %s",s1,s2);  */
  return ((char*)strstr(s1,s2) != (char *) NULL);
}

char *nameinscope(char *s1, char *s2) {

  return (mystrconcat (s1, mystrconcat("\t",s2)));
}

    


#if __STDC__ || __cplusplus || c_plusplus
char *LastGenFixExt(char *fname,char *newend)
#else
char *LastGenFixExt(fname,newend)
char *fname;
char *newend;
#endif
{
	char *buf= mystrconcat(fname, "");
        int len = strlen(fname);
	if (len > 0) len--;
        buf[len] = 0;  /* zap the extension */
        while(!(--len < 0 ) && buf[len] != '/') ;
	return  (mystrconcat(&buf[len+1],newend));
}

