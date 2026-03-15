;;;; bootstrap-alex.lisp -- ASDF-based loader for alex batch experiments on SBCL
;;;;
;;;; Loads the qcsp-alex-sep16-1997 system via ASDF and sets
;;;; *default-pathname-defaults* to qcsp-alex-sep16-1997/ so that relative
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

;;; Load the alex system
(format t "~&; Loading :qcsp-alex-sep16-1997 via ASDF...~%")
(asdf:load-system :qcsp-alex-sep16-1997)
(format t "~&; :qcsp-alex-sep16-1997 loaded successfully.~%")

;;; Set default pathname to qcsp-alex-sep16-1997/ so ADT-Random/ etc. resolve
(setq *default-pathname-defaults*
      (truename (merge-pathnames "qcsp-alex-sep16-1997/" *project-root*)))

(format t "~&; Bootstrap complete. CWD: ~A~%" *default-pathname-defaults*)
