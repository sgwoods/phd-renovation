;;; gen-seeds-alex.lisp -- Regenerate random state seed files for alex experiments
;;; Usage: sbcl --non-interactive --load "Q-Batch-SBCL/gen-seeds-alex.lisp"

(load "Q-Batch-SBCL/bootstrap-alex.lisp")

;; Regenerate all seed files in alex's ADT-Random/ directory
;; The old files used #S(RANDOM-STATE :SEED ...) format which SBCL 2.x can't read.
;; We replace them with fresh SBCL Mersenne Twister random states.

(let ((dir "ADT-Random/"))
  (dolist (entry (directory (merge-pathnames "Rnd*" dir)))
    (let* ((name (file-namestring entry))
           (random-file (concatenate 'string dir name))
           (stream (open random-file
                        :direction :output
                        :if-exists :supersede
                        :if-does-not-exist :create)))
      (setq *random-state* (make-random-state t))
      (write *random-state* :stream stream)
      (close stream)
      (format t "Regenerated ~A~%" random-file))))

(format t "~&Done.~%")
