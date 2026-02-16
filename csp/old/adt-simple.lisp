;; adt-simple.lisp
;;
;;  Abstract Data Type Recognition Domain for CSP Experimentation
;; 

(defun adt (&key
	    (situation-id     "adt-t1-1") 
	    (sit-noise                 0)
	    (template-id        "adt-t1")  
	    (dom (list 'adt situation-id template-id))
	    (search-mode            "bt")  ;; backTRACK/JUMP/MARK bt bj bm
	    (node-consis               t)  ;; make node consis before search
	    (node-force-all          nil)  ;; for each dom val try all const
	    (arc-consis              nil)  ;; arc consistency before/during/nil
	    (rand-dist           "dist1")  ;; dist of random element attributes
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
Example program to solve the ADT problem.  Takes no required args, but
it is assumed we will use the default situation and template values.
"

(setq *check* 1)

;; re-load adt-setup constants
(load "adt-setup")

;; insure ADT functions are loaded
;; arc-p consistent-p 
(if (not (eq *domain-loaded* 'adt))
    (progn
      (load "adt-simple")
      (load "adt-setup") ))

(setq *test* situation-id)

;; Establish random object either from file as indicated, or create new one
;;   unique  indicates create a unique one
;;   default indicates to utilize the one stored as RndDefault
;;   string  indicates to utilize the one stored as RndString
(if (eq random-ident 'unique)
    (progn
      (setq random-ident (unique-string))
      (setq *random-state* (make-random-state t))
      (save-rand random-ident))
  (if (eq random-ident 'default)
      (progn
	(load-rand 'default))
    (load-rand random-ident)))

;; Establish initial  ADT world situations
;;  Note that random insertion of noise will occur identically for the same
;;  random state, so a particular test case can be re-created as required.  
;; Since Lucid does not let you use a user generated "seed", we save the seed
;;  objects in the Random subdirectory for later retrieval and restoration.
(if (not (adt-set-global-values situation-id sit-noise 
				random-ident template-id 
 				rand-dist(get-dist rand-dist)
				long-output single-line-override
				))

    (progn
      (comment "Exiting with a ADT setup error.")
      (return-from adt nil))
  (progn
;;  not appropriate at moment for ADT
;;    (save-situation random-ident sit-noise)
;;    (save-gnuplot   random-ident sit-noise)
    ))


(setq *check* 3)
;; set up global variables
(if (not (set-globals (adt-variables)
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
      (return-from adt nil)))

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
     ))
   ((equal search-mode "bm")
    (bm init-var-set #'consistent-p))
   (t
    (comment1 "Error in search-mode value" search-mode))
   )))

;; **************************************************
;; adt variables
;;  part 1 of create initial state from defined objects

(defun adt-variables ( &optional (template *current-template*) )
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
 This is the ADT version.  
"
(let (
      (sit-obj (get-sit-object     sit-obj-id))
      (tslot   (get-templ-slot-object *current-template* tslot-id))
      )

(setq *node-consistency-calls* (+ 1 *node-consistency-calls*))

(if force

    ;; Compute all node arc checks

    (let (
	  ;; stmt type, ie Decl, Zero etc
	  ;; not this is specialized by type, so that
	  ;; the TYPES of the Decl/Zero/etc match appropriately
	  (node-match-type     (ts-matches-type        tslot sit-obj))
	  )

      (if node-match-type
	  t
	nil))
  )))


;; **************************************************
;; Arc presence check

(defun arc-p (symbol1 symbol2)
"
 Return true if there is an arc between symbol1 and symbol2.
 This is the ADT version.
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
ADT version.
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
A sort will affect the perform of the ADT.  We would wish to put constraints 
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
 Does template slot match situation object for stmt type value ?
"
(setq *node-consistency-checks* (+ 1 *node-consistency-checks*))
(setq *ts-match-type-count* (+ 1 *ts-match-type-count*))
e1
(let* (
       (ts-type        (get-tslot-type tslot))


       (so-type        (get-sit-type sit-obj))

	)
  (if (equal ts-type so-type)
      x 
    y)))


;; ***************************************************************************
;; ***************************************************************************
;; Object accessors for ADT domain
;; ***************************************************************************
;; ***************************************************************************

;; **************************************************
;; Template object accessors
;;
;; Template object ( template-id
;;                   linenumber		
;;                   stmt
;;                   (template-slot-1 template-slot-2 .... template-slot-n )
;;                   (constraint-1 constraint-2 ... constraint-m) 
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

;;  
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
(defun get-templ-constraints (template)
  (third template))

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
;; id linenumber stmt

;; Slot id
;;
(defun get-tslot-id (tslot)
" something like t1-a ... "
  (first tslot))

;; Stmt type
;;
(defun get-tslot-type (tslot)
 " Statement type, one of Decl, Zero, Assign, Print, For .... "
  (second tslot))

;; Stmt body itself, not including stmt type
;;
(defun get-tslot-stmt-body (tslot)
"  Statement body depending on type ... this body is a parameter,type set"
  (cddr tslot))

;; Stmt parameters n
;;
(defun get-tslot-stmt-param (tslot n)
  (nth (1- n) (get-tslot-stmt-body tslot)))

;; Stmt parameter name n
;;
(defun get-tslot-stmt-param-name (tslot n)
  (first (nth (1- n) (get-tslot-stmt-body tslot))))

;; Stmt parameter type n
;;
(defun get-tslot-stmt-param-type (tslot n)
  (second (nth (1- n) (get-tslot-stmt-body tslot))))



(defun get-decl-name ( body )
  (first body))

(defun get-decl-typebody ( body )
  (second body))

;;
;; pull apart typebody ... (array (int char ..)) or (int char ...)
;;

;; ie array or (int char)
(defun get-primary-type ( typebody )
  (first typebody))

;; For primary-type = array, more info available ... ie -> (int char)
;;
(defun get-array-type-rng ( typebody )
  (second typebody ))

;; for Decl only the typebody has a third parameter, size range 
;; ie (array (int char) (10 100)) -> (10 100)
;;
(defun get-array-size-rng ( typebody )
  (third typebody ))

;; **************************************************
;; Body parameter accessor, ie
;;
;;  zero has 1(x) or 2(x,i)  params,        x<-nil, x[i]<-nil
;;  print has 1(x) or 2(x,i) params,        pr(x), pr(x[i])
;;  assign has 2(x,y) 3(x,i,y),4(x,i.y,j),  x<-y, x[i]<-y, x[i]<-y[j]
;;  
;; ie ( (name type) (name type) (name type) )
;;
(defun get-param-and-type( body n )
  (nth (1- n) body))


;; ***************************************************************************
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

;; **************************************************************************
;; **************************************************************************
;; Single Situation index system, ident based lookups
;;
;; Structure to hold and access situation objects so they may be 
;; referenced by id or location perhaps in other code.
;;
;; structure is a global list for now, to have a spatial index, id index later.
;;
;; Situation (SitObject1 SitObject2 ... SitObjectn)
;;

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

;;
(defun get-sit-obj-line (ident)
"
Given sit id, return line position (actual and adjusted)
"
  (get-sit-x (get-sit-object ident)))

;;
(defun get-sit-obj-line-adj (ident)
"
Return adjusted line number"
(first (get-sit-obj-line ident)))

;;
(defun get-sit-obj-line-adj (ident)
"
Return actual (initial) line number"
(second (get-sit-obj-line ident)))

;;
(defun get-sit-obj-type (ident)
"
Given sit id, return type.
"
  (get-sit-type (get-sit-object ident)))

;; --- 

(defun find-sit-object ( objlist ident )
" 
In objlist, return the sit-object indicated by ident.
"
(if (eq objlist nil)
    nil
  (if (equal ident (get-sit-id (car objlist)))
      (car objlist)
    (find-sit-object (cdr objlist) ident))))

;; ************************************************************************
;; ************************************************************************
;; Situation options list
;;
;; Structure to hold and access various situations
;;
;; Situations (Situation1 ... SituationN)
;;

(defun get-situation ( ident situations )
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

;; ***************************************************************************
;; ***************************************************************************
;; Distribution

;;
(defun get-dist ( ident )
"
Return Distribution object based on identifier.
"
 (find-situation *distributions* ident)
)

;; ************************************************************************
;; ************************************************************************
;; Situation object accessors
;;
;; Sit Object   
;;   ( sitid (adjLine actLine) (StmtType ...
;;                              Decl          array arrName arrType arrSize
;;                              Decl          type  Name
;;                              Zero          name   
;;                              Zero          arrName index
;;                              Assign        name    value
;;                              Assign        arrName value index
;;                              Assign        arrName value index
;;                              Print         name
;;                              Print         arrName index
;;                              Check         name1 name2
;;                              For           index initVal endVal Sub-Sit-Ob
;;                                            ( sitid actLine+1  Sub-Stmt
;;                                                               Zero   ... 
;;                                                               Assign ... 
;;                                                               Print  ... 

;; ID      
;;
(defun get-sit-id (sit-obj)
"
Return x coordinate of sit-obj.
"
  (first sit-obj))

;; Adjusted Location
;;
(defun get-sit-line-adj (sit-obj)
"
Return adjusted line number as counted after input.
"
  (first (second sit-obj)))

;; Actual Location
;;
(defun get-sit-line-act (sit-obj)
"
Return actual line number as input of sit-obj.
"
  (second (second sit-obj)))

;; Stmt
;;
(defun get-sit-stmt (sit-obj)
"
Return the Stmt of sit-obj itself.
"
(third sit-obj))

;; Stmt Type
;;
(defun get-sit-type (sit-obj)
"
Return the Stmt Type of Stm in sit-obj
"
(first (get-sit-stmt sit-obj)))

;; ---------------------------------------------------------------------------
;; Sit-Obj Stmt accessors
;; ---------------------------------------------------------------------------

;; Stmt Type
;;
(defun get-stmt-activity ( stmt )
  " Return activity of stmt. "
  (first stmt))

;; Stmt Parameter
;;
(defun get-stmt-orient ( stmt n )
  " Return statement parameter by parameter position."
  (nth stmt))

;; **************************************************
;; Situation Object decision functions, constraint support
;;

;; Before Test
;;

(defun before-p (sit1 sit2)
"
 Verify via ACTUAL line numbers.  Note if ACTUAL line numbers are the SAME,
 neither is before the other.
"
(let (
      (line1 (get-sit-line-act sit1))
      (line2 (get-sit-line-act sit2))
      )
  (< sit sit2)))

(defun same-name-p ( sit1-id sit2-id )
"
 Determine if $name of sit1-id and $name of sit2-id are identical.
" 
())


; ??????? HERE I AM




  
;; **********************************************************************
;; SET LOADED FLAG 
;; **********************************************************************
(setq *domain-loaded* 'adt)

