/*      @(#)stdio.h 1.16 89/12/29 SMI; from UCB 1.4 06/30/83    */

/* LINTLIBRARY */

/*	@(#)c_varieties.h 1.11 91/10/07 SMI	*/

/*
 *	Copyright (c) 1988,1989,1990 by Sun Microsystems
 */

/************************************************************************** *						 			  *
 *			    >>> WARNING <<<				  *
 *									  *
 *	This file is provided for backward compatibility purpose only.    *
 *	It will be phased out in future releases of Sun C++.  No new	  *
 *	code should be written with the macros below.  Existing code	  *
 *	should be modified to ensure forward compatibility. 	 	  *
 *									  *
 *	The following format, which is similar to that in SunOS 5.0 	  *
 *	system header files, is the recommended way to achieve 		  *
 *	portability among different C dialects in SunOS 5.0.		  *
 *									  *
 *   		#ifndef _FOO_H						  *
 *   		#define _FOO_H						  *
 *									  *
 *  		#ifdef __cplusplus	// for C++ only			  *
 *		extern "C" {						  *
 *  		#endif							  *
 *									  *
 *		#if defined(__STDC__)	// for both Sun C++ and ANSI-C	  *
 *		extern int foo(char*);					  *
 *		#else			// for K&R C			  *
 *		extern int foo();					  *
 *		#endif							  *
 *									  *
 *		#ifdef __cplusplus					  *
 *		}							  *
 *		#endif							  *
 *									  *
 *		#endif							  *
 *									  *
\**************************************************************************/

/*
 *	This file defines some macros that are used to make code
 *	portable among the major C dialects currently in use at
 *	Sun.  As of 12/90, these include Sun C (a lot like K&R C),
 *	ANSI C, and C++.
 *
 * external functions:
 *	To declare an external function, invoke the EXTERN_FUNCTION
 *	macro; the macro's first parameter should be the function's
 *	return type and function name, and the second macro parameter
 *	should be the parenthesized list of function arguments (or an
 *	ellipsis - DOTDOTDOT macro should be used to indicate the 
 *      ellipsis as explained later in this file - if the arguments are 
 *      unspecified or of varying number or type, or the uppercase word 
 *      "_VOID_" if the function takes no arguments).  Some examples:
 *
 *	    EXTERN_FUNCTION( void printf, (char *, DOTDOTDOT) );
 *	    EXTERN_FUNCTION( int fread, (char*, int, int, FILE*) );
 *	    EXTERN_FUNCTION( int getpid, (_VOID_) );
 *
 *	Note that to be ANSI-C conformant, one should put "," at the end
 *	first argument of printf() declaration.
 *
 * Pointers to functions declared as struct members or function arguments:
 *	Ideally, all pointers to function types should be declared with
 *	the exact function argument types for C++ and ANSI-C, as in
 *
 *	    struct xp_ops {
 *	    #if defined(__STDC__)
 *           	bool_t      (*xp_recv)(SVCXPRT *, struct rpc_msg *);
 *			....
 *          #else
 *		bool_t      (*xp_recv)();
 *			....
 *	    };
 *
 *	    EXTERN_FUNCTION(int foo, (char*, int (*func) (int, char)));
 *
 *	In the event when the argument types of the function pointer may
 * 	vary depending on the situation, one can use DOTDOTDOT to tell
 *	C++ not to be so uptight.  Using this method may require pointer
 *	casting when actual assignments or function calls take place,
 *	because ellipses "..." in function pointers does not work as
 *	a wildcard.  It is meant to match only those pointers to functions
 *	that are defined specifically to take variable arguments.
 *	Note that for ANSI-C, at least one argument has to be provided 
 *	before the ellipses.
 *
 *	    struct foo {
 *		    int	(*f)( int, DOTDOTDOT );
 *		    . . .
 *	    };
 *
 */

typedef void (*_PFV_)();
typedef int (*_PFI_)();

/* Which type of C/C++ compiler are we using? */

    /*
     * Definitions for C++ 2.0 and later require extern "C" { decl; }
     */




extern  struct  _iobuf {
        int     _cnt;
        unsigned char *_ptr;
        unsigned char *_base;
        int     _bufsiz;
        short   _flag;
        char    _file;          /* should be short */
} _iob[];



 extern "C" { extern int _flsbuf ( unsigned char , struct _iobuf * ) ; } ;
 extern "C" { extern int _filbuf ( struct _iobuf * ) ; } ;


 extern "C" { extern struct _iobuf * fopen ( const char * , const char * ) ; } ;
 extern "C" { extern struct _iobuf * fdopen ( int , const char * ) ; } ;
 extern "C" { extern struct _iobuf * freopen ( const char * , const char * , struct _iobuf * ) ; } ;
 extern "C" { extern struct _iobuf * popen ( const char * , const char * ) ; } ;
 extern "C" { extern struct _iobuf * tmpfile ( void ) ; } ;
 extern "C" { extern long ftell ( struct _iobuf * ) ; } ;
 extern "C" { extern char * fgets ( char * , int , struct _iobuf * ) ; } ;
 extern "C" { extern char * gets ( char * ) ; } ;
 extern "C" { extern void exit ( int ) ; } ;
 extern "C" { extern char * sprintf ( char * , const char * , ... ) ; } ;		
/*
 *  Additional declarations to make C++ happy.
 */
 extern "C" { extern int puts ( const char * ) ; } ;
 extern "C" { extern int fputs ( const char * , struct _iobuf * ) ; } ;
 extern "C" { extern int printf ( const char * , ... ) ; } ;
 extern "C" { extern int fprintf ( struct _iobuf * , const char * , ... ) ; } ;
 extern "C" { extern int scanf ( const char * , ... ) ; } ;
 extern "C" { extern int fscanf ( struct _iobuf * , const char * , ... ) ; } ;
 extern "C" { extern int sscanf ( const char * , const char * , ... ) ; } ;
 extern "C" { extern int fread ( char * , unsigned int , int , struct _iobuf * ) ; } ;
 extern "C" { extern int fwrite ( const char * , unsigned int , int , struct _iobuf * ) ; } ;
 extern "C" { extern int fclose ( struct _iobuf * ) ; } ;
 extern "C" { extern int fflush ( struct _iobuf * ) ; } ;
 extern "C" { extern int fseek ( struct _iobuf * , long , int ) ; } ;
 extern "C" { extern void rewind ( struct _iobuf * ) ; } ;
 extern "C" { extern int getw ( struct _iobuf * ) ; } ;
 extern "C" { extern int fgetc ( struct _iobuf * ) ; } ;

 extern "C" { extern int pclose ( struct _iobuf * ) ; } ;
 extern "C" { extern int putw ( int , struct _iobuf * ) ; } ;
 extern "C" { extern int fputc ( char , struct _iobuf * ) ; } ;
 extern "C" { extern void setbuf ( struct _iobuf * , char * ) ; } ;
 extern "C" { extern void setbuffer ( struct _iobuf * , char * , int ) ; } ;
 extern "C" { extern int setlinebuf ( struct _iobuf * ) ; } ;
 extern "C" { extern int ungetc ( int , struct _iobuf * ) ; } ;

 extern "C" { extern int abort ( void ) ; } ;
 extern "C" { extern long strtol ( const char * , char * * , int ) ; } ;
 extern "C" { extern double strtod ( const char * , char * * ) ; } ;
 extern "C" { extern int atoi ( const char * ) ; } ;
 extern "C" { extern double atof ( const char * ) ; } ;
 extern "C" { extern long atol ( const char * ) ; } ;
 extern "C" { extern void perror ( const char * ) ; } ;

 extern "C" { extern char * ctermid ( char * ) ; } ;
 extern "C" { extern char * cuserid ( char * ) ; } ;
 extern "C" { extern char * tempnam ( const char * , const char * ) ; } ;
 extern "C" { extern char * tmpnam ( char * ) ; } ;
 extern "C" { extern void psignal ( unsigned , char * ) ; } ;
 extern "C" { extern int putenv ( const char * ) ; } ;
 extern "C" { extern void setusershell ( void ) ; } ;
 extern "C" { extern char * setstate ( char * ) ; } ;
 extern "C" { extern void srandom ( unsigned ) ; } ;
 extern "C" { extern long random ( void ) ; } ;
 extern "C" { extern void swab ( const char * , char * , int ) ; } ;
 extern "C" { extern char * getpass ( const char * ) ; } ;
/*EXTERN_FUNCTION ( extern int    vfprintf, (FILE*, const char*, va_list) );*/
 extern "C" { extern int vfprintf ( struct _iobuf * , const char * , void * ) ; } ;
 extern "C" { extern int setvbuf ( struct _iobuf * , char * , int , int ) ; } ;



/* 
 * system error messages - additional decls to please C++.
 */
extern int errno;
extern char* sys_errlist[];
extern int sys_nerr;


main() 
{
  int count;
  int sum; 
  int value;
  count = 0;
  sum = 0; 
  while( scanf( "%i", &value ) == 1 )
  {
    sum += value;
    count++;
  }

}  
