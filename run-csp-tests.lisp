;;;; run-csp-tests.lisp -- Load phd-research (csp) system and run tests
;;;;
;;;; Usage: sbcl --load "run-csp-tests.lisp"

(require :asdf)

(pushnew (make-pathname :name nil :type nil
                        :defaults (truename *load-pathname*))
         asdf:*central-registry*
         :test #'equal)

;;; Load the phd-research system
(asdf:load-system :phd-research)

;;; Set default path to csp/ so relative loads within test functions work
(let ((*default-pathname-defaults*
        (truename (merge-pathnames "csp/"
                   (make-pathname :name nil :type nil
                                  :defaults *load-pathname*)))))

  ;;; ===== Queens domain tests =====
  (format t "~&~%;; ===== csp test suite =====~%")

  (format t "~&;; qc 4: 4-Queens with AC-3~%")
  (csp:qc 4)

  (format t "~&;; qc 8: 8-Queens with AC-3~%")
  (csp:qc 8)

  (format t "~&;; cqc 4: Confused 4-Queens with AC-3~%")
  (csp:cqc 4)

  ;;; ===== ADT domain test =====
  (format t "~&;; adt: Abstract Data Type recognition~%")
  (ensure-directories-exist "ADT-Random/dummy")
  (csp:adt :random-ident 'unique)

  ;;; ===== MPR domain test =====
  (format t "~&;; mpr: Model Pattern Recognition~%")
  (ensure-directories-exist "MPR-Random/dummy")
  (csp:mpr :random-ident 'unique)
)

(format t "~&~%;; ===== All csp tests completed. =====~%")
