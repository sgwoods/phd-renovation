;; adt-simple.lisp
(defun cadt () (compile-file "adt-simple")  (load "adt-simple"))
(defun ladt () (load "adt-simple.lisp"))
(defun madt () (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:adt-simple.lisp"))
;;
;;  Abstract Data Type Recognition Domain for CSP Experimentation
;; 

;; Note we can define a situation id "immediate" that would
;; result in using a passed situation directly rather than looking one up,
;; similarly for template "immediate".  In this way we can abstract out
;; any cumulative work in looking up from this function.... for use in
;; any PU-CSP use of MAP-CSP (adt) as a subroutine.  SGW Dec 6/1995


(defun adt (&key
	    (situation-id       "my-sit")  ;; special implies o/ride
	    (sit-noise                     0)
	    (template-id    "average-array-template-9-17")  ;; special implies o/ride
	    (dom (list 'adt situation-id template-id))
	    (search-mode            "bt")  ;; backTRACK/JUMP/MARK bt bj bm qu
	    (node-consis               t)  ;; make node consis before search
	    (node-force-all          nil)  ;; for each dom val try all const
	    (arc-consis              nil)  ;; arc consistency before/during/nil
	    (rand-dist           "dist1")  ;; dist of random element attributes
	    (forward-checking        nil)  ;; simple dom red on cur inst
	    (dynamic-rearrangement   nil)  ;; dyn var inst order
	    (advance-sort              t)  ;; var ordr : t nil random quilici
	    (sort-const          'random)  ;; inline constraint appln order
	    (adv-sort-const      'random)  ;; advance constraint appln order
	    (one-solution-only       nil)  ;; quit after one found
	    (cpu-sec-limit          1800)  ;; 30 minutes cpu
	    (ck-pt-interval          900)  ;; 15 minutes cpu
	    (debug                   nil)  ;; debug search
	    (debug-csp               nil)  ;; debug constraint application
	    (debug-node              nil)  ;; debug node consistency appln 
	    (random-ident       'default)  ;; optional random identifier
	    (output-file             nil)  ;; write output to
	    (long-output             nil)  ;; force LONG output explanation
	    (single-line-override    t)    ;; overrides other out, 1 line only
	    (suppress-single-line    nil)  ;; return solution set only
	    (override-situation      nil)  ;; force "special" situation usage
	    (override-template       nil)  ;; force "special" template  usage
	    (part-soln               nil)  ;; partial solution if any
	    )
"
Example program to solve the ADT problem.  Takes no required args, but
it is assumed we will use the default situation and template values.
"

(setq *check* 1)
;;(format t "override-template: ~a~%" override-template) 
(setq *override-situation* override-situation)
(setq *override-template*  override-template)

;; re-load adt-setup constants
(if (not *adt-setup-loaded*)
    (load "adt-setup"))

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

;; Dec 10/1995.  We should reload existing situation if it has been created  
;;  since we want to keep them around anyhow.

(if (not (adt-set-global-values  situation-id 
				 sit-noise            
				 random-ident 
				 template-id  
				 rand-dist            
				 (get-dist rand-dist)
				 long-output  
				 single-line-override 
				 suppress-single-line
				 ))
    (progn
      (comment "Exiting with a ADT setup error.")
      (return-from adt nil)))

(setq *check* 3)

;; set up global variables
(if (not (set-globals (adt-variables :partial-solution part-soln)
		      dom 
		      search-mode 
		      node-consis 
		      node-force-all 
		      arc-consis
		      forward-checking 
		      dynamic-rearrangement 
		      advance-sort
		      sort-const
		      adv-sort-const
		      one-solution-only 
		      cpu-sec-limit 
		      ck-pt-interval
		      debug 
		      debug-csp 
		      debug-node
		      output-file))
    (progn
      (comment "Exiting with a general setup error.")
      (return-from adt nil)))

;; Show set up options
(show-options)
(setq *check* 4) 

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

  ;; Advance constraint sorting (do before AC !!)
  ;;  actually updates *current-template* directly destructively
  (if adv-sort-const
      (progn
	(setq *constraints* (adv-sort-constr 
			     (get-templ-constraints *current-template*) 
			     adv-sort-const))

	;; check for completeness sacrifice ???
	;(if (constraint-exists-p 'close-to-p)
	;    (progn
	;      (comment
	;      ">> WARNING: CLOSE-TO constraint may sacrifice completeness<<")
	;      ))

	(setf (nth 2 *current-template*) *constraints*)))

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

   ) ;; cond end

  ;; Advance constraint processing completed.
  (setq *internal-advance-end-time*   (get-internal-run-time))

  ;; If advance sort requested of variable list, do so here
  (if advance-sort
      (if (eq advance-sort 'random)
	  ;; random ordering
	  (progn
	    (setq init-var-set (random-order init-var-set)) )

	;; quilici pre-determined partial ordering ... see quilici.lisp
	(if (eq advance-sort 'quilici)
	    (progn
	      (setq *internal-sort-start-time* (get-internal-run-time))
	      (setq init-var-set (quilici-advance-var-sort init-var-set))
	      (setq *internal-sort-end-time* (get-internal-run-time)) )

	;; advance-sort ordering by heuristic 
	(progn
	  (setq *internal-sort-start-time* (get-internal-run-time))
	  (setq init-var-set (advance-sort init-var-set))
	  (setq *internal-sort-end-time* (get-internal-run-time)) 
	  )
	)) )

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

   ((equal search-mode "qu")
    (quilici-search 
           init-var-set 
           (get-templ-constraints *current-template*)
     ))

   ((equal search-mode "gsat")
    (adt-gsat
           init-var-set 
           (get-templ-constraints *current-template*)
     ))

   ((equal search-mode "bm")
    (bm init-var-set #'consistent-p))

   (t
    (comment1 "Error in search-mode value" search-mode))
   )) 

;; just before exiting return solution set
(format t
	"~%Successful constraint checks: ~a  Unsuccessful constraint checks ~a ~%"
	*constraint-success* *constraint-failure*)

*solution-set*

)


;; ***************************************************************************
;; ***************************************************************************
;; ************* END OF MAIN PROGRAM, PRIMARY UTILITIES FOLLOW ***************
;; ***************************************************************************
;; ***************************************************************************

;; **************************************************
;; adt variables
;;  part 1 of create initial state from defined objects

(defun adt-variables ( &key (template *current-template*)
			    (partial-solution nil) )
  (let* (
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
		     allvalues)))))

    ;; return generated varlist
    (if (null partial-solution)
	varlist
      (replace-some varlist partial-solution))
    )) 

(defun replace-some (varlist partial-solution)
; there is already partial solution for (car x)? replace x of varlist with 
; the partial solution  
  (mapcar #'(lambda (x) 
	      (let* (
		     (m (member (car x) partial-solution
				:test #'(lambda (a b) (equal a (car b)))))
						
		     (repl (if (null m) nil (car m)))
		    )
		(if repl
		    repl
		  x)))
	  varlist))

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
	      (append newnode (list domval) )) )) ))

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

NOTE could use "force" flag here, currently only one type of check required
"
(setq *node-consistency-calls* (+ 1 *node-consistency-calls*))

(let* (
       (sit-obj (get-sit-object     sit-obj-id))
       (tslot   (get-templ-slot-object *current-template* tslot-id))
       (tmatch  (ts-matches-type        tslot sit-obj))
       )

  (if *debug-node*
      (progn
	(comment2 "Sit obj id, tslot-id = " sit-obj-id tslot-id)
	(comment1 "Result = " tmatch)
	))

  (if tmatch
      t
    nil)) )

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
;; NOTE  this consistent-p call applies all constraints across two
;;       slots ... in a particular order either as given or sorted ...
;;       consequently provision is made to re-order the constraints
;;       dynamically for a particular use ... see "sort-const/r" below.
;;
;; note  Template slot ids are variables
;;       Sit object ids    are domain values
;;       partial solution  is all present variable instantiations
;;                         used only for n-ary constraints

(defun consistent-p (ts1 sit1 ts2 sit2 partial-solution 
			 &key (sort-const *sort-const*) )
" 
Is this sit-object to templ-slot assignment consistent with respect to 
ALL arc constraints in the curent template between ts1 and ts2 ?
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
	(constraint-set (get-related-constraints *current-template* ts1 ts2) )
	(blist          partial-solution)  ; ignored for now
	)

    ;; if no applicable arc constraints, assignment okay by default.
    (if (null constraint-set) 
	(progn
	  (setq *consistent-null-arcs* (+ 1 *consistent-null-arcs*))
	  (if *debug-consis* (comment1 "No arc constraints" t))
	  (list 't 0))

      ;; else constraints exist ... apply them in pre-sorted order.
      ;; Note :one may wish to apply constraints in a different order
      ;; according to different situations or variable types etc....
      ;; we shall dispense with this and make constraint ordering
      ;; something done in advance if at all ... noting that template
      ;; definition gives one (default) ordering.

      ;; Optional, LOCALLY sort constraints before checking THIS consistency
      (if sort-const
	  (consistent-all ts1 sit1 ts2 sit2 blist 
			  (sort-constr constraint-set sort-const))
	(consistent-all ts1 sit1 ts2 sit2 blist constraint-set))  )))

(defun sort-constr (constraint-set sort-const)
" A sort will affect the perform of the ADT.  We would wish to put constraints 
 more likely to fail FIRST in the list, thus way avoiding the checking of arc
 constraints that usually succeed.  We must balance this with the list sorting 
 cost, and also keeping in mind that the *best* order for a particular pair of
 template slots may be difficult (?) to determine... more work required here.
 This is an INLINE sort called from consistent-p only."

  (if (eq sort-const 'random)
      (random-order constraint-set)
    constraint-set))

;; **************************************************
;;
(defun adv-sort-constr (constraint-list adv-sort-const)
"Heuristically or randomly sort constraint set.  Currently random only."
(if (eq adv-sort-const 'random)
    (random-order constraint-list)
  (if (eq adv-sort-const 'quilici)
      (quilici-advance-constr-sort constraint-list)
    constraint-list )))


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
	(if (null levels) (setq levels (list 1)));;yongjun added this statement  
    (apply 'max levels) ))

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
  (if result 
	(setq *constraint-success* (+ *constraint-success* 1))
	(setq *constraint-failure* (+ *constraint-failure* 1)))

  (list result cons-level) ))

;; **************************************************
;;
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

   ;;; -----------------------------------------------------------------------
   ;; real program, possible-data-dependency  
   ((eq cons-type 'possible-data-dependency)

    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-possible-data-dependency-cks* 
			(+ 1 *constraint-possible-data-dependency-cks*))

    (check-possible-data-dependency constraint ts1 s1 ts2 s2))

   ;;; -----------------------------------------------------------------------
   ;; real program, guaranteed-data-dependency  
   ((eq cons-type 'guaranteed-data-dependency)

    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-guaranteed-data-dependency-cks* 
			(+ 1 *constraint-guaranteed-data-dependency-cks*))

    (check-guaranteed-data-dependency constraint ts1 s1 ts2 s2))

   ;;; -----------------------------------------------------------------------
   ;; real program, same-data-dependency  
   ((eq cons-type 'same-data-dependency)

    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-same-data-dependency-cks* 
			(+ 1 *constraint-same-data-dependency-cks*))

    (check-same-data-dependency constraint ts1 s1 ts2 s2))

   ;;; -----------------------------------------------------------------------
   ;; real program, control-data-dependency  
   ((eq cons-type 'control-data-dependency)

    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-control-data-dependency-cks* 
			(+ 1 *constraint-control-data-dependency-cks*))

    (check-control-data-dependency constraint ts1 s1 ts2 s2))

   ;;; -----------------------------------------------------------------------
   ;; real program, same-variable  
   ((eq cons-type 'same-variable)

    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-same-variable-cks* 
			(+ 1 *constraint-same-variable-cks*))

    (check-same-variable constraint ts1 s1 ts2 s2))

   ;;; -----------------------------------------------------------------------
   ;; Before Ordering
   ((eq cons-type 'before-p)

    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-before-cks* (+ 1 *constraint-before-cks*))

    (check-before-p constraint ts1 s1 ts2 s2))

   ;;; -----------------------------------------------------------------------
   ;; Added by Yongjun Zhang 
   ((eq cons-type 'same-line) 

    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-sameline-cks* (+ 1 *constraint-sameline-cks*))

    (check-same-line constraint ts1 s1 ts2 s2))

   ;; Added by Yongjun Zhang 
   ((eq cons-type 'is-zero) 

    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-iszero-cks* (+ 1 *constraint-iszero-cks*))

    (check-is-zero constraint ts1 s1 ts2 s2))

   ;;; -----------------------------------------------------------------------
   ;; Same Name (pairwise, exactly)
   ((eq cons-type 'same-name-p)
    
    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-same-name-cks* (+ 1 *constraint-same-name-cks*))

    (check-same-name-p constraint ts1 s1 ts2 s2))

   ;;; -----------------------------------------------------------------------
   ;; Close-to-p
   ((eq cons-type 'close-to-p)
    
    ;; Locality not counted in total constraint checks, keep track though
    ;; (setq *constraint-cks* (+ 1 *constraint-cks*))
    ;; (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-close-to-cks* (+ 1 *constraint-close-to-cks*))

    (check-close-to-p constraint ts1 s1 ts2 s2))

   ;;; -----------------------------------------------------------------------
   ;; Same Type (pairwise only)
   ((eq cons-type 'same-type-p)

    (setq *constraint-cks* (+ 1 *constraint-cks*))
    (if  *debug-consis* (comment1 " " *constraint-cks*))
    (setq *constraint-same-type-cks* (+ 1 *constraint-same-type-cks*))
    
    (check-same-type-p constraint ts1 s1 ts2 s2))

   ;; else constraint unknown ... signal an error
   (t
    (comment1 "Constraint error" (first constraint))     
    nil)

   )) )

;; ***************************************************************************
(defun get-sit-dependency ( sit-comp-index  var-posi )
	(let* ((hash-value (gethash sit-comp-index *component-hash*))
		   (comp-body  (first hash-value))
		   (this-var (nth var-posi comp-body)) 
		   (dependency (second hash-value)))
		(rest
			(first (member this-var dependency :test
				#'(lambda (x y) 
					(eql x (first (first y)))))))) 
)
;; ***************************************************************************
(defun get-sit-variable ( sit-comp-index  var-posi )
	(let* ((hash-value (gethash sit-comp-index *component-hash*))
		   (comp-body  (first hash-value))
		   (this-var (nth var-posi comp-body)) 
		   (dependency (second hash-value)))
		(first 	
			(first (member this-var dependency :test
				#'(lambda (x y) 
					(eql x (first (first y)))))))) 
)
;; ***************************************************************************
(defun compare-dependency (atom-or-list-1 atom-or-list-2 )
  (cond ((atom atom-or-list-1) (equal atom-or-list-1 atom-or-list-2))
    ((atom atom-or-list-2) nil)
    ((not (eq (length atom-or-list-1) (length atom-or-list-2))) nil)
    (T	(in-other-list atom-or-list-1 atom-or-list-2)))
  )
;; ***************************************************************************
(defun get-var-posi (temp-comp-name var-name )
	(let* ((this-comp (second (first
			(member temp-comp-name (second *current-template*) :test
				#'(lambda (x y )
					(equal x (first y))))))) 	
		   (temp (length (member var-name this-comp))))
	(- (length this-comp) temp)) 	
)   
;; ***************************************************************************
;; Constraint verification routines
;; ***************************************************************************
;; (POSSIBLE-DATA-DEPENDENCY (E4 E7) ID8) E7 AVERAGEC_9 E4  AVERAGEC_10)
(defun check-possible-data-dependency (constraint t1 s1 t2 s2 )
  (let* (
	 (aflist   (get-affected-list constraint))
	 (order    (if (eq t1 (first aflist)) 't1 't2))  ;; who is a, a < b
	 (temp-t	t1)
	 (temp-s	s1) 
	 (t1 (if (eq order 't1) t1 t2))
	 (t2 (if (eq order 't1) t2 temp-t))
	 (s1 (if (eq order 't1) s1 s2))
	 (s2 (if (eq order 't1) s2 temp-s))
	 (t1-posi  (get-var-posi t1 (nth 2 constraint)))   
	 (s1-dependency  (get-sit-dependency s1 t1-posi))  ; 
	 (dependency (cond ((atom s1-dependency) (equal s2 s1-dependency)) 
					 (T (member s2 s1-dependency)))))                        
;;  (format t
;;          "~%~a  ~a  ~a  ~a  ~a"
;;          constraint t1 s1 t2 s2)
               
    (if dependency 
	(progn
	  (if  *debug-consis* (comment2 "possible-data-dependency succeed for" s1 s2))
	  t)
      (progn
	(if  *debug-consis* (comment2 "possible-data-dependency fail for" s1 s2))
	nil)
      )) )

;; ***************************************************************************
;; (GUARANTEED-DATA-DEPENDENCY (E4 E7) ID8) E7 AVERAGEC_9 E4  AVERAGEC_10)
(defun check-guaranteed-data-dependency (constraint t1 s1 t2 s2 )
  (let* (
	 (aflist   (get-affected-list constraint))
	 (order    (if (eq t1 (first aflist)) 't1 't2))  ;; who is a, a < b
	 (temp-t	t1)
	 (temp-s	s1) 
	 (t1 (if (eq order 't1) t1 t2))
	 (t2 (if (eq order 't1) t2 temp-t))
	 (s1 (if (eq order 't1) s1 s2))
	 (s2 (if (eq order 't1) s2 temp-s))
	 (t1-posi  (get-var-posi t1 (nth 2 constraint)))   
	 (s1-dependency  (get-sit-dependency s1 t1-posi))  ; 
;;	 (dependency (cond ((atom s1-dependency) (equal s2 s1-dependency)) 
;;					 (T nil))))                        
;;above statement is modified to the following to test CPU difference on Jan 9, 1997

	 (dependency (equal s2 s1-dependency)))                        

;;  (format t
;;          "~%~a  ~a  ~a  ~a  ~a"
;;          constraint t1 s1 t2 s2)
               
    (if dependency 
	(progn
	  (if  *debug-consis* (comment2 "guaranteed-data-dependency succeed for" s1 s2))
	  t)
      (progn
	(if  *debug-consis* (comment2 "guaranteed-data-dependency fail for" s1 s2))
	nil)
      )) )


;; ***************************************************************************
;;(SAME-DATA-DEPENDENCY (E4 E3) (ID8 ID5)) E4 AVERAGEC_10 E3 AVERAGEC_4 
(defun check-same-data-dependency (constraint t1 s1 t2 s2 )
  (let* (
	 (aflist   (get-affected-list constraint))
	 (order    (if (eq t1 (first aflist)) 't1 't2))  ;; who is a, a < b
	 (temp-t	t1)
	 (temp-s	s1) 
	 (t1 (if (eq order 't1) t1 t2))
	 (t2 (if (eq order 't1) t2 temp-t))
	 (s1 (if (eq order 't1) s1 s2))
	 (s2 (if (eq order 't1) s2 temp-s))
	 (t1-posi  (get-var-posi t1 (first (nth 2 constraint))))   
	 (t2-posi  (get-var-posi t2 (second (nth 2 constraint))))  
	 (s1-dependency  (get-sit-dependency s1 t1-posi))  ; 
	 (s2-dependency  (get-sit-dependency s2 t2-posi)) ;  
	 (same-dependency (compare-dependency s1-dependency s2-dependency))  
	)           
                       
;;  (format t
;;          "~%~a  ~a  ~a  ~a  ~a"
;;          constraint t1 s1 t2 s2)
 
    (if same-dependency 
	(progn
	  (if  *debug-consis* (comment2 "same-data-dependency succeed for" s1 s2))
	  t)
      (progn
	(if  *debug-consis* (comment2 "same-data-dependency fail for" s1 s2))
	nil)
      )) )
;; ***************************************************************************
(defun check-same-variable (constraint t1 s1 t2 s2 )
  (let* (
	 (aflist   (get-affected-list constraint))
	 (order    (if (eq t1 (first aflist)) 't1 't2))  ;; who is a, a < b
	 (temp-t	t1)
	 (temp-s	s1) 
	 (t1 (if (eq order 't1) t1 t2))
	 (t2 (if (eq order 't1) t2 temp-t))
	 (s1 (if (eq order 't1) s1 s2))
	 (s2 (if (eq order 't1) s2 temp-s))
	 (t1-posi  (get-var-posi t1 (first (nth 2 constraint))))   
	 (t2-posi  (get-var-posi t2 (second (nth 2 constraint))))  
	 (s1-var  (get-sit-variable s1 t1-posi))  ; 
	 (s2-var  (get-sit-variable s2 t2-posi)) ;  
	 (same-var (equal s1-var s2-var))  
	)           
                       
;;  (format t
;;          "~%~a  ~a  ~a  ~a  ~a"
;;          constraint t1 s1 t2 s2)
 
    (if same-var 
	(progn
	  (if  *debug-consis* (comment2 "same-variable succeed for" s1 s2))
	  t)
      (progn
	(if  *debug-consis* (comment2 "same-variable fail for" s1 s2))
	nil)
      )) )
;; ***************************************************************************
(defun in-dependency ( comp-index dependency )
	(cond ((endp dependency) nil)
		  (T
 			(let ((first-dependency (cdar dependency))) 
				(cond ((and (atom first-dependency) 
							(eql first-dependency comp-index)) T)
					  ((and (listp first-dependency) 
 							(member comp-index first-dependency)) T)
					  (T (in-dependency comp-index (rest dependency)))))))   
)
;; ***************************************************************************
;;(CONTROL-DATA-DEPENDENCY (E4 E3) (ID8 ID5)) E4 AVERAGEC_10 E3 AVERAGEC_4 
(defun check-control-data-dependency (constraint t1 s1 t2 s2 )
  (let* (
	 (aflist   (get-affected-list constraint))
	 (order    (if (eq t1 (first aflist)) 't1 't2))  ;; who is a, a < b
	 (temp-t	t1)
	 (temp-s	s1) 
	 (t1 (if (eq order 't1) t1 t2))
	 (t2 (if (eq order 't1) t2 temp-t))
	 (s1 (if (eq order 't1) s1 s2))
	 (s2 (if (eq order 't1) s2 temp-s))
	 (s1-dependency  (nth 1 (gethash  s1 *component-hash*))) ;  
	 (control-dependency (in-dependency s2 s1-dependency))  
	)           
                       
;;  (format t
;;          "~%~a  ~a  ~a  ~a  ~a"
;;          constraint t1 s1 t2 s2)
 
    (if control-dependency 
	(progn
	  (if  *debug-consis* (comment2 "control-data-dependency succeed for" s1 s2))
	  t)
      (progn
	(if  *debug-consis* (comment2 "control-data-dependency fail for" s1 s2))
	nil)
      )) )
;; ***************************************************************************

(defun check-before-p (constraint t1 s1 t2 s2 )
  (let* (
	 (aflist   (get-affected-list constraint))
	 (order    (if (eq t1 (first aflist)) 't1 't2))  ;; who is a, a < b
	 (s1-line  (get-sit-obj-line-adj s1))  ; changed by YJ from adj to act 
	 (s2-line  (get-sit-obj-line-adj s2))  ; ......................
	 (before-p (if (eq order 't1) (<= s1-line s2-line) (<= s2-line s1-line)))
	)                                      ;; changed from < to <=  
    (if before-p
	(progn
	  (if  *debug-consis* (comment2 "Before-p succeed for" s1 s2))
	  t)
      (progn
	(if  *debug-consis* (comment2 "Before-p fail for" s1 s2))
	nil)
      )) )

;; Added by Yongjun Zhang 
(defun check-same-line (constraint t1 s1 t2 s2 )
  (let* (
	 (aflist   (get-affected-list constraint))
	 (order    (if (eq t1 (first aflist)) 't1 't2))  ;; who is a, a < b
	 (s1-line  (get-sit-obj-line-act s1))  ; changed by YJ from adj to act 
	 (s2-line  (get-sit-obj-line-act s2))  ; ......................
	 (sameline (eq s2-line s1-line))
	)                                   
    (if sameline  
	(progn
	  (if  *debug-consis* (comment2 "Same-line succeed for" s1 s2))
	  t)
      (progn
	(if  *debug-consis* (comment2 "Same-line fail for" s1 s2))
	nil)
      )) )

(defun check-is-zero ( constraint t1 s1 t2 s2 )
  (let* (
	 (aflist   (get-affected-list constraint))
	 (plist    (get-parameter-list constraint))
	 (order    (if (eq t1 (first aflist)) 't1 't2)) 
	 (t1-templNameVar (if (eq order 't1) (first  plist) (second plist)))
	 (t2-templNameVar (if (eq order 't2) (first  plist) (second plist)))
	 (t1-var-pos  (get-ts-obj-namePos t1 t1-templNameVar))
	 (t2-var-pos  (get-ts-obj-namePos t2 t2-templNameVar))
	 (s1-obj (get-sit-object s1))
	 (s2-obj (get-sit-object s2))
	 (s1-name (if (> t1-var-pos 0) 
		      (get-sit-param-clean s1-obj t1-var-pos) nil))
	 (s2-name (if (> t2-var-pos 0) 
		      (get-sit-param-clean s2-obj t2-var-pos) nil))
	 )

	(print "constraint:") 
	(print constraint)
	(print t1)
	(print s1)
	(print t2)
	(print s2)
	(print s1-obj)
	(print s2-obj)
	(print s1-name)
	(print s2-name)

    (if (or (< t1-var-pos 0) (< t2-var-pos 0))
	;; error in setup ...
	(progn
	  (comment2 "Error, is-zero, not found" t1-var-pos t2-var-pos)
	  nil)
      ;; check for equality
      (if (equal s1-name 0)
	  ;; equality success !
	  (progn
	    (if  *debug-consis* (comment2 "is-zero succeed for" s1 s2))
	    t)
	;; equality failure !
	(progn
	  (if  *debug-consis* (comment2 "is-zero fail for" s1 s2))
	  nil) ))) )


(defun check-same-name-p ( constraint t1 s1 t2 s2 )
  (let* (
	 (aflist   (get-affected-list constraint))
	 (plist    (get-parameter-list constraint))
	 (order    (if (eq t1 (first aflist)) 't1 't2)) 
	 (t1-templNameVar (if (eq order 't1) (first  plist) (second plist)))
	 (t2-templNameVar (if (eq order 't2) (first  plist) (second plist)))
	 (t1-var-pos  (get-ts-obj-namePos t1 t1-templNameVar))
	 (t2-var-pos  (get-ts-obj-namePos t2 t2-templNameVar))
	 (s1-obj (get-sit-object s1))
	 (s2-obj (get-sit-object s2))
	 (s1-name (if (> t1-var-pos 0) 
		      (get-sit-param-clean s1-obj t1-var-pos) nil))
	 (s2-name (if (> t2-var-pos 0) 
		      (get-sit-param-clean s2-obj t2-var-pos) nil))
	 )

    (if (or (< t1-var-pos 0) (< t2-var-pos 0))
	;; error in setup ...
	(progn
	  (comment2 "Error, same-name-p, not found" t1-var-pos t2-var-pos)
	  nil)
      ;; check for equality
      (if (equal s1-name s2-name)
	  ;; equality success !
	  (progn
	    (if  *debug-consis* (comment2 "Same-name-p succeed for" s1 s2))
	    t)
	;; equality failure !
	(progn
	  (if  *debug-consis* (comment2 "Same-name-p fail for" s1 s2))
	  nil) ))) )

(defun check-close-to-p (constraint t1 s1 t2 s2 )
"Two statements are close together if they are within some number of 
 statements as indicated in the constraint."
;(print constraint)
;(print t1)
;(print s1)
;(print t2)
;(print s2) 
(let* (
      (maxDist (third constraint))
      (s1Pos   (get-sit-obj-line-adj s1))    ;; modifed -adj to -act  08/96 
      (s2Pos   (get-sit-obj-line-adj s2))    ;; modifed -adi to -act  08/96 
      (result  (<= (abs (- s1Pos s2Pos)) maxDist))
      )
  
  (if  *debug-consis*
      (if result
	  (comment2 "Close-to-p succeed for" s1 s2)
	(comment2 "Close-to-p fail for" s1 s2)))
;;  (print s1Pos)
;;  (print s2Pos) 
;;  (print (- s1Pos s2Pos))
;;  (print maxDist)   
;;  (print result) 
  result   ;; return the final value
  ))

(defun check-same-type-p (constraint t1 s1 t2 s2)

  ;; Note that this is not completed.  How do we check types without any
  ;;  explicit instantiations or necessarily occuring decl statements? 
  ;; Also, we must be aware of the fact that we are only looking LOCALLY
  ;; at the context between t1=s1 and t2=s2  and not all other pairings, etc.

  ; Also note that since we are already node consistent, any type values will
  ; necessarily match those with explicit restrictions, ie Decl.

  ; Could do type checks assuming the existence of a decl stmt ... via 
  ;  a name check  with the decl statement, thus involving t1 t2 and t-decl

  t  ;; simply return t always
  )

;; ***************************************************************************
;; Matching routines for tslots and sit-objs
;; ***************************************************************************

(defun ts-matches-type (tslot sit-obj)
"
 Does template slot match situation object for stmt type value ?
"
(setq *node-consistency-checks* (+ 1 *node-consistency-checks*))
(setq *ts-match-type-count* (+ 1 *ts-match-type-count*))

(let (
      (ts-type        (get-tslot-type tslot))
      (so-type        (get-sit-type sit-obj))
      )

  (if (not (equal ts-type so-type))    ;; Types not same, reject immediately
      nil
    T)))

;;Modified here (commented all the following )
    ;; Decl
;;    (if (eq ts-type 'Decl)             ;; Types are both DECL stmts ... check
;;	(let* (
	       ;; check type to be declared, Decls have only 1 parameter
	       ;; ts type is a list, of two possible formats: array, not array
;;	       (ts-wholeType  (get-tslot-stmt-param-type tslot 1))
;;	       (so-declType   (get-sit-param sit-obj 1))
;;	      )
;;	  (if (and (eq (first ts-wholeType) 'array)    ;; mismatch case 1
;;		   (not (eq so-declType 'array)))
;;	      nil
;;	    (if (and (not (eq (first ts-wholeType) 'array))  ;; mismatch case 2
;;		     (eq so-declType 'array))
;;		nil
;;	      (if (eq so-declType 'array)              ;; both array decls
;;		  (let (
;;			(ts-arr-type-list (second ts-wholeType))  ;; tmpl rng 
;;			(ts-arr-size-rng  (third  ts-wholeType))  ;; tmpl rng
;;			(so-declArrType   (get-sit-param sit-obj 3)) ;; so val
;;			(so-declArrSize   (get-sit-param sit-obj 4)) ;; so val
;;			)
;;		    (if (and (or-equal so-declArrType ts-arr-type-list)
;;			     (in-range so-declArrSize ts-arr-size-rng))
;;			t
;;		      nil))
;;		(let (                               ;; both NOT array decls
;;		      (ts-type-rng       ts-wholeType)
;;		      )
;;		  (if (or-equal so-declType ts-type-rng)
;;			t
;;		      nil)  )))))
;;
      ;;  Zero
;;      (if (eq ts-type 'Zero)
;;	  (zap-ck-param-length tslot sit-obj)
;;
;;	(if (eq ts-type 'Assign)
;;	    (zap-ck-param-length tslot sit-obj)
;;
;;My change July 9
	
;;	(if (eq ts-type 'Call)
;;	    (zap-ck-param-length tslot sit-obj)
;;
;;	(if (eq ts-type 'Equals)
;;	    (zap-ck-param-length tslot sit-obj)

;;My change Aug 13

;;	(if (eq ts-type 'LessEq)
;;	    (zap-ck-param-length tslot sit-obj)
;;
;;	(if (eq ts-type 'Index)
;;	    (zap-ck-param-length tslot sit-obj)
;;
;;	(if (eq ts-type 'Plus)
;;	    (zap-ck-param-length tslot sit-obj)

;;change till here, parenthesis are added after 

 
;;	  (if (eq ts-type 'Print)
;;	      (zap-ck-param-length tslot sit-obj)
;;
;;	    (if (eq ts-type 'Check)    
;;		(zap-ck-param-length tslot sit-obj)  
;;
;;	      (if (eq ts-type 'Increment)    
;;		  (zap-ck-param-length tslot sit-obj)  
;;
;;		(if (eq ts-type 'Not-Equals)    
;;		    (zap-ck-param-length tslot sit-obj)  
;;
;;		  (if (eq ts-type 'Begin)    
;;		      t 
;;		    (if (eq ts-type 'End)    
;;			t 
;;		      (if (eq ts-type 'For) 
;;			  t 
;;			(if (eq ts-type 'While) 
;;			    t 
;;			)))))))) )))))))))))

(defun zap-ck-param-length (tslot sit-obj)
" 
Note that for functions Zero, Print and Assign which operate on
arrays or other objects with the type information EXPLICITLY located
in information from other statments, 
a node consistency check simply counts the parameters
and if the param length is the same, succeeds.  
 Any TYPECHECKING of situation elements REQUIRES selection of
 a particular instance rather than a set of instances .....
"
  (let ( 
	(ts-num-param (length (get-tslot-stmt-body tslot)))
	(so-num-param (length (get-sit-param-list sit-obj)))
	)
   
	(if (eq ts-num-param so-num-param)
	t
      nil)) )


;; ***************************************************************************
;; Object accessors for ADT domain
;; ***************************************************************************

;; **************************************************
;; Template object accessors
;;
;; Template object ( template-id
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

;;;  ------------------------------------------------------------------------
;;; Access Detail via tslot id only
;;;  ------------------------------------------------------------------------

(defun get-ts-obj (tslot-id)
  (get-templ-slot-object *current-template* tslot-id))

(defun get-ts-obj-namePos (tslotid name)
  (member-count name (get-tslot-stmt-body (get-ts-obj tslotid))))

;;;  ------------------------------------------------------------------------

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

(defun get-related-variables-1 (t1id constraints)
  (let* (
	 (rel-consts (get-related-constraints-1 t1id constraints))
	 )
    (get-other-vars-only t1id rel-consts)))


(defun get-other-vars-only (tid rel-consts)
  (remove-if #'(lambda (x) (equal x tid)) (get-other-vars tid rel-consts)))

(defun get-other-vars (tid rel-consts)
  (if (null rel-consts)
      nil
    (let* (
	   (this    (car rel-consts))
	   (rest (cdr rel-consts))
	   (this-al (get-affected-list this))
	   )
      (union this-al (get-other-vars tid rest)))))
	        

(defun get-related-constraints-1 (t1id constraints)
"
 Adapted from get-slot-intersection for use in gsat.lisp
"
(let (
      (constraint        (car constraints))
      (rest-constraints  (cdr constraints))
      )
  (if (null constraint) 
      nil
    (if (applies-to-one-p constraint t1id)
	(append (list constraint)
		(get-related-constraints-1 t1id rest-constraints))
      (get-related-constraints-1 t1id rest-constraints)) )))

(defun applies-to-p (constraint t1id t2id)
"
Does this constraint apply to these templates ids ?
"
(member-both-p t1id t2id (get-affected-list constraint)) )


(defun applies-to-one-p (constraint t1id)
"
Does this constraint apply to this templates id ?
"
(member t1id (get-affected-list constraint)) )


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

;; Modified here 
;; Stmt type
;;
(defun get-tslot-type (tslot)
 " Statement type, one of Decl, Zero, Assign, Print, For .... "
;;  (second tslot)
	(first (second tslot)))
	
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


;; ***************************************************************************
;; access stuff via tslotid
;; ***************************************************************************
;; Stmt parameter posn by name  HERE HERE 
;;
(defun get-tslot-namePos (tslot name)
  (member-count name (get-tslot-stmt-body tslot)))

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
;  (print ident)
;  (print (get-sit-object ident)) 
  (second (get-sit-object ident)))

;;
(defun get-sit-obj-line-adj (ident)
"
 Return adjusted line number.
"
(first (get-sit-obj-line ident)))

;;
(defun get-sit-obj-line-act (ident)
"
 Return actual (initial) line number
"
(second (get-sit-obj-line ident)))

;;
(defun get-sit-obj-type (ident)
"
Given sit id, return type.
"
  (get-sit-type (get-sit-object ident)))
;; 

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
Return identifier of sit-obj.
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

;;Modified here 
;; Stmt Type
;;
(defun get-sit-type (sit-obj)
"
Return the Stmt Type of Stmt in sit-obj
"
;;(first (get-sit-stmt sit-obj))
	(second sit-obj))

;; Stmt Parameter List
;;
(defun get-sit-param-list (sit-obj)
"
Return the Parameter List of Stmt in sit-obj

"
(cdr (get-sit-stmt sit-obj)))

;; Clean up sit param list for name checking by position
;;
(defun get-sit-param-list-nodecl (sit-obj)
 "
Retrn the Parameter List of Stmt in sit-obj, removing type stuff from Decl stmt
"
(remove-types-from-param-list (get-sit-param-list sit-obj)))

;; Stmt parameter with cleaned up Decl part
;;
(defun get-sit-param-clean (sit-obj n)
  (nth (1- n) (get-sit-param-list-nodecl sit-obj)))

;; Stmt Parameter
;;
(defun get-sit-param ( sit-obj n )
  " 
   Return statement parameter by parameter position.
    we assume that access to this is in context-sensitive position by
    stmt type.
  "
  (nth n (get-sit-stmt sit-obj)))


;; **********************************************************************
;; SET LOADED FLAG 
;; **********************************************************************
(setq *domain-loaded* 'adt)

