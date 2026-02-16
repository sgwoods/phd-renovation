
(defun at () (load "adt-test"))
; after run (adt) once

;; sit obj components  (domain values)

(setq s *current-situation*)

(setq sa (get-sit-object 'adt2-1a))   ;; decl array A char
(setq sb (get-sit-object 'adt2-1b))   ;; decl array B char
(setq sc (get-sit-object 'adt2-1c))   ;; decl array C char
(setq sd (get-sit-object 'adt2-1d))   ;; For
(setq sd1 (get-sit-object 'adt2-1d1)) ;; Begin
(setq sd1 (get-sit-object 'adt2-1d2)) ;; Print
(setq sd1 (get-sit-object 'adt2-1d3)) ;; End
(setq se  (get-sit-object 'adt2-1e))  ;; 
(setq se1 (get-sit-object 'adt2-1e1)) ;;
(setq se2 (get-sit-object 'adt2-1e2)) ;;
(setq se3 (get-sit-object 'adt2-1e3)) ;;
(setq sf  (get-sit-object 'adt2-1f))  ;; 
(setq sf1 (get-sit-object 'adt2-1f1)) ;;
(setq sf2 (get-sit-object 'adt2-1f2)) ;;
(setq sf3 (get-sit-object 'adt2-1f3)) ;;

;; template components (variable slots)

(setq ct *current-template*)

(setq slots  (get-templ-slots       *current-template*))
(setq constr (get-templ-constraints *current-template*))

(setq ta (nth 0 slots)) ;; 
(setq tb (nth 1 slots)) ;; 
(setq tc (nth 2 slots)) ;; 
(setq td (nth 3 slots)) ;; 
(setq te (nth 4 slots)) ;; 

;; template constraints

(setq cl (get-templ-constraints *current-template*))
(setq c1 (nth 0 cl))
(setq c2 (nth 1 cl))
(setq c3 (nth 2 cl))
(setq c4 (nth 3 cl))

;; specific example

(setq constraint c2)
(setq t1 't1-d)
(setq s1 'adt1-1d)
(setq t2 't1-a)
(setq s2 'adt1-1a)

(setq aflist   (get-affected-list constraint))
(setq plist    (get-parameter-list constraint))
(setq order    (if (eq t1 (first aflist)) 't1 't2))
(setq t1-templNameVar (if (eq order 't1) (first  plist) (second plist)))
(setq t2-templNameVar (if (eq order 't2) (first  plist) (second plist)))
(setq t1-var-pos  (get-ts-obj-namePos t1 t1-templNameVar))
(setq t2-var-pos  (get-ts-obj-namePos t2 t2-templNameVar))
(setq s1-obj (get-sit-object s1))
(setq s2-obj (get-sit-object s2))
(setq s1-name (if (> t1-var-pos 0) (get-sit-param s1-obj t1-var-pos) nil))
(setq s2-name (if (> t2-var-pos 0) (get-sit-param s2-obj t2-var-pos) nil))

;;

;;(setq cx1 (check-same-name-p c7 t3 a2 t5 a5))

