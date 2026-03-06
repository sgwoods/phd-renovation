;;;; tests/qcsp3-suite.lisp -- FiveAM tests for qcsp3 system
;;;;
;;;; Usage: sbcl --non-interactive --load "tests/qcsp3-suite.lisp"

(require :asdf)

(let ((ql-setup (merge-pathnames "quicklisp/setup.lisp"
                                 (user-homedir-pathname))))
  (when (probe-file ql-setup)
    (load ql-setup)))

(ql:quickload :fiveam :silent t)

;;; Register project root
(defvar *project-root*
  (make-pathname :directory (butlast (pathname-directory
                                       (truename *load-pathname*)))
                 :device (pathname-device (truename *load-pathname*))))

(pushnew *project-root* asdf:*central-registry* :test #'equal)

;;; Load the system
(asdf:load-system :qcsp3)

;;; Set *unix* (used by path selection code)
(setq qcsp3:*unix* t)

;;; =========================================================================
;;; Test definitions
;;; =========================================================================

(5am:def-suite qcsp3-tests
  :description "Tests for the extended CSP solver (qcsp3/)")

(5am:in-suite qcsp3-tests)

(defmacro with-qcsp3-paths (&body body)
  `(let ((*default-pathname-defaults*
           (truename (merge-pathnames "qcsp3/" *project-root*)))
         (*standard-output* (make-broadcast-stream)))
     ,@body))

(5am:test qcsp3-adt-bt
  "QCSP3 ADT with simple backtrack should complete"
  (with-qcsp3-paths
    (ensure-directories-exist "ADT-Random/dummy")
    (ensure-directories-exist "ADT-Situation/dummy")
    (5am:is-true (qcsp3:adt :random-ident 'unique))))

(5am:test qcsp3-adt-fc
  "QCSP3 ADT with forward checking should complete"
  (with-qcsp3-paths
    (ensure-directories-exist "ADT-Random/dummy")
    (ensure-directories-exist "ADT-Situation/dummy")
    (5am:is-true (qcsp3:adt :random-ident 'unique
                             :forward-checking t))))

(5am:test qcsp3-adt-fcdr
  "QCSP3 ADT with FC + dynamic rearrangement should complete"
  (with-qcsp3-paths
    (ensure-directories-exist "ADT-Random/dummy")
    (ensure-directories-exist "ADT-Situation/dummy")
    (5am:is-true (qcsp3:adt :random-ident 'unique
                             :forward-checking t
                             :dynamic-rearrangement t))))

(5am:test qcsp3-adt-fcdr-advsort
  "QCSP3 ADT with FC + DR + advance sort should complete"
  (with-qcsp3-paths
    (ensure-directories-exist "ADT-Random/dummy")
    (ensure-directories-exist "ADT-Situation/dummy")
    (5am:is-true (qcsp3:adt :random-ident 'unique
                             :forward-checking t
                             :dynamic-rearrangement t
                             :advance-sort t))))

;;; Run
(format t "~&~%;; ===== QCSP3 Test Suite =====~%~%")
(let ((result (5am:run! 'qcsp3-tests)))
  (sb-ext:exit :code (if result 0 1)))
