# All four experiments on the same scale

set xlabel "Program statements"
set xrange [0:1049]
set xtics 0,50
set ylabel "Constraint checks"
set yrange [0:250000]
set ytics 0,25000

set key 400,235000,2
set term postscript landscape monochrome "Times-Roman" 14
set output "all4fig-2.ps"

plot "ij4-ci.dat" title "MAP-CSP : FCDR w/ adv sort" with linespoints,\
 "ij3-other-ci.dat" title "MAP-CSP : FCDR, no sort" with linespoints,\
 "ij3-ci.dat" title "Memory-CSP: Both FCDR w/ adv sort" with linespoints,\
 "ij2-ci.dat" title "Memory-CSP: BT + FCDR w/ adv sort" with linespoints,\
 "ij1-ci.dat" title "MAP-CSP : Simple BackTrack" with linespoints

