;;;; renovate.lisp -- Bootstrap script for loading phd-research into SBCL
;;;;
;;;; Usage:
;;;;   sbcl --load "renovate.lisp"
;;;;
;;;; This registers the project directory with ASDF, loads the system,
;;;; and drops you into the REPL ready to work.

;;; Ensure ASDF knows where to find phd-research.asd
(require :asdf)

(pushnew (make-pathname :name nil :type nil
                        :defaults (truename *load-pathname*))
         asdf:*central-registry*
         :test #'equal)

;;; Load the system
(format t "~&; Loading :phd-research via ASDF...~%")
(asdf:load-system :phd-research)
(format t "~&; :phd-research loaded successfully.~%")
