;;;; may29-ij4-run.lisp -- Parametric ij4 (direct ADT + FC/DR/advance-sort) for may29
;;;;
;;;; Usage: sbcl --non-interactive --eval '(defvar *may29-noise* 50)' \
;;;;        --load "Q-Batch-SBCL/may29-ij4-run.lisp"

(load "Q-Batch-SBCL/bootstrap-may29.lisp")

(let* ((noise *may29-noise*)
       (noise-str (format nil "~3,'0D" noise))
       (seeds '("default" "1783960706" "6148712495" "8261581571" "4705297406"
                "6724813580" "8798969000" "0805098560" "4767135635" "7685437293"))
       (suffixes '("1" "2" "3" "4" "5" "6" "7" "8" "9" "99")))

  (format t "~&;; may29-ij4: noise=~A~%" noise)

  (loop for seed in seeds
        for suffix in suffixes
        for outfile = (format nil "../Q-Batch-SBCL/may29-ij4/Test-ij4-~A.~A" noise-str suffix)
        do (format t "~&;; seed=~A -> ~A~%" seed outfile)
           (time (qcsp-may29:adt :situation-id "q-i1"
                   :sit-noise noise
                   :template-id "quilici-t1"
                   :forward-checking t
                   :dynamic-rearrangement t
                   :advance-sort t
                   :single-line-override t
                   :random-ident seed
                   :output-file outfile))))

(sb-ext:exit)
