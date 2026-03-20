;; memory-csp.lisp
(defun cmcsp () (compile-file "memory-csp") (load "memory-csp"))
(defun lmcsp () (load "memory-csp.lisp"))
;;
;; My SECOND implementation of Quilici's approach to indexing, ordering etc 
;;  this time decomposed into two P-CSP phases : index and resolution
;; The index phase is strictly ordered according to the input variable 
;;  order.  The resolution phase is configurable.
;;

(defun memory-search (
		      index-template-id
		      whole-template-id

		      &key 
		      (situation-id   "quilici-i1")
		      (sit-noise                 0)
		      (rand-dist           "dist1")  
		      (random-ident       'default)  
		      (output-file             nil)  
		      (long-output             nil)  
		      (single-line-override      t)
		      (suppress-single-line      t)
		      (memory-key                t) ; single line here only
		      (memory-output-file      nil)

		      ;; Phase 1 options ------------------------------
		      ;;   note index ordering is given
		      (1-search-mode "bt")
		      (1-node-consis               t) 
		      (1-arc-consis              nil)  
		      (1-forward-checking        nil)  
		      (1-dynamic-rearrangement   nil)  
		      (1-advance-sort            nil)
		      (1-sort-const              nil)
		      (1-adv-sort-const          nil)
		      (1-one-solution-only       nil)  

		      ;; Phase 2 options ------------------------------
		      (2-search-mode "bt")
		      (2-node-consis               t) 
		      (2-arc-consis              nil)  
		      (2-forward-checking          t)
		      (2-dynamic-rearrangement     t)
		      (2-advance-sort              t)
		      (2-sort-const          'random)  
		      (2-adv-sort-const      'random)  
		      (2-one-solution-only       nil)  
		      
		      ) 
" Two-Phase Memory-Based Mapping CSP.  "

 (let* (
	(partial-solution-set nil)
	(complete-solution-set nil)
	(cur-part-solution 0)
	(cur-part-name     nil)
	)
	;; ---------------------------------------------------------------
	;; Phase 1 
	;; ---------------------------------------------------------------

   ;; set global counter variable *value-series*
   (initialize-value-series)

   (save-values :name "phase1" :mode "zero")
   (save-values :name "both"   :mode "zero")

   (setq partial-solution-set 
	 (adt :situation-id situation-id
	      :sit-noise    sit-noise
	      :rand-dist     rand-dist
	      :random-ident  random-ident
	      :output-file   output-file
	      :long-output   long-output
	      :single-line-override    single-line-override
	      :suppress-single-line    suppress-single-line

	      :template-id index-template-id     

	      :search-mode            1-search-mode 
	      :node-consis            1-node-consis 
	      :arc-consis             1-arc-consis 
	      :forward-checking       1-forward-checking 
	      :dynamic-rearrangement  1-dynamic-rearrangement 
	      :advance-sort           1-advance-sort
	      :sort-const             1-sort-const 
	      :adv-sort-const         1-adv-sort-const 
	      :one-solution-only      1-one-solution-only 
	      ))

   (save-values :name "phase1" :mode "increment")
   (save-values :name "both"   :mode "increment")

   ;; ---------------------------------------------------------------
   ;; Phase 2 
   ;; ---------------------------------------------------------------

   (save-values :name "phase2" :mode "zero")

   (dolist (one-part-soln partial-solution-set complete-solution-set)
	   (let (
		 (one-revised nil)
		 )

	     (setq one-revised
		   (adt :situation-id situation-id
			:sit-noise    sit-noise
			:rand-dist     rand-dist
			:random-ident  random-ident
			:output-file   output-file
			:long-output   long-output
			:single-line-override    single-line-override
			:suppress-single-line    suppress-single-line

			:template-id  whole-template-id  
			  
			:search-mode            2-search-mode 
			:node-consis            2-node-consis 
			:arc-consis             2-arc-consis 
			:forward-checking       2-forward-checking 
			:dynamic-rearrangement  2-dynamic-rearrangement 
			:advance-sort           2-advance-sort
			:sort-const             2-sort-const 
			:adv-sort-const         2-adv-sort-const 
			:one-solution-only      2-one-solution-only 
			  
			:part-soln    one-part-soln
			))

	     ;; save individual resolution values
	     (setq cur-part-solution (1+ cur-part-solution))
	     (setq cur-part-name     (concatenate 'string "partial" 
  				      (num-to-string cur-part-solution)))
	     (save-values :name cur-part-name :mode "zero")
	     (save-values :name cur-part-name :mode "increment")

	     ;; keep running totals
	     (save-values :name "phase2" :mode "increment")
	     (save-values :name "both"   :mode "increment")

	     (setq complete-solution-set
		   (append complete-solution-set
			   (list one-revised)))
	     )) ;; dolist

   (setq complete-solution-set
	 (remove-if #'(lambda (x) (null x)) complete-solution-set))


   (if memory-key
       (progn

	 (if (not (null memory-output-file))
	     (progn
	       (comment1 "Memory-Key opened file/stream" memory-output-file)
	       (setq *output-stream*
		     (open memory-output-file 
			   :direction :output 
			   :if-exists :append 
			   :if-does-not-exist :create))
	       ))

	 (show-solution :solution-set   partial-solution-set
			:exit-location  'memory-csp-phase1 
			:replace-values "phase1"
			:memory-key t)

	 (show-solution :solution-set   complete-solution-set 
			:exit-location  'memory-csp-phase1 
			:replace-values "phase2"
			:memory-key t)

	 (show-solution :solution-set   complete-solution-set 
			:exit-location  'memory-csp-phase1 
			:replace-values "both"
			:memory-key t)

	 (if (not (null memory-output-file))
	     (progn
	       (close *output-stream*)
	       (setq *output-stream* *standard-output*)
	       (format *output-stream*
		       "~&~& File/stream closed (at Memory-Key). ~2&")))
	 ))

   complete-solution-set
   ) ;; let* 
 ) ;; defun


(defun initialize-value-series ()
   (setq *value-series* '()))

(defun save-values (&key (name "default") (mode "zero"))
" Maintain in-storage counters of performance in order to
  output a comprehensive explanation of performance."

(if (equal mode "zero")
    ;; zero out specific name entry
    (insert-values name
		   (list
		    0   ;; *Situation-noise-added*
		    'uk ;; *search-mode*
		    'uk ;; *node-consis*
		    'uk ;; *arc-consis*
		    'uk ;; *forward-checking*
		    'uk ;; *dynamic-rearrangement* 
		    'uk ;; *random-ident*
		    'uk ;; avg var len is used as phase identifier string 
		    0   ;; *node-consistency-checks*
		    0   ;; *constraint-cks*
		    0   ;; *backtrack-nodes-created*
		    0   ;; *nodes-visited*
		    0   ;; Advance processing time
		    0   ;; Search time
		    0   ;; Total time
		    0   ;; *backjump-count*
		    0   ;; *type-a-savings*
		    0   ;; *type-b-savings*
		    0   ;; *for-check-cost*
		    0   ;; *dyn-rearr-cost*
		    nil ;; *advance-sort*
		    0   ;; Advance sort time
		    nil ;; *sort-const* 
		    nil ;; *adv-sort-const* 
		    nil ;; *solution-set*
		    ))

  (if (equal mode "replace")
      ;; replace current name entries
      (insert-values name
		     (list
		      *Situation-noise-added*
		      *search-mode*
		      *node-consis*
		      *arc-consis*
		      *forward-checking*
		      *dynamic-rearrangement* 
		      *random-ident*
		      name                          ;; use this space for id
		      *node-consistency-checks*
		      *constraint-cks*
		      *backtrack-nodes-created*
		      *nodes-visited*
		      (/ (- *internal-advance-end-time* 
			    *internal-advance-start-time*)
			 (* 1.0 internal-time-units-per-second))
		      (/ (- *internal-end-time* 
			    *internal-start-time*)
			 (* 1.0 internal-time-units-per-second))
		      (/ (- *internal-end-time* 
			    *internal-advance-start-time*)
			 (* 1.0 internal-time-units-per-second))
		      *backjump-count*
		      *type-a-savings*
		      *type-b-savings*
		      *for-check-cost*
		      *dyn-rearr-cost*
		      *advance-sort*
		      (/ (- *internal-sort-end-time* 
			    *internal-sort-start-time*)
			 (* 1.0 internal-time-units-per-second))
		      *sort-const* 
		      *adv-sort-const* 
		      *solution-set*
		      ))

    (if (equal mode "increment")
	;; increment current name entries
	(increment-values name
		     (list
		      *Situation-noise-added*
		      *search-mode*
		      *node-consis*
		      *arc-consis*
		      *forward-checking*
		      *dynamic-rearrangement* 
		      *random-ident*
		      name                          ;; use this space for id
		      *node-consistency-checks*
		      *constraint-cks*
		      *backtrack-nodes-created*
		      *nodes-visited*
		      (/ (- *internal-advance-end-time* 
			    *internal-advance-start-time*)
			 (* 1.0 internal-time-units-per-second))
		      (/ (- *internal-end-time* 
			    *internal-start-time*)
			 (* 1.0 internal-time-units-per-second))
		      (/ (- *internal-end-time* 
			    *internal-advance-start-time*)
			 (* 1.0 internal-time-units-per-second))
		      *backjump-count*
		      *type-a-savings*
		      *type-b-savings*
		      *for-check-cost*
		      *dyn-rearr-cost*
		      *advance-sort*
		      (/ (- *internal-sort-end-time* 
			    *internal-sort-start-time*)
			 (* 1.0 internal-time-units-per-second))
		      *sort-const* 
		      *adv-sort-const* 
		      *solution-set*
		      ))

      (comment1 "Invalid save-values mode: " mode) ))))


(defun insert-values (name value-lst)
  (let (
	(this (member name *value-series* :test #'(lambda (x y) 
						    (equal x (car y)))))
	) 
    (if (null this)
	(setq *value-series*
	      (cons (list name value-lst) *value-series*))
      (setf (car this) (list name value-lst)))))


(defun increment-values (name value-lst)
  (let* (
	 (this (member name *value-series* :test #'(lambda (x y) 
						     (equal x (car y)))))
	 (old-values (cadar this))
	 )
    (if (null this)
	(comment1 "Increment failed - name not found: " name)
      (setf (car this)
	    (list name
		  (list
		   (nth 0 value-lst )  ;; noise
		   (nth 1 value-lst )  ;; search mode  
		   (nth 2 value-lst )  ;; node consis flag
		   (nth 3 value-lst )  ;; arc consis  flag
		   (nth 4 value-lst )  ;; fc flag
		   (nth 5 value-lst )  ;; dr flag
		   (nth 6 value-lst )  ;; ident
		   (nth 7 value-lst )  ;; use this space for name
		                       ;; nc checks
		   (+ (nth 8 value-lst)  (nth 8 old-values))
		                       ;; constraint checks
		   (+ (nth 9 value-lst)  (nth 9 old-values))
		                       ;; backtrack nodes
		   (+ (nth 10 value-lst) (nth 10 old-values))
		                       ;; nodes visited
		   (+ (nth 11 value-lst) (nth 11 old-values))
		                       ;; advance processing time
		   (+ (nth 12 value-lst) (nth 12 old-values))
		                       ;; search time
		   (+ (nth 13 value-lst) (nth 13 old-values))
		                       ;; total time
		   (+ (nth 14 value-lst) (nth 14 old-values))
		                       ;; bj count
		   (+ (nth 15 value-lst) (nth 15 old-values))
		                       ;; type a savings
		   (+ (nth 16 value-lst) (nth 16 old-values))
		                       ;; type b savings
		   (+ (nth 17 value-lst) (nth 17 old-values))
		                       ;; fc cost
		   (+ (nth 18 value-lst) (nth 18 old-values))
		                       ;; dr cost
		   (+ (nth 19 value-lst) (nth 19 old-values))
		                       ;; adv sort type
		   (nth 20 value-lst)
		                       ;; adv sort TIME
		   (+ (nth 21 value-lst) (nth 21 old-values))
		                       ;; dyn sort const type
		   (nth 22 value-lst)
		                       ;; adv sort const type
		   (nth 23 value-lst)
		   (append (nth 24 value-lst) (nth 23 old-values))
		   ))
	    ))))

(defun reload-values ( value-set-name )
  " This routine resets the global parameters with the stored
    value set ... then show-solution can be called with the
    new value set. "
 (let (
       (vallist (recall-values value-set-name))
       )
   (setq *Situation-noise-added*   (nth 0 vallist))
   (setq *search-mode*             (nth 1 vallist))
   (setq *node-consis*             (nth 2 vallist))
   (setq *arc-consis*              (nth 3 vallist))
   (setq *forward-checking*        (nth 4 vallist))
   (setq *dynamic-rearrangement*   (nth 5 vallist))
   (setq *random-ident*            (nth 6 vallist))
   (setq *RECALL-avg-var-len*      (nth 7 vallist))
   (setq *node-consistency-checks* (nth 8 vallist))
   (setq *constraint-cks*          (nth 9 vallist))
   (setq *backtrack-nodes-created* (nth 10 vallist))
   (setq *nodes-visited*           (nth 11 vallist))
   (setq *RECALL-adv-proc-time*    (nth 12 vallist))
   (setq *RECALL-search-time*      (nth 13 vallist))
   (setq *RECALL-total-time*       (nth 14 vallist))
   (setq *backjump-count*          (nth 15 vallist))
   (setq *type-a-savings*          (nth 16 vallist))
   (setq *type-b-savings*          (nth 17 vallist))
   (setq *for-check-cost*          (nth 18 vallist))
   (setq *dyn-rearr-cost*          (nth 19 vallist))
   (setq *advance-sort*            (nth 20 vallist))
   (setq *RECALL-adv-sort-time*    (nth 21 vallist))
   (setq *sort-const*              (nth 22 vallist))
   (setq *adv-sort-const*          (nth 23 vallist))
   (setq *solution-set*            (nth 24 vallist))
   ))

(defun recall-values ( name )
  (nth 1
   (car (member name *value-series* :test #'(lambda (x y) (equal x (car y)))))
))


(defun dump-value-series ()

  (dolist (value-set *value-series*)
	  (let (
		(thisname (car value-set))
		(valuelst (cdr value-set))
		)
	    (show-solution :solution-set    (nth 24 valuelst)
			   :exit-location   'dump-value-series
			   :replace-values  thisname
			   :memory-key t)))
  )

    

 