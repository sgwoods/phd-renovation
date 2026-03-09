;;;; run-test4-alex.lisp -- Load qcsp-alex-sep16-1997 system and run test4 suite
;;;;
;;;; Usage: sbcl --load "run-test4-alex.lisp"
;;;;
;;;; Note: qcsp-alex-sep16-1997 does not contain its own AO (arc-oriented)
;;;; files.  The original setup loaded them from a shared directory.
;;;; We load the qcsp3 system first, then source the AO files from qcsp3/.

(require :asdf)

(pushnew (make-pathname :name nil :type nil
                        :defaults (truename *load-pathname*))
         asdf:*central-registry*
         :test #'equal)

;;; Load the qcsp-alex-sep16-1997 system (core CSP solver)
(asdf:load-system :qcsp-alex-sep16-1997)

;;; Load qcsp3 system so that AO file dependencies (package + core) are available
(asdf:load-system :qcsp3)

;;; Load AO support files from qcsp3/ (not part of qcsp3.asd)
(let ((*default-pathname-defaults*
        (truename (merge-pathnames "qcsp3/"
                   (make-pathname :name nil :type nil
                                  :defaults *load-pathname*)))))
  (load "comment")
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

;;; Load test4 definitions from qcsp-alex-sep16-1997/
(let ((*default-pathname-defaults*
        (truename (merge-pathnames "qcsp-alex-sep16-1997/"
                   (make-pathname :name nil :type nil
                                  :defaults *load-pathname*)))))
  (load "test4"))

;;; All test4 dependencies are already loaded; prevent re-loading
(defun qcsp-alex::load-t4 () nil)

;;; Initialize *ao-debug* -- normally set by ao-ac3, but the alex tests
;;; call ao-revise directly, bypassing ao-ac3.
(setq qcsp3::*ao-debug* nil)

;;; Run all tests
(format t "~&~%;; ===== test4 suite (qcsp-alex-sep16-1997) =====~%")

(format t "~&;; testao1: AO-revise V1->V2~%")
(qcsp-alex::testao1)

(format t "~&;; testao2: AO-revise V0->V1~%")
(qcsp-alex::testao2)

(format t "~&;; testao3: AO-revise V2->V0~%")
(qcsp-alex::testao3)

(format t "~&~%;; ===== All test4 tests completed (qcsp-alex-sep16-1997). =====~%")
