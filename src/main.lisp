;;;; src/main.lisp -- Entry point for the PhD CSP research system
;;;;
;;;; Usage:
;;;;   sbcl --load "src/main.lisp"
;;;;
;;;; Loads both ASDF systems (:phd-research and :qcsp3) and drops
;;;; into a REPL with the CWD set to qcsp3/ for interactive use.
;;;;
;;;; Available entry points after loading:
;;;;   (qcsp3:qc N)             -- N-Queens with AC-3
;;;;   (qcsp3:cqc N)            -- Confused N-Queens with AC-3
;;;;   (qcsp3:adt ...)          -- Abstract Data Type recognition
;;;;   (qcsp3:mpr ...)          -- Model Pattern Recognition
;;;;   (qcsp3:memory-search ..) -- Two-phase memory-based CSP search
;;;;
;;;; For batch experiments, see Q-Batch-SBCL/*.sh

(require :asdf)

;;; Register project root
(defvar *project-root*
  (make-pathname :directory (butlast (pathname-directory
                                       (truename *load-pathname*)))
                 :device (pathname-device (truename *load-pathname*))))

(pushnew *project-root* asdf:*central-registry* :test #'equal)

;;; Load the primary system (qcsp3 is the superset)
(format t "~&; Loading :qcsp3 via ASDF...~%")
(asdf:load-system :qcsp3)
(format t "~&; :qcsp3 loaded successfully.~%")

;;; Set up working directory for ADT/MPR operations
(setq *default-pathname-defaults*
      (truename (merge-pathnames "qcsp3/" *project-root*)))

;;; Set platform flag
(setq qcsp3:*unix* t)

;;; Ensure required directories exist
(ensure-directories-exist
 (merge-pathnames "ADT-Random/dummy" *default-pathname-defaults*))
(ensure-directories-exist
 (merge-pathnames "ADT-Situation/dummy" *default-pathname-defaults*))

(format t "~&; Ready. CWD: ~A~%" (namestring *default-pathname-defaults*))
(format t ";~%")
(format t "; Try: (qcsp3:qc 4)           -- 4-Queens~%")
(format t ";      (qcsp3:adt)            -- ADT recognition~%")
(format t ";      (qcsp3:memory-search)  -- two-phase search~%")
