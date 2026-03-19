# Quilici time version, ij3 ci data

set xlabel "Program statements"
set xrange [0:1049]
set xtics 0,50
set ylabel "CPU Seconds"
set yrange [0:1500]
set ytics 0,25

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "ij3-ci-time.ps"
plot "ij3-ci-time.dat" title "Quilici 2 Phase: Both FCDR w/ adv sort" with lines, "ij3-ci-time.dat" title "95% Confidence Interval" with errorbars


