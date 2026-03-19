
(princ "Test Aug 12, 1993 using Aug 5 version v0.5 MOTOR") (terpri)(terpri)

(load "load")

(princ "**** Noise 700 ****") (terpri)(terpri)
;;700

(time (mpr :situation-id "test-1"
	   :sit-noise    700
	   :template-id  "test1-m"
	   :random-ident nil
	   :search-mode "bt"
	   :sch-call nil
	   :output-file "Batch/T4/t4-results/t4-lisp.out700.1"
	   ))

(time (mpr :situation-id "test-1"
	   :sit-noise    700
	   :template-id  "test1-m"
	   :random-ident nil
	   :search-mode "bt"
	   :sch-call nil
	   :output-file "Batch/T4/t4-results/t4-lisp.out700.2"
	   ))

(time (mpr :situation-id "test-1"
	   :sit-noise    700
	   :template-id  "test1-m"
	   :random-ident nil
	   :search-mode "bt"
	   :sch-call nil
	   :output-file "Batch/T4/t4-results/t4-lisp.out700.3"
	   ))

(time (mpr :situation-id "test-1"
	   :sit-noise    700
	   :template-id  "test1-m"
	   :random-ident nil
	   :search-mode "bt"
	   :sch-call nil
	   :output-file "Batch/T4/t4-results/t4-lisp.out700.4"
	   ))

(time (mpr :situation-id "test-1"
	   :sit-noise    700
	   :template-id  "test1-m"
	   :random-ident nil
	   :search-mode "bt"
	   :sch-call nil
	   :output-file "Batch/T4/t4-results/t4-lisp.out700.5"
	   ))

