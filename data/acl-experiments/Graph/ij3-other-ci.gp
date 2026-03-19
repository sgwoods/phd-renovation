# MAP-CSP FCDR no sort

set xlabel "Program statements"
set xrange [0:1049]
set xtics 0,50
set ylabel "Constraint checks"
set yrange [0:500000]
set ytics 0,25000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "ij3-other-ci.ps"
plot "ij3-other-ci.dat" title "FC, DR no sort" with lines, "ij3-other-ci.dat" title "95% Confidence Intervat" with errorbars



