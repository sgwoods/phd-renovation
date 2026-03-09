;;;; qcsp-alex-sep16-1997.asd -- ASDF system definition for Sep 1997 CSP snapshot
;;;;
;;;; Load order derived from qcsp-alex-sep16-1997/load.lisp and compile.lisp.

(defsystem :qcsp-alex-sep16-1997
  :description "QCSP Sep 1997 snapshot -- Extended CSP solver with experiments"
  :version "2.0.0"
  :licence "Academic"
  :serial t
  :components
  ((:module "qcsp-alex-sep16-1997"
    :serial t
    :components
    (;; Package definition and global declarations
     (:file "package")

     ;; Core search algorithms
     (:file "bm")              ; BackMark search
     (:file "bt")              ; BackTrack search
     (:file "ct")              ; Constraint Techniques (AC-3)
     (:file "gsat")            ; GSAT local search

     ;; Utilities and compilation support
     (:file "utility")         ; Global state, comment functions

     ;; Domain: N-Queens
     (:file "queens")          ; N-Queens problem domain

     ;; Domain: Model Pattern Recognition
     (:file "mpr-simple")      ; MPR functionality
     (:file "mpr-setup")       ; MPR template/situation data

     ;; Quilici constraint-driven search
     (:file "quilici-search")  ; Constraint-ordered search

     ;; Domain: Abstract Data Type
     (:file "adt-simple")      ; ADT functionality
     (:file "adt-setup")       ; ADT template/situation data

     ;; Memory-based CSP (two-phase Quilici approach)
     (:file "memory-csp")      ; Index + resolution phases
     ))))
