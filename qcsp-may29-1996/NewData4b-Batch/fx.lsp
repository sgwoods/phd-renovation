
(princ "New Test Run: RANGE , q-i2, FCDR, Dist1") (terpri)(terpri)
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
	   :output-file "New-Batch/fcdr-dist1-RNG0100.1"
	   ))

(princ "**** Noise 0500 ****") (terpri)(terpri)
(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    0500
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "default"
	   :output-file "New-Batch/fcdr-dist1-RNG0500.1"
	   ))

(princ "**** Noise 1000 ****") (terpri)(terpri)
(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    1000
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "default"
	   :output-file "New-Batch/fcdr-dist1-RNG1000.1"
	   ))

(princ "**** Noise 2000 ****") (terpri)(terpri)
(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    2000
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "default"
	   :output-file "New-Batch/fcdr-dist1-RNG2000.1"
	   ))

(princ "**** Noise 3000 ****") (terpri)(terpri)
(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    3000
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "default"
	   :output-file "New-Batch/fcdr-dist1-RNG3000.1"
	   ))

(princ "**** Noise 4000 ****") (terpri)(terpri)
(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    4000
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "default"
	   :output-file "New-Batch/fcdr-dist1-RNG4000.1"
	   ))

(princ "**** Noise 5000 ****") (terpri)(terpri)
(time (adt 
       :situation-id "q-i2" 
       :template-id  "quilici-t1"
	   :sit-noise    5000
	   :rand-dist "dist1"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "default"
	   :output-file "New-Batch/fcdr-dist1-RNG5000.1"
	   ))
