;;;; tests/alex-suite.lisp -- FiveAM tests for qcsp-alex-sep16-1997 system
;;;;
;;;; Usage: sbcl --non-interactive --load "tests/alex-suite.lisp"

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
(asdf:load-system :qcsp-alex-sep16-1997)

;;; =========================================================================
;;; Test definitions
;;; =========================================================================

(5am:def-suite alex-tests
  :description "Tests for the Sep 1997 CSP snapshot (qcsp-alex-sep16-1997/)")

(5am:in-suite alex-tests)

(defmacro with-alex-paths (&body body)
  `(let ((*default-pathname-defaults*
           (truename (merge-pathnames "qcsp-alex-sep16-1997/" *project-root*)))
         (*standard-output* (make-broadcast-stream)))
     ,@body))

(5am:test alex-queens-4
  "Alex 4-Queens with AC-3 should complete"
  (with-alex-paths
    (5am:is (eq (qcsp-alex:qc 4) :complete))))

(5am:test alex-queens-8
  "Alex 8-Queens with AC-3 should complete"
  (with-alex-paths
    (5am:is (eq (qcsp-alex:qc 8) :complete))))

(5am:test alex-mpr
  "Alex MPR recognition should complete"
  (with-alex-paths
    (ensure-directories-exist "MPR-Random/dummy")
    (ensure-directories-exist "MPR-Situation/dummy")
    (5am:is (eq (qcsp-alex:mpr :random-ident "unique") :complete))))

(5am:test alex-adt
  "Alex ADT recognition should complete"
  (with-alex-paths
    (ensure-directories-exist "ADT-Random/dummy")
    (ensure-directories-exist "ADT-Situation/dummy")
    (5am:is-true (qcsp-alex:adt :situation-id "quilici-i1"
                                 :template-id "quilici-t1"
                                 :random-ident "unique"))))

(5am:test alex-memory-search
  "Alex two-phase memory-based search should find solution"
  (with-alex-paths
    (ensure-directories-exist "ADT-Random/dummy")
    (ensure-directories-exist "ADT-Situation/dummy")
    (5am:is (consp (qcsp-alex:memory-search "quilici-t1-index" "quilici-t1"
                     :sit-noise 0 :random-ident "unique")))))

;;; Note: alex defaults to C-program templates ("average-array-template-9-17")
;;; from yjzhang's research extension. Tests above explicitly pass Quilici IDs.

;;; Run
(format t "~&~%;; ===== Alex Test Suite =====~%~%")
(let ((result (5am:run! 'alex-tests)))
  (sb-ext:exit :code (if result 0 1)))
