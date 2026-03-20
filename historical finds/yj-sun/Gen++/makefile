#ident	"@(#)gen++:d.pkg/makefile	1.7"

# solaris...
# CPL =  /proj/solaris/SUNWSpro/SC3.0.1/bin/CC

# sun ...
CPL =  /proj/soft1/C++2.1/SC1.0/CC

CC  =  cc

GEN = /proj/seg/team/sgwoods/yj-sun/Gen++
OTHERLIBS = mknewname.o
OTHERINCLUDES =

INCLUDES = -I$(GEN)
GLIBS = $(GEN)/glib.o \
	$(GEN)/gfront.a
FEFLAGS =
CFLAGS = -g $(FEFLAGS) $(INCLUDES) $(OTHERINCLUDES)

QFILE = dumptest.query

analyzer: AnalMain.o analyzer.o GenoaGetOpts.o $(GLIBS) $(OTHERLIBS)
	$(CPL) -o analyzer $(CFLAGS) AnalMain.o analyzer.o GenoaGetOpts.o $(GLIBS) $(OTHERLIBS)

mknewname.o: $(GEN)/mknewname.c
	$(CPL) -c $(GEN)/mknewname.c

GenoaGetOpts.c AnalMain.c analyzer.c:	$(QFILE) $(GEN)/cplang
	$(GEN)/cplang $(QFILE)

GenoaGetOpts.o:	GenoaGetOpts.c
	$(CPL) $(CFLAGS)  -c GenoaGetOpts.c

AnalMain.o:	AnalMain.c
	$(CPL) $(CFLAGS) -c AnalMain.c

analyzer.o: 	analyzer.c
	$(CPL) $(CFLAGS) -c analyzer.c

clean:
	rm -f analyzer.[co] AnalMain.[co] GenoaGetOpts.[co] GenoaMainRoutine.[co]
	rm -f mknewname.o

clobber: clean
	rm -f analyzer

