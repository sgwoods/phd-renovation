;;;; may29-ij3-run.lisp -- Parametric ij3 (memory-search + FC/DR/advance-sort) for may29
;;;;
;;;; Usage: sbcl --non-interactive --eval '(defvar *may29-noise* 50)' \
;;;;        --load "Q-Batch-SBCL/may29-ij3-run.lisp"

(load "Q-Batch-SBCL/bootstrap-may29.lisp")

(let* ((noise *may29-noise*)
       (noise-str (format nil "~3,'0D" noise))
       (seeds '("default" "1783960706" "6148712495" "8261581571" "4705297406"
                "6724813580" "8798969000" "0805098560" "4767135635" "7685437293"))
       (suffixes '("1" "2" "3" "4" "5" "6" "7" "8" "9" "99")))

  (format t "~&;; may29-ij3: noise=~A~%" noise)

  (loop for seed in seeds
        for suffix in suffixes
        for outfile = (format nil "../Q-Batch-SBCL/may29-ij3/ij3-~A.~A" noise-str suffix)
        do (format t "~&;; seed=~A -> ~A~%" seed outfile)
           (time (qcsp-may29:memory-search "quilici-t1-index" "quilici-t1"
                   :sit-noise noise
                   :1-forward-checking t
                   :1-dynamic-rearrangement t
                   :1-advance-sort t
                   :random-ident seed
                   :memory-output-file outfile))))

(sb-ext:exit)
