;; Code for Step 1 of AC4, outputs formatted output of lists to screen
;;****************************************************************************

(defun step (A-list E-list consistent-p partial-solution)

(let (	(M-list nil)						     ;; line 1
	(C-list (make-c-list e-list a-list))
	(S-list (make-s-list A-list))
     )

(dolist (edge E-list)						     ;; line 2
 	(setq i (car edge))
  	(setq j (car (last edge)))
	(setq id (cdr (assoc1 i A-list)))
 	(setq jd (cdr (assoc1 j A-list)))
 	(dolist (il id)						     ;; line 3
 		;; begin					     ;; line 4
 		(setq total 0)					     ;; line 5
		(dolist (jl jd) 				     ;; line 6
			(if 	(car (funcall consistent-p i il      ;; line 7
					j jl partial-solution))
				;; begin			     ;; line 8
				(progn 	(setq total (+ total 1))     ;; line 9a
					(setq S-list (append-vl S-list
						(list i il) 
						(list j jl) ))	     ;; line 9b
				);; end				     ;; line 10
			)
		)
		(if 	(equal total 0) 			     ;; line 11
			(progn 	(setq M-list (cons (list i il) M-list))
 				(setq A-list (del-il-from-i i il A-list))))
		(setq C-list (add-to-counter edge il C-list total))     
								     ;; line 12
		;; end, line 4					     ;; line 13
	)  
) ;; end dolist

(progn	(terpri) (terpri)

	(princ "a-list") (terpri)
	(dolist (z a-list) (princ z) (terpri)) (terpri)

	(princ "c-list") (terpri)
	(dolist (z c-list) (princ z) (terpri)) (terpri)

 	(princ "m-list") (terpri)
	(dolist (z m-list) (princ z) (terpri)) (terpri)

	(princ "s-list") (terpri)
	(dolist (z s-list) (princ z) (terpri)) (terpri) 
)


))





(defun make-c-list (edge-list a-list)

(let ((c-list nil))

(dolist (edge E-list) 
 	(setq i (car edge))
 	(setq id (cdr (assoc1 i A-list)))
  	(dolist (il id) 
    		(setq C-list (cons (cons (cons edge (list il)) '(0)) C-list))
	)
) ;; end dolist
c-list
)
)



(defun add-to-counter (edge slabel c-list value)

(let (counter)

(if 	(equal c-list nil)
	(values counter c-list)
	(progn	(if 	(found (car c-list) edge slabel)
			;; then
			(progn	(setq counter 
					(+ (car (last (car c-list))) value))
				(setq c-list 
				      (cons (cons (car (car c-list)) 
							(list counter))
				      	    (cdr c-list)))
			)
			;; else
			(progn 	(multiple-value-setq (counter temp-list)
					(add-to-counter edge slabel (cdr c-list)
							value))
				(setq c-list (cons (car c-list) temp-list))
			)
		)
		(values counter c-list)
	)
)))

