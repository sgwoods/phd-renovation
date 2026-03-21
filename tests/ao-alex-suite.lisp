;;;; tests/ao-alex-suite.lisp -- AO regression tests for qcsp-alex extras
;;;;
;;;; Usage: sbcl --non-interactive --load "tests/ao-alex-suite.lisp"

(require :asdf)

(let ((ql-setup (merge-pathnames "quicklisp/setup.lisp"
                                 (user-homedir-pathname))))
  (when (probe-file ql-setup)
    (load ql-setup)))

(ql:quickload :fiveam :silent t)

(defvar *project-root*
  (make-pathname :directory (butlast (pathname-directory
                                       (truename *load-pathname*)))
                 :device (pathname-device (truename *load-pathname*))))

(pushnew *project-root* asdf:*central-registry* :test #'equal)

(asdf:load-system :qcsp-alex-sep16-1997)
(asdf:load-system :qcsp3)

(defvar *alex-ao-loaded* nil)

(defun ensure-alex-ao-loaded ()
  "Load the shared AO helpers once for deterministic alex test4 checks."
  (unless *alex-ao-loaded*
    (let ((*default-pathname-defaults*
            (truename (merge-pathnames "qcsp3/extras/" *project-root*)))
          (*standard-output* (make-broadcast-stream)))
      (unless (fboundp 'qcsp3:comment1)
        (load "comment"))
      (load "compile-ao")
      (load "ac-graph")
      (load "hierarchy")
      (load "ao-ac3")
      (load "ao-revise-fns")
      (load "ao-revise")
      (load "ao-revise-step")
      (load "ao-revise-aggressive")
      (load "applyr")
      (load "example-extend"))
    (let ((*default-pathname-defaults*
            (truename (merge-pathnames "qcsp-alex-sep16-1997/extras/"
                                       *project-root*)))
          (*standard-output* (make-broadcast-stream)))
      (load "test4"))
    (setf *alex-ao-loaded* t)
    (setf (symbol-function 'qcsp-alex::load-t4) (lambda () nil))
    (setf (symbol-value (find-symbol "*AO-DEBUG*" :phd-qcsp3)) nil)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (ensure-alex-ao-loaded))

(defmacro with-alex-ao-paths (&body body)
  `(let ((*standard-output* (make-broadcast-stream)))
     ,@body))

(defun alex-variable-list-summary (value)
  (and value
       (mapcar (lambda (var)
                 (list (symbol-name (qcsp3::cvariable-name var))
                       (mapcar (lambda (domval)
                                 (symbol-name (qcsp3::domval-name domval)))
                               (qcsp3::cvariable-domainvaluelist var))))
               value)))

(5am:def-suite ao-alex-tests
  :description "AO/test4 regression checks for qcsp-alex extras")

(5am:in-suite ao-alex-tests)

(5am:test alex-ao-revise-baseline
  "Alex AO revise should preserve the current historical baseline behavior."
  (with-alex-ao-paths
    (let ((ao1 (qcsp-alex::testao1))
          (ao2 (qcsp-alex::testao2))
          (ao3 (qcsp-alex::testao3)))
      (5am:is (equal (alex-variable-list-summary ao1)
                     '(("V1" ("A2")))))
      (5am:is (null ao2))
      (5am:is (equal (alex-variable-list-summary ao3)
                     '(("V1" ("A2"))
                       ("V0" ("E1"))
                       ("V2" ("B3")))))
      (5am:is (= qcsp3::*constraint-count* 183)))))

(format t "~&~%;; ===== AO Alex Test Suite =====~%~%")
(let ((result (5am:run! 'ao-alex-tests)))
  (sb-ext:exit :code (if result 0 1)))
