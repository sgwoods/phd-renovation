
(princ "Large New Test Run: 3000, h-i2, FCDR, Dist2") (terpri)(terpri)
(load "load")

(princ "**** Noise 3000 ****") (terpri)(terpri)
(time (adt 
       :situation-id "h-i2" 
       :template-id  "quilici-t1-large"
	   :sit-noise    3000
	   :rand-dist "dist2"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "default"
	   :output-file "New-Batch/H-fcdr-dist2-3000.1"
	   ))

(time (adt 
       :situation-id "h-i2" 
       :template-id  "quilici-t1-large"
	   :sit-noise    3000
	   :rand-dist "dist2"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "1783960706"
	   :output-file "New-Batch/H-fcdr-dist2-3000.2"
	   ))

(time (adt 
       :situation-id "h-i2" 
       :template-id  "quilici-t1-large"
	   :sit-noise    3000
	   :rand-dist "dist2"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "6148712495"
	   :output-file "New-Batch/H-fcdr-dist2-3000.3"
	   ))

(time (adt 
       :situation-id "h-i2" 
       :template-id  "quilici-t1-large"
	   :sit-noise    3000
	   :rand-dist "dist2"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "8261581571"
	   :output-file "New-Batch/H-fcdr-dist2-3000.4"
	   ))

(time (adt 
       :situation-id "h-i2" 
       :template-id  "quilici-t1-large"
	   :sit-noise    3000
	   :rand-dist "dist2"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "4705297406"
	   :output-file "New-Batch/H-fcdr-dist2-3000.5"
	   ))

(time (adt 
       :situation-id "h-i2" 
       :template-id  "quilici-t1-large"
	   :sit-noise    3000
	   :rand-dist "dist2"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "6724813580"
	   :output-file "New-Batch/H-fcdr-dist2-3000.6"
	   ))

(time (adt 
       :situation-id "h-i2" 
       :template-id  "quilici-t1-large"
	   :sit-noise    3000
	   :rand-dist "dist2"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "8798969000"
	   :output-file "New-Batch/H-fcdr-dist2-3000.7"
	   ))

(time (adt 
       :situation-id "h-i2" 
       :template-id  "quilici-t1-large"
	   :sit-noise    3000
	   :rand-dist "dist2"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "0805098560"
	   :output-file "New-Batch/H-fcdr-dist2-3000.8"
	   ))

(time (adt 
       :situation-id "h-i2" 
       :template-id  "quilici-t1-large"
	   :sit-noise    3000
	   :rand-dist "dist2"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "4767135635"
	   :output-file "New-Batch/H-fcdr-dist2-3000.9"
	   ))

(time (adt 
       :situation-id "h-i2" 
       :template-id  "quilici-t1-large"
	   :sit-noise    3000
	   :rand-dist "dist2"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "7685437293"
	   :output-file "New-Batch/H-fcdr-dist2-3000.99"
	   ))
:exit

