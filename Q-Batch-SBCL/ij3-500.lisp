
;; 500

(princ "Journal Testing (2 Phased)") (terpri)(terpri)
(load "Q-Batch-SBCL/bootstrap.lisp")

(princ "**** Noise 500 ****") (terpri)(terpri)
(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    500
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "default"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-500.1"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    500
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "1783960706"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-500.2"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    500
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "6148712495"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-500.3"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    500
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "8261581571"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-500.4"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    500
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "4705297406"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-500.5"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    500
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "6724813580"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-500.6"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    500
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "8798969000"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-500.7"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    500
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "0805098560"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-500.8"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    500
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "4767135635"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-500.9"
	   ))

(time (qcsp3:memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    500
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "7685437293"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-500.99"
	   ))

(sb-ext:exit)
