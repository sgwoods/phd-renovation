
# CI interval New-FCDR Dist 2, 2 Solns  100,500,1000,2000

set xlabel "Program statements"
set xrange [0:9000]
set xtics 0,500
set ylabel "Constraint checks"
set yrange [0:150000]
set ytics 0,10000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "ff3-ci.ps"
plot "ff3.ci" title "Skewed Dist 3" with lines, "ff3.ci" title "95% Confidence Interval" with errorbars


