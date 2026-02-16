
(princ "New Test Run: 9999, q-i2, FCDR, Dist1") (terpri)(terpri)
(load "load")

(princ "**** Noise 9999 ****") (terpri)(terpri)
(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    9999
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "default"
	   :output-file "New-Batch/fcdr-dist1-9999.1"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    9999
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "1783960706"
	   :output-file "New-Batch/fcdr-dist1-9999.2"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    9999
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "6148712495"
	   :output-file "New-Batch/fcdr-dist1-9999.3"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    9999
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "8261581571"
	   :output-file "New-Batch/fcdr-dist1-9999.4"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    9999
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "4705297406"
	   :output-file "New-Batch/fcdr-dist1-9999.5"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    9999
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "6724813580"
	   :output-file "New-Batch/fcdr-dist1-9999.6"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    9999
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "8798969000"
	   :output-file "New-Batch/fcdr-dist1-9999.7"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    9999
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "0805098560"
	   :output-file "New-Batch/fcdr-dist1-9999.8"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    9999
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "4767135635"
	   :output-file "New-Batch/fcdr-dist1-9999.9"
	   ))

(time (adt 
	:situation-id "q-i2" 
	:template-id  "quilici-t1"
	   :sit-noise    9999
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "7685437293"
	   :output-file "New-Batch/fcdr-dist1-9999.99"
	   ))
:exit

