
(princ "Large New Test Run: 4000, h-i2, FCDR, Dist3") (terpri)(terpri)
(load "load")

(time (adt 
       :situation-id "h-i2" 
       :template-id  "quilici-t1-large"
	   :sit-noise    4000
	   :rand-dist "dist3"
	   :forward-checking t
	   :dynamic-rearrangement t
	   :random-ident "7685437293"
	   :output-file "New-Batch/H-fcdr-dist3-4000.99"
	   ))
:exit

