;; load.lsp

(load "bm")
(load "bt")
(load "ct")
(load "gsat")

(load "utility")
(load "compile")

;; load Queens domain
; (load "queens")   

;; load MPR domain
;(load "mpr-simple")   ;; functionality
;(load "mpr-setup")    ;; template, situation information

;  load ADT domain
(load "quilici-search") 
(load "adt-simple")   ;; functionality
(load "adt-setup")    ;; template, situation information

;  load new memory-csp in two phases
(load "memory-csp")