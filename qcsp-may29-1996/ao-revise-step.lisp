;; ao-revise-step.lisp  (non-aggressive or stepped linking version)
;;

(defun aor-s (&optional (sys *unix*) )
  (if sys
      (progn
	(load	"ao-revise-step.lisp")
	(load	"ao-revise-fns.lisp"))
    (progn
      (load "HD:Languages:Allegro Common Lisp:qcsp:ao-revise-step.lisp")
      (load "HD:Languages:Allegro Common Lisp:qcsp:ao-revise-fns.lisp"))))

(defun ao-revise-step ( srcVar thisTarget constraint-fn maxDepth )
" 
 THIS IS THE STEPPED LINKING VERSION of AO-REVISE - 

  Revision of source domain results in domain values being linked only  as far
  as necessary to justify their continued existence.  Consequently, LINKs are
  COMPLETE only if all values in Domain(Target) have been checked - and LINKs
  are STRONG only if the final value of Domain(Target) is the linked target 
  value, otherwise there always exist other Domain(Target) values to check.

   Return affected VarList if srcVar domain is revised (and existing links
   followed, thus possibly affecting other variables ... if no revisions  are
   made, return nil 

   Revisions are made in-place to domain values and source variable domain.
"
  (let* (
	 (updateVarList nil)
	 (varV1         (CVariable-Name srcVar))
	 (orig-xval     (CVariable-FirstDomainValue srcVar))
	 (xi            (if (listp (DomVal-Name orig-xval))  ; first undel xi
			    (get-next-undel orig-xval)
			  orig-xval))
	 (varV2         (CVariable-Name thisTarget))
	 )

    (loop   ;; iterate over the entire undeleted range of the source variable

     (if (null xi)       ;; no more source values to check
	 (return))       ;; then exit from xi source loop 

     (if *ao-debug*  
	 (comment1 "Loop xi (source) Domain Value : " xi)) 

     (let* (
	    (xi-ok     nil)           ;; this xi initially unjustified
	    (orig-yval (CVariable-FirstDomainValue thisTarget))  
	    (yj        (if (listp (DomVal-Name orig-yval))  ; first undel yj
			   (get-next-undel orig-yval)
			 orig-yval))
	    (yj-sibling  (get-next-undel yj))
	    (xiyj-ok   'fail)        ;; this source, target pair isn't just yet
	    )
     
       ;; iterate over the range of the target variable until a consistent
       ;;  target dom value is found or none remain to check
       (loop  
		                   
	(if (or (null yj)                ;; exit 1 - no more yj to consider 
		(not (fail3-p xiyj-ok))  ;; exit 2 - this xiyj pair success
		)
	    (return))                    ;; then exit from yj target loop 

	(if *ao-debug*  
	    (comment1 "   Loop yj (target) Domain Value : " yj))

	(if (null yj-sibling)   ;; ie does yj have any siblings remaining
	    (progn
	      ;;  No, yj last element in target domain, may simpl src domval 
	      ;;      if xiyj-ok turns out to be poss true : marking necessary

	      (resetVisit xi constraint-fn)

	      ;; note xi is MARKED in place by applyR algorithm ....
	      (setq xiyj-ok  
		    (applyR xi yj constraint-fn 'initial maxDepth 0 t))

	      (if (not (fail3-p xiyj-ok))    
		  (progn    ;; xi yj necc poss consistent 

		    (if *ao-debug* 
			(comment1 "   Not fail3-p xiyj-ok  " xiyj-ok))

		    (setq xi-ok t)    ; xi is justified by yj
		    (addLink xi srcVar yj VarV2 constraint-fn)

		    (if (simplify xi 1 constraint-fn)
			(setq updateVarList (append updateVarList
				(keepSrcValPropagateStep 
				   xi varV1 maxDepth ))))
		    )
		(progn      ;; xi yj NOT poss consistent and no more yj remain

		  (setq xi-ok nil)    ; xi is unjustified w.r.t any yj
		  )
		))

	  ;; ie yj has further siblings - one is yj-sibling
	  (progn
	    ;; yj is NOT last element in target domain so no simplification
	    ;; possible -  therefore : marking unnecessary here

	    (setq xiyj-ok  
		  (applyR xi yj constraint-fn 'initial maxDepth 0 nil))

	    (if (not (fail3-p xiyj-ok))    
		(progn    ;; xi yj necc poss consistent 

		  (if *ao-debug* 
		      (comment1 "   Not fail3-p xiyj-ok  " xiyj-ok))

		  (setq xi-ok t)    ; xi is justified by yj
		  (addLink xi srcVar yj VarV2 constraint-fn)

		  )
	      (progn      ;; xi yj NOT poss consistent, yet more yj remain

		(if *ao-debug* 
		    (comment " xy yj not poss consis, more yj ...  "))

		(setq xi-ok nil)  ; xi currently unjustified
		  
		))
	    ))
	
	(setq yj         yj-sibling)
	(setq yj-sibling (get-next-undel yj-sibling))
	)    ; loop over target domain yj

       (if (not xi-ok)
	   (setq updateVarList (append updateVarList
		       (deleteSrcValPropagateStep 
			   xi srcVar maxDepth constraint-fn ))))
       
       (setq xi    (get-next-undel xi))
       ))  ; loop over source domain xi

    ;; return the updated variable list, each var occurs max once only
    (remove-duplicates updateVarlist)

    )) ;; ao-revise-step

;; ***************************************************************************

(defun deleteSrcValPropagateStep ( xi xi-var maxDepth constraint-fn )
"
  THIS IS THE STEPPED IMPLEMENTATION.  
"
 (if *ao-debug* (comment2 "DeleteSrcValPropagateStep ... xi xi-var" xi xi-var))

  ;; update the domain value's variable domain list to exclude xi
  (setf (CVariable-DomainValueList xi-var)
      (remove xi (CVariable-DomainValueList xi-var)))

  ;; delete DomVal object itself, ie mark xi DELETED 
  (free-storage-domval xi )

  (let* (
	 (HLinks     (DomVal-HasLinks        xi))
	 (TLinks     (DomVal-TargetedByLinks xi))
	 (returnL    (list (DomVal-MyCVariable xi))) ;; xi's del affects var
	 (Xi-Sibling  nil)
	 )

    (delete-forward-hlinks HLinks)

    (dolist (TL TLinks)

	    (setq Xi-Sibling (get-next-undel xi))

	    (if (null Xi-Sibling)
		
		;; Xi has no siblings in order
		(let* (
		       (linkSrcV  (Link-SourceVar TL))
		       (linkSrcD  (Link-Source    TL))
		       )

		  ;; delete the linked SOURCE domval in tlist recursively
		  (setq returnL
			(append returnL
				(deleteSrcValPropagateStep 
				 linkSrcD linkSrcV maxDepth constraint-fn )))
		  )

	      ;; Xi has at least sibling Xi-Sibling in order ....
	      (let* (
		     (found nil)           ;; true if link re-est'd, nil else
		     (last-sibling         ;; true if cur sibl is the last one
  		           (not (get-next-undel Xi-Sibling)))
		     (linkSrcV  (Link-SourceVar TL))
		     (linkSrcD  (Link-Source    TL))
		     )

		(loop   ;; try to re-establish link with an Xi sibling

		 (if (or (null Xi-Sibling)   ;; exit loop if no more siblings
			 found)              ;;   or re-est sibling found
		     (return))

		 (if (not (fail3-p 
			   (applyR linkSrcD Xi-Sibling constraint-fn 
				   'initial maxDepth 0 last-sibling )))
		     (setq found t))

		 ;; try next Xi-sibling
		 (if (not found) 
		     (progn
		       (setq Xi-Sibling   (get-next-undel Xi-Sibling))
		       (setq last-sibling (not (get-next-undel Xi-Sibling)))
		       ))
		 ) ; re-est loop

		(if found    ;; ie re-establishment successful by Xi-Sibling
		    (progn

		      (if (and last-sibling 
			       (simplify linkSrcD 1 constraint-fn))
			  (setq returnL (append returnL
			           (keepSrcValPropagateStep
				     linkSrcD linkSrcV maxDepth ))))

		      ;; update  this link with new target Xi-Sibling
		      (setf (Link-TargetList TL)
			    (cons Xi-Sibling
				  (remove-target xi (Link-TargetList TL))))
		      )

		  (progn     ;; ie re-establishment failed

		    ;; delete the now-unjustified SOURCE domval recursively
		    (setq returnL (append returnL
			     (deleteSrcValPropagateStep 
			        linkSrcD linkSrcV maxDepth constraint-fn )))

		    ))
		)))

    ;; return list of affected variables
    returnL     
    ))

;; ***************************************************************************

(defun keepSrcValPropagateStep ( xi xi-var maxDepth )
"
  THIS IS THE STEPPED IMPLEMENTATION. 

  Since xi was used to justify others, and xi has changed, these
  justifications need to be re-verified.
"
  (if *ao-debug* (comment1 "\n KEEPSrcValPropagateStep ... " xi ))

  (let* (
	 (TLinks (DomVal-TargetedByLinks xi))
	 (returnL nil)
	 )

    (dolist (TL TLinks)
	    (let* (
		   (tlist      (Link-TargetList TL))
		   (srcVar     (Link-SourceVar  TL))
		   (srcD       (Link-Source     TL))
		   (c-fn       (Link-Relation   TL))
		   (Xi-Sibling (get-next-undel xi))
		   (re-assert  nil)
		   )

	      ;;  re-assert chk with mark for last xi case, without otherwise
	      (if (null Xi-Sibling)
		  (progn
		    (resetVisit xi c-fn)
		    (setq re-assert (applyR srcD xi c-fn 
					    'initial maxDepth 0 t))
		    )
		(progn
		    (setq re-assert (applyR srcD xi c-fn 
					    'initial maxDepth 0 nil))
		    ))

	      (if (fail3-p re-assert)    ;; re-assertion necc failed ?

		  ;; yes, xi no longer capable of justifying srcD wrt c-fn
		  (if (null Xi-Sibling)  ;; xi has no siblings ?
		    
		      (progn ;; yes - no siblings

			;; remove Link from DomVal TargetedBy list
			(setf (DomVal-TargetedByLinks xi) (remove TL TLinks))

			;; has link targetlist becomeempty ?
			(if (null 
 			      (setf (Link-TargetList TL) 
				    (remove-target xi tlist)))

			    ;; yes, link has failed
			    (progn
				   
			      ;; remove this link from srcD haslink list
			      (setf (DomVal-HasLinks srcD) 
				    (remove TL (DomVal-HasLinks srcD)))

			      ;; delete this failed justification link
			      (free-storage-link TL)

			      ;; delete the now unjust'd (wrt Link fn) src var
			      ;;   note any propagated vars with deletions
			      (setq returnL (append returnL
				    (deleteSrcValPropagateStep 
				       srcD srcVar maxDepth c-fn )))
			      )

			;; link target list not empty - unexpected in STEP
			(progn
			  ;; each link should only ever have 1 target in list
			  ;;  at a time, so having one left after deletion is
			  ;;  an error.
		     (comment "Warn of unexp non-empty target list in KSVPS.")
			  )) )

		    ;; xi has siblings, first is Xi-Sibling
		    (let* (
			   (found nil)    ;; true if link is re-est'd, nil else
			   (last-sibling  ;; true if cur sibling is last one
			    (not (get-next-undel Xi-Sibling)))
			   )

		      (loop
			
		       (if (or (null Xi-Sibling)   ;; exit loop no more sibl
			       found)              ;;   or re-est sibling found
			   (return))

		       (if (not (fail3-p 
				 (applyR srcD Xi-Sibling c-fn 
					 'initial maxDepth 0 last-sibling )))
			   (setq found t))

		       ;; try next Xi-Sibling
		       (if (not found)
			   (progn
			     (setq Xi-Sibling (get-next-undel Xi-Sibling))
			     (setq last-sibling 
				   (not (get-next-undel Xi-Sibling)))
			     ))
		       ) ; re-est loop

		      (if found    ;; ie re-establish successful by Xi-Sibling
			  (progn

			    (if (and last-sibling (simplify SrcD 1 c-fn))
				(setq returnL (append returnL
			                (keepSrcValPropagateStep
					   SrcD srcVar maxDepth ))))

			    ;; update this link with new target Xi-Sibling
			    (setf (Link-TargetList TL)
				  (cons Xi-Sibling
					(remove-target xi 
						       (Link-TargetList TL))))
			    )
			(progn     ;; ie re-establishment failed

			  ;; delete the now-unjust'd Source domval recursively
			  (setq returnL
				(append returnL
					(deleteSrcValPropagateStep 
					 srcD srcVar maxDepth c-fn )))

			  ;; delete the link object itself (free it ?)
			  (free-storage-link TL)
			  )) ))	)

	      (progn ;; re-assertion succeeded : if xi last one, simplify

		(if (and (null Xi-Sibling) (simplify srcD 1 c-fn))
		    (setq returnL (append returnL
			    (keepSrcValPropagateStep srcD srcVar maxDepth ))))

		))) 

    ;; return list of affected variables
    returnL
    ))
