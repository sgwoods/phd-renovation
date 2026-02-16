# New Expers, Q-i1 all w/ Advance ordering

set xlabel "Program statements"
set xrange [0:2000]
set xtics 0,200
set ylabel "Constraint checks"
set yrange [0:50000]
set ytics 0,5000

#set key 400,235000,2
set key
set term postscript landscape monochrome "Times-Roman" 14
set output "newfig4-sm.ps"

plot "new-fcdr-adv.ci" title "MAP-CSP : FCDR adv" with linespoints,\
 "ff1.ci" title "MAP-CSP : FCDR adv (2 solution)" with linespoints,\
 "new-memory-fcdrA-fcdrA.ci" title "Memory-CSP: FCDR adv + FCDR adv" with linespoints,\
 "newbt-adv.ci" title "MAP-CSP : Simple BackTrack adv" with linespoints,\
 "newbt-noadv.ci" title "MAP-CSP : Simple BackTrack" with linespoints,\
 "new-ac3-fcdr-adv.ci" title "AC3 + FCDR adv" with linespoints
