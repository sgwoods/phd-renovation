#  MAPCSP SimpleBacktrack

set xlabel "Program statements"
set xrange [0:1049]
set xtics 0,50
set ylabel "Constraint checks"
set yrange [0:500000]
set ytics 0,25000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "ij1-other-ci.ps"
plot "ij1-other-ci.dat" title "MAP-CSP : Simple BackTrack" with lines, "ij1-other-ci.dat" title "95% Confidence Interval" with errorbars


