(in-package #:phd-qcsp-alex)
(defun quilici-search (current-state consistent-p
                        &key    (forward-checking       t)
                                (dynamic-rearrangement  t)
                                (one-solution-only      t)
                                (backjump             nil)
				(arc-c                nil)
				(sch-c                nil)
				)
    (let (
	 prev-node-id
	 node-id
	 partial-solution
	 symbol
	 value
	 domain
	 variables-left
	 arc-cost
	 depth
	 max-fail-level
	 parent-state
	 (solution-set nil)
	 sp-all
	 sp-fail-level
	 s-p
         )

      (setq *internal-start-time* (get-internal-run-time))

      (when (null current-state) 
	    (setq *internal-end-time* (get-internal-run-time))
	    (show-solution solution-set 'null-current-state)
	    (return-from backtracking 'error))

      (setq node-id    	     (bt-state-node-id          current-state))
      (setq prev-node-id     (bt-state-prev-node-id     current-state))
      (setq partial-solution (bt-state-partial-solution current-state))
      (setq symbol  (get-first-symbol (bt-state-variables-left current-state)))
      (setq value            (bt-state-value            current-state))
      (setq domain  (rest (first (bt-state-variables-left current-state))))
      (setq variables-left   (rest (bt-state-variables-left current-state)))
      (setq arc-cost	     (bt-state-arc-cost         current-state))
      (setq depth            (+ 1 (bt-state-depth            current-state)))
      (setq max-fail-level   (bt-state-max-fail-level   current-state))
      (setq parent-state     (bt-state-parent-state     current-state))

      (loop  ;; MAIN BACKTRACKING LOOP

       (if (> (- (get-internal-run-time) *internal-advance-start-time*)
	      (* *cpu-sec-limit* internal-time-units-per-second) )
	   (progn
	     (comment1 "Time limit bound exceeded" *cpu-sec-limit*)
	     (setq *internal-end-time* (get-internal-run-time))
	     (show-solution solution-set 'time-bound-exceeded)
	     (return-from backtracking 'time-bound)	     ))

       (if (> (- (get-internal-run-time) *internal-advance-start-time*)
	      (* *this-check-point* internal-time-units-per-second) )
	   (progn
	     (comment1 "Checkpoint ..." *this-check-point*)
	     (setq *internal-end-time* (get-internal-run-time))
	     (show-solution solution-set 'CHECKPOINT)
	     (setq *this-check-point* (+ *this-check-point* 
					*check-point-interval*))     ))

       (if (endp domain)

	   (block domain-exhausted

		  (when (null parent-state) 
			(setq *internal-end-time* (get-internal-run-time))
			(show-solution solution-set 'null-parent-state)
			(return-from backtracking 'complete))

		  (progn ; backtrack 1 level, ie SEL NXT VAR TO INSTANTIATE

		    (setq node-id      (bt-state-node-id       parent-state))
		    (setq prev-node-id (bt-state-prev-node-id  parent-state))
		    (setq partial-solution 
			  (bt-state-partial-solution parent-state))
		    (setq symbol       (bt-state-symbol         parent-state))
		    (setq value        (bt-state-value          parent-state))
		    (setq domain       (bt-state-domain         parent-state))
		    (setq variables-left 
			  (bt-state-variables-left parent-state))
		    (setq arc-cost     (bt-state-arc-cost       parent-state))
		    (setq depth        (bt-state-depth          parent-state))
		    (setq max-fail-level 
			  (bt-state-max-fail-level parent-state))
		    (setq parent-state  (bt-state-parent-state  parent-state))

		    )) ;; domain-exhausted

	 (block next-domain-value
		
		(setq *nodes-visited* (+ 1 *nodes-visited*))
		(setq node-id (create-node-id))
		(setq value  (first domain)) 	
		(setq domain (rest domain))    

		(setq max-fail-level 0)

   		(setq sp-all
		      (satisfy-p partial-solution 
				 symbol 
				 value 
				 consistent-p ))
		(setq sp-fail-level (second sp-all))
		(setq s-p (first sp-all))

		(if (not (null parent-state))
		    (let ( (old (bt-state-max-fail-level parent-state)) )
		      (if (and (not (eq old -1)) 
			       (> sp-fail-level old))
			  (progn
			    (setf (bt-state-max-fail-level parent-state) 
				  sp-fail-level))
			(progn 
			  ) )))
		
		(when  s-p  

		  (if (endp variables-left)

		      (block no-variables-left

			     (if (not (null parent-state))
				 (progn
				   (setf 
				    (bt-state-max-fail-level parent-state) 
				    -1 )))

			     (if one-solution-only
				 (progn
				   (setq solution-set
					 (cons (cons (list symbol value) 
						     partial-solution) 
					       solution-set))
				   (show-solution solution-set 'one-solution)
				   (return-from backtracking t) )
			       (setq solution-set
				     (cons 
				      (append partial-solution
					      (list (list symbol value) ))
				      solution-set )))
			     ) ;; END no variables left

		    (block instantiate-next-variable

			   (setq *backtrack-nodes-created* 
				 (+ 1 *backtrack-nodes-created*))

			   (if (not (null parent-state))
			       (progn
				 (setf (bt-state-max-fail-level parent-state) 
				       -1)))

			   (setq parent-state
				 (make-bt-state
				  :node-id          node-id
				  :prev-node-id     prev-node-id
				  :partial-solution partial-solution
				  :symbol           symbol
				  :value            value
				  :domain           domain
				  :variables-left   variables-left
				  :arc-cost         arc-cost
				  :depth            depth
				  :max-fail-level   max-fail-level
				  :parent-state     parent-state))

			   (setq prev-node-id node-id)
			   (setq partial-solution
				 (append partial-solution
				  (list (list symbol value))))

			   (when sch-c
			     (setq variables-left 
				   (spatial-consis symbol value 
						   variables-left)) )
			   (when arc-c 
				 (setq cost-before *constraint-cks*)
				 (setq old variables-left)
				 (setq merged (append partial-solution 
						      variables-left))
				 (setq ps-length (length partial-solution))
				 (setq reduced-set
				       (ac-3 merged #'arc-p 
					     #'consistent-p partial-solution))
				 (setq variables-left (nthcdr ps-length
							      reduced-set))   
				 (setq cost-after *constraint-cks*)
				 (setq arc-cost (- cost-after cost-before)) )

			   (when forward-checking
				 (setq variables-left
				       (forward-checking
					symbol
					value
					consistent-p
					variables-left
					partial-solution )) )

			   (when dynamic-rearrangement
				 (setq variables-left (dynamic-rearrangement
						   variables-left)) )

			   (setq symbol (get-first-symbol variables-left))
			   (setq domain (cdar variables-left))
			   (setq depth (+ 1 depth))
			   (setq variables-left
				 (rest variables-left))

			   ) ;; block inst-nxt-var
		    ) ;; block inst-nxt-var
		  ) ;; if endp var-left
		) ;; when s-p
	 );; block nxt dom val
       ) ;; endp domain
      ) ;; loop 
    ) ;; let
) ;; defun 

;; ***************************************************************************
;; ***************************************************************************
;; **** END OF QUILICI SEARCH PROGRAM, CHANGED UTILITIES FOLLOW (FROM BT) ****
;; ***************************************************************************
;; ***************************************************************************
