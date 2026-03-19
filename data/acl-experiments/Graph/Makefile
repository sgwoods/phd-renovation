# Makefile 
# 
# graphical output
#

ij1-avg.ps:	ij1-avg.dat ij1-avg.gp
		gnuplot < ij1-avg.gp

ij1-ci.ps:	ij1-ci.dat ij1-ci.gp
		gnuplot < ij1-ci.gp

ij1-avg.dat:	ij1-raw.dat
		grab-avg  < ij1-raw.dat > ij1-avg.dat


ij1-ci.dat:	ij1-raw.dat
		grab-ci  < ij1-raw.dat > ij1-ci.dat

# ---------------------------------------------------------------------------

ij2-avg.ps:	ij2-avg.dat ij2-avg.gp
		gnuplot < ij2-avg.gp

ij2-ci.ps:	ij2-ci.datij2-ci.gp
		gnuplot < ij2-ci.gp

ij2-avg.dat:	ij2-raw.dat
		grab-avg  < ij2-raw.dat > ij2-avg.dat

ij2-ci.dat:	ij2-raw.dat
		grab-ci  < ij2-raw.dat > ij2-ci.dat

# ---------------------------------------------------------------------------

ij3-avg.ps:	ij3-avg.dat ij3-avg.gp
		gnuplot < ij3-avg.gp

ij3-ci.ps:	ij3-ci.dat ij3-ci.gp
		gnuplot < ij3-ci.gp

ij3-avg.dat:	ij3-raw.dat
		./grab-avg  < ij3-raw.dat > ij3-avg.dat

ij3-ci.dat:	ij3-raw.dat
		./grab-ci  < ij3-raw.dat > ij3-ci.dat


