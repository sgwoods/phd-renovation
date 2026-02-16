# H1 dist 1: of number of solution  against problem size

set xlabel "Program statements"
set xrange [0:6049]
set xtics 0,500
set ylabel "Number of (Large) Solutions Found"
set yrange [0:110]
set ytics 0,10
set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "h1-dist.ps"
plot "h1-dist.dat" title "Std Dist 1" with lines, "h1-dist.dat" title "Median" with errorbars


