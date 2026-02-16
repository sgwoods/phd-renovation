# CI interval New-FCDR Dists 1 2 and 3, 2 Solns  100,500,1000,2000, 3K 4K 5K
set xlabel "Program statements"
set xrange [0:6000]
set xtics 0,500
set ylabel "Constraint checks"
set yrange [0:500000]
set ytics 0,50000
set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "hall-ci.ps"
plot "h1.ci" title "Std Dist'n 1, 95% Confidence Interval" with errorbars,"h2.ci" title "Equal Dist'n 2, 95% Confidence Interval" with errorbars,"h3.ci" title "Skewed Dist'n 3, 95% Confidence Interval" with errorbars,"h1.ci" title "Dist'n 1" with lines,"h2.ci" title "Dist'n 2" with lines,"h3.ci" title "Dist'n 3" with lines
