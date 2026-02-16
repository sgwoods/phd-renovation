# FCDR constraint checks, ij4 confidence interval data

set xlabel "Program statements"
set xrange [0:1049]
set xtics 0,50
set ylabel "CPU Seconds"
set yrange [0:1500]
set ytics 0,25

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "ij4-ci-time.ps"
plot "ij4-ci-time.dat" title "FC, DR w/ adv sort" with lines, "ij4-ci-time.dat" title "95% Confidence Interval" with errorbars


