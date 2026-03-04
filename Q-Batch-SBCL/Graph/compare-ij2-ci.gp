# Compare ij2 (memory-search baseline) -- ACL vs SBCL
# Usage: gnuplot compare-ij2-ci.gp   (from project root)

set xlabel "Program statements (noise level)"
set xrange [0:1049]
set xtics 0,100
set ylabel "Constraint checks (TCC)"
set yrange [0:*]

set key top left
set grid

set term pdfcairo enhanced font "Helvetica,11" size 8,5
set output "Q-Batch-SBCL/Graph/compare-ij2-ci.pdf"

set title "ij2: Memory-CSP BT + FCDR w/ adv sort -- ACL vs SBCL"

plot \
  "Q-Batch/Graph/ij2-ci.dat" using 1:2:3:4 title "ACL (original)" with yerrorbars lc rgb "#0000AA" pt 5 ps 0.8, \
  "Q-Batch/Graph/ij2-ci.dat" using 1:2 notitle with lines lc rgb "#0000AA" lw 1.5, \
  "Q-Batch-SBCL/Graph/ij2-ci.dat" using 1:2:3:4 title "SBCL (M4 Mac)" with yerrorbars lc rgb "#CC0000" pt 7 ps 0.8, \
  "Q-Batch-SBCL/Graph/ij2-ci.dat" using 1:2 notitle with lines lc rgb "#CC0000" lw 1.5
