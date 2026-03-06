(in-package #:phd-qcsp3)
;; ao-revise-agressive.lisp
;;

(defun load-aora ( &optional (sys *unix*) )
  (if sys
      (progn
	(load "ao-revise-aggressive.lisp")
	(load "ao-revise-fns.lisp") 
	)
    (progn
      (load "HD:Languages:Allegro Common Lisp:qcsp:ao-revise-aggressive.lisp")
      (load "HD:Languages:Allegro Common Lisp:qcsp:ao-revise-fns.lisp")
      )))

(defun ao-revise-aggr ( srcVar thisTarget constraint-fn maxDepth )
" 
 THIS IS THE AGGRESSIVE LINKING VERSION of AO-REVISE - 

   Revision of source domain results in domain values being linked against
   target domain values COMPLETELY - that is, all target values are checked for
   each source domain value. Consequently,LINKs are STRONG when only one target
   value supports the source value and are WEAK when more than one target
   values  support the source : a corresponding numerical value indicates
   relative weakness where the number= the number of target values supporting  
   the source domain value.  Note that STRONG links => weak support for the
   source value.
   
 Return affected VarList if srcVar domain is revised (and existing links 
 followed, thus possibly affecting other variables ... if no revisions  are 
 made, return nil

 Revisions are made in-place to domain values and source variable domain.
"
  (let* (
	 (updateVarList nil)
	 (domV1         (CVariable-DomainValueList srcVar))
	 (varV2         (CVariable-Name thisTarget))
	 (domV2         (CVariable-DomainValueList thisTarget)) 
	 )

    (dolist ( xi  domV1 )      ;; iterate over the range of the source variable

	    (if *ao-debug*  
		(comment1 "DoList xi (source) Domain Value : " xi)) 

	    (let* (
		   (xiyj-ok 'fail)  ;; this source, target pair is not
				    ;; justified yet
		   (xi-ok   nil)
		   (yj      nil)   ;; target domain value under consideration
		   (restd   domV2) ;; target domain range under consideration
		   )

	       ;; note it's possible that a back propagation has resulted in
	       ;; 1 of the original xi dolist elements not yet see to have been
	       ;; deleted, if this is the case, simply skip to the next one.
	       (let ( (nm (DomVal-Name xi)) )
		 (if (and (listp nm) (equal (second nm) 'DELETED))
		     (progn
		       ;; skipping this xi value entirely as it is deleted ...
		       )

		   (progn
		     ;; this xi value is not deleted continue as expected ... 

		     ;; AGGRESSIVE :
		     ;; iterate over the range of the target variable finding
		     ;; all consistent target dom values
		     (loop

		      (if (null restd)  ;; exit 1 - no more yj to consider
			  (return))     ;; exit from yj target loop on cond'n

		      (setq yj    (car restd))  ;; get next target candidate yj
		      (setq restd (cdr restd))  ;; shorten remaining yj candset

		      ;; check for deleted yj in list, skip if encountered
		      (let ( (nm (DomVal-Name yj)) )
			(if (and (listp nm) (equal (second nm) 'DELETED))
			    (progn
			      ;; skipping yj value entirely as it is deleted 
			      )

			  (progn
			    ;; this yj value not deleted continue as expected 

			    (if *ao-debug*  
				(comment1 "   Loop yj (target) Domain Value : "
					  yj))

			    ;; note xi is MARKED in place by applyR algorithm
			    (setq xiyj-ok 
				  (applyR xi yj constraint-fn 
					  'initial maxDepth 0 t))

			    (if (not (fail3-p xiyj-ok))  

				;; true or poss consistent pair xi yj found
				(progn
				  (if *ao-debug* 
				      (comment1 "   Not fail3-p xiyj-ok  " 
						xiyj-ok))

				  ;; add link object betw 2 consistent DomVals
				  (addLink xi srcVar yj VarV2 constraint-fn)

				  (setq xi-ok t)
				  ))

			    )))) ;; loop for next yj in target domain range

		     ;; no yj exists which even poss satisfies 
		     ;;   constraint-fn for xi
		     (if (not xi-ok)
			 (progn 

			   ;; DSVP deletes obj from domain and follows exist 
			   ;;  links propagating deletions where appropriate.
			   (setq updateVarList 
				 (append updateVarList 
				    (deleteSrcValPropagateAggr xi srcVar 
							       maxDepth)))
			   )

		       ;; at least one yj exists which >= poss 
		       ;;  satisfies constraint-fn for xi
		       (progn

			 ;; note in aggr version we know all of yj traversed,
			 ;; and xi marked accordingly - therefore we can try to
			 ;; simplify the  hierarchy of xi ...
			 (if (simplify xi (sizeOfDomain domV2) constraint-fn)
			     (setq updateVarList
				   (append updateVarList 
 				     (keepSrcValPropagateAggr xi srcVar 
							      maxDepth )))) 
		       
			 ;; reset all hierarchy of xi for given constraint-fn 
			 ;;  to 0 mark vals ONLY if not deleted
			 (resetVisit xi constraint-fn)
			 )) 
		     )))))  ;; next xi - dolist xi

    ;; return the updated variable list, each var occuring max once only
    (remove-duplicates updateVarlist)

    )) ;; ao-revise-aggr (aggressive)

;; ***************************************************************************

(defun deleteSrcValPropagateAggr ( xi xi-var maxDepth )
"
  THIS IS THE AGGRESSIVE IMPLEMENTATION.

 We wish to destroy the xi DomVal which has been deleted from its domain list,
 and propagate this deletion to other domain values which are involved in Links
 in  which xi is a target.  In particular, any link for a SRC domain value
 which  has no other targeted siblings of xi needs to have its SRC recursively
 deleted. 

 The variables containing any SRC which is deleted should be recorded and
 returned for later use as targets in revisions - thus the output of
 deleteSrcValPropagate is a list of variable NAMES.
"
 (if *ao-debug* (comment2 "DeleteSrcValPropagateAggr ... xi xi-var" xi xi-var))
  
  ;; update the domain value's variable domain list appropriately
  (setf (CVariable-DomainValueList xi-var)
	(remove xi (CVariable-DomainValueList xi-var)))

  ;; delete DomVal object itself
  (free-storage-domval xi )

  (let* (
	 (HLinks  (DomVal-HasLinks xi))
	 (TLinks  (DomVal-TargetedByLinks xi))
	 (returnL  (list (DomVal-MyCVariable xi))) ;; xi's del affects its var
	 )

    (delete-forward-hlinks HLinks)

    (dolist (TL TLinks)
	    (let* (
		   (newTList  (remove-target xi (Link-TargetList TL)))
		   )

	      ;; linked siblings exist in link ? or have we trashed the last 1?
	      (if (not (null newTList))  

		  (if (= (length newTList) 1)  ;; last just support only, 
		                               ;; can simpl ?
		      (let* (
			     (linkSrcV  (Link-SourceVar TL))
			     (linkSrcD  (Link-Source    TL))
			     (c-fn      (Link-Relation  TL))
			     (last-xi   (car newTList))
			     (re-assert (applyR linkSrcD last-xi c-fn 
						'initial maxDepth 0 t))
			     )

			(if (fail3-p re-assert)   ;; re-assert necc failed ?
			    (progn     ;; failed re-assertion
   	            (comment "Warn DSVPa: Unexp re-asrt fail: linkSrcD last-xi"
				       linkSrcD last-xi) 

			      (free-storage-link TL)			      
			      
			      (setq returnL (append returnL
				    (deleteSrcValPropagateAggr linkSrcD
						       linkSrcV maxDepth )))
			      )
			  (progn       ;; successful re-assertion 
			    (if *ao-debug* 
	   	      (comment1 "DSVPa: 1 link-just exist, OK re-est newTList" 
					  newTList))

			    (setf (Link-TargetList TL) newTList)

			    (if (simplify linkSrcD 1 c-fn)
				(progn
				  (if *ao-debug*
			         (comment1 "DSVPa: simpl linkSrcD: " linkSrcD))
				  (setq returnL (append returnL
				      (keepSrcValPropagateAggr 
				       linkSrcD linkSrcV   maxDepth )))
				  )) )) )

		    (progn  ;; > 1 link siblings exist, nothing to do
		      (if *ao-debug* 
		  (comment1 "DSVPa: > 1 link-justs exist, newTList" newTList))

		      (setf (Link-TargetList TL) newTList)
		      ))

		;; no linked siblings exists in link anymore ... recurse
		(let* (
		       (linkSrcV  (Link-SourceVar TL))
		       (linkSrcD  (Link-Source    TL))
		       )

		  (if *ao-debug* (comment2 "DSVPa: removing a link: LSV LSD"
					   linkSrcV linkSrcD))

		  ;; delete the link object itself (free it ?)
		  (free-storage-link TL)

		  ;; delete the linked SOURCE domval in tlist recursively
		  (setq returnL (append returnL
			(deleteSrcValPropagateAggr 
			 linkSrcD linkSrcV maxDepth )))
		  ))) )

    ;; return list of affected variables
    returnL     
    ))

;; ***************************************************************************

(defun keepSrcValPropagateAggr ( xi xi-var maxDepth )
"
  THIS IS THE AGGRESSIVE IMPLEMENTATION.

 While xi is retained, its hierarchy has been pruned, thus potentially changing
 the way in which xi participates in relations with other domain values.  In
 particular,   any domain values involved in Links in which xi is a target 
 need to be re-checked, starting with xi itself.

 Any SRC which cannot be re-justified needs to be deleteSrcValpropagated 
 (see above)

 The variables containing any SRC which is deleted should be recorded and
 returned for later use as targets in revisions - thus the output of
 deleteSrcValPropagate is a list of variables.
"

  (if *ao-debug* (comment1 "\n KEEPSrcValPropagateAggr ... " xi ))

  (let* (
	 (TLinks (DomVal-TargetedByLinks xi))
	 (returnL nil)
	 )

    (dolist (TL TLinks)
	    (let* (
		   (tlist     (Link-TargetList TL))
		   (newTlist  (remove-target xi tlist))
		   (srcVar    (Link-SourceVar  TL))
		   (srcD      (Link-Source     TL))
		   (c-fn      (Link-Relation   TL))
		   (re-assert nil)
		   )

	      (if (null newTlist)  ;; ie xi is ONLY element in tlist
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

		  ;; yes, xi no longer is capable of justifying srcD w.r.t c-fn
		  
		  (progn  

		    ;;  remove TL link from domval xi TargetedBy link list
		    (setf (DomVal-TargetedByLinks xi) (remove TL TLinks))

		    ;; updt link targetlist to exclude xi since re-assert faild
		    (setf (Link-TargetList TL) newTlist)  

		    ;; if link TargetList contains no xi siblings, then srcD 
		    ;;  has lost all justification for c-fn in target Var dom
		    ;;  ... we can delete the link and recurse dsvpa the 
		    ;;  now unjustified source domval srcD

		    (if (null newTlist)

			;; yes, link has failed, there are no xi siblings ests
			(progn    
			  
			  ;; remove this link from srcD haslink list
			  (setf (DomVal-HasLinks srcD) 
				(remove TL (DomVal-HasLinks srcD)))

			  ;; delete this failed justification link itself
			  (free-storage-link TL)

			  ;; del the now unjustified (wrt Link fn) source var
			  ;;   note any propagated vars with deletions
			  (setq returnL (append returnL
 			        (deleteSrcValPropagateAggr 
				  srcD srcVar maxDepth)))
			  )
		      (progn  ;; no, link retains xi siblings in targetlist,
			      ;;  srcD remains justified but if size of 
			      ;;  newTlist is 1 it is possible to 
			      ;;  simplify wrt remaining xi sibling
			      ;;  in a sort of look-ahead maneuver.

                        (if (= 1 (length newTlist))
			    (let (
				  (xi-sib (first newTlist))
				  (last-assert nil)
				  )
	
			      (resetVisit srcD c-fn)  ;; reset srcD marks nil
			      (setq  last-assert      ;; reduce wrt last sibl
				     (applyR srcD xi-sib c-fn 
					     'initial maxDepth 0 t))

			      (if (not (fail3-p last-assert))  
				  (progn           ;; last-assert succeess
				    (if (simplify srcD 1 c-fn)
					(setq returnL (append returnL
				           (keepSrcValPropagateAggr 
					     srcD srcVar maxDepth))))
				  )

				(progn             ;; last-assert failure
				  (setq returnL (append returnL
				    (deleteSrcValPropagateAggr 
				       srcD srcVar maxDepth)))
				  )))

			  (progn  ;; newTlist is > 1 in size, no act to take,
			          ;;  srcD remains justified
			    ))
			)))

		(progn ;; no, re-assert succeeded, if xi last element simplify 
		       ;;  in any event, xi continues to justify srcD wrt c-fn

		  (if (null newTlist) 
		      (if (simplify srcD 1 c-fn)
			  (setq returnL (append returnL
				   (keepSrcValPropagateAggr 
				      srcD srcVar maxDepth))) ))
		  ))))
    returnL
    ))
