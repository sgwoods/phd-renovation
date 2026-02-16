;; load.lsp

(defvar *unix* t)
(if (not *unix*)
    (progn   ;; prepare any flags, etc for Macintosh specific control

      (setq *output-stream* t)  ;; force output stream definition

      ))

(defun loadit (&optional (sys *unix*) ) 
  (if sys                ;; unix load
    (progn
      (load "bm")
      (load "bt")
      (load "ct")
      (load "gsat")

      (load "utility")
      (load "compile")

      ;; load Queens domain
      ;; (load "queens")   

      ;; load MPR domain
      ;;(load "mpr-simple")   ;; functionality
      ;;(load "mpr-setup")    ;; template, situation information

      ;; load ADT domain
      (load "quilici-search") 
      (load "adt-simple")   ;; functionality
      (load "adt-setup")    ;; template, situation information

      ;; load new memory-csp in two phases
      (load "memory-csp")
      )
  (progn              ;; mac load
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:bm")
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:bt")
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ct")
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:gsat")

      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:utility")
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:compile")

      ;; load Queens domain
      ;; (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:queens")   

      ;; load MPR domain
      ;;(load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:mpr-simple")   
      ;;(load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:mpr-setup")    

      ;; load ADT domain variations
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:quilici-search") 
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:adt-simple")   
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:adt-setup")    

      ;; load new memory-csp in two phases
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:memory-csp")
    )) )

(loadit)