;;;; bootstrap.lisp -- ASDF-based loader for Q-Batch experiments on SBCL
;;;;
;;;; Replaces the original (load "load") used in the ACL-era batch scripts.
;;;; Loads the qcsp3 system via ASDF and sets *default-pathname-defaults*
;;;; to qcsp3/ so that relative paths (ADT-Random/, ADT-Situation/) resolve
;;;; correctly.
;;;;
;;;; Must be run from the project root directory.

(require :asdf)

;;; Derive project root from *load-pathname* (strip Q-Batch-SBCL/bootstrap.lisp)
(defvar *project-root*
  (make-pathname :directory (butlast (pathname-directory
                                      (truename *load-pathname*)))
                 :device (pathname-device (truename *load-pathname*))))

;;; Register project root with ASDF (where qcsp3.asd lives)
(pushnew *project-root* asdf:*central-registry* :test #'equal)

;;; Load the qcsp3 system
(format t "~&; Loading :qcsp3 via ASDF...~%")
(asdf:load-system :qcsp3)
(format t "~&; :qcsp3 loaded successfully.~%")

;;; Set default pathname to qcsp3/ so ADT-Random/ and ADT-Situation/ resolve
(setq *default-pathname-defaults*
      (truename (merge-pathnames "qcsp3/" *project-root*)))

;;; Mark unix mode for path selection in adt-setup.lisp
(setq *unix* t)

(format t "~&; Bootstrap complete. CWD: ~A~%" *default-pathname-defaults*)
