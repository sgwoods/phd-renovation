# Version X BT only  q-i1 quilici-t1

set xlabel "Program statements"
set xrange [0:1000]
set xtics 0,50
set ylabel "Constraint checks"
set yrange [0:100000]
set ytics 0,10000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "newbt-ci.ps"
plot "newbt-ci.dat" title "BT only, dist 1" with lines, "newbt-ci.dat" title "95% Confidence Interval" with errorbars


