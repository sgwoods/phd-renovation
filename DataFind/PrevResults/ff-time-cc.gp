# Statements against Time

set xlabel "Time in Seconds"
set xrange [0:1500]
set xtics 0,100
set ylabel "Constraint Checks"
set yrange [0:120000]
set ytics 0,10000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "time-cc.ps"
plot "time-cc.dat" title "Time/CC Sampling" with lines


