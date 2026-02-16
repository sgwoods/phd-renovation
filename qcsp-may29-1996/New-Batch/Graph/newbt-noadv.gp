# BT no adv  q-i1 quilici-t1

set xlabel "Program statements"
set xrange [0:1600]
set xtics 0,100
set ylabel "Constraint checks"
set yrange [0:750000]
set ytics 0,50000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "newbt-noadv.ps"
plot "newbt-noadv.ci" title "BT no adv, dist 1" with lines, "newbt-noadv.ci" title "95% Confidence Interval" with errorbars


