# 1 "C++/scanf.C"

/* <<Sun C++ 3.0.1 (cfront 3.0.1) 9/3/92>> */
/* < C++/scanf.C > */

# 1 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"

# 1 "C++/scanf.C"
void *__vec_new (void *, int , int , void *);

# 1 "C++/scanf.C"
void __vec_delete (void *, int , int , void *, int , int );
typedef int (*__vptp)(void);
struct __mptr {short d; short i; __vptp f; };

# 1 "C++/scanf.C"

# 1 "/usr/lang/SC2.0.1/include/CC_413/c_varieties.h"

# 10 "/usr/lang/SC2.0.1/include/CC_413/c_varieties.h"

# 44 "/usr/lang/SC2.0.1/include/CC_413/c_varieties.h"

# 99 "/usr/lang/SC2.0.1/include/CC_413/c_varieties.h"

# 100 "/usr/lang/SC2.0.1/include/CC_413/c_varieties.h"
typedef void (*_PFV_ )(void );
typedef int (*_PFI_ )(void );

# 106 "/usr/lang/SC2.0.1/include/CC_413/c_varieties.h"

# 112 "/usr/lang/SC2.0.1/include/CC_413/c_varieties.h"

# 132 "/usr/lang/SC2.0.1/include/CC_413/c_varieties.h"

# 134 "/usr/lang/SC2.0.1/include/CC_413/c_varieties.h"

# 5 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"

# 8 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"
struct _iobuf;
struct _iobuf {	/* sizeof _iobuf == 20 */
int _cnt__6_iobuf ;
unsigned char *_ptr__6_iobuf ;
unsigned char *_base__6_iobuf ;
int _bufsiz__6_iobuf ;
short _flag__6_iobuf ;
char _file__6_iobuf ;
};

# 15 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"
extern struct _iobuf _iob [];

# 30 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"

# 34 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"

# 39 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"

# 57 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"

# 71 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"

# 124 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"

# 128 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"
extern int errno ;
extern char *sys_errlist [];
extern int sys_nerr ;

# 2 "C++/scanf.C"

# 75 "/usr/lang/SC2.0.1/include/CC_411/stdio.h"
extern int scanf (const char *,...);
extern struct __mptr* __ptbl_vec__C___scanf_C_main_[];

# 3 "C++/scanf.C"
int main (void )
# 4 "C++/scanf.C"
{ 
# 5 "C++/scanf.C"
int __1count ;
int __1sum ;
int __1value ;

# 4 "C++/scanf.C"
_main();
# 8 "C++/scanf.C"
__1count = 0 ;
__1sum = 0 ;
while (scanf ( (const char *)"%i", & __1value ) == 1 )
# 11 "C++/scanf.C"
{ 
# 12 "C++/scanf.C"
__1sum +=
# 12 "C++/scanf.C"
__1value ;
__1count ++ ;
}

# 16 "C++/scanf.C"
}


/* this is to link in __head from libC.so for patch version of cfront */
extern struct __linkl *__head;
struct __linkl **__LinkInHead = (struct __linkl **)(& __head );


# 16 "C++/scanf.C"

/* the end */
C++/scanf.C
