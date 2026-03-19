
 ;;acq.lsp	Last revised July 28, 1993

;;All of the ac-fraction functions in this lisp file are models of the 
;;fractional arc consistency algorithms presented by Bernard A. NADEL in his 
;;paper entitled 'Constraint Satisfaction Algorithms', from Comput. Intell. 5,
;;188-224 (1989).

;;Some algorithms are direct model's of those presented in NADEL's paper 
;;such as :	AC-fifth-out,	which is NADEL's AC 1/5
;;		AC-quarter-in,	which is NADEL's AC 1/4
;;		AC-third-out, which is an optimization of NADEL's AC 1/3
;;		AC-half, which is NADEL's AC 1/3

;;Other algorithms are new algorithms invented by me (Denis McGonigal) 
;;and can be found in the paper Many Fractional AC Algorithms.  These
;;algorithms are : AC-fifth-in, AC-quarter-out and AC-third-in.

;;The algorithms do the work specified by described by NADEL's algorithms 
;;however they return a NEW revised list (variable-list). The input list 
;;is still the same.

;;The functions return three 'values', they are:
;;The new revised list, T or NIL (for 'delete-p') if a deletion of a domain
;;value took place, and, T or NIL (for 'nil-domain-p') if a domain has
;;had all its values deleted.

;;It is assumed that the parameter var-list is a list of 'vd-lists'
;;A 'vd-list' is a list where the car is the name of a variable and the cdr
;;is a list of domain values for that variable; thus 'vd-list'.
;;It is the variable list that Steve Woods describes in ct.lisp.

;;The function will revise the domain of 'source' in the parameter list.
;;The function assumes that the source parameter is a member of variable-list. 

;;The functions "member1" and "get-range" are defined in rrevise.lisp.
;;These functions were written by Steve Woods.

;;In all of the algorithms, each arc (source, target) if revised, is revised 
;;once only.
;;

;;
;;*****************************************************************************
;;
;;The function AC 1/5 OUT revises the source variable's domain with all
;;the variables preceding source in var-list. It is only the source
;;variable's domain that may be changed.
;;
;;*****************************************************************************

(defun ac-fifth-out (source var-list consistent-p partial-solution
				&optional (delete-p nil) (nil-domain-p nil))

(let (
        (temp-list (copy-list var-list))
	(new-domain nil)
     )

	(multiple-value-setq (new-domain delete-p nil-domain-p)	
		(rrevise source temp-list (caar temp-list)
			 source consistent-p partial-solution))
	(replace-domain source temp-list new-domain)
	(values temp-list delete-p nil-domain-p)

 )) 

;;end ac-fifth-out


;;*****************************************************************************
;;
;;The function AC 1/5 IN revises the domains of each variable that precedes
;;target in the var-list. The domain of target remains unchanged.  The revises
;;are done with the domain of target.
;;
;;*****************************************************************************

(defun ac-fifth-in (target var-list consistent-p partial-solution
				&optional (delete-p nil) (nil-domain-p nil))

(let (
	(temp-list (copy-list var-list))
	(source-range (remove1 target 
                            (get-range var-list (caar var-list) target )))
	(target-domain (cdar (member1 target var-list)))
	(new-domain nil)
	(temp-delete-p nil)
     )

	(dolist (source-with-domain source-range)
	(let (
		(source (car source-with-domain))
	     )
	     	(multiple-value-setq (new-domain temp-delete-p)
		   (revise source (cdr (assoc1 source temp-list)) target 
			   target-domain consistent-p partial-solution))
	     	(replace-domain source  temp-list new-domain)
	     	(setq delete-p (or delete-p temp-delete-p))
	     	(if (null new-domain) (setq nil-domain-p t))

	)) ;; end let,end dolist
	
	(values temp-list delete-p nil-domain-p)

)) 

;;end ac-fifth-in

;;*****************************************************************************
;;
;;AC 1/4 OUT is a function that revises the source variable's domain with all 
;;variables that follow it in the var-list.
;;
;;*****************************************************************************

(defun ac-quarter-out (source var-list consistent-p partial-solution
				&optional (delete-p nil) (nil-domain-p nil))

(let (
	(temp-list (copy-list var-list))
	(new-domain nil)
     )

	(multiple-value-setq (new-domain delete-p nil-domain-p)	
		(rrevise source temp-list source (caar (last temp-list))
			 consistent-p partial-solution))
	(replace-domain source temp-list new-domain)
	(values temp-list delete-p nil-domain-p)

))

;;end ac-fifth-out

;;*****************************************************************************
;;
;;AC 1/4 IN is a function that revises the domains of the variables 
;;following target with the domain of target.
;;The variables in source-range all come after target in the list var-list.
;;
;;*****************************************************************************

(defun ac-quarter-in (target var-list consistent-p partial-solution
				&optional (delete-p nil) (nil-domain-p nil))

(let  (
	 
	(temp-list (copy-list var-list))
	(source-range (remove1 target (get-range var-list target 
		      (caar (last var-list)))))
	(target-domain (cdar (member1 target var-list)))
	(new-domain nil)
	(temp-delete-p nil)
      )

    	(dolist (source-with-domain source-range)
	(let (
		(source (car source-with-domain))
	     )
		(multiple-value-setq (new-domain temp-delete-p)
		(revise source (cdr (assoc1 source temp-list)) target 
			target-domain consistent-p partial-solution))
		(replace-domain source  temp-list new-domain)
		(setq delete-p (or delete-p temp-delete-p))
		(if (null new-domain) (setq nil-domain-p t))

	)) ;; end let, end dolist

	(values temp-list delete-p nil-domain-p)

)) 

;; end ac-quarter-in

;;*****************************************************************************
;;
;;AC 1/3 OUT (or AC 1/3 FORWARD) is a function that performs 
;;AC 1/4 OUT on all the variables
;;in source-range.
;;The calls to AC 1/4 OUT begin at the end of the list source-range
;;and work their way back to first-source. 
;;The call to reverse is to make the revisions more efficient.
;;See my paper called 'Revision of Inefficiency Found in 
;;Fractional Arc Consistency Algorithm' for explanations.
;;
;;*****************************************************************************

(defun ac-third-out (first-source var-list consistent-p partial-solution
				&optional (delete-p nil) (nil-domain-p nil))

(let  (
	(temp-list (copy-list var-list))
	(source-range (reverse (get-range var-list first-source 
		(caar (last var-list)))))
	(temp-delete-p nil)
	(temp-nil-domain-p nil)
      )
	(dolist (source-with-domain source-range)
	    (let (
		    (source (car source-with-domain))
		 )

		    (multiple-value-setq (temp-list temp-delete-p 
					temp-nil-domain-p)
				(ac-quarter-out source temp-list consistent-p 
					partial-solution))
		    (setq delete-p (or delete-p temp-delete-p))
		    (setq nil-domain-p (or nil-domain-p temp-nil-domain-p))

	));;end let, end dolist

	(values temp-list delete-p nil-domain-p)

))

;;end ac-third-out

;;*****************************************************************************
;;
;;AC 1/3 IN (or AC 1/3 BACKWARD)(SETQ SOU
;;This function is similar to AC 1/3 out with the exception that the revises
;;are in the opposite direction.
;;
;;*****************************************************************************

(defun ac-third-in (first-target var-list consistent-p partial-solution
				&optional (delete-p nil) (nil-domain-p nil))

(let  (
	(temp-list (copy-list var-list))
	(target-range (get-range var-list first-target (caar (last var-list))))
	(temp-delete-p nil)
	(temp-nil-domain-p nil)
      )

	(dolist (target-with-domain target-range)
		(let (
	        	(target (car target-with-domain))
		     )

		(multiple-value-setq (temp-list temp-delete-p 
					temp-nil-domain-p)
			(ac-quarter-in target temp-list consistent-p 
					partial-solution))
		(setq delete-p (or delete-p temp-delete-p))
		(setq nil-domain-p (or nil-domain-p temp-nil-domain-p))

	));;end let, end dolist

	(values temp-list delete-p nil-domain-p)

))

;;end ac-third-in

;;****************************************************************************
;;
;;AC 1/2 is a function that performs a revise between all arcs in var-list
;;within the range between source and the last variable in var-list.
;;
;;****************************************************************************

(defun ac-half (first-source var-list consistent-p partial-solution
				&optional (delete-p nil) (nil-domain-p nil))

(let  (
	(temp-list (copy-list var-list))
	(temp-delete-p nil)
	(temp-nil-domain-p nil)
      )

	(multiple-value-setq (temp-list temp-delete-p temp-nil-domain-p)
		(ac-third-out first-source temp-list consistent-p 
			partial-solution))
		(setq delete-p (or delete-p temp-delete-p))
		(setq nil-domain-p (or nil-domain-p temp-nil-domain-p))

	(multiple-value-setq (temp-list temp-delete-p temp-nil-domain-p)
		(ac-third-in first-source temp-list consistent-p
			partial-solution))
		(setq delete-p (or delete-p temp-delete-p))
		(setq nil-domain-p (or nil-domain-p temp-nil-domain-p))

	(values temp-list delete-p nil-domain-p)

))

;;end ac-half

;;****************************************************************************
;;
;;This function was written by Steve Woods (21/07/93).  
;;The function repalces replace the domain of the variable 'id' with
;;the new domain 'dom'. The variable is found in 'var-list' which has the 
;;same format as variable-list described above. 
;; 
;;The function is equiped to handle NIL as an input for 'dom'. 
;;
;;For example suppose:
;;
;;id 		= (row 1)
;;var-list 	= ( ((row 1) 1 2 3) )
;;dom 		= NIL
;;
;;The result from a call to replace-domain would be : ( ((row 1) ) )
;;
;;Suppose 'dom' is changed to (a b) then the result would be:
;;			 ( ((row 1) a b) )
;;
;;****************************************************************************

(defun replace-domain (id var-list dom)
"
This function destructively changes var-list with the new domain.  This is
 intentional.  Also assumes presence of id key in var-list.
"  
  (if (null dom)
      (progn
       (setf (nth (position id var-list :test '(lambda (x y) (equal x (car y))))
		  var-list)
	     (list id)))
    (setf (nth (position id var-list :test '(lambda (x y) (equal x (car y))))
	       var-list)
	  (append (list id) dom) )))
         
;;****************************************************************************
