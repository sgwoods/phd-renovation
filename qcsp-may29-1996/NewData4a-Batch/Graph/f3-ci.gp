
# CI interval New-FCDR Dist 3, 2 Solns  100,500,1000,2000

set xlabel "Program statements"
set xrange [0:2049]
set xtics 0,250
set ylabel "Constraint checks"
set yrange [0:225000]
set ytics 0,25000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "f3-ci.ps"
plot "f3.ci" title "Skewed Dist 3" with lines, "f3.ci" title "95% Confidence Interval" with errorbars


