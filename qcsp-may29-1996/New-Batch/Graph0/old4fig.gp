# OLD : All four experiments on the same scale

set xlabel "Program statements"
set xrange [0:1249]
set xtics 0,100
set ylabel "Constraint checks"
set yrange [0:200000]
set ytics 0,10000

#set key 400,235000,2
set key
set term postscript landscape monochrome "Times-Roman" 14
set output "old4fig.ps"

plot "old-fcdr-adv.dat" title "MAP-CSP : FCDR w/ adv sort" with linespoints,\
 "old-fcdr-noadv.dat" title "MAP-CSP : FCDR, no sort" with linespoints,\
 "old-memory-fcdr-fcdr-adv.dat" title "Memory-CSP: Both FCDR w/ adv sort" with linespoints,\
 "old-memory-bt-fcdr-adv.dat" title "Memory-CSP: BT + FCDR w/ adv sort" with linespoints,\
 "old-bt-ci.dat" title "MAP-CSP : Simple BackTrack" with linespoints

