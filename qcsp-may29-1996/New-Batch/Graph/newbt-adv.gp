# BT adv  q-i1 quilici-t1

set xlabel "Program statements"
set xrange [0:1600]
set xtics 0,100
set ylabel "Constraint checks"
set yrange [0:300000]
set ytics 0,25000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "newbt-adv.ps"
plot "newbt-adv.ci" title "BT adv, dist 1" with lines, "newbt-adv.ci" title "95% Confidence Interval" with errorbars


