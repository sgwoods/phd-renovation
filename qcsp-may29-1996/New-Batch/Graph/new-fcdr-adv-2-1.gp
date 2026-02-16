# Compare FCDR adv between q-i2 and q-i1

set xlabel "Program statements"
set xrange [0:6000]
set xtics 0,500
set ylabel "Constraint checks"
set yrange [0:100000]
set ytics 0,10000

set key 
set term postscript landscape monochrome "Times-Roman" 14
set output "new-fcdr-adv-2-1-soln.ps"
plot "new-fcdr-adv.ci" title "1 Solution FCDR adv, dist 1" with lines, "new-fcdr-adv.ci" title "95% Confidence Interval" with errorbars,\
 "ff1.ci" title "2 Solution FCDR adv, dist 1" with lines, "ff1.ci" title "95% Confidence Interval" with errorbars