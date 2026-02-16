;;;; run-test4.lisp -- Load qcsp3 system and run test4 suite
;;;;
;;;; Usage: sbcl --load "run-test4.lisp"

(require :asdf)

(pushnew (make-pathname :name nil :type nil
                        :defaults (truename *load-pathname*))
         asdf:*central-registry*
         :test #'equal)

;;; Load the qcsp3 system
(asdf:load-system :qcsp3)

;;; Set default path to qcsp3/ so test4's relative loads work
(let ((*default-pathname-defaults*
        (truename (merge-pathnames "qcsp3/"
                   (make-pathname :name nil :type nil
                                  :defaults *load-pathname*)))))

  ;; Load test4 support files (what load-t4 would load)
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

  ;; Load test4 definitions (but skip calling load-t4 again)
  (load "test4"))

;;; All test4 dependencies are already loaded; prevent re-loading
(defun load-t4 (&optional sys) (declare (ignore sys)) nil)

;;; Run all tests
(format t "~&~%;; ===== test4 suite =====~%")

(format t "~&;; testacs: AO-ac3 Step, case 1~%")
(testacs 1)

(format t "~&;; testaca: AO-ac3 Aggressive, case 1~%")
(testaca 1)

(format t "~&;; testacns: AO-ac-new Step, case 1~%")
(testacns 1)

(format t "~&;; testacna: AO-ac-new Aggressive, case 1~%")
(testacna 1)

(format t "~&;; test4s: AO-revise Step~%")
(test4s)

(format t "~&;; test4a: AO-revise Aggressive~%")
(test4a)

(format t "~&~%;; ===== All test4 tests completed. =====~%")
