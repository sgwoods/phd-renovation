(in-package #:phd-qcsp3)
;; bm.lisp (global use of arrays, vectors VERSION)

;; *variables*       ( (var1 dom1 dom2 ... domn) 
;;                     (var2 dom1 dom2 ... domn) ... )
;;  note order inherent

;; U    is level of search, identifies variable  integer
;; F[U] is current assignment to variable U      ( (var1 nil) (var2 nil) .... )
;;
;; Mark is array      n * m  (n: num variables, m: size of domain of var[i])
;;
;;             m (dom values) ->  m[k]
;;             d1   d2   d3    d4
;;
;;     n  v1   a1   b1   c1    x1
;; (vars) v2   a2   b2   c2    x2
;;        v3   a3   b3   c3    x3
;;        v4   a4   b4   c4    x4
;;
;;  ( (v1 (d1 a1) (d2 b1) (d3 c1) (d4 x1))   
;;    (v2 (d1 a2) (d2 b2) (d3 c2) (d4 x2))   
;;    (v3 (d1 a3) (d2 b3) (d3 c3) (d4 x3))   
;;    (v4 (d1 a4) (d2 b4) (d3 c4) (d4 x4)) )
;;
;; LowUnit is vector  1 * n
;;
;;    n(vars)
;;    v1     v2     v3      v4 ...
;;
;;   ((v1 x1)(v2 x2)(v3 x3)(v4 x4) ... )


;; ***************************************************************************
;; NOTE need to add control flags as per bt yet.  one-solution-only, etc
;;  also add hybrid functionality too... can use only the globals for control
;;  but this is not consistent with the bt.lisp file.
;;
;; along with AC addition, dont forget to add sch heuristic also
;; ***************************************************************************

(defun bm ( variables-list &optional (consistent-p #'consistent-p) )
  (let (
	(U        1)
	(F        (create-initial-F   variables-list))
	(Mark1    (create-initial-mcl variables-list))
	(LowUnit1 (create-initial-mbl variables-list))
	)

    (setq *variables*  variables-list)

    (princ "Warning! AC and SCH not supported yet in BackMark") (terpri)

    ;; emergency exit from recursive backmarking when set
    (setq *exit-backmark-now* nil)

    (setq *internal-start-time* (get-internal-run-time))

    (setq Mark Mark1)
    (setq LowUnit LowUnit1)

    (backmark U F consistent-p ) 

    (setq *internal-end-time* (get-internal-run-time))
    (show-solution 
     :solution-set *solution-set* 
     :exit-location 'done-backmark)

    (if *exit-backmark-now*
	(if (> length *solution-set* 0) t :error)
      :complete)
    ))

(defun backmark ( U F consistent-p )

  (if *debug* (show-bm-bt-state U F *backtrack-nodes-created*))
  (if *debug-consis*
      (progn
	(comment  "--------------------")
	(comment1 "> BACKTRACK POINT <" *backtrack-nodes-created*)
	(comment3 "  Symbol, Domain Partial"  
		  (get_U U) (get-domain U) (simplify_F F U) )
	(comment  "--------------------")
	))

  ;; check CPU limit bound, exit if exceeded
  (if (> (- (get-internal-run-time) *internal-advance-start-time*)
	 (* *cpu-sec-limit* internal-time-units-per-second) )
      (progn
	(comment1 "Time limit bound exceeded" *cpu-sec-limit*)
	(show-solution 
	 :solution-set *solution-set* 
	 :exit-location 'time-bound-exceeded)
	(return-from backmark nil)
	))

  ;; check CPU checkpoint bound, output when encountered ...
  (if (> (- (get-internal-run-time) *internal-advance-start-time*)
	 (* *this-check-point* internal-time-units-per-second) )
      (progn
	(comment1 "Checkpoint ..." *this-check-point*)
	(show-solution 
	 :solution-set *solution-set* 
	 :exit-location 'CHECKPOINT)
	(setq *this-check-point* (+ *this-check-point* 
				    *check-point-interval*))
	))

  (dolist (F_U (get-domain U))

    (setq *nodes-visited* (+ 1 *nodes-visited*))
    (if *debug* (show-bm-visit-state U
				     F_U 
				     (simplify_F F U)
				     Mark LowUnit *nodes-visited*))
;;    (if *debug-consis* 
;;	(progn
;;	  (comment1s ">>>>>> Node " *nodes-visited*)
;;	  (comment3 "Current: symbol, value, partial" 
;;		    (get_U U) F_U (simplify_F F U))))

    (set-F F U F_U)

    ;; Type *A* savings if this block is avoided
    (if (>= (get-Mark Mark U F_U) (get-LowUnit LowUnit U ))
	(let (
	      (testflag t)
	      (i        (get-LowUnit LowUnit U))
	      )

	  (setq *val-ret* 0)
	  ;; Type *B* savings if i > 1
	  (if (> i 1) 
	      (progn
		(if *debug* (comment1 "Type-B Savings, i=" i))
		(setq *type-b-savings* (1+ *type-b-savings*)
		      )))

	  (loop while (< i U) do
		(let* (
		       (testlist (consistent-p  (get_U i)
						(get-F F i)
						(get_U U)
						F_U
						(simplify_F F U))) 
		       (testresult (first testlist))
		       (testval    (second testlist))
		       )
		  (setf testflag testresult)
		  (setq *val-ret* testval)
		  
		  (if *debug* 
		      (progn (comment4 "consistent-ck" 
				       (get_U i) (get-F F i) (get_U U) F_U)
			     (comment1 "result" testflag) ))

		  (if (not testflag)
		      (progn
			(if *debug* 
			    (comment1 "EXITING with failed consis, i" i))
			(loop-finish)))

		  (setf i (1+ i)) )) ; loop

	  (if *debug* 
	      (progn (comment3 "Set Mark (U F_U) to i" U F_U i)
		     (comment2 " Return-val, testflag" *val-ret* testflag) ))

	  (setf Mark (set-Mark1 Mark U F_U i))

	  (if testflag
	      (if (< U *Number-Of-Units*)  ;; more variables to instantiate
		  (progn 
		    (setq *backtrack-nodes-created* 
			  (+ 1 *backtrack-nodes-created*))
		    (backmark (1+ U) F consistent-p)

		    ;; one solution, emergency exit from recursion
		    (if *exit-backmark-now* (return-from backmark t))
		    )
		(progn    ;; a solution found
		  (if (or *debug* *debug-consis*)
		      (comment1 "**** Solution Found ****" F))
		  (setq *solution-set* (append *solution-set* 
					       (list (copy-list F))))

		  ;; exit if one solution only required, set exit flag
		  (if *one-solution-only* 
		      (progn
			(setq *exit-backmark-now* t)
			(return-from backmark t) ))
		  )))
	  )
      (progn
	(if *debug* 
	    (comment2 "Type-A Savings A < B" 
		     (get-Mark Mark U F_U) (get-LowUnit LowUnit U)))
	(setq *type-a-savings* (1+ *type-a-savings*)) )
      ))

  (setf LowUnit (set-LowUnit LowUnit U (1- U)))
  (loop as i from (1+ U) to *Number-Of-Units* do
	(setf LowUnit (set-LowUnit LowUnit i 
				   (min (get-LowUnit LowUnit i) (1- U))))) 
  )

;; ----------------------------------------************
;; Utility functions
;; ----------------------------------------************

;; --------------------------------------------------
(defun get-domain (U)
"
Return the list of domain values applicable to variable_U.
"
(lookup-domain (get_U U) *variables*) )

(defun lookup-domain (U variables)
  (if (null variables)
      nil
    (let* (
	   (this     (car variables))
	   (rest     (cdr variables))
	   (this-id  (first this))
	   (this-dom (rest this))
	  )
      (if (eq U this-id)
	  this-dom
	(lookup-domain U rest)))))

;; --------------------------------------------------      
(defun get-F (F U)
"
Assignments.
Return the value of list F for variable_U, indicating the current 
instantiation of variable_U.
"
(second (nth (1- U) F)) )

(defun set-F (F U F_U)
"Assignment.
Destructively assign the value F_U to variable_U in list F.
"
(setf (nth (1- U) F) (list (get_U U) F_U)) )

(defun get_U (U)
"
Get variable identifier from U value.
"
(first (nth (1- U) *variables*)) )

;; --------------------------------------------------      
(defun get-Mark (Mark U F_U)
"
Mark array.
Return the value of array Mark for variable_U, instantiation F_U.
"
(get-sit-val (cdr (nth (1- U) Mark)) F_U) )

(defun get-sit-val (vec inst)
  (second (find-if #'(lambda (x) (eq (car x) inst)) vec)))

(defun set-Mark1 (Mark U F_U i)
"
Mark array.
Return new array value.
"
 (set-array-val Mark (get_U U) F_U i) )

(defun set-array-val (array index1 index2 val)
  (if (null array)
      nil
    (let* (
	   (vec (first array))
	   )
      (if (equal (car vec) index1)
	  (append
	   (list (cons index1 (set-vector-val (cdr vec) index2 val)))
	   (set-array-val (cdr array) index1 index2 val))
	(cons vec
	      (set-array-val (cdr array) index1 index2 val))))))

(defun set-vector-val (vec index val)
"
Set vector element in list to new val.  Note this must be changed to be more
 than an entire recursion function.
"
  (if (null vec)
      nil
    (if (equal (first (car vec)) index)
	(append
	 (list (list index val))
	 (set-vector-val (cdr vec) index val))
      (append
       (list (car vec))
       (set-vector-val (cdr vec) index val)))))

;; --------------------------------------------------      
(defun get-LowUnit (LowUnit U)
"
LowUnit vector.
Return the value of vector LowUnit for variable_U.
"
(second (nth (1- U) LowUnit)) )

(defun set-LowUnit (LowUnit U val)
"
LowUnit vector.
Return new vector value.
"
  (set-vector-val LowUnit (get_U U) val))

;; --------------------------------------------------      
(defun create-initial-mcl (var-list)
 (if (null var-list) 
     nil
   (let* (
	  (this (car var-list))
	  (rest (cdr var-list))
	  (var  (first this))
	  (dom  (cdr this))
	  )
     (append (list (cons var (init-mcl-dom dom)))
	     (create-initial-mcl rest)))))

(defun init-mcl-dom (dom)
  (if (null dom)
      nil
    (let (
	  (this (car dom))
	  (rest (cdr dom))
	  )
    (append (list (list this 1))
	    (init-mcl-dom rest)))))
	  
;; --------------------------------------------------      
(defun create-initial-mbl (var-list)
  (if (null var-list)
      nil
    (let* (
	   (this (car var-list))
	   (rest (cdr var-list))
	   (var  (first this))
	   )
      (append (list (list var 1))
	      (create-initial-mbl rest)))))


;; --------------------------------------------------      
(defun create-initial-F (var-list)
  (if (null var-list)
      nil
    (let* (
	   (this (car var-list))
	   (rest (cdr var-list))
	   (var  (first this))
	   )
      (append (list (list var nil))
	      (create-initial-F rest)))))

;; --------------------------------------------------      
(defun make-part-sol (F)
  (if (null F)
      nil
    (let* (
	   (this (car F))
	   (rest (cdr F))
	   (val  (second this))
	   )
      (if (not (null val))
	  (cons this
		(make-part-sol rest))
	(make-part-sol rest)) )))

;; --------------------------------------------------

(defun simplify_F (F U)
  (let (
	(n (length F))
	)
    (reverse (nthcdr (- n (1- U)) (reverse F))) ))
