;;;; qcsp-may29-1996.asd -- ASDF system definition for May 1996 CSP snapshot
;;;;
;;;; Load order derived from qcsp-may29-1996/load.lisp and compile.lisp.

(defsystem :qcsp-may29-1996
  :description "QCSP May 1996 snapshot -- CSP solver with memory-based search"
  :version "2.0.0"
  :licence "Academic"
  :serial t
  :components
  ((:module "qcsp-may29-1996"
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
