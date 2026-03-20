#ident	"@(#)gen++:d.pkg/rc/makefile	1.3"

CPL = 3.0.3CC
CC  = cc
OTHERLIBS = mknewname.o p/librc.a
OTHERINCLUDES = -ptrp/ptrepository -Iincl
GEN = /home2/bloom1/laurae/gen++
QFILE = ruleChecker.query

INCLUDES = -I$(GEN)
GLIBS = $(GEN)/glib.o \
	$(GEN)/gfront.a
FEFLAGS =
CFLAGS = -g $(FEFLAGS) $(INCLUDES) $(OTHERINCLUDES)

analyzer: AnalMain.o analyzer.o GenoaGetOpts.o $(GLIBS) $(OTHERLIBS)
	$(CPL) -o analyzer $(CFLAGS) AnalMain.o analyzer.o GenoaGetOpts.o $(GLIBS) $(OTHERLIBS) -l++

p/librc.a:
	cd p; $(MAKE) CPL="$(CPL)"

$(QFILE):  query.list
	makeRC

mknewname.o : $(GEN)/mknewname.c
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
	cd p; $(MAKE) clean

clobber: clean
	rm -f analyzer

