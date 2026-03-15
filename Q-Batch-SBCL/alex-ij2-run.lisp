;;;; alex-ij2-run.lisp -- Parametric ij2 (memory-search baseline) for alex
;;;;
;;;; Usage: sbcl --non-interactive --eval '(defvar *alex-noise* 50)' \
;;;;        --load "Q-Batch-SBCL/alex-ij2-run.lisp"

(load "Q-Batch-SBCL/bootstrap-alex.lisp")

(let* ((noise *alex-noise*)
       (noise-str (format nil "~3,'0D" noise))
       (seeds '("default" "1783960706" "6148712495" "8261581571" "4705297406"
                "6724813580" "8798969000" "0805098560" "4767135635" "7685437293"))
       (suffixes '("1" "2" "3" "4" "5" "6" "7" "8" "9" "99")))

  (format t "~&;; alex-ij2: noise=~A~%" noise)

  (loop for seed in seeds
        for suffix in suffixes
        for outfile = (format nil "../Q-Batch-SBCL/alex-ij2/ij2-~A.~A" noise-str suffix)
        do (format t "~&;; seed=~A -> ~A~%" seed outfile)
           (time (qcsp-alex:memory-search "quilici-t1-index" "quilici-t1"
                   :sit-noise noise
                   :random-ident seed
                   :memory-output-file outfile))))

(sb-ext:exit)
