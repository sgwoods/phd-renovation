
;; 100

(princ "Journal Testing (2 Phased)") (terpri)(terpri)
(load "Q-Batch-SBCL/bootstrap.lisp")

(princ "**** Noise 100 ****") (terpri)(terpri)
(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    100
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "default"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-100.1"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    100
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "1783960706"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-100.2"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    100
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "6148712495"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-100.3"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    100
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "8261581571"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-100.4"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    100
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "4705297406"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-100.5"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    100
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "6724813580"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-100.6"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    100
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "8798969000"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-100.7"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    100
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "0805098560"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-100.8"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    100
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "4767135635"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-100.9"
	   ))

(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    100
	   :1-forward-checking t
	   :1-dynamic-rearrangement t
	   :1-advance-sort t
	   :random-ident "7685437293"
	   :memory-output-file "../Q-Batch-SBCL/ij3/ij3-100.99"
	   ))

(sb-ext:exit)
