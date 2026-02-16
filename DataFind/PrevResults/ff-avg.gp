# AVG lines New-FCDR 3 Dists, 2 Solns 100,500,1000,2000

set xlabel "Program statements"
set xrange [0:9000]
set xtics 0,500
set ylabel "Constraint checks"
set yrange [0:150000]
set ytics   0,10000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "ff-avg.ps"
plot "ff1.avg" title "Std Dist 1" with lines, "ff2.avg" title "Equal Dist 2" with lines, "ff3.avg" title "Skewed Dist 3" with lines



