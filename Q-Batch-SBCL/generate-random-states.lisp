;;;; generate-random-states.lisp -- Create SBCL-compatible random state files
;;;;
;;;; Usage:
;;;;   sbcl --non-interactive --load Q-Batch-SBCL/generate-random-states.lisp
;;;;
;;;; Creates qcsp3/ADT-Random/Rnd<name> files with SBCL-native random states.
;;;; These replace the original ACL-format random states that cannot be read
;;;; by SBCL.

(format t "~&; Generating SBCL-compatible random states...~%")

;; Ensure the target directory exists
(ensure-directories-exist
 (merge-pathnames "qcsp3/ADT-Random/" (truename *default-pathname-defaults*)))

(defvar *seed-names*
  '("default"
    "1783960706"
    "6148712495"
    "8261581571"
    "4705297406"
    "6724813580"
    "8798969000"
    "0805098560"
    "4767135635"
    "7685437293"))

(dolist (name *seed-names*)
  (let* ((filename (concatenate 'string "qcsp3/ADT-Random/Rnd" name))
         (rs (make-random-state t)))
    (with-open-file (stream filename
                     :direction :output
                     :if-exists :supersede
                     :if-does-not-exist :create)
      (write rs :stream stream))
    (format t "~&;   Created ~A~%" filename)))

(format t "~&; Done. ~A random state files created.~%" (length *seed-names*))
