
(princ "New Test Run: 0100, q-i2, FCDR, Dist1") (terpri)(terpri)
(load "load")

(princ "**** Noise 0100 ****") (terpri)(terpri)
(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    0100
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "default"
	   :output-file "New-Batch/fcdr-dist1-0100.1"
	   ))

(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    0100
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "1783960706"
	   :output-file "New-Batch/fcdr-dist1-0100.2"
	   ))

(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    0100
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "6148712495"
	   :output-file "New-Batch/fcdr-dist1-0100.3"
	   ))

(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    0100
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "8261581571"
	   :output-file "New-Batch/fcdr-dist1-0100.4"
	   ))

(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    0100
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "4705297406"
	   :output-file "New-Batch/fcdr-dist1-0100.5"
	   ))

(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    0100
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "6724813580"
	   :output-file "New-Batch/fcdr-dist1-0100.6"
	   ))

(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    0100
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "8798969000"
	   :output-file "New-Batch/fcdr-dist1-0100.7"
	   ))

(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    0100
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "0805098560"
	   :output-file "New-Batch/fcdr-dist1-0100.8"
	   ))

(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    0100
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "4767135635"
	   :output-file "New-Batch/fcdr-dist1-0100.9"
	   ))

(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    0100
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "7685437293"
	   :output-file "New-Batch/fcdr-dist1-0100.99"
	   ))
:exit

