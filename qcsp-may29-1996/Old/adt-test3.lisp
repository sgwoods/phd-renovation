
(defun at () (load "adt-test"))
; after run (adt) once

;; sit obj components  (domain values)

(setq s *current-situation*)

(setq a1 (get-sit-object 'adt1-1a)) ;; decl array int
(setq a2 (get-sit-object 'adt1-1b)) ;; decl int
(setq a3 (get-sit-object 'adt1-1c)) ;; decl int
(setq a4 (get-sit-object 'adt1-1d)) ;; zero array at position
(setq a5 (get-sit-object 'adt1-1e)) ;; assign array at position a value


;; template components (variable slots)

(setq ct *current-template*)
(setq slots  (get-templ-slots       *current-template*))
(setq constr (get-templ-constraints *current-template*))

(setq t1 (nth 0 slots)) ;; decl array int or char
(setq t2 (nth 1 slots)) ;; decl int
(setq t3 (nth 2 slots)) ;; decl int or char
(setq t4 (nth 3 slots)) ;; zero array int or char
(setq t5 (nth 4 slots)) ;; assign to array int or char and int or char
(setq t6 (nth 5 slots)) ;; print array int or char at position 
(setq t7 (nth 6 slots)) ;; print int or char

;; test node consistency function
(setq ts-type (get-tslot-type t1))
(setq so-type (get-sit-type a1))

(setq tst11 (equal ts-type so-type))
(setq ts-wholeType (get-tslot-stmt-param-type t1 1))
(setq so-declType   (get-sit-param a1 1))

(setq r11 (ts-matches-type t1 a1)) ; t
(setq r12 (ts-matches-type t1 a2)) ; f
(setq r21 (ts-matches-type t2 a1)) ; t 
(setq r22 (ts-matches-type t2 a2)) ; f
;; etc ...

(setq t-for1
      '(t1-x For (index1 (int)) (initVal (int)) (endVal (int))
	   (t1-x2 Zero (NameD (array (int char))) (index2 (int))))) 

(setq t-for2
      '(t1-x For (index1 (int)) (initVal (int)) (endVal (int))
	   (t1-x2 Print (NameD (array (int char))) (index2 (int)))) )

(setq s-for1
      '(dt1-1f 50 (For  idx1 initVal endVal (adt1-1f 51 (Zero  bA1 idx1)))) )

(setq s-for2
      '(dt1-1f 50 (For  idx1 initVal endVal (adt1-1f 51 (Print bA1 idx1)))) )
;; ok

(setq v (adt-variables))
(setq v1 (first v))

(setq sit1   (get-sit-object 'adt1-1a))
(setq ts1    (get-templ-slot-object *current-template* 't1-a))

(setq just1 (node-consistent-p 't1-a 'adt1-1a))
(setq v1c (node-consistent-one-node v1))

(setq allv (node-consistent-variables v))

;; ok

(setq cl (get-templ-constraints *current-template*))
(setq c1 (nth 0 cl))
(setq c2 (nth 1 cl))
(setq c3 (nth 2 cl))
(setq c4 (nth 3 cl))
(setq c5 (nth 4 cl))
(setq c6 (nth 5 cl))
(setq c7 (nth 6 cl))
(setq c8 (nth 7 cl))
(setq c9 (nth 8 cl))
(setq c10 (nth 9 cl))

; ok

;; check-same-name-p ( constraint t1 s1 t2 s2 )

(setq constraint c5)
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

