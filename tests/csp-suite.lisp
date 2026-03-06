;;;; tests/csp-suite.lisp -- FiveAM tests for phd-research (csp/) system
;;;;
;;;; Usage: sbcl --non-interactive --load "tests/csp-suite.lisp"

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
(asdf:load-system :phd-research)

;;; Set *unix* (used by path selection code)
(setq csp:*unix* t)

;;; =========================================================================
;;; Test definitions
;;; =========================================================================

(5am:def-suite csp-tests
  :description "Tests for the base CSP solver (csp/)")

(5am:in-suite csp-tests)

(defmacro with-csp-paths (&body body)
  `(let ((*default-pathname-defaults*
           (truename (merge-pathnames "csp/" *project-root*)))
         (*standard-output* (make-broadcast-stream)))
     ,@body))

(5am:test queens-4
  "4-Queens with AC-3 should complete"
  (with-csp-paths
    (5am:is (eq (csp:qc 4) :complete))))

(5am:test queens-8
  "8-Queens with AC-3 should complete"
  (with-csp-paths
    (5am:is (eq (csp:qc 8) :complete))))

(5am:test confused-queens-4
  "Confused 4-Queens with AC-3 should complete"
  (with-csp-paths
    (5am:is (eq (csp:cqc 4) :complete))))

(5am:test adt-recognition
  "ADT recognition should complete"
  (with-csp-paths
    (ensure-directories-exist "ADT-Random/dummy")
    (5am:is (eq (csp:adt :random-ident 'unique) :complete))))

(5am:test mpr-recognition
  "MPR recognition should complete"
  (with-csp-paths
    (ensure-directories-exist "MPR-Random/dummy")
    (5am:is (eq (csp:mpr :random-ident 'unique) :complete))))

;;; Run
(format t "~&~%;; ===== CSP Test Suite =====~%~%")
(let ((result (5am:run! 'csp-tests)))
  (sb-ext:exit :code (if result 0 1)))
