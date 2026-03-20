#ident	"@(#)gen++:d.pkg/examples/makefile	1.5"
AFILES = CSg.an \
	Gprint.an \
	OP.an \
	TypeRel.an \
	defuse.an \
	dumptest.an \
	flow.an \
	gref.an \
	hier.an \
	metrics.an
OTHERLIBS=examples/mknewname.o

all:	$(AFILES)
	@echo DONE.

.SUFFIXES:
.SUFFIXES: .query .an

.query.an:
	(cd ..; make clobber; OTHERLIBS=$(OTHERLIBS) mk examples/$*)
	mv ../analyzer $*.an

clean:
	rm -f $(AFILES)
