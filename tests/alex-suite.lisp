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
    (5am:is (string= (symbol-name (qcsp-alex:qc 4)) "COMPLETE"))))

(5am:test alex-queens-8
  "Alex 8-Queens with AC-3 should complete"
  (with-alex-paths
    (5am:is (string= (symbol-name (qcsp-alex:qc 8)) "COMPLETE"))))

;;; Note: ADT test omitted for the alex snapshot because its template/situation
;;; data is loaded from external files not included in the repository.
;;; The may29 snapshot has inline data and includes an ADT test.

;;; Run
(format t "~&~%;; ===== Alex Test Suite =====~%~%")
(let ((result (5am:run! 'alex-tests)))
  (sb-ext:exit :code (if result 0 1)))
