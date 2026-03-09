(in-package #:phd-qcsp-alex)
;; test4.lisp

(defun t4 ()
  (load "test4.lisp"))

(defun load-t4 ()
  (load "comment")
  (load "compile-ao")
  (load "hierarchy")
  (load "ao-revise-fns")
  (load "ao-revise-aggressive")
  (load "applyr")
  (load "example-extend"))

(defun testao1 ()
  (setq AO1 (qcsp3::ao-revise qcsp3::v1 qcsp3::v2 qcsp3::rfn 2)))

(defun testao2 ()
  (setq AO2 (qcsp3::ao-revise qcsp3::v0 qcsp3::v1 qcsp3::rfn 2)))

(defun testao3 ()
  (setq AO3 (qcsp3::ao-revise qcsp3::v2 qcsp3::v0 qcsp3::rfn 2)))



