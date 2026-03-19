# Memory-CSP   BT + FCDR w/ sort

set xlabel "Program statements"
set xrange [0:1049]
set xtics 0,50
set ylabel "Constraint checks"
set yrange [0:500000]
set ytics 0,25000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "ij2-ci.ps"
plot "ij2-ci.dat" title "Quilici 2 Phase: BT + FCDR w/ adv sort" with lines, "ij2-ci.dat" title "95% Confidence Interval" with errorbars


