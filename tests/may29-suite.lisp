;;;; tests/may29-suite.lisp -- FiveAM tests for qcsp-may29-1996 system
;;;;
;;;; Usage: sbcl --non-interactive --load "tests/may29-suite.lisp"

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
(asdf:load-system :qcsp-may29-1996)

;;; =========================================================================
;;; Test definitions
;;; =========================================================================

(5am:def-suite may29-tests
  :description "Tests for the May 1996 CSP snapshot (qcsp-may29-1996/)")

(5am:in-suite may29-tests)

(defmacro with-may29-paths (&body body)
  `(let ((*default-pathname-defaults*
           (truename (merge-pathnames "qcsp-may29-1996/" *project-root*)))
         (*standard-output* (make-broadcast-stream)))
     ,@body))

(5am:test may29-queens-4
  "May29 4-Queens with AC-3 should complete"
  (with-may29-paths
    (5am:is (eq (qcsp-may29:qc 4) :complete))))

(5am:test may29-queens-8
  "May29 8-Queens with AC-3 should complete"
  (with-may29-paths
    (5am:is (eq (qcsp-may29:qc 8) :complete))))

(5am:test may29-adt
  "May29 ADT recognition should complete"
  (with-may29-paths
    (ensure-directories-exist "ADT-Random/dummy")
    (ensure-directories-exist "ADT-Situation/dummy")
    (5am:is (consp (qcsp-may29:adt :random-ident "unique")))))

(5am:test may29-mpr
  "May29 MPR recognition should complete"
  (with-may29-paths
    (ensure-directories-exist "MPR-Random/dummy")
    (ensure-directories-exist "MPR-Situation/dummy")
    (5am:is (eq (qcsp-may29:mpr :random-ident "unique") :complete))))

;;; Run
(format t "~&~%;; ===== May29 Test Suite =====~%~%")
(let ((result (5am:run! 'may29-tests)))
  (sb-ext:exit :code (if result 0 1)))
