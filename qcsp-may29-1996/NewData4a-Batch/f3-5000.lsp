
(princ "New Test Run: 5000, q-i2, FCDR, Dist3") (terpri)(terpri)
(load "load")

(princ "**** Noise 5000 ****") (terpri)(terpri)
(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    5000
	   :rand-dist "dist3"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "default"
	   :output-file "New-Batch/fcdr-dist3-5000.1"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    5000
	   :rand-dist "dist3"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "1783960706"
	   :output-file "New-Batch/fcdr-dist3-5000.2"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    5000
	   :rand-dist "dist3"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "6148712495"
	   :output-file "New-Batch/fcdr-dist3-5000.3"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    5000
	   :rand-dist "dist3"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "8261581571"
	   :output-file "New-Batch/fcdr-dist3-5000.4"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    5000
	   :rand-dist "dist3"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "4705297406"
	   :output-file "New-Batch/fcdr-dist3-5000.5"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    5000
	   :rand-dist "dist3"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "6724813580"
	   :output-file "New-Batch/fcdr-dist3-5000.6"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    5000
	   :rand-dist "dist3"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "8798969000"
	   :output-file "New-Batch/fcdr-dist3-5000.7"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    5000
	   :rand-dist "dist3"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "0805098560"
	   :output-file "New-Batch/fcdr-dist3-5000.8"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    5000
	   :rand-dist "dist3"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "4767135635"
	   :output-file "New-Batch/fcdr-dist3-5000.9"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    5000
	   :rand-dist "dist3"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "7685437293"
	   :output-file "New-Batch/fcdr-dist3-5000.99"
	   ))
:exit

