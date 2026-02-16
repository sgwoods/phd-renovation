# CI interval New-FCDR Dist 1, 2 Solns  100,500,1000,2000

set xlabel "Program statements"
set xrange [0:9000]
set xtics 0,500
set ylabel "Constraint checks"
set yrange [0:150000]
set ytics 0,10000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "ff1-ci.ps"
plot "ff1.ci" title "Std Dist 1" with lines, "ff1.ci" title "95% Confidence Interval" with errorbars


