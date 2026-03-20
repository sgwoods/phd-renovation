/*ident	"@(#)gen++:d.pkg/rc/p/ctor.c	1.3" */
/* #include <iostream.h> */
#include <stdio.h>
#include <List.h>
#include <List.c>

List_of_p<char> mem;
List_of_p<char> init;
List_of_p<char> assTo;

void
addToMem(char* t)
{
    mem.put(t);
}

void
addToInit(char* t)
{
    List_of_piter<char> lii(init);
    lii.reset();
    lii.insert_prev(t);
}

void
addToAss(char* t)
{
    assTo.put(t);
}

void
checkInit(FILE *msgout,char* fname, char* file, int line) 
{
    List_of_piter<char> lim(mem);
    List_of_piter<char> lii(init);
    List_of_piter<char> lia(assTo);

    char* memb;
    while(lim.next(memb)) {
		lii.reset();
 		if(!lii.find_next(memb)) {
  fprintf(msgout, "line %d, '%s': %s::%s:%s ()", line,file,fname,fname,memb);
			lia.reset();
 			if(!lia.find_next(memb)) {
	fprintf(msgout, " should be given an initial value (ILNA).\n");
			}
			else {
 fprintf(msgout," should be initialized rather than assigned to (ILNA).\n");
			}
        }
    }
}

void
checkOrder(FILE *msgout, char* fname, char* file, int line) 
{
    List_of_piter<char> lim(mem);
    List_of_piter<char> lii(init);

    char* imemb;
    while(lii.next(imemb)) {
 		if(!lim.find_next(imemb)) {
 fprintf(msgout,"line %d, '%s': %s::%s (): members should",line,file,fname,fname); 
	fprintf(msgout,"be initialized in declaration order (ILOD)\n");
			break;
		}
	}
}

void
clearLists()
{
      mem.make_empty();
      init.make_empty();
      assTo.make_empty();
}
