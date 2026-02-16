
# CI interval New-FCDR Dist 2, 2 Solns  100,500,1000,2000

set xlabel "Program statements"
set xrange [0:2049]
set xtics 0,250
set ylabel "Constraint checks"
set yrange [0:225000]
set ytics 0,25000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "f2-ci.ps"
plot "f2.ci" title "Equal Dist 2" with lines, "f2.ci" title "95% Confidence Interval" with errorbars


