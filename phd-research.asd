;;;; phd-research.asd -- ASDF system definition for PhD CSP solver
;;;;
;;;; Modernized from legacy Allegro CL (ACL) project.
;;;; Original load order derived from csp/load.lisp and csp/compile.lisp.

(defsystem :phd-research
  :description "Constraint Satisfaction Problem (CSP) solver -- PhD research project"
  :version "2.0.0"
  :licence "Academic"
  :serial t
  :components
  ((:module "csp"
    :serial t
    :components
    (;; Core search algorithms
     (:file "bm")            ; BackMark search
     (:file "bt")            ; BackTrack search
     (:file "ct")            ; Constraint Techniques (AC-3 arc consistency)

     ;; Utilities and compilation support
     (:file "utility")       ; Global state, variable initialization

     ;; Domain: N-Queens
     (:file "queens")        ; N-Queens problem domain

     ;; Domain: Model Pattern Recognition
     (:file "mpr-simple")    ; MPR functionality
     (:file "mpr-setup")     ; MPR template/situation data

     ;; Domain: Abstract Data Type
     (:file "adt-simple")    ; ADT functionality
     (:file "adt-setup")     ; ADT template/situation data
     ))))
