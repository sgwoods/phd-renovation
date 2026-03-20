# 1 "simple.C"

/* <<Sun C++ 3.0.1 (cfront 3.0.1) 9/3/92>> */
/* < simple.C > */

# 1 "simple.C"
void *__vec_new (void *, int , int , void *);

# 1 "simple.C"
void __vec_delete (void *, int , int , void *, int , int );
typedef int (*__vptp)(void);
struct __mptr {short d; short i; __vptp f; };

# 1 "simple.C"
extern struct __mptr* __ptbl_vec__simple_C_main_[];

# 1 "simple.C"
int main (void )
# 2 "simple.C"
{ 
# 3 "simple.C"
int __1i ;

# 3 "simple.C"
int __1j ;

# 3 "simple.C"
int __1k ;
char __1A [20];

# 2 "simple.C"
_main();
# 5 "simple.C"
__1i = 0 ;
__1k = 1 ;
__1j = 2 ;

# 9 "simple.C"
while (__1i < 20 )
# 10 "simple.C"
{ 
# 11 "simple.C"
(__1A [__1i ])= 'a' ;
__1i ++ ;
}

# 13 "simple.C"
;

# 15 "simple.C"
}


/* this is to link in __head from libC.so for patch version of cfront */
extern struct __linkl *__head;
struct __linkl **__LinkInHead = (struct __linkl **)(& __head );


# 15 "simple.C"

/* the end */
