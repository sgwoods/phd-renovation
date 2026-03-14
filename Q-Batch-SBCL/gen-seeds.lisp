;;; gen-seeds.lisp -- Regenerate random state seed files for experiments
;;; Usage: sbcl --non-interactive --load "Q-Batch-SBCL/gen-seeds.lisp"

(load "Q-Batch-SBCL/bootstrap.lisp")

(let ((seeds '("0805098560" "1783960706" "4705297406" "4767135635"
               "6148712495" "6724813580" "7685437293" "8261581571"
               "8798969000")))
  (dolist (seed seeds)
    (let* ((random-file (concatenate 'string "ADT-Random/Rnd" seed))
           (stream (open random-file
                        :direction :output
                        :if-exists :supersede
                        :if-does-not-exist :create)))
      (setq *random-state* (make-random-state t))
      (write *random-state* :stream stream)
      (close stream)
      (format t "Created ~A~%" random-file))))
