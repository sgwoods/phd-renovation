(in-package #:phd-csp)
;; ct.lsp

(defun revise (symbol1 domain1 symbol2 domain2 consistent-p partial-solution )
"
The REVISE routine by Mackworth.
SYMBOL and SYMBOL2 are two variable names.
DOMAIN1 and DOMAIN2 are their domain respectively.
CONSISTENT-P is a function as specfied in the backtracking routine to check
for the consistency of two instantiations.
The function returns a new domain for SYMBOL1.
"
    (let (
	  (delete-p nil) 
	  (new-domain nil)
	  )
      (dolist (value1 domain1 (values new-domain delete-p))
	(if (compatible-p symbol1 value1 symbol2 domain2 
			  consistent-p partial-solution)
	    (progn
	      (if *debug-ac*
		  (comment4 "AC3: Compatible" symbol1 value1 symbol2 domain2))
	      (setq new-domain (cons value1 new-domain))
	      (setq *ac-count-compat* (1+ *ac-count-compat*))
	      )
	  (progn
	    (if *debug-ac* 
		(comment4 "AC3: Not compatible" symbol1 value1 symbol2 domain2))
	    (setq delete-p t)
	    (setq *ac-count-notcompat* (1+ *ac-count-notcompat*))
	    ))
	)))

(defun compatible-p (symbol1 value1 symbol2 domain2 
			     consistent-p partial-solution)
    (dolist (value2 domain2 nil)
        (when (first (funcall consistent-p 
			      symbol1 
			      value1 
			      symbol2 
			      value2
			      partial-solution ))
	  (return-from compatible-p t) )
	)
    ;; (comment4 "NOT COMPAT" symbol1 value1 symbol2 domain2)
    )

(defun ac-3 (variable-list arc-p consistent-p partial-solution)
"
The AC-3 routine by Mackworth.
VARIABLE-LIST is a list of variables as specified in the backtracking routine.
It is a list of sublists, each has its car a variable symbol and its cdr a
list of all possible domain values for that variable.
ARC-P is a function as described in ARC-P.
CONSISTENT-P is a function as described in CONSISTENT-P.
The function returns a new variable list which is arc-consistent.
"
    (let* (
	   (arc-list (get-all-arcs variable-list arc-p)) 
           (q arc-list)
           domain 
	   delete-p
	   )

      (setq variable-list (copy-alist variable-list))
      (do (symbol1 symbol2)
	  ((endp q) variable-list)
	(setq symbol1 (first  (first q)))
	(setq symbol2 (second (first q)))
	(setq q (rest q))

	(multiple-value-setq (domain delete-p)
	    (revise symbol1 (cdr (assoc1 symbol1 variable-list))
		    symbol2 (cdr (assoc1 symbol2 variable-list))
		    consistent-p
		    partial-solution))

	(when delete-p
	  (rplacd (assoc1 symbol1 variable-list) domain)
	  (setq q 
		(union q 
		       (get-incident-arcs symbol1 symbol2 
					  variable-list arc-p)
		       :test #'equal) ))
	)))


(defun get-incident-arcs (symbol1 symbol2 variable-list arc-p)
    (let (
	  (arc-list nil) 
	  symbol
	  )
      (dolist (variable variable-list arc-list)
	(setq symbol (first variable))
	(when
	    (and 
	     (not (equal symbol symbol1))
	     (not (equal symbol symbol2))
	     (funcall arc-p symbol symbol1))
	  (setq arc-list (cons (list symbol symbol1) arc-list)) ))
      ))

(defun degree-of-node (symbol variable-list arc-p)
    (let (
	  (arc-list nil) 
	  symbol1
	  )
      (dolist (variable variable-list (values (length arc-list) arc-list))
	(setq symbol1 (first variable))
	(when (and
	       (not (equal symbol1 symbol))
	       (funcall arc-p symbol symbol1))
	  (setq arc-list (cons (list symbol symbol1) arc-list)) ))
      ))

(defun get-all-arcs (variable-list arc-p)
"
Create a list of all the existing arcs.
Input: VARIABLE-LIST is a list of sublist, each has its car a variable symbol
       and its cdr a list of domain values for that variable.  ARC-P is
       a function as defined in ARC-P.
"
   (let (
	 arc-list 
	 symbol1 
	 symbol2
	 )
     (dolist (variable1 variable-list arc-list)
       (dolist (variable2 variable-list)
	 (setq symbol1 (first variable1))
	 (setq symbol2 (first variable2))
	 (when (and (not (equal symbol1 symbol2))
		    (funcall arc-p symbol1 symbol2))
	   (setq arc-list (cons (list symbol1 symbol2) arc-list) ))
	 )) ))


