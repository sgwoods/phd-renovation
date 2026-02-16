;;  300

(princ "Journal Testing (2 Phased)") (terpri)(terpri)
(load "load")

(princ "**** Noise 300 ****") (terpri)(terpri)
(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    300
	   :random-ident "default"
	   :memory-output-file "Q-Batch/ij2/ij2-300.1"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    300
	   :random-ident "1783960706"
	   :memory-output-file "Q-Batch/ij2/ij2-300.2"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    300
	   :random-ident "6148712495"
	   :memory-output-file "Q-Batch/ij2/ij2-300.3"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    300
	   :random-ident "8261581571"
	   :memory-output-file "Q-Batch/ij2/ij2-300.4"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    300
	   :random-ident "4705297406"
	   :memory-output-file "Q-Batch/ij2/ij2-300.5"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    300
	   :random-ident "6724813580"
	   :memory-output-file "Q-Batch/ij2/ij2-300.6"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    300
	   :random-ident "8798969000"
	   :memory-output-file "Q-Batch/ij2/ij2-300.7"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    300
	   :random-ident "0805098560"
	   :memory-output-file "Q-Batch/ij2/ij2-300.8"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    300
	   :random-ident "4767135635"
	   :memory-output-file "Q-Batch/ij2/ij2-300.9"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    300
	   :random-ident "7685437293"
	   :memory-output-file "Q-Batch/ij2/ij2-300.99"
	   ))


:exit
