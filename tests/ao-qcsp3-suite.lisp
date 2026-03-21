;;;; tests/ao-qcsp3-suite.lisp -- AO regression tests for qcsp3 extras
;;;;
;;;; Usage: sbcl --non-interactive --load "tests/ao-qcsp3-suite.lisp"

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

(asdf:load-system :qcsp3)

(defvar *qcsp3-ao-loaded* nil)

(defun ensure-qcsp3-ao-loaded ()
  "Load the historical AO helper files once for deterministic test4 checks."
  (unless *qcsp3-ao-loaded*
    (let ((*default-pathname-defaults*
            (truename (merge-pathnames "qcsp3/extras/" *project-root*)))
          (*standard-output* (make-broadcast-stream)))
      (load "compile-ao")
      (load "ac-graph")
      (load "hierarchy")
      (load "ao-ac3")
      (load "ao-ac-new")
      (load "ao-revise-fns")
      (load "ao-revise")
      (load "ao-revise-step")
      (load "ao-revise-aggressive")
      (load "applyr")
      (load "example-extend")
      (load "test4"))
    (setf *qcsp3-ao-loaded* t)
    ;; Avoid re-loading the extras every time the legacy test helpers run.
    (setf (symbol-function 'qcsp3::load-t4) (lambda () nil))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (ensure-qcsp3-ao-loaded))

(defmacro with-qcsp3-ao-paths (&body body)
  `(let ((*default-pathname-defaults*
           (truename (merge-pathnames "qcsp3/extras/" *project-root*)))
         (*standard-output* (make-broadcast-stream)))
     ,@body))

(defun qcsp3-graph-summary (graph)
  (mapcar (lambda (var)
            (list (symbol-name (qcsp3::cvariable-name var))
                  (mapcar (lambda (domval)
                            (symbol-name (qcsp3::domval-name domval)))
                          (qcsp3::cvariable-domainvaluelist var))))
          (qcsp3::graph-variable-list graph)))

(5am:def-suite ao-qcsp3-tests
  :description "AO/test4 regression checks for qcsp3 extras")

(5am:in-suite ao-qcsp3-tests)

(5am:test qcsp3-ao-ac3-step
  "Legacy qcsp3 AO AC-3 step mode should converge to the expected case-1 graph."
  (with-qcsp3-ao-paths
    (let ((result (qcsp3::testacs 1)))
      (5am:is (equal (qcsp3-graph-summary result)
                     '(("V0" ("E1")) ("V1" ("A2")) ("V2" ("B3")))))
      (5am:is (= qcsp3::*constraint-count* 211)))))

(5am:test qcsp3-ao-ac3-aggressive
  "Legacy qcsp3 AO AC-3 aggressive mode should match the expected reduced graph."
  (with-qcsp3-ao-paths
    (let ((result (qcsp3::testaca 1)))
      (5am:is (equal (qcsp3-graph-summary result)
                     '(("V0" ("E1")) ("V1" ("A2")) ("V2" ("B3")))))
      (5am:is (= qcsp3::*constraint-count* 35)))))

(5am:test qcsp3-ao-ac-new-step
  "Legacy qcsp3 AO AC-new step mode should match the expected reduced graph."
  (with-qcsp3-ao-paths
    (let ((result (qcsp3::testacns 1)))
      (5am:is (equal (qcsp3-graph-summary result)
                     '(("V0" ("E1")) ("V1" ("A2")) ("V2" ("B3")))))
      (5am:is (= qcsp3::*constraint-count* 35)))))

(5am:test qcsp3-ao-ac-new-aggressive
  "Legacy qcsp3 AO AC-new aggressive mode should match the expected reduced graph."
  (with-qcsp3-ao-paths
    (let ((result (qcsp3::testacna 1)))
      (5am:is (equal (qcsp3-graph-summary result)
                     '(("V0" ("E1")) ("V1" ("A2")) ("V2" ("B3")))))
      (5am:is (= qcsp3::*constraint-count* 35)))))

(5am:test qcsp3-ao-wrapper-step
  "Legacy qcsp3 test4s wrapper should preserve the historical nil revise summary."
  (with-qcsp3-ao-paths
    (qcsp3::test4s)
    (5am:is (equal (list qcsp3::ao1 qcsp3::ao2 qcsp3::ao3)
                   '(nil nil nil)))
    (5am:is (= qcsp3::*constraint-count* 35))))

(5am:test qcsp3-ao-wrapper-aggressive
  "Legacy qcsp3 test4a wrapper should preserve the historical nil revise summary."
  (with-qcsp3-ao-paths
    (qcsp3::test4a)
    (5am:is (equal (list qcsp3::ao1 qcsp3::ao2 qcsp3::ao3)
                   '(nil nil nil)))
    (5am:is (= qcsp3::*constraint-count* 35))))

(format t "~&~%;; ===== AO QCSP3 Test Suite =====~%~%")
(let ((result (5am:run! 'ao-qcsp3-tests)))
  (sb-ext:exit :code (if result 0 1)))
