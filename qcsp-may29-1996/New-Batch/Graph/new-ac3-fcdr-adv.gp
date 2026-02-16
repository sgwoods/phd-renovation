# AC3 + FCDR adv  q-i1 quilici-t1

set xlabel "Program statements"
set xrange [0:1600]
set xtics 0,100
set ylabel "Constraint checks"
set yrange [0:100000]
set ytics 0,10000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "new-ac3-fcdr-adv.ps"
plot "new-ac3-fcdr-adv.ci" title "AC3 + FCDR adv, dist 1" with lines, "new-ac3-fcdr-adv.ci" title "95% Confidence Interval" with errorbars


