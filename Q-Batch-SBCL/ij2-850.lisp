
;; 850

(princ "Journal Testing (2 Phased)") (terpri)(terpri)
(load "Q-Batch-SBCL/bootstrap.lisp")

(princ "**** Noise 850 ****") (terpri)(terpri)
(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    850
	   :random-ident "default"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-850.1"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    850
	   :random-ident "1783960706"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-850.2"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    850
	   :random-ident "6148712495"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-850.3"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    850
	   :random-ident "8261581571"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-850.4"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    850
	   :random-ident "4705297406"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-850.5"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    850
	   :random-ident "6724813580"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-850.6"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    850
	   :random-ident "8798969000"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-850.7"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    850
	   :random-ident "0805098560"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-850.8"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    850
	   :random-ident "4767135635"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-850.9"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    850
	   :random-ident "7685437293"
	   :memory-output-file "../Q-Batch-SBCL/ij2/ij2-850.99"
	   ))

(sb-ext:exit)
