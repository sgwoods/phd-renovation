# AVG lines New-FCDR 3 Dists, 2 Solns 100,500,1000,2000

set xlabel "Program statements"
set xrange [0:2049]
set xtics 0,250
set ylabel "Constraint checks"
set yrange [0:200000]
set ytics   0,25000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "f-avg.ps"
plot "f1.avg" title "Std Dist 1" with lines, "f2.avg" title "Equal Dist 2" with lines, "f3.avg" title "Skewed Dist 3" with lines



