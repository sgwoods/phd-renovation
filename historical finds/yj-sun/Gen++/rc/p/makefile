#ident	"@(#)gen++:d.pkg/rc/p/makefile	1.2"
#ident	"%@%"
CPL = CC
CFLAGS = -I../incl
OFILES = check.o ctor.o

librc.a: $(OFILES)
	ar r librc.a $?
	ranlib librc.a

.c.o:
	$(CPL) -c $(CFLAGS) $<

clean:
	rm -f librc.a $(OFILES)
	rm -rf ptrepository
