;; AC4.lisp  Started     2 August, 1993
;;
;; This file contains the LISP code for the algorithm AC-4 described by 
;; Mohr and Henderson in their paper entitled "Arc and Path Consisitency
;; Revisited*" found in ARTIFICIAL INTELLIGENCE 28 (1986) 225-233
;;
;; ATTENTION !!!!!!!!!!!!!!!!!! ATTENTION !!!!!!!!!!!!!!!!!!!!!!!!!!!!
;;
;; The implementation has a bug in it. Many tests on the algorithm have 
;; turned out well but a special case in the 4-queens CSP did not work.
;; The file AC4test has the formated LISP input and the AC4 function calls
;; that will give the erroneous result. A file called 'step.lisp' contains
;; the code for step 1 of AC4. The code will give formatted output to the 
;; screen.
;;
;; The bug has something to do with the "counter list". 
;; It is not understood why the implementation does not work.
;; An e-mail letter from Hany Tolba suggests that there is a bug in the
;; algorithm. This letter can be found in a file called "Hany".
;;
;;*****************************************************************************
;;
;; AC-4 is a full arc consistency algorithm that is optimal in time complexity.
;; 
;; A-LIST 
;;
;; It is assumed that the parameter A-list is a list of 'vd-lists'
;; A 'vd-list' is a list where the car is the name of a variable and the cdr
;; is a list of domain values for that variable; thus 'vd-list'.
;; The name of a variable may also be a list i.e. (row 1)(queens
;; It is the variable list that Steve Woods describes in ct.lisp.
;; In other word A-list is list variables coupled with their domains
;; i.e (  (a 1 2 3) (b) (c 7 4 1)  )
;; ATTENTION : it is assumed that A-list is non-null and each of its domain
;;		are also non-null 
;;
;; EDGE-LIST
;;
;; It is assumed that E-list is a list of edges, 
;; each edge being a list of 2 nodes, (i j) 
;; i.e. E-list : ( (i j) (k l) (m n) )
;;
;; COUNTER-LIST
;;
;; C-list is a list of counters for (edge, i-label)
;; For the edge (i, j) and label b for at node i C[(i,j),b] counters the 
;; number of labels b supports in node j.  
;; A counter will have the form (((i j) b) total). (i j) for an edge,
;; b for the label, and total for the number of label ((i j) b) supports.
;; If this counter should be zero
;; then b should be deleted. (this is a partial revision of node i)
;;
;; VARIABLE DEFINITIONS
;;
;; il : i label
;; jl : j label
;; id : i domain
;; jd : j domain
;;
;;*****************************************************************************

(defun AC-4 (A-list E-list consistent-p partial-solution)

;; STEP 0, Checks

(let (	(M-list nil) 
	(C-list nil)
	(S-list nil)
     )


(if 	(eq A-list nil) 
	(return-from AC-4 A-list)
	(progn	(multiple-value-setq (A-list C-list E-list M-list S-list)
			(step1 A-list E-list consistent-p partial-solution))
		(setq A-list (step2 A-list C-list E-list M-list S-list))))

A-list

))

;; it has been determined that line 14 is redundant since there is a direct
;; correlation between the members of List and the values 1 in the array M


;;*****************************************************************************
;;
;; STEP 1, Construction of the Data Structures
;;
;;*****************************************************************************

(defun step1 (A-list E-list consistent-p partial-solution)

(let (	(M-list nil)						     ;; line 1
	(C-list nil)
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
		(setq C-list (add-total-to-counter edge il total C-list))     
								     ;; line 12
		;; end, line 4					     ;; line 13
	)  
) ;; end dolist

(values A-list C-list E-list M-list S-list)

))


;;*****************************************************************************
;;
;; STEP 2, Pruning the Inconsistent Labels
;;
;;*****************************************************************************

(defun step2 (A-list C-list E-list M-list S-list)

(loop while (not (null M-list))	do				;; line 15
	;; begin						;; line 16
	(progn	(setq jc (car M-list))				;; line 17
		(setq M-list (cdr M-list))
		(dolist (ib (return-support-jc jc S-list))	;; line 18
			;; begin				;; line 19
			(multiple-value-setq (counter c-list)	;; line 20
				(decr-counter (list (car ib) (car jc)) 
							(cadr ib) c-list))
			(if 	(and 	(equal counter 0)	;; line 21
					(not (member3 ib M-list)))
				;; then					
				;; begin			;; line 22
				(progn	(setq M-list (append M-list ib))
								;; line 23
 					(setq A-list (del-il-from-i (car ib)
					      (cadr ib) A-list));; line 24
				)
			)	;; end				;; line 25
		)	;; end 					;; line 26
	);; end							;; line 27
	
)

(values A-list)

)

;;*****************************************************************************
;;
;;  This function takes an A-list (described above) as input and 
;;  returns s-list. That is for each variable that has a non empty 
;;  domain, the couplets (variable, domain value) are added to s-list.
;;  For those variables that have an empty domain, the variable alone
;;  is added to the list.
;;
;;  If the A-list above were to be input then the output would be :
;;
;;  ( 	(((a) 1)) (((a) 2)) (((a) 3)) 
;;	(((b)))
;;	(((c) 7)) (((c) 4)) (((c) 1))  )
;;
;;*****************************************************************************

(defun make-s-list (A-list)

(let  (	
	(s-list nil)
	(vd-list nil)
	(vd nil)
	(dom nil)
	(var nil)
	(label nil)
      )
	(dolist (vd-list A-list)
		(setq var (car vd-list))
		(setq dom (cdr vd-list))
		(if	dom
			(dolist (label dom)
				(setq vd (cons var (list label)))
				(setq s-list (reverse (cons (list vd) 
						(reverse s-list)))))	
			(setq s-list (reverse (cons (list (list var))
 					(reverse s-list))))
		)
	)
	s-list

));;end make-s-list

;;*****************************************************************************
;;
;;  This function takes the couplet ((i) b) and appends it to the 
;;  end of the list ( ((j) c) ) which is in an s-list.
;;  vl means var-label couplet
;;  This function was written to replace line 9b of the algorithm presented 
;;  by Mohr and Henderson
;;
;;*****************************************************************************

(defun append-vl (s-list supporting-vl supported-vl)

(let (	(temp nil)
	(temp-list nil)
     )
	(setq temp (member4 supporting-vl s-list))
	(setq temp-list (remove2 supporting-vl s-list))
	(setq temp (append temp (list supported-vl)))
	(setq temp-list (append temp-list (list temp)))
	temp-list
)
)

;;*****************************************************************************

(defun remove2 (element list)
  (remove element list :test #'(lambda (x y) (equal x (car y)))))

;;*****************************************************************************

(defun 	return-support-jc (sublist list)
	(if 	(null list)
		nil
		(if	(equal sublist (caar list))
			(cdar list)
			(return-support-jc sublist (cdr list)) )))

;;*****************************************************************************

(defun 	member3 (sublist list)
	(if 	(null list)
		nil
		(if	(equal sublist (car list))
			(car list)
			(member3 sublist (cdr list)) )))

;;*****************************************************************************

(defun 	member4 (element list)
	(if 	(null list)
		nil
		(if 	(member5 element (car list))
			(car list)
			(member4 element (cdr list))  )))
	
;;*****************************************************************************

(defun 	member5 (element list)
	(if 	(null list)
		nil
		(if 	(equal element (car list))
			t	nil )))

;;*****************************************************************************

(defun del-il-from-i (i il A-list)

(let ( 	(s nil)
     )

	(if  	(null A-list)
		A-list
		(progn 	(setq s (car A-list))
			(if 	(equal i (car s))
				(progn 	(setq s (remove il s))
					(cons s (cdr A-list)))
				(cons s (del-il-from-i i il (cdr A-list)))
	)	)	)

)
) ;;end del-il-from-i 

;;*****************************************************************************

(defun add-total-to-counter (edge sl total C-list)

	(setq C-list (cons (cons (cons edge (list sl)) (list total)) C-list))

) ;; end add-total-to-counter

;;*****************************************************************************
;;
;; This function removes a list from a list.
;; It is called remove-l for remove list.
;;
;;*****************************************************************************

(defun remove-l (l li)

	(if 	(null li)
		li
		(if 	(equal l (car li))
			(cdr li)
			(cons (car li) (remove-l l (cdr li)))
)	)	)

;;*****************************************************************************
;;
;;  This function decrements the edge slabel counter in c-list
;;  This function returns 2 values : 
;;  the new value for the counter and a new c-list
;;  
;;  The variable 'premier' stands for first in french and the variable 
;;  is assigned the car of c-list 
;;  
;;*****************************************************************************

(defun decr-counter (edge slabel c-list)

(let (counter)

(if 	(equal c-list nil)
	(values counter c-list)
	(progn	(if 	(found (car c-list) edge slabel)
			;; then
			(progn	(setq counter (- (car (last (car c-list))) 1))
				(setq c-list 
				      (cons (cons (car (car c-list)) 
							(list counter))
				      	    (cdr c-list)))
			)
			;; else
			(progn 	(multiple-value-setq (counter temp-list)
					(decr-counter edge slabel (cdr c-list)))
				(setq c-list (cons (car c-list) temp-list))
			)
		)
		(values counter c-list)
	)
)))

;;*****************************************************************************

(defun found (a b c)
	(equal (car a) (cons b (list c)))
)
