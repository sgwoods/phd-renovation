
;; 450

(princ "Journal Testing (2 Phased)") (terpri)(terpri)
(load "Q-Batch-SBCL/bootstrap.lisp")

(princ "**** Noise 450 ****") (terpri)(terpri)
(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    450
	   :random-ident "default"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-450.1"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    450
	   :random-ident "1783960706"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-450.2"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    450
	   :random-ident "6148712495"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-450.3"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    450
	   :random-ident "8261581571"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-450.4"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    450
	   :random-ident "4705297406"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-450.5"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    450
	   :random-ident "6724813580"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-450.6"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    450
	   :random-ident "8798969000"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-450.7"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    450
	   :random-ident "0805098560"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-450.8"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    450
	   :random-ident "4767135635"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-450.9"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    450
	   :random-ident "7685437293"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-450.99"
	   ))

(sb-ext:exit)
