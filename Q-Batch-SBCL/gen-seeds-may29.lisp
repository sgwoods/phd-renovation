;;; gen-seeds-may29.lisp -- Regenerate random state seed files for may29 experiments
;;; Usage: sbcl --non-interactive --load "Q-Batch-SBCL/gen-seeds-may29.lisp"

(load "Q-Batch-SBCL/bootstrap-may29.lisp")

;; Regenerate all seed files in may29's ADT-Random/ directory
;; The old files have mixed ACL (#S(RANDOM-STATE :SEED ...)) and SBCL formats.
;; We replace them all with fresh SBCL Mersenne Twister random states.

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
