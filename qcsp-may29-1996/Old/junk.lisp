;;
;; (defun memberv (var varset)
;;
(setq test1 (not (memberv 'var1 '( (var0 a b c) (var1 d e f) (var2 g h i) ))))
(setq test2 (not (memberv 'var4 '( (var0 a b c) (var1 d e f) (var2 g h i) ))))

;;
;; (defun remove-var (var varset)
;;
(setq test3 (remove-var 'var1 '( (var0 a b c) (var1 d e f) (var2 g h i) )))
(setq test4 (remove-var 'var3 '( (var0 a b c) (var1 d e f) (var2 g h i) )))

;;
;; (defun getval (var part-soln)
;;
(setq test5 (getval 'var1 '( (var0 9)  (var1 10) (var2 11)))) 
(setq test6 (getval 'var3 '( (var0 9)  (var1 10) (var2 11)))) 

;;

(setq varset '( (var1 a b c) (var2 d e f) (var3 g h i) (var4 j k l)))
(setq cset   '( (c1 (var1 var2)) (c2 (var2 var3)) (c3 (var3 var4)) ))
(setq curv (caar varset))
(setq domv (cdar varset))
(setq initial-open  '())
(setq open 
      (dolist (d domv initial-open)
	      (setq initial-open 
		    (append initial-open (list (list (list curv d)) )))) )
(setq varset (cdr varset))

;;

(setq curc    (first cset))
(setq cparam  (get-affected-list curc))
(setq curv1   (first cparam))
(setq curv2   (second cparam))
(setq unboundv1 (memberv curv1 varset))
(setq unboundv2 (memberv curv2 varset))
(setq cset    (cdr cset))

;;
;;(defun reviseOpen ( open curc )
;;
(setq open1 '( ( (t2-a adt2-1a) (t2-b adt2-1a) )  
	       ( (t2-a adt2-1a) (t2-b adt2-1d) ) ))
(setq c1 '(BEFORE-P (T2-A T2-B)))
(setq test10 (reviseOpen open1 c1))  ;; ok

;;
;; (defun isrtReviseOpen-1 ( open curc v2dom v1b )
;;
(setq open2 '( ((T2-A ADT2-1C) (T2-C ADT2-1F1)) ((T2-A ADT2-1B) (T2-C ADT2-1E1)) ((T2-A ADT2-1A) (T2-C ADT2-1D1)) ))
(setq v2dom '(T2-B ADT2-1F ADT2-1E ADT2-1D ADT2-1B)) 
(setq curc  '(BEFORE-P (T2-A T2-B)))
(setq v1b 'T2-A)
(setq test11 (isrtReviseOpen-1 open2 curc v2dom v1b))

