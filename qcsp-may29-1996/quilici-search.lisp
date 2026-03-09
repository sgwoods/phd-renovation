(in-package #:phd-qcsp-may29)
;; quilici-search.lisp
;;
(defun cq () (compile-file "quilici-search") (load "quilici-search"))
(defun lq () (load "quilici-search.lisp"))
;;
;; My first RE-implementation of something like 
;;    Quilici's approach to indexing, ordering etc 
;; 
;; This approach utilizes a strict given constraint ordering during the 
;; search process and enforces the implied variable ordering as a sideeffect.
;; After further study and analysis we determined that this is too simplistic
;; an interpretation of Quilici's approach ... see memory-csp for the
;; more representative two phase (index and resolution) approach.  However, 
;; this methodology can be useful for modelling particular orderings based 
;; on constraints only.

(defun quilici-search ( varset
			cset
			&optional (debug-q *debug-q*)
			) 
" Reimplementation of overall strategy using a specific constraint driven
  approach and an open list of current boundary states which represent
  partial solutions still in consideration.  Quilici as the source, this
  particular algorithm is used in a joint paper."

 (if (null varset)
     nil
   (let* ( 
	  (curv (caar varset))
	  (domv (cdar varset))
	  (initial-open '())
	  (open 
	   (dolist (d domv initial-open)
		   (setq initial-open 
			 (append initial-open (list (list (list curv d)) )))) )
	  (varset (cdr varset))
	  )

     (setq *internal-start-time* (get-internal-run-time))

     (loop while (not (null cset)) do
	   (let* (
		  (curc    (first cset))
		  (cparam  (get-affected-list curc))
		  (curv1   (first cparam))
		  (curv2   (second cparam))
		  (unboundv1  (memberv2 curv1 varset))
		  (unboundv2  (memberv2 curv2 varset))
		  )

	     (if (and (not unboundv1) (not unboundv2))   ;; both v bound
		 (setq open (reviseOpen open curc))
	       (if (and unboundv1 unboundv2)
		   (progn
		     (comment "ERROR1: both vars unbound ... VAR ORDER ERROR")
		     (comment1 "unboundv1   :" unboundv1)
		     (comment1 "unboundv2   :" unboundv2)
		     (comment2 "curv1 curv2 :" curv1 curv2)
		     (comment1 "varset      :" varset)
		     (comment1 "curc        :" curc)
		     (comment1 "open        :" open)
		     (setq open 'ERROR1)
		     (return-from quilici-search 'error)
		     )
		 (if unboundv2                             ;; v1 bound, v2 unb
		     (progn
		       (setq open 
			     (isrtReviseOpen-1 open curc unboundv2 curv1)) 
		       (setq varset (remove-var curv2 varset))
		       )
		   (if unboundv1                           ;; v2 bound, v1 unb
		       (progn
			 (setq open 
			       (isrtReviseOpen-2 open curc unboundv1 curv2)) 
			 (setq varset (remove-var curv1 varset))
			 )))))


	     ;; check CPU limit bound, exit if exceeded
	     (if (> (- (get-internal-run-time) *internal-advance-start-time*)
		    (* *cpu-sec-limit* internal-time-units-per-second) )
		 (progn
		   (comment1 "Time limit bound exceeded" *cpu-sec-limit*)
		   (setq *internal-end-time* (get-internal-run-time))
		   (show-solution 
		    :solution-set open 
		    :exit-location 'time-bound-exceeded)
		   (return-from quilici-search 'time-bound)
		   ))

	     ;; check CPU checkpoint bound, output when encountered ...
	     (if (> (- (get-internal-run-time) *internal-advance-start-time*)
		    (* *this-check-point* internal-time-units-per-second) )
		 (progn
		   (comment1 "Checkpoint ..." *this-check-point*)
		   (setq *internal-end-time* (get-internal-run-time))
		   (show-solution 
		    :solution-set open 
		    :exit-location 'CHECKPOINT)
		   (setq *this-check-point* (+ *this-check-point* 
					       *check-point-interval*))
		   )) 

	     ;; loop for next constraint
	     (setq cset  (cdr cset))

	     (if debug-q
		 (progn
		   (comment " --------------------- ")
		   (comment1 "Done curc    : " curc)
		   (comment1 "Open is      : " open)
		   (comment1 "Remain cset : " cset)))
	     ))

     ;; solutions are now in open list if they exist else none.

     (setq *internal-end-time* (get-internal-run-time))
     (setq *solution-set* open)

     (show-solution 
      :solution-set *solution-set* 
      :exit-location 'null-parent-state)
     )))

(defun reviseOpen ( open curc )
" Remove any elements of open that fail for constraint curc "
  (remove-if #'(lambda (this) 
		 (let* (
			(cparam (get-affected-list curc))
			(cv1    (first cparam))
			(cv2    (second cparam))
			(val1   (getvalPS cv1 this))
			(val2   (getvalPS cv2 this))
			)
		   (eq (car 
			(test-constraint-1 cv1 val1 cv2 val2 this curc)) 
		       nil))) 
	     open ))

(defun isrtReviseOpen-1 ( open curc v2dom v1b )
"Extend open w/ all values of v2 that are consistent with bound v1 and curc" 
(if (null open)
    '()
  (let* (
	 (this (car open))
	 (rest (cdr open))
	 (val1 (getvalPS v1b this))
	 (newopen '())
	 (v2u  (car v2dom))
	 )
    (dolist (d2 (cdr v2dom) newopen)
	    (if (eq (car (test-constraint-1 v1b val1 v2u d2 this curc)) t)
		(progn
		  (setq *backtrack-nodes-created* 
			(+ 1 *backtrack-nodes-created*))
		  (setq newopen (cons (cons (list v2u d2) this)
				      newopen))
		  )
	      ))

    (append newopen (isrtReviseOpen-1 rest curc v2dom v1b)) )))

(defun isrtReviseOpen-2 ( open curc v1dom v2b )
"Extend open w/ all values of v1 that are consistent with bound v2 and curc" 
(if (null open)
    '()
  (let* (
	 (this (car open))
	 (rest (cdr open))
	 (val2 (getvalPS v2b this))
	 (newopen '())
	 (v1u  (car v1dom))
	 )
    (dolist (d1 (cdr v1dom) newopen)
	    (if (eq (car (test-constraint-1 v1u d1 v2b val2 this curc)) t)
		(progn
		  (setq *backtrack-nodes-created* 
			(+ 1 *backtrack-nodes-created*))
		(setq newopen (cons (cons (list v1u d1) this)
				    newopen))
		)
	      ))
    (append newopen (isrtReviseOpen-2 rest curc v1dom v2b)) )))


;; AUX Functions

(defun memberv2 (var varset)
  (let (
	(res (memberv var varset))
	)
    (if res
	(cons var res)
      res)))

(defun memberv (var varset)
" return range of variable if in varset, nil else "
  (if (null varset)
      nil
    (if (equal var (caar varset))
	(cdar varset)
      (memberv var (cdr varset)))))

(defun remove-var (var varset)
" return varset with var entry removed "
  (remove-if #'(lambda (x) (equal var (car x))) varset))

(defun getvalPS (var part-soln)
" return variable value in partial solution set "
  (if (null part-soln)
      nil
    (if (eq var (first (car part-soln)))
	(second (car part-soln))
      (getvalPS var (cdr part-soln)) )))

(defun quilici-advance-var-sort (varset)
" Quilici variable ordering in advance - need only be done once to
  get key index to front ... may not be required if order is ok initally"

  ;; (comment "Warning, quilici-advance-var-sort currently INACTIVE.")

  varset)

(defun quilici-advance-constr-sort (cset)
" Quilici constraint ordering as required "
  (comment "Warning, quilici-advance-constr sort currently INACTIVE.")

  cset)
      

	      
