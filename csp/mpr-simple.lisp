(in-package #:phd-csp)
;; mpr-simple.lisp
;;
;;  Model Pattern Recognition Domain for CSP Experimentation
;; 
;;               Steven Woods
;;               Defense Research Establishment Valcartier
;;               March, 1993
;;

(defun mpr (&key
	    (situation-id       "test-1") 
	    (sit-noise                 0)
	    (template-id       "test1-w")  
	    (dom (list 'mpr situation-id template-id))
	    (search-mode            "bt")  ;; backTRACK/JUMP/MARK bt bj bm
	    (node-consis               t)  ;; make node consis before search
	    (node-force-all          nil)  ;; for each dom val try all const
	    (arc-consis              nil)  ;; arc consistency before/during/nil
	    (sch-call                nil)  ;; spatial cohesion reduction 
	    (rand-dist           "ddist")  ;; dist of random element attributes
	    (forward-checking        nil)  ;; simple dom red on cur inst
	    (dynamic-rearrangement   nil)  ;; dyn var inst order
	    (advance-sort        'random)  ;; variable instantiation order     
	    (sort-const          'random)  ;; constraint application order
	    (one-solution-only       nil)  ;; quit after one found
	    (cpu-sec-limit           600)  ;; 10 minutes cpu
	    (ck-pt-interval          150)  ;;  2 minutes cpu
	    (debug                   nil)  ;; debug search
	    (debug-csp               nil)  ;; debug constraint application
	    (random-ident       'default)  ;; optional random identifier
	    (output-file             nil)  ;; write output to
	    (long-output             nil)  ;; force LONG output explanation
	    (single-line-override    nil)  ;; overrides other out, 1 line only
	    )
"
Example program to solve the MPR problem.  Takes no required args, but
it is assumed we will use the default situation and template values.
"

(setq *check* 1)

;; re-load mpr-setup constants
(load "mpr-setup")

;; ensure MPR functions are loaded (domain switching)
;; arc-p consistent-p
(if (not (eq *domain-loaded* 'mpr))
    (progn
      (load "mpr-simple")
      (load "mpr-setup")))

(setq *test* situation-id)

;; Establish random object either from file as indicated, or create new one
;;   unique  indicates create a unique one
;;   default indicates to utilize the one stored as RndDefault
;;   string  indicates to utilize the one stored as RndString
(if (string-equal random-ident "unique")
    (progn
      (setq random-ident (unique-string))
      (setq *random-state* (make-random-state t))
      (save-rand random-ident))
  (if (string-equal random-ident "default")
      (progn
	(load-rand "default"))
    (load-rand random-ident)))

;; Establish initial mpr world situations
;;  Note that random insertion of noise will occur identically for the same
;;  random state, so a particular test case can be re-created as required.  
;; Since Lucid does not let you use a user generated "seed", we save the seed
;;  objects in the Random subdirectory for later retrieval and restoration.
(if (not (mpr-set-global-values situation-id sit-noise 
				random-ident template-id 
 				sch-call rand-dist
				(get-dist rand-dist)
				long-output
				single-line-override
				))

    (progn
      (comment "Exiting with a MPR setup error.")
      (return-from mpr nil))
  (progn
    (save-situation random-ident sit-noise)
    (save-gnuplot   random-ident sit-noise)
    ))


(setq *check* 3)
;; set up global variables
(if (not (set-globals (mpr-variables)
		      dom 
		      search-mode 
		      node-consis 
		      node-force-all 
		      arc-consis
		      forward-checking 
		      dynamic-rearrangement 
		      advance-sort
		      sort-const
		      one-solution-only 
		      cpu-sec-limit 
		      ck-pt-interval
		      debug 
		      debug-csp 
		      output-file))
    (progn
      (comment "Exiting with a general setup error.")
      (return-from mpr nil)))

;; Show set up options
(show-options)

(let
    (
     (init-var-set   *raw-variables*)              ;; raw backtrack values
     (arc-call       (if (or (eq arc-consis 'during)
			     (eq arc-consis 'both))
			 t nil))
     (arc-pre        (if (or (eq arc-consis 'before)
			     (eq arc-consis 'both))
			 t nil))
     )

  (var-set-characterize init-var-set 'initial)

  ;; Time advance constraint processing time
  (setq *internal-advance-start-time* (get-internal-run-time))

  (cond

   ((and node-consis arc-pre)
    (setq init-var-set 
	  (ac-3 (node-consistent-variables init-var-set 
					   :force node-force-all)
		#'arc-p #'consistent-p nil)) 
    (var-set-characterize init-var-set 'ac3-node )
    (setq *arc-constraint-fail* *constraint-fail*)
    (setq *constraint-fail* nil) )

   (node-consis
    (setq init-var-set (node-consistent-variables init-var-set 
						  :force node-force-all)) 
    (var-set-characterize init-var-set 'node ) )
   
   (arc-pre
    (setq init-var-set (ac-3 init-var-set
			     #'arc-p #'consistent-p nil))
    (var-set-characterize init-var-set 'ac3)
    (setq *arc-constraint-fail* *constraint-fail*)
    (setq *constraint-fail* nil) )

   ) ;; cond

  ;; Advance constraint processing completed.
  (setq *internal-advance-end-time*   (get-internal-run-time))

  ;; If advance sort requested of variable list, do so here
  (if advance-sort
      (if (eq advance-sort 'random)
	  ;; random ordering
	  (progn
	    (setq init-var-set (random-order init-var-set)) )
	;; advance-sort ordering by heuristic 
	(progn
	  (setq *internal-sort-start-time* (get-internal-run-time))
	  (setq init-var-set (advance-sort init-var-set))
	  (setq *internal-sort-end-time* (get-internal-run-time)) )
	))

  ;; record problem for later use in global lookups, etc
  ;; NOTE the entire generated problem could be used later instead of
  ;;  expending time recreating the same problem next time.
  (setq *variables* init-var-set)
  (setq *var-order* (mapcar #'(lambda (x) (first x)) init-var-set))
  (setq *var-order-note* 'redone)

  ;; Invoke search, call backtracking for BT/BJ or backmark for BM
  (cond 
   ((or (equal search-mode "bt") (equal search-mode "bj"))
    ;; Invoke backtracking
    (backtracking 
     (make-initial-bt-state init-var-set)
     #'consistent-p
     :forward-checking      forward-checking
     :dynamic-rearrangement dynamic-rearrangement
     :backjump              (if (equal search-mode "bj") t nil)
     :one-solution-only     one-solution-only
     :arc-c                 arc-call
     :sch-c                 sch-call
     ))
   ((equal search-mode "bm")
    (bm init-var-set #'consistent-p))
   (t
    (comment1 "Error in search-mode value" search-mode))
   )))

;; **************************************************
;; mpr variables
;;  part 1 of create initial state from defined objects

(defun mpr-variables ( &optional (template *current-template*) )
  (let (
	(allvalues (get-sit-ids))
	(varlist nil)
	)
    (dolist ( templ-slot (get-templ-slots template) varlist )
      (setq varlist 
	    (append
	     varlist
	     (list
	      (cons
	       (get-templ-id templ-slot)
	       allvalues))))
      )))


;; **************************************************
;; Apply node consistency checks to a set of assignments
;;
(defun node-consistent-variables (variable-list &key (force nil) )
"
Accept domain variable list, return the list in node 
 consistent form only.  This dramatically reduces search
 in a single pass.
"
(let (
      (newvarlist nil)
      )
  (dolist (node variable-list newvarlist)
    (setq newvarlist 
	  (append 
	   newvarlist
	   (list (node-consistent-one-node node :force force)) ))
    )))
     

(defun node-consistent-one-node ( node &key (force nil) )
"
Accept a node defined by a variable and its domain and return that node
 with the domain filtered by applying the node consistency check to 
 each possible domain value.
 node = (slot sit1 sit2 ... sitn)
"
(let (
      (variable (car node))
      (domain   (cdr node))
      (newnode  (list (car node)))
      )
  (dolist (domval domain newnode)
    (if (node-consistent-p variable domval :force force)
	(setq newnode 
	      (append newnode (list domval) )) ))
  ))


;; **************************************************
;; Node consistency checks
;;
;; note  Template slot ids are variables
;;       Sit object    ids are domain values

(defun node-consistent-p (tslot-id sit-obj-id &key (force nil) )
"
 Does this sit-obj id pass the constraints for tslot ?  This is used in initial
 domain assigment to each template slot.
 Note "force" forces the computation of ALL node arcs, default is only
 until a fail is found.
 This is the MPR version.  
"
(let (
      (sit-obj (get-sit-object     sit-obj-id))
      (tslot   (get-templ-slot-object *current-template* tslot-id))
      )

(setq *node-consistency-calls* (+ 1 *node-consistency-calls*))

(if force

    ;; Compute all node arc checks

    (let (
	  (match-type     (ts-matches-type        tslot sit-obj))
	  (match-size     (ts-matches-size        tslot sit-obj))
	  (match-activity (ts-matches-activity    tslot sit-obj))
	  (match-orient   (ts-matches-orientation tslot sit-obj))
	  (match-abs-loc  (ts-matches-abs-loc     tslot sit-obj))
	  )

      ;; Can record the reasoning for node-consistency decision here.
      ;; later, could relax these selectively.
      (princ "Warning: dumb NC checking") (terpri)

      (record-node-fail tslot-id sit-obj-id 
			match-type 
			match-size
			match-activity 
			match-orient 
			match-abs-loc )

      (if (and match-type match-size match-activity 
	       match-orient match-abs-loc)
	  t
	nil))

  ;; Compute only as many as required to fail once, 
  ;; record where failure occurred
  ;;  note that the order is important and will affect performance ...

  (if (ts-matches-type        tslot sit-obj)
      (if (ts-matches-size      tslot sit-obj)
	  (if (ts-matches-activity    tslot sit-obj)
	      (if (ts-matches-orientation tslot sit-obj)
		  (if (ts-matches-abs-loc     tslot sit-obj)
		      (progn
			(record-node-fail tslot-id sit-obj-id t t t t t)
			t)
		    (progn
		      (record-node-fail tslot-id sit-obj-id t t t t nil)
		      t))
		(progn
		  (record-node-fail tslot-id sit-obj-id t t t nil '?)
		  nil))
	    (progn
	      (record-node-fail tslot-id sit-obj-id t t nil '? '?)
	      nil))
	(progn
	  (record-node-fail tslot-id sit-obj-id t nil '? '? '?)
	  nil))
    (progn
      (record-node-fail tslot-id sit-obj-id nil '? '? '? '?)
      nil))
  )))

;; **************************************************
;; Arc presence check

(defun arc-p (symbol1 symbol2)
"
 Return true if there is an arc between symbol1 and symbol2.
 This is the MPR version.
"
(if (member 't  
	    (mapcar #'(lambda (x) (member-both-p symbol1 symbol2 x))
		    (mapcar 'second (get-templ-constraints *current-template*))))
    t nil))

;; **************************************************
;; Arc consistency check
;;
;; note  Template slot ids are variables
;;       Sit object ids    are domain values
;;       partial solution  is all present variable instantiations
;;                         used only for n-ary constraints

(defun consistent-p (ts1 sit1 ts2 sit2 partial-solution 
			 &key (sort-const *sort-const*) )
" 
Is this sit-object to templ-slot assignment consistent with respect to 
all arc constraints in the curent template between ts1 and ts2. 
Note that the partial solution blist is only required for the case where
we are talking about n-ary constraints, such as the medial constraint.
"
  (setq *consistent-p-calls* (+ 1 *consistent-p-calls*))

    (if *debug-consis* 
	(comment5 "Consistent-p <ts1 sit1 ts2 sit2 partial-sol> ?"
		    ts1 sit1 ts2 sit2 partial-solution))

  ;; hard wired constraint that no two slots may have the same
  ;;  variable assignment ts(i) =/= ts(j) placed here for efficiency
  ;;  purposes.
  (if (equal sit1 sit2)
      (progn
	(setq *unique-restrict-count* (+ 1 *unique-restrict-count*))
	(if *debug-consis* (comment3 "Restricted unique for" sit1 sit2 nil))
	(let (
	      (cons-level (get-constraint-max-level 
			   (list 'unique (list ts1 ts2))  ts1))
	      )
	  (return-from consistent-p (list nil cons-level)) )))

  (let (
	;; Note some constraints are N-ary ie 3-ary (ts1 ts2 ts3)
	;;  we must be careful with *smart* backtracking methods in these 
	;; cases, this condition is also discussed under "BJ" in bt.lisp.
	;;  
	;;  if we are comparing a constraint C_v_k between the CURRENT level
	;; _v and some other previous level _k, an n-ary constraint is
	;; considered to be a constraint at C_v_(max affect_list), where 
	;; affect_list is the list of levels of parameters for the constraint
	;; in question, less the CURRENT level.  For example,  if we are 
	;; currently at level 4 (v4), and a particular 3-ary constraint exists 
	;; involving v4, (and v1 and v2), then this is considered a 
	;; constraint between v4 and v3 (max of v1 and v2).  In this way, 
	;; we can avoid repetitions for constraint checks done until 
	;; we backtrack past v2.  Ie if this
	;; 3-ary constraint failed for v1=1 v2=2 v3=x v4=5, then it will also
	;; fail for this v4, and any other values of v3... ie until we 
	;; backtrack to v2.

	(constraint-set (get-related-constraints *current-template* ts1 ts2) )
	;; Note binding list only possess current selected values
	(blist          partial-solution)
	)

    ;; if no applicable arc constraints, assignment okay by default.
    (if (null constraint-set) 
	(progn
	  (setq *consistent-null-arcs* (+ 1 *consistent-null-arcs*))
	  (if *debug-consis* (comment1 "No arc constraints" t))
	  (list 't 0))

      ;; else constraints exist ...
      (if sort-const
	  (consistent-all ts1 sit1 ts2 sit2 blist 
			  (sort-constr constraint-set sort-const))
	(consistent-all ts1 sit1 ts2 sit2 blist 
			(sort-constraint-list constraint-set)) ))))

(defun sort-constr (constraint-set sort-const)
"Heuristically or randomly sort constraint set.  Current random only."
  (if (eq sort-const 'random)
      (random-order constraint-set)
    constraint-set))

;; **************************************************
;;
(defun get-constraint-max-level (constraint ck-var)
"
MPR version.
"
  (let (
	(levels 
	 (mapcar #'(lambda (x) (list-element-pos *var-order* x))
	       (remove ck-var (get-affected-list constraint))) )
	)
    (apply 'max levels) ))

;; **************************************************
;;
(defun sort-constraint-list (constraint-list)
"
A sort will affect the perform of the MPR.  We would wish to put constraints 
more likely to fail FIRST in the list, thus way avoiding the checking of arc
constraints that usually succeed.  We must balance this with the list sorting 
cost, and also keeping in mind that the *best* order for a particular pair of
template slots may be difficult (?) to determine... more work required here.
"
constraint-list
)

;; **************************************************
;;
(defun consistent-all (ts1 s1 ts2 s2 blist cs)
"
 Check entire set of constraints for this pair of bindings.
 If ANY constraint fails, return (FALSE failure-level), else return (TRUE 0).
"
  (if (null cs)
      (list 't 0)
    (let* (
	   (result-all (test-constraint-1 ts1 s1 ts2 s2 blist (car cs))  )
	   (result     (first  result-all))
	   (level      (second result-all))
	  )
      (if result
	  (consistent-all  ts1 s1 ts2 s2 blist (cdr cs))
	(list nil level) )) ))


;; **************************************************
;;
(defun test-constraint-1 (ts1 s1 ts2 s2 blist constraint)
"
 Does this single constraint hold for the assignment of
 s1 to ts1 and s2 to ts2 ?
   blist       binding list / partial solution
               USED ONLY FOR MULTIPLE >2 VARIABLE CONSTRAINTS
   ts1         first template slot (variable)
   s1          domain value assigned to first template slot
   ts2         second template slot (variable)
   s2          domain value assigned to second template slot
   constraint  the constraint to test for holding
"
(if  *debug-consis*
    (progn (comment1 "  Constraint :" constraint)
	   (comment4 "  (TS1 S1) (TS2 S2)" ts1 s1 ts2 s2)))

(let (
      (cons-level (get-constraint-max-level constraint ts1))
      (result (test-constraint-2 ts1 s1 ts2 s2 blist constraint))
      )
  (list result cons-level) ))

(defun test-constraint-2 (ts1 s1 ts2 s2 blist constraint)
"
"
(let (
      (cons-type  (get-constraint-type      constraint))
      )

  (cond   ;; Constraint type

   ;; Uniqueness constraint (not impl here)
   ;;  TS(i) = S(j) => for all TS other than TS(i), TS(i) =/= S(j).
   ;;  ... it could fit here though for n^2 constraints additionally !
   ;; ((eq (get-constraint-type constraint 'unique))
   ;;  (if (eq s1 s2)
   ;;      nil
   ;;    t))
   ;;
   ;; see fn consistent-p, where this has been implemented "hard-wired"

   ;; Spatial Separation constraint
   ((eq cons-type 'sep)

    (let (
	  (dist (distance-between s1 s2))
	  (minimum (get-nth-param 1 (get-parameter-list constraint) ))
	  (maximum (get-nth-param 2 (get-parameter-list constraint) ))
	  )
      (setq *constraint-cks* (+ 1 *constraint-cks*))
      (if  *debug-consis* (comment1 " " *constraint-cks*))
      (setq *constraint-sep-cks* (+ 1 *constraint-sep-cks*))
      
      (if (and 
	   (>= dist minimum)    ;; greater than minimum separation
	   (<= dist maximum))   ;; less than maximum sepration
	  (progn
	    (if  *debug-consis* (comment2 "Separation succeed for" s1 s2))
	    t)
	(progn
	  (if  *debug-consis* (comment2 "Separation fail for" s1 s2))
	  (record-fail ts1 s1 ts2 s2 constraint)
	  nil)
	)))

   ;; Same attribute Type
   ((eq cons-type 'same-attr-type)
    
    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-same-type-cks* (+ 1 *constraint-same-type-cks*))

    (let (
	  (s1-type (get-sit-obj-type s1))
	  (s2-type (get-sit-obj-type s2))
	  )
    
      (if (equal s1-type s2-type)
	  (progn
	    (if  *debug-consis* (comment2 "Same attr type succeed for" s1 s2))
	    t)
	(progn
	  (if  *debug-consis* (comment2 "Same attr type fail for" s1 s2))
	  (record-fail ts1 s1 ts2 s2 constraint)
	  nil)
	)))

   ;; Same attribute Orient
   ((eq cons-type 'same-attr-orient)

  (setq *constraint-cks* (+ 1 *constraint-cks*))
  (if  *debug-consis* (comment1 " " *constraint-cks*))
  (setq *constraint-same-orient-cks* (+ 1 *constraint-same-orient-cks*))

  (let (
	(s1-orient (get-sit-obj-orient s1))
	(s2-orient (get-sit-obj-orient s2))
	)
    
    (if (equal s1-orient s2-orient)
	(progn
	  (if  *debug-consis* (comment2 "Same attr orient succeed for" s1 s2))
	  t)
      (progn
	(if  *debug-consis* (comment2 "Same attr orient fail for" s1 s2))
	(record-fail ts1 s1 ts2 s2 constraint)
	nil)
      )))

 ;; Same attribute Activity
 ((eq cons-type 'same-attr-activity)

  (setq *constraint-cks* (+ 1 *constraint-cks*))
  (if  *debug-consis* (comment1 " " *constraint-cks*))
  (setq *constraint-same-activity-cks* (+ 1 *constraint-same-activity-cks*))

  (let (
	(s1-activity (get-sit-obj-activity s1))
	(s2-activity (get-sit-obj-activity s2))
	)
    
    (if (equal s1-activity s2-activity)
	(progn
	  (if  *debug-consis* (comment2 "Same attr activity succeed for" s1 s2))
	  t)
      (progn
	(if  *debug-consis* (comment2 "Same attr activity fail for" s1 s2))
	(record-fail ts1 s1 ts2 s2 constraint)
	nil)
      )))

 ;; Same attribute Size
 ((eq cons-type 'same-attr-size)

  (setq *constraint-cks* (+ 1 *constraint-cks*))
  (if  *debug-consis* (comment1 " " *constraint-cks*))
  (setq *constraint-same-size-cks* (+ 1 *constraint-same-size-cks*))

  (let (
	(s1-size (get-sit-obj-size s1))
	(s2-size (get-sit-obj-size s2))
	)
    
    (if (equal s1-size s2-size)
	(progn
	  (if  *debug-consis* (comment2 "Same attr size succeed for" s1 s2))
	  t)
      (progn
	(if  *debug-consis* (comment2 "Same attr size fail for" s1 s2))
	(record-fail ts1 s1 ts2 s2 constraint)
	nil)
      )))

 ;; Echelon constraint
 ;;  A line exists along the direction of movement of param1. is 
 ;;  param 2 within bound of the line ?

 ((eq cons-type 'echelon)

  (setq *constraint-cks* (+ 1 *constraint-cks*))
  (if  *debug-consis* (comment1 " " *constraint-cks*))
  (setq *constraint-ech-cks* (+ 1 *constraint-ech-cks*))
  
  (let* (
	 (affectlist (get-affected-list constraint))
	 (p1        (get-nth-param 1 affectlist))    ;; first  tslot id
	 (p2        (get-nth-param 2 affectlist))    ;; second tslot id
	 (bound     (get-nth-param 1
		     (get-parameter-list constraint)))	 
	 )

    (cond

     ( (and (eq ts1 p1) (eq ts2 p2))
       (if (echelon-bound-p 
	    (get-sit-obj-x s1)
	    (get-sit-obj-y s1)
	    (get-sit-obj-orient s1)
	    (get-sit-obj-x s2)
	    (get-sit-obj-y s2)
	    bound)
	   (progn
	     (if *debug-consis* (comment3 "Echelon succeed for" s1 s2 bound))
	     t)
	 (progn
	   (if *debug-consis* (comment3 "Echelon Fail for" s1 s2 bound))
	   (record-fail ts1 s1 ts2 s2 constraint)
	   nil) ))

     ( (and (eq ts1 p2) (eq ts2 p1))
       (if (echelon-bound-p 
	    (get-sit-obj-x s2)
	    (get-sit-obj-y s2)
	    (get-sit-obj-orient s2)
	    (get-sit-obj-x s1)
	    (get-sit-obj-y s1)
	    bound)
	   (progn
	     (if  *debug-consis* (comment3 "Echelon succeed for" s1 s2 bound))
	     t)
	 (progn
	   (if *debug-consis* (comment3 "Echelon Fail for" s2 s1 bound))
	   (record-fail ts1 s1 ts2 s2 constraint)
	   nil) ))
     (t
      (progn
	(comment "Error in Echelon constraint - parameter order ?")
	nil)) )))

 ;; Medial distance constraint
 ;;  line from param1 to param2, param3 is within bound of the line
 ;;  if any are unbound, constraint is assumed to hold
 ;;  We are given ts1 ts2 which could be any of pA pB pC.

 ((eq cons-type 'med-dist)

  (let* (
	 (affectlist (get-affected-list constraint))
	 (p1        (get-nth-param 1 affectlist))    ;; first  tslot id
	 (p2        (get-nth-param 2 affectlist))    ;; second tslot id
	 (p3        (get-nth-param 3 affectlist))    ;; third  tslot id
	 (bound     (get-nth-param 1
		     (get-parameter-list constraint)))
	 )

    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-med-cks* (+ 1 *constraint-med-cks*))

    (cond
     ;; Case 1/6
     ( (and (equal ts1 p1) (equal ts2 p2))
       (let ( 
	     (sp3 (get-tslot-instant p3 blist)) 
	     )
	 (if (eq sp3 nil)
	     (progn
	       (if  *debug-consis* (comment3 "Medial(1) NIL succeed for" s1 s2 sp3))
	       t)
	   (if (medial-distance-bound-p (get-sit-obj-x s1) (get-sit-obj-y s1)
					(get-sit-obj-x s2) (get-sit-obj-y s2)
					(get-sit-obj-x sp3)
					(get-sit-obj-y sp3) 
					bound)
	       (progn
		 (if  *debug-consis* (comment3 "Medial(1) succeed for" s1 s2 sp3))
		 t)
	     (progn
	       (if  *debug-consis* (comment3 "Medial(1) fail for" s1 s2 sp3))
	       (record-fail ts1 s1 ts2 s2 constraint)
	       nil)))) )

     ;; Case 2/6
     ( (and (equal ts1 p2) (equal ts2 p1))
       (let ( 
	     (sp3 (get-tslot-instant p3 blist)) 
	     )
	 (if (eq sp3 nil)
	     (progn
	       (if  *debug-consis* (comment3 "Medial(2) NIL succeed for" s2 s1 sp3))
	       t)
	   (if (medial-distance-bound-p (get-sit-obj-x s2) (get-sit-obj-y s2)
					(get-sit-obj-x s1) (get-sit-obj-y s1)
					(get-sit-obj-x sp3)
					(get-sit-obj-y sp3) 
					bound)
	       (progn
		 (if  *debug-consis* (comment3 "Medial(2) succeed for" s2 s1 sp3))
		 t)
	     (progn
	       (if  *debug-consis* (comment3 "Medial(2) fail for" s2 s1 sp3))
	       (record-fail ts1 s1 ts2 s2 constraint)
	       nil)))) )       

     ;; Case 3/6
     ( (and (equal ts1 p1) (equal ts2 p3))
       (let (
	     (sp2 (get-tslot-instant p2 blist))
	     )
	 (if (eq sp2 nil)
	     (progn
	       (if *debug-consis* (comment3 "Medial(3) NIL succeed for" s1 sp2 s2))
	       t)
	   (if (medial-distance-bound-p (get-sit-obj-x s1)  (get-sit-obj-y s1)
					(get-sit-obj-x sp2) 
					(get-sit-obj-y sp2)
					(get-sit-obj-x s2)  (get-sit-obj-y s2)
					bound)
	       (progn
		 (if *debug-consis* (comment3 "Medial(3) succeed for" s1 sp2 s2))
		 t)
	     (progn
	       (if *debug-consis* (comment3 "Medial(3) fail for" s1 sp2 s2))
	       (record-fail ts1 s1 ts2 s2 constraint)
	       nil)))) )

     ;; Case 4/6
     ( (and (equal ts1 p3) (equal ts2 p1))
       (let (
	     (sp2 (get-tslot-instant p2 blist))
	     )
	 (if (eq sp2 nil)
	     (progn
	       (if *debug-consis* (comment3 "Medial(4) NIL succeed for" s2 sp2 s1))
	       t)
	   (if (medial-distance-bound-p (get-sit-obj-x s2)  (get-sit-obj-y s2)
					(get-sit-obj-x sp2) 
					(get-sit-obj-y sp2)
					(get-sit-obj-x s1)  (get-sit-obj-y s1)
					bound)
	       (progn
		 (if *debug-consis* (comment3 "Medial(4) succeed for" s2 sp2 s1))
		 t)
	     (progn
	       (if *debug-consis* (comment3 "Medial(4) fail for" s2 sp2 s1))
	       (record-fail ts1 s1 ts2 s2 constraint)
	       nil)))) )

     ;; Case 5/6
     ( (and (equal ts1 p3) (equal ts2 p2))
       (let 
	   (
	    (sp1 (get-tslot-instant p1 blist))
	    )
	 (if (eq sp1 nil)
	     (progn
	       (if *debug-consis* (comment3 "Medial(5) NIL succeed for" sp1 s2 s1))
	       t)
	   (if (medial-distance-bound-p (get-sit-obj-x sp1) 
					(get-sit-obj-y sp1)
					(get-sit-obj-x s2)  (get-sit-obj-y s2)
					(get-sit-obj-x s1)  (get-sit-obj-y s1)
					bound) 
	       (progn
		 (if *debug-consis* (comment3 "Medial(5) succeed for" sp1 s2 s1))
		 t) 
	     (progn
	       (if *debug-consis* (comment3 "Medial(5) fail for" sp1 s2 s1))
	       (record-fail ts1 s1 ts2 s2 constraint)
	       nil)))) )

     ;; Case 6/6
     ( (and (equal ts1 p2) (equal ts2 p3))
       (let 
	   (
	    (sp1 (get-tslot-instant p1 blist))
	    )
	 (if (eq sp1 nil)
	     (progn
	       (if *debug-consis* (comment3 "Medial(6) NIL succeed for" sp1 s1 s2))
	       t)
	   (if (medial-distance-bound-p (get-sit-obj-x sp1) 
					(get-sit-obj-y sp1)
					(get-sit-obj-x s1)  (get-sit-obj-y s1)
					(get-sit-obj-x s2)  (get-sit-obj-y s2)
					bound) 
	       (progn
		 (if *debug-consis* (comment3 "Medial(6) succeed for" sp1 s1 s2))
		 t)
	     (progn
	       (if *debug-consis* (comment3 "Medial(6) fail for" sp1 s1 s2))
	       (record-fail ts1 s1 ts2 s2 constraint)
	       nil)))) )

     ;; Default error case
     (t
       (comment "Error in  medial case statement")
      ))
    ))

 ;; Positional constraints - note they apply to the entire template
 ;;  and do not require that reciprocal ones be specified.
 ;; However, it is crucial the parameter order be resolved correctly 
 ;;  since the following L/R/A/B constraints are directional.

 ;;   s1 right of s2 ?
 ((eq cons-type 'right-of)

  (setq *constraint-cks* (+ 1 *constraint-cks*))
  (if  *debug-consis* (comment1 " " *constraint-cks*))
  (setq *constraint-pos-cks* (+ 1 *constraint-pos-cks*))
  (let* (
	 (affectlist (get-affected-list constraint))
	 (p1        (get-nth-param 1 affectlist))    ;; first  tslot id
	 (p2        (get-nth-param 2 affectlist))    ;; second tslot id
	 )
    (cond 
     ( (and (eq ts1 p1) (eq ts2 p2))
       (if (sit-object-right-of-p s1 s2)
	   (progn
	     (if *debug-consis* (comment2 "Right-of succeed for" s1 s2))
	     t)
	 (progn
	   (if *debug-consis* (comment2 "Right-of failed for" s1 s2))
	   (record-fail ts1 s1 ts2 s2 constraint)
	    nil)) )

     ( (and (eq ts1 p2) (eq ts2 p1))
       (if (sit-object-right-of-p s2 s1)
	   (progn
	     (if *debug-consis* (comment2 "Right-of succeed for" s2 s1))
	     t)
	 (progn
	   (if *debug-consis* (comment2 "Right-of failed for" s2 s1))
	   (record-fail ts1 s1 ts2 s2 constraint)
	    nil)) ) 
     (t
      (comment "Error in parameters of Right-of"))
     )))

 ;;   s1 left of s2 ?
 ((eq cons-type 'left-of)

  (setq *constraint-cks* (+ 1 *constraint-cks*))
  (if  *debug-consis* (comment1 " " *constraint-cks*))
  (setq *constraint-pos-cks* (+ 1 *constraint-pos-cks*))
  (let* (
	 (affectlist (get-affected-list constraint))
	 (p1        (get-nth-param 1 affectlist))    ;; first  tslot id
	 (p2        (get-nth-param 2 affectlist))    ;; second tslot id
	 )
    (cond
     ( (and (eq ts1 p1) (eq ts2 p2))
       (if (sit-object-left-of-p s1 s2)
	   (progn
	     (if *debug-consis* (comment2 "Left-of succeed for" s1 s2))
	     t)
	 (progn
	   (if *debug-consis* (comment2 "Left-of failed for" s1 s2))
	   (record-fail ts1 s1 ts2 s2 constraint)
	   nil)) )
     
     ( (and (eq ts1 p2) (eq ts2 p1))
       (if (sit-object-left-of-p s2 s1)
	   (progn
	     (if *debug-consis* (comment2 "Left-of succeed for" s2 s1))
	     t)
	 (progn
	   (if *debug-consis* (comment2 "Left-of failed for" s2 s1))
	   (record-fail ts1 s1 ts2 s2 constraint)
	   nil)) )
     (t
      (comment "Error in parameters of Left-of"))
     )))

 ;;   s1 ahead of s2 ?
 ((eq cons-type 'ahead-of)

  (setq *constraint-cks* (+ 1 *constraint-cks*))
  (if  *debug-consis* (comment1 " " *constraint-cks*))
  (setq *constraint-pos-cks* (+ 1 *constraint-pos-cks*))
  (let* (
	 (affectlist (get-affected-list constraint))
	 (p1        (get-nth-param 1 affectlist))    ;; first  tslot id
	 (p2        (get-nth-param 2 affectlist))    ;; second tslot id
	 )
    (cond
     ( (and (eq ts1 p1) (eq ts2 p2))
       (if (sit-object-ahead-of-p s1 s2)
	   (progn
	     (if *debug-consis* (comment2 "Ahead-of succeed for" s1 s2))
	     t)
	 (progn
	   (if *debug-consis* (comment2 "Ahead-of failed for" s1 s2))
	   (record-fail ts1 s1 ts2 s2 constraint)
	   nil)) )
     
     ( (and (eq ts1 p2) (eq ts2 p1))
       (if (sit-object-ahead-of-p s2 s1)
	   (progn
	     (if *debug-consis* (comment2 "Ahead-of succeed for" s2 s1))
	   t)
	 (progn
	   (if *debug-consis* (comment2 "Ahead-of failed for" s2 s1))
	   (record-fail ts1 s1 ts2 s2 constraint)
	   nil)) )
     (t
      (comment "Error in parameters of Ahead-of"))
     )))

 ;;   s1 behind of s2 ?
 ((eq cons-type 'behind-of)

  (setq *constraint-cks* (+ 1 *constraint-cks*))
  (if  *debug-consis* (comment1 " " *constraint-cks*))
  (setq *constraint-pos-cks* (+ 1 *constraint-pos-cks*))
  (let* (
	 (affectlist (get-affected-list constraint))
	 (p1        (get-nth-param 1 affectlist))    ;; first  tslot id
	 (p2        (get-nth-param 2 affectlist))    ;; second tslot id
	 )
    (cond
     ( (and (eq ts1 p1) (eq ts2 p2))
       (if (sit-object-behind-of-p s1 s2)
	   (progn
	     (if *debug-consis* (comment2 "Behind-of succeed for" s1 s2))
	     t)
	 (progn
	   (if *debug-consis* (comment2 "Behind-of failed for" s1 s2))
	   (record-fail ts1 s1 ts2 s2 constraint)
	   nil)) )
     
     ( (and (eq ts1 p2) (eq ts2 p1))
       (if (sit-object-behind-of-p s2 s1)
	   (progn
	     (if *debug-consis* (comment2 "Behind-of succeed for" s2 s1))
	     t)
	 (progn
	   (if *debug-consis* (comment2 "Behind-of failed for" s2 s1))
	   (record-fail ts1 s1 ts2 s2 constraint)
	   nil)) )
     (t
      (comment "Error in parameters of Behind-of"))
     ))) 

 ;; constraint unknown ...
 (t
  (comment1 "Constraint error" (first constraint))     
  nil)
)))



;; ***************************************************************************
;; Matching routines for tslots and sit-objs
;; ***************************************************************************

(defun ts-matches-type (tslot sit-obj)
"
 Does template slot match situation object for type value ?
"
(setq *node-consistency-checks* (+ 1 *node-consistency-checks*))
(setq *ts-match-type-count* (+ 1 *ts-match-type-count*))
  (let (
	(ts-type        (get-tslot-type tslot))
	(so-type        (get-sit-type sit-obj))
	)
    (if (listp ts-type)  ;; is ts-type a list of options ?
	(or-equal so-type ts-type)
      (if (eq ts-type '*)  ; wildcard
	  t
	(if (equal ts-type so-type)
	    t
	  nil))) ))

(defun ts-matches-orientation (tslot sit-obj)
"
 Does template slot match situation object for orientation value ?
"
(setq *node-consistency-checks* (+ 1 *node-consistency-checks*))
(setq *ts-match-orient-count* (+ 1 *ts-match-orient-count*))
  (let (
	(ts-orient       (get-tslot-orient tslot))
	(so-orient       (get-sit-orient   sit-obj))
	)
    (if (listp ts-orient)  ;; is ts-orient a list of options ?
	(or-equal so-orient ts-orient)
      (if (eq ts-orient '*)  ; wildcard
	  t
	(if (equal ts-orient so-orient)
	    t
	  nil))) ))

(defun ts-matches-activity (tslot sit-obj)
"
 Does template slot match situation object for activity value ?
"
(setq *node-consistency-checks* (+ 1 *node-consistency-checks*))
(setq *ts-match-activity-count* (+ 1 *ts-match-activity-count*))
  (let (
	(ts-activity   (get-tslot-activity tslot))
	(so-activity   (get-sit-activity sit-obj))
	)
    (if (listp ts-activity)   ;; is ts-activity a list of options ?
	(or-equal so-activity ts-activity)
      (if (eq ts-activity '*)  ; wildcard
	  t
	(if (equal ts-activity so-activity)
	    t
	  nil))) ))

(defun ts-matches-size (tslot sit-obj)
"
 Does template slot match situation object for size value ?
"
(setq *node-consistency-checks* (+ 1 *node-consistency-checks*))
(setq *ts-match-size-count* (+ 1 *ts-match-size-count*))
  (let (
	(ts-size   (get-tslot-size tslot))
	(so-size   (get-sit-size sit-obj))
	)
    (if (listp ts-size)    ;; is ts-size a list of options ?
	(or-equal so-size ts-size)
      (if (eq ts-size '*)  ; wildcard
	  t
	(if (equal ts-size so-size)
	    t
	  nil))) ))

(defun ts-matches-abs-loc (tslot sit-obj)
"
 Does template slot match situation object for abs loc range ?
"
(setq *node-consistency-checks* (+ 1 *node-consistency-checks*))
(setq *ts-match-abs-loc-count* (+ 1 *ts-match-abs-loc-count*))
(let (
      (loclist (get-tslot-abs-loc tslot))
      )
  (if (eq loclist '*)  ;; wildcard
      t
    (let (
	  (min-x  (first  loclist))
	  (min-y  (second loclist))
	  (max-x  (third  loclist))
	  (max-y  (fourth loclist))
	  (so-x   (get-sit-x sit-obj))
	  (so-y   (get-sit-y sit-obj))
	  )

    (if (in-range-p so-x so-y min-x min-y max-x max-y)
	t
      nil)))) )

;; ***************************************************************************
;; ***************************************************************************
;; Object accessors for MPR domain
;; ***************************************************************************
;; ***************************************************************************

;; **************************************************
;; Template object accessors
;;
;; Template object ( template-id
;;                   (template-slot-1 template-slot-2 .... template-slot-n )
;;                   (constraint-1 constraint-2 ... constraint-m) 
;;                   (cohesion-constr-1 cohesion-constr-p) )
;;

;; Template id
;;
(defun get-templ-id (template)
  (first template))

;; Slot List
;;
(defun get-templ-slots (template)
  (second template))

;; Constraint List
;;
(defun get-templ-constraints (template)
  (third template))

;; Cohesion constraints
(defun get-templ-cohesion-constr (template)
  (fourth template))

(defun get-templ-slot-object (template ident)
"
Return template slot object based on its identifier and template.
"
 (find-templ-slot-object (get-templ-slots template) ident) )


(defun find-templ-slot-object ( objlist ident )
" 
In objlist, return the templ-slot object indicated by ident.
"
(if (eq objlist nil)
    nil
  (if (equal ident (get-tslot-id (car objlist)))
      (car objlist)
    (find-templ-slot-object (cdr objlist) ident))))

;; Constraints
;;
(defun get-related-constraints (template tslot1-id tslot2-id)
"
"
  (get-slot-intersection (get-templ-constraints template) 
			 tslot1-id tslot2-id) )


(defun get-slot-intersection (constraints t1id t2id)
"
Return constraint set that applies to these two templates.
Optionally we may sort these later before applying them.
"
(let (
      (constraint        (car constraints))
      (rest-constraints  (cdr constraints))
      )
  (if (null constraint) 
      nil
    (if (applies-to-p constraint t1id t2id)
	(append (list constraint)
		(get-slot-intersection rest-constraints t1id t2id))
      (get-slot-intersection rest-constraints t1id t2id)) )))

(defun applies-to-p (constraint t1id t2id)
"
Does this constraint apply to these templates ids ?
"
(member-both-p t1id t2id (get-affected-list constraint)) )


(defun member-both-p (val1 val2 list)
"
Return t if both val1 and val2 are members of list
"
(if (and (member val1 list) (member val2 list))
    t nil))

;; **************************************************
;; Template slot object accessors
;;

;; Slot id
;;
(defun get-tslot-id (tslot)
  (first tslot))

;; Type
;;
(defun get-tslot-type (tslot)
  (second tslot))

;; Activity
;;
(defun get-tslot-activity (tslot)
  (third tslot))

;; Orientation
;;  note one of 8 compass points (e ne n nw w sw s se)
;;
(defun get-tslot-orient (tslot)
  (fourth tslot))

;; Absolute range restriction
;;  ( min-x min-y max-x max-y )
(defun get-tslot-abs-loc (tslot)
  (fifth tslot))

;; Size
;;
(defun get-tslot-size (tslot)
  (sixth tslot))

;; **************************************************
;; Binding List structure
;;
;; Structure is basically the same as partial solution
;;  in backtrack code node structure.
;;
;; Binding list ( (slot1 sitval1) ... (slotN sitvalN) )

;; Current instantiation for template slot ts (tsid blist)
;;
(defun get-tslot-instant ( tsid blist )
  (get-bind-elem-sitid (get-tslot-bind-elem tsid blist)))

;; Rest Domain of template slot ts (tsid blist)
;;
(defun get-tslot-domain ( tsid blist )
  (get-bind-elem-dom (get-tslot-bind-elem tsid blist)))

;; Return binding element tsid
;;
(defun get-bind-elem-tsid (bind-elem)
  (first bind-elem))

;; Return binding element sitid
(defun get-bind-elem-sitid (bind-elem)
  (second bind-elem))

;; Return binding element domainlist
;;
(defun get-bind-elem-dom (bind-elem)
  (third bind-elem))

;; Current binding element for template slot ts (tsid blist)
;;
(defun get-tslot-bind-elem (tsid blist)
  (let (
	(this (car blist))
	)
    (if (eq this nil)
	nil
      (if (equal (get-bind-elem-tsid this) tsid)
	  this
	(get-tslot-bind-elem tsid (cdr blist))))))

;; **************************************************
;; Template constraint object accessors
;;
;; Constraint object  ( type (from_id to_id) (parameters) )
;; 
;; note for now these constraint arcs are directed, binary in nature.
;; 

(defun get-constraint-type ( constraint )
"
 Return constraint type.
"
  (first constraint))

(defun get-affected-list ( constraint )
"
 Return list of template slots affected in this constraint.
"
  (second constraint))

(defun get-parameter-list ( constraint )
"
 Return parameters of the constraint.
"
  (third constraint))

(defun get-param-list-length (plist)
  (length plist))

(defun get-nth-param (n plist)
  (nth (- n 1) plist))

;; **************************************************
;; Template index system
;;
;; Structure to hold and access template objects so they may be 
;; referenced by id 
;;
;; structure is a global list for now, to be indexed otherwise later
;;
;; Templates (Template1 Template2 ... TemplateN)
;;

(defun get-templ-object ( ident )
"
Return template object based on identifier.
"
 (find-templ-object *template-object-list* ident)
)

(defun find-templ-object ( objlist ident )
" 
In objlist, return the templ-object indicated by ident.
"
(if (eq objlist nil)
    nil
  (if (equal ident (get-templ-id (car objlist)))
      (car objlist)
    (find-templ-object (cdr objlist) ident))))

(defun set-current-template ( ident )
"
Set global current template variable with template indexed by id.
"
(setq *current-template* (get-templ-object ident))
)

;; **************************************************
;; Single Situation index system
;;
;; Structure to hold and access situation objects so they may be 
;; referenced by id or location perhaps in other code.
;;
;; structure is a global list for now, to have a spatial index, id index later.
;;
;; Situation (SitObject1 SitObject2 ... SitObjectn)

(defun get-sit-object ( ident )
"
Return sit object based on identifier.
"
 (find-sit-object *current-situation* ident)
)

(defun get-sit-ids ()
"
Return a list of all situation objects in global storage.
"
   (get-ids *current-situation*)
)

(defun get-ids (list)
"
Return a list of ids of a list of situation objects.
"
  (if (null (car list))
      nil
    (append (list (get-sit-id (car list)))
	    (get-ids (cdr list)) )))


(defun get-sit-obj-x (ident)
"
Given sit id, return x position.
"
  (get-sit-x (get-sit-object ident)))

(defun get-sit-obj-y (ident)
"
Given sit id, return y position.
"
  (get-sit-y (get-sit-object ident)))

(defun get-sit-obj-type (ident)
"
Given sit id, return type.
"
  (get-sit-type (get-sit-object ident)))

(defun get-sit-obj-activity (ident)
"
Given sit id, return activity.
"
  (get-sit-activity (get-sit-object ident)))

(defun get-sit-obj-orient (ident)
"
Given sit id, return orientation.
"
  (get-sit-orient (get-sit-object ident)))

(defun get-sit-obj-size (ident)
"
Given sit id, return size.
"
  (get-sit-size (get-sit-object ident)))  

(defun find-sit-object ( objlist ident )
" 
In objlist, return the sit-object indicated by ident.
"
(if (eq objlist nil)
    nil
  (if (equal ident (get-sit-id (car objlist)))
      (car objlist)
    (find-sit-object (cdr objlist) ident))))


(defun get-sit-objects-range (fromx fromy tox toy)
"
Return sit objects in this rectangle.  TO BE DEFINED.
"
nil
)

;; **************************************************
;; Situation options list
;;
;; Structure to hold and access various situations
;;
;; Situations (Situation1 ... SituationN)
;;

(defun get-situation ( ident situations)
"
Return Situation object based on identifier.
"
 (find-situation situations ident)
)

(defun find-situation ( objlist ident )
" 
In objlist, return the Situation indicated by ident.
"
(if (eq objlist nil)
    nil
  (let (
	(this (car objlist))
	(rest (cdr objlist))
	)
    (if (equal ident (first this))
	(cdr this)
      (find-situation rest ident)))))

(defun set-current-situation ( ident situations )
"
Set global current situation variable with Situation indexed by id.
"
(setq *current-situation* (get-situation ident situations ))
)

;; Distribution
(defun get-dist ( ident )
"
Return Distribution object based on identifier.
"
 (find-situation *distributions* ident)
)

;; **************************************************
;; Situation object accessors
;;
;; Sit Object   ( sitid (x y) type activity orientation )
;;

;; ID
;;
(defun get-sit-id (sit-obj)
"
Return x coordinate of sit-obj.
"
  (first sit-obj))

;; X coordinate
;;
(defun get-sit-x (sit-obj)
"
Return x coordinate of sit-obj.
"
  (first (second sit-obj)))

;; Y coordinate
;;
(defun get-sit-y (sit-obj)
"
Return y coordinate of sit-obj.
"
  (second (second sit-obj)))

;; Type
;;
(defun get-sit-type (sit-obj)
"
Return type of sit-obj.
"
(third sit-obj))

;; Activity
;;
(defun get-sit-activity (sit-obj)
"
Return activity of sit-obj.
"
(fourth sit-obj))

;; Orientation
;;  note one of 8 compass points (e ne n nw w sw s se)
;;
(defun get-sit-orient (sit-obj)
"
Return orientation direction of sit-obj.  One of 8 compass points.
"
  (fifth sit-obj))

;; Size
;;
(defun get-sit-size (sit-obj)
"
Return activity of sit-obj.
"
(sixth sit-obj))

;; **************************************************
;; Situation Object decision functions
;;

;; RIGHT TEST
;;

(defun right-of (sit1 sit2)
"
 sit2 is base point, use sit2 angle.  Is sit1 right of sit2 ?
"
  (vec-orient-interior-p 
   (get-sit-x sit2)
   (get-sit-y sit2)
   (get-sit-orient sit2)
   (get-sit-x sit1)
   (get-sit-y sit1)))

(defun sit-object-right-of-p (s1 s2)
"
Returns true iff
  given a point s1 and a base point s2 and the orientation of the base,
  right -right- is defined as the interior of a vector going from the base
  in the direction of its orientation.
"
(let (
      (sit1 (get-sit-object s1))
      (sit2 (get-sit-object s2))
      )
  (right-of sit1 sit2)))

;; LEFT TEST
;;
(defun left-of (sit1 sit2) 
"
 Sit2 is base point, use sit2 angle.  Is sit1 left of sit2 ?
"
  (vec-orient-interior-p 
   (get-sit-x sit2)
   (get-sit-y sit2)
   (rotate-orient-180 (get-sit-orient sit2))
   (get-sit-x sit1)
   (get-sit-y sit1)))

(defun sit-object-left-of-p (s1 s2)
"
Returns true iff
  given a point s1 and a base point s2 and the orientation of the base,
  -left- is defined as the interior of a vector going from the base
 180 degrees from its orientation.
"
(let (
      (sit1 (get-sit-object s1))
      (sit2 (get-sit-object s2))
      )
  (left-of sit1 sit2)))

;; AHEAD TEST
;;
(defun ahead-of (sit1 sit2) 
"
 Sit2 is a base point, use sit2 angle.  Is sit1 ahead of sit2 ?
"
  (vec-orient-interior-p 
   (get-sit-x sit2)
   (get-sit-y sit2)
   (rotate-orient-90 (get-sit-orient sit2) 'l)
   (get-sit-x sit1)
   (get-sit-y sit1)))

(defun sit-object-ahead-of-p (s1 s2)
"
Returns true iff
  given a point s1 and a base point s2 and the orientation of the base,
  -ahead- is defined as the interior of a vector going from the base
  rotated 90 degrees to the left of its orientation.
"
(let (
      (sit1 (get-sit-object s1))
      (sit2 (get-sit-object s2))
      )
  (ahead-of sit1 sit2)))

;; BEHIND TEST
;;
(defun behind-of (sit1 sit2) 
"
 Sit2 is a base point, use sit2 angle.  Is sit1 behind of sit2 ?
"
(vec-orient-interior-p 
 (get-sit-x sit2)
 (get-sit-y sit2)
 (rotate-orient-90 (get-sit-orient sit2) 'r)
 (get-sit-x sit1)
 (get-sit-y sit1) ))

(defun sit-object-behind-of-p (s1 s2)
"
Returns true iff
  given a point s1 and a base point s2 and the orientation of the base,
  -behind- is defined as the interior of a vector going from the base
  rotated 90 degrees to the right of its orientation.
"
(let (
      (sit1 (get-sit-object s1))
      (sit2 (get-sit-object s2))
      )
  (behind-of sit1 sit2)))


(defun notu (val)
"
Simply retain 'u if u returned indicating on decision vector.
"
  (if (eq val 'u)
      'u             ;; if on line, respond true in either l/r f/b question
    (not val)))

;; ***************************************************************************
;; Spatial routines for MPR domain
;;   Functions for the computation of spatial relationships for MPR
;; ***************************************************************************

(defun distance-between (s1 s2)
"
 What is the absolute distance between s1 and s2 based on their coordinates ?
 S1 and S2 are situation identifiers.
"
  (let*
      (
	;; assuming for the first pass that s1 and s2 have absolute locations
	;;  as opposed to regional locations, or locations with error  ...
	;;  in that case this function will have to change significantly.
       (sit1 (get-sit-object s1))
       (sit2 (get-sit-object s2))
       (s1x (get-sit-x sit1))
       (s1y (get-sit-y sit1))
       (s2x (get-sit-x sit2))
       (s2y (get-sit-y sit2))
       )
    (sqrt 
     (+ 
      (sqr (abs (- s1x s2x)))
      (sqr (abs (- s1y s2y))) )) ))

(defun sqr (x)
"
Return the square of x.
"
(* x x))

(defun echelon-bound-p ( x1 y1 orient x2 y2 bound )
"
 Given a line defined as corresponding to the vector of orientation of
 the object at (x1 y1), is the object at (x2 y2) within bound of the
 line ?  
"

;;(if *debug*
;;    (progn
;;      (comment3 "echelon-bound call: x1 y1 orient" x1 y1 orient)
;;      (comment3 "                    x2 y2  bound" x2 y2 bound)
;;      ))

(let* (
       (newxy (find-other-point x1 y1 orient))
       (second_x (first newxy))
       (second_y (second newxy))
       )

;;  (if *debug*
;;      (progn
;;	(comment2 "echelon-bound call mdbp: x1 y1" x1 y1)
;;	(comment2 "                     secx secy" second_x second_y)
;;	(comment2 "                         x2 y2" x2 y2)
;;	(comment1 "                         bound" bound)))

  (medial-distance-bound-p x1 y1 second_x second_y x2 y2 bound)
  ))

(defun medial-distance-bound-p ( x1 y1 x2 y2 px py pbound )
"
 Given a line from pt 1 to pt 2 , Is pt P less than pbound off the line ?
"
;; A line, given two points
;;
;; x2 =/= x1, then
;;               (y2 - y1)
;; 0 = y1 - y +  --------- (x - x1)
;;               (x2 - x1) 
;;
;; x2 = x1, then 
;; 0 = y1 - y

;; distance d from a point xo yo to a line Ax + By + C = 0
;;
;;         Ax0 + By0 + C
;; d =  -------------------
;;       + sqrt( A^2 + B^2 )
;;       -

;;(if *debug* 
;;    (progn
;;      (comment  "Medial distance bound function")
;;      (comment2 "x1 y1 " x1 y1)
;;      (comment2 "x2 y2 " x2 y2)
;;      (comment2 "px py " px py)
;;      (comment1 "pbound" pbound) ))

(if (eq x1 x2)      
    (if (<= (abs (- x1 px)) pbound)
	t
      nil)

  (let* 
      (
       (A  (/ (- y2 y1)
	      (- x2 x1)))
       (B  -1)
       (C  (- y1
	      (* A x1)))
       (top (+
	     (* A px)
	     (* B py)
	     C ))
       (bottom (sqrt (+ (sqr A) (sqr B))))
       (distance (abs (/ top bottom)))
       )

    (if (<= distance pbound)
	t
      nil)
   )))


(defun vec-orient-interior-p ( x1 y1 orient px py )
"
 Given x y orient of pt(x y), is px py to the interior of vector ?
"
(let* (
       (newxy (find-other-point x1 y1 orient))
       (newx  (first newxy))
       (newy  (second newxy))
       )
  (vec-pt-interior-p x1 y1 newx newy px py) ))

(defun find-other-point (x1 y1 orient)
"
Return other point along vector, in direction of vector.
NOTE that the second point MUST be in the direction of the vector
"
(let* (
       (deltaxy (change-orient orient))
       (newx    (+ x1 (first deltaxy)))
       (newy    (+ y1 (second deltaxy)))
       )
;;  (if *debug*
;;      (progn
;;	(comment3 "given x y angle" x1 y1 )
;;	(comment1 "deltaxy        " deltaxy)
;;	(comment2 "other point is " newx newy )
;;	))

(list newx newy)))

(defun in-range-p (px py min-x min-y max-x max-y)
 "
True if px py point is in rectangle defined by the two points,
 bottom left (min-x min-y) and upper right (max-x max-y).
"
 (let* (
	(x1 min-x)  ;; bottom left
	(y1 min-y)
	(x2 min-x)  ;; top left
	(y2 max-y)
	(x3 max-x)  ;; top right
	(y3 max-y)
	(x4 max-x)  ;; bottom right
	(y4 min-y)
       )

 (if (point-poly-intersect-p x1 y1 x2 y2 x3 y3 x4 y4 px py)
     t 
   nil)
 ))

(defun point-poly-intersect-p ( x1 y1 x2 y2 x3 y3 x4 y4 px py )
"
Does px py lie within the polygon defined by points 1 2 3 4 ?
Note points 1 2 3 4 must be listed in clockwise direction.
"
(let (
      (d12 (vec-pt-interior-p x1 y1 x2 y2 px py))
      (d23 (vec-pt-interior-p x2 y2 x3 y3 px py))
      (d34 (vec-pt-interior-p x3 y3 x4 y4 px py))
      (d41 (vec-pt-interior-p x4 y4 x1 y1 px py))
      )
  (if (and d12 d23 d34 d41)
      t
    nil)
  ))

(defun vec-pt-interior-p ( x1 y1 x2 y2 px py )
"
 Source:: Fletcher

 This is a (supposedly) inexpensive way in which to check whether some
 point P is on INTERIOR of passed vector 1->2. This function forms the basis
 for much of the required spatial calculations in determining intersecting
 polygons used in template area matching.  
    Refer  :   point-vector-pos

   1) Translate passed vector and P such that vector originates at origin
   2) Rotate vector of (origin to P) 90 degrees CounterClockwise
   3) Compute Dot Product of passed vector and rotated P
   4) If DP is >= 0 then INTERIOR (t), 
               < 0 then EXTERIOR (nil),
"

(let*
    (
      (x_2  (- x2 x1))     ;; = x2 - x1
      (y_2  (- y2 y1))     ;; = y2 - y1
      (p_x  (- px x1))     ;; = px - x1
      (p_y  (- py y1))     ;; = py - y1

      ;; Rotate P 90 degrees
      (p__x (* p_y -1))    ;; = (- p_y)
      (p__y p_x)           ;; = p_x

      ;; Compute Dot Product
      (dp   (+             ;; = ( (p__x * x_2) + (p__y * y_2) )
	     (* p__x x_2)
	     (* p__y y_2)))
      )

;;   (if (>= dp 0)           ;; (dp >= 0)
;;       t
;;       nil)

  (if (> dp 0)
      t
    (if (< dp 0)
	nil
      'u))

   ))

(defun rotate-orient-90 ( orient direction )
"
Rotate orientation 90 degree left(l) or right(r).
"
(if (not (or (eq direction 'l) (eq direction 'r)))
    (comment1 "Error in rotate direction" direction))

(cond 
 ( (eq orient 'e)
   (if (eq direction 'l) 'n  's))
 ((eq orient 'ne)
   (if (eq direction 'l) 'nw 'se))
 ((eq orient 'n)
   (if (eq direction 'l) 'w  'e))
 ((eq orient 'nw)
   (if (eq direction 'l) 'sw 'ne))
 ((eq orient 'w)
   (if (eq direction 'l) 's  'n))
 ((eq orient 'sw)
   (if (eq direction 'l) 'se 'nw))
 ((eq orient 's)
   (if (eq direction 'l) 'e  'w))
 ((eq orient 'se)
   (if (eq direction 'l) 'ne 'sw))
 (t
  (comment "ERROR in rotate-orient-90")
   'invalid)
 ))

(defun rotate-orient-180 ( orient )
  (rotate-orient-90 (rotate-orient-90 orient 'r) 'r))

(defun change-orient ( orient )
"
 Return directional x y change factors as a list.
"
(cond 
 ((eq orient 'e)
   '(10 0))
 ((eq orient 'ne)
  '(10 10))
 ((eq orient 'n)
  '(0 10))
 ((eq orient 'nw)
  '(-10 10))
 ((eq orient 'w)
  '(-10 0))
 ((eq orient 'sw)
  '(-10 -10))
 ((eq orient 's)
  '(0 -10))
 ((eq orient 'se)
  '(10 -10))
 (t
  (comment "ERROR in change-orient")
  'invalid)
))

;; Spatial (cohesion) consistency propagation

(defun spatial-consis (variable sit-inst vars-left)
" Remove all domain values in vars-left which fall outside the range
  specified for this variable in (third (cdr *current-template*)) "
(let (
      (sq-range (get-range-element variable))
      )
  (if (null sq-range)  ;; no spatial cohesion constraint on this variable
      vars-left        ;; do no restriction
    (let* (
	   (sit-inst-x (get-sit-obj-x sit-inst))
	   (sit-inst-y (get-sit-obj-y sit-inst))
	   (min-x (- sit-inst-x sq-range))
	   (max-x (+ sit-inst-x sq-range))
	   (min-y (- sit-inst-y sq-range))
	   (max-y (+ sit-inst-y sq-range))
	   )
      ;; if any variable has a domain value outside those above, delete it
      (remove-dom-vals vars-left min-x max-x min-y max-y)
      )) ))

(defun remove-dom-vals (vars-left min-x max-x min-y max-y)
(if (null vars-left)
    nil
  (append
   (list (remove-dom-val (car vars-left) min-x max-x min-y max-y))
   (remove-dom-vals (cdr vars-left) min-x max-x min-y max-y) )))

(defun remove-dom-val (var-set min-x max-x min-y max-y)
  (let (
	(new-list  (remove-if #'(lambda (x) 
				  (exceed-bound x min-x max-x min-y max-y))
			      (cdr var-set) )) )
    ;; Keep track of savings, if any
    (setq *sch-save* 
	  (+ *sch-save* (- (1- (length var-set)) (length new-list))))

    (cons (car var-set) new-list)))

(defun exceed-bound (this min-x max-x min-y max-y)
  (setq *constraint-cks* (+ 1 *constraint-cks*))
  (setq *constraint-sch-cks* (+ 1 *constraint-sch-cks*))
  (let (
	(this-x (get-sit-obj-x this))
	(this-y (get-sit-obj-y this))
	)
    (or (> this-x max-x)
	(< this-x min-x)
	(> this-y max-y)
	(< this-y min-y))))

(defun get-range-element (variable)
" What is the square range for variable in template ? "
  (second (assoc1 variable (nth 3 *current-template*))))

;; **********************************************************************
;; SET LOADED FLAG 
;; **********************************************************************
(setq *domain-loaded* 'mpr)

