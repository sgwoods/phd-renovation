# Compare all experiments -- ACL vs SBCL overlay
# Usage: gnuplot compare-all.gp   (from project root)

set xlabel "Program statements (noise level)"
set xrange [0:1049]
set xtics 0,100
set ylabel "Constraint checks (TCC)"
set yrange [0:250000]
set ytics 0,25000

set key top left
set grid

set term pdfcairo enhanced font "Helvetica,11" size 10,6
set output "Q-Batch-SBCL/Graph/compare-all.pdf"

set title "All experiments: ACL (dashed) vs SBCL (solid)"

plot \
  "Q-Batch/Graph/ij2-ci.dat" using 1:2 title "ACL ij2 (mem-BT+FCDR)" with linespoints lc rgb "#0000AA" dt 2 pt 4 ps 0.6, \
  "Q-Batch-SBCL/Graph/ij2-ci.dat" using 1:2 title "SBCL ij2 (mem-BT+FCDR)" with linespoints lc rgb "#0000AA" pt 5 ps 0.6 lw 1.5, \
  "Q-Batch/Graph/ij3-ci.dat" using 1:2 title "ACL ij3 (mem-both FCDR)" with linespoints lc rgb "#CC0000" dt 2 pt 8 ps 0.6, \
  "Q-Batch-SBCL/Graph/ij3-ci.dat" using 1:2 title "SBCL ij3 (mem-both FCDR)" with linespoints lc rgb "#CC0000" pt 9 ps 0.6 lw 1.5, \
  "Q-Batch/Graph/ij4-ci.dat" using 1:2 title "ACL ij4 (direct FCDR)" with linespoints lc rgb "#008800" dt 2 pt 6 ps 0.6, \
  "Q-Batch-SBCL/Graph/ij4-ci.dat" using 1:2 title "SBCL ij4 (direct FCDR)" with linespoints lc rgb "#008800" pt 7 ps 0.6 lw 1.5
