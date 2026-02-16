# Quilici constraint checks, ij2 avg data

set xlabel "Program statements"
set xrange [0:549]
set xtics 0,50
set ylabel "Constraint checks"
set yrange [0:750000]
set ytics   0,50000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "ij2-avg.ps"
plot "ij2-avg.dat" title "Quilici" with lines, "ij2-avg.dat" title "Quilici rng" with errorbars



