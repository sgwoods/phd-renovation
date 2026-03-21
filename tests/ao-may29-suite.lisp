;;;; tests/ao-may29-suite.lisp -- AO regression tests for qcsp-may29 extras
;;;;
;;;; Usage: sbcl --non-interactive --load "tests/ao-may29-suite.lisp"

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

(asdf:load-system :qcsp-may29-1996)

(defvar *may29-ao-loaded* nil)

(defun ensure-may29-ao-loaded ()
  "Load the May 1996 AO helper files once for deterministic test4 checks."
  (unless *may29-ao-loaded*
    (let ((*default-pathname-defaults*
            (truename (merge-pathnames "qcsp-may29-1996/extras/" *project-root*)))
          (*standard-output* (make-broadcast-stream)))
      (unless (fboundp 'qcsp-may29:comment1)
        (load "comment"))
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
    (setf *may29-ao-loaded* t)
    (setf (symbol-function 'qcsp-may29::load-t4) (lambda () nil))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (ensure-may29-ao-loaded))

(defmacro with-may29-ao-paths (&body body)
  `(let ((*default-pathname-defaults*
           (truename (merge-pathnames "qcsp-may29-1996/extras/" *project-root*)))
         (*standard-output* (make-broadcast-stream)))
     ,@body))

(defun may29-graph-summary (graph)
  (mapcar (lambda (var)
            (list (symbol-name (qcsp-may29::cvariable-name var))
                  (mapcar (lambda (domval)
                            (symbol-name (qcsp-may29::domval-name domval)))
                          (qcsp-may29::cvariable-domainvaluelist var))))
          (qcsp-may29::graph-variable-list graph)))

(5am:def-suite ao-may29-tests
  :description "AO/test4 regression checks for qcsp-may29 extras")

(5am:in-suite ao-may29-tests)

(5am:test may29-ao-ac3-step
  "May29 AO AC-3 step mode should converge to the expected case-1 graph."
  (with-may29-ao-paths
    (let ((result (qcsp-may29::testacs 1)))
      (5am:is (equal (may29-graph-summary result)
                     '(("V0" ("E1")) ("V1" ("A2")) ("V2" ("B3")))))
      (5am:is (= qcsp-may29::*constraint-count* 211)))))

(5am:test may29-ao-ac3-aggressive
  "May29 AO AC-3 aggressive mode should match the expected reduced graph."
  (with-may29-ao-paths
    (let ((result (qcsp-may29::testaca 1)))
      (5am:is (equal (may29-graph-summary result)
                     '(("V0" ("E1")) ("V1" ("A2")) ("V2" ("B3")))))
      (5am:is (= qcsp-may29::*constraint-count* 35)))))

(5am:test may29-ao-ac-new-step
  "May29 AO AC-new step mode should match the expected reduced graph."
  (with-may29-ao-paths
    (let ((result (qcsp-may29::testacns 1)))
      (5am:is (equal (may29-graph-summary result)
                     '(("V0" ("E1")) ("V1" ("A2")) ("V2" ("B3")))))
      (5am:is (= qcsp-may29::*constraint-count* 35)))))

(5am:test may29-ao-ac-new-aggressive
  "May29 AO AC-new aggressive mode should match the expected reduced graph."
  (with-may29-ao-paths
    (let ((result (qcsp-may29::testacna 1)))
      (5am:is (equal (may29-graph-summary result)
                     '(("V0" ("E1")) ("V1" ("A2")) ("V2" ("B3")))))
      (5am:is (= qcsp-may29::*constraint-count* 35)))))

(5am:test may29-ao-wrapper-step
  "May29 test4s wrapper should preserve the historical nil revise summary."
  (with-may29-ao-paths
    (qcsp-may29::test4s)
    (5am:is (equal (list qcsp-may29::ao1 qcsp-may29::ao2 qcsp-may29::ao3)
                   '(nil nil nil)))
    (5am:is (= qcsp-may29::*constraint-count* 35))))

(5am:test may29-ao-wrapper-aggressive
  "May29 test4a wrapper should preserve the historical nil revise summary."
  (with-may29-ao-paths
    (qcsp-may29::test4a)
    (5am:is (equal (list qcsp-may29::ao1 qcsp-may29::ao2 qcsp-may29::ao3)
                   '(nil nil nil)))
    (5am:is (= qcsp-may29::*constraint-count* 35))))

(format t "~&~%;; ===== AO May29 Test Suite =====~%~%")
(let ((result (5am:run! 'ao-may29-tests)))
  (sb-ext:exit :code (if result 0 1)))
