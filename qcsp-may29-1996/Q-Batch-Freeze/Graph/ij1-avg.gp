# BT constraint checks, ij1 avg data

set xlabel "Program statements"
set xrange [0:549]
set xtics 0,50
set ylabel "Constraint checks"
set yrange [0:600000]
set ytics   0,50000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "ij1-avg.ps"
plot "ij1-avg.dat" title "BT" with lines, "ij1-avg.dat" title "BT rng" with errorbars



