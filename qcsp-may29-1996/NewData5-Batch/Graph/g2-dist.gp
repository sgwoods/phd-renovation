# G2 dist 2: of number of solution  against problem size

set xlabel "Program statements"
set xrange [0:6049]
set xtics 0,500
set ylabel "Number of (Small) Solutions Found"
set yrange [0:110]
set ytics 0,10
set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "g2-dist.ps"
plot "g2-dist.dat" title "Equal Dist 2" with lines, "g2-dist.dat" title "Median" with errorbars


