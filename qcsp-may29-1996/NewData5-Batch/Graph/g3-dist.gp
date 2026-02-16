# G3 dist 3: of number of solution  against problem size

set xlabel "Program statements"
set xrange [0:6049]
set xtics 0,500
set ylabel "Number of (Small) Solutions Found"
set yrange [0:160]
set ytics 0,10
set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "g3-dist.ps"
plot "g3-dist.dat" title "Skewed Dist 3" with lines, "g3-dist.dat" title "Median" with errorbars


