# CI interval New-FCDR Dist 3, 2 Solns  100,500,1000,2000
set xlabel "Program statements"
set xrange [0:6049]
set xtics 0,500
set ylabel "Constraint checks"
set yrange [0:500000]
set ytics 0,50000
set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "g3-ci.ps"
plot "g3.ci" title "Skewed Dist 3" with lines, "g3.ci" title "95% Confidence Interval" with errorbars


