;;;; bootstrap-may29.lisp -- ASDF-based loader for may29 batch experiments on SBCL
;;;;
;;;; Loads the qcsp-may29-1996 system via ASDF and sets
;;;; *default-pathname-defaults* to qcsp-may29-1996/ so that relative
;;;; paths (ADT-Random/, ADT-Situation/) resolve correctly.
;;;;
;;;; Must be run from the project root directory.

(require :asdf)

;;; Derive project root from *load-pathname*
(defvar *project-root*
  (make-pathname :directory (butlast (pathname-directory
                                      (truename *load-pathname*)))
                 :device (pathname-device (truename *load-pathname*))))

;;; Register project root with ASDF
(pushnew *project-root* asdf:*central-registry* :test #'equal)

;;; Load the may29 system
(format t "~&; Loading :qcsp-may29-1996 via ASDF...~%")
(asdf:load-system :qcsp-may29-1996)
(format t "~&; :qcsp-may29-1996 loaded successfully.~%")

;;; Set default pathname to qcsp-may29-1996/ so ADT-Random/ etc. resolve
(setq *default-pathname-defaults*
      (truename (merge-pathnames "qcsp-may29-1996/" *project-root*)))

(format t "~&; Bootstrap complete. CWD: ~A~%" *default-pathname-defaults*)
