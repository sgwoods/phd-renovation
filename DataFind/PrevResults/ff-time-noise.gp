# Statements against Time

set xlabel "Program statements"
set xrange [0:9000]
set xtics 0,500
set ylabel "Time in Seconds"
set yrange [0:1500]
set ytics 0,100

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "time-noise.ps"
plot "time-noise.dat" title "Time Sampling" with lines


