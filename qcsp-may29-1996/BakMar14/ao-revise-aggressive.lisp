;; ao-revise-agressive.lisp
;;

(defun load-aora ( &optional (sys *unix*) )
  (if sys
      (progn
	(load "ao-revise-aggressive.lisp")
	(load "ao-revise-fns.lisp") 
	)
    (progn
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-revise-aggressive.lisp")
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-revise-fns.lisp")
      )))


(defvar *ao-debug*)
(setq   *ao-debug*  t)

(defun ao-revise ( srcVar thisTarget constraint-fn maxDepth )
" 
 THIS IS THE AGGRESSIVE LINKING VERSION of AO-REVISE - 

   Revision of source domain results in domain values being linked against
   target domain values COMPLETELY - that is, all target values are checked for
   each source domain value.  Consequently, LINKs are STRONG when only one target
   value supports the source value and are WEAK when more than one target
   values  support the source : a corresponding numerical value indicates
   relative weakness where the number = the number of target values supporting  
   the source domain value.  Note that STRONG links => weak support for the
   source value.
   
 Return affected VarList if srcVar domain is revised (and existing links followed,
 thus possibly affecting other variables ... if no revisions  are made, return nil

 Revisions are made in-place to domain values and source variable domain.
"
  (let* (
	 (updateVarList nil)
	 (varV1         (CVariable-Name srcVar))
	 (domV1         (CVariable-DomainValueList srcVar))
	 (varV2         (CVariable-Name thisTarget))
	 (domV2         (CVariable-DomainValueList thisTarget)) 
	 )

    (dolist ( xi  domV1 )          ;; iterate over the range of the source variable

	    (if *ao-debug*  
		(comment1 "DoList xi (source) Domain Value : " xi)) 

	    (let* (
		   (xiyj-ok 'fail)  ;; this source, target pair is not
				    ;; justified yet
		   (xi-ok   nil)
		   (yj      nil)   ;; target domain value under consideration
		   (restd   domV2) ;; target domain range under consideratoin   
		   )

	       ;; note that it is possible that a back propagation has resulted in
	       ;; one of the original xi dolist elements not yet see to have been
	       ;; deleted, if this is the case, simply skip to the next one.
	       (let ( (nm (DomVal-Name xi)) )
		 (if (and (listp nm) (equal (second nm) 'DELETED))
		     (progn
		       ;; skipping this xi value entirely as it is deleted ...
		       )

		   (progn
		     ;; this xi value is not deleted continue as expected ... 

		     ;; AGGRESSIVE :
		     ;; iterate over the entire range of the target variable finding
		     ;; all consistent target dom values
		     (loop

		      (if (null restd)    ;; exit 1 - no more yj to consider
			  (return))       ;; exit from yj target loop on exit condition

		      (setq yj    (car restd))  ;; get the next target candidate yj
		      (setq restd (cdr restd))  ;; shorten remaining yj candidate set

		      ;; check for deleted yj in list, skip if encountered
		      (let ( (nm (DomVal-Name yj)) )
			(if (and (listp nm) (equal (second nm) 'DELETED))
			    (progn
			      ;; skipping this yj value entirely as it is deleted ...
			      )

			  (progn
			    ;; this yj value is not deleted continue as expected ...

			    (if *ao-debug*  
				(comment1 "   Loop yj (target) Domain Value : " yj))

			    ;; note xi is MARKED in place by applyR algorithm ....
			    (setq xiyj-ok 
				  (applyR xi yj constraint-fn 'initial maxDepth 0))

			    (if (not (fail3-p xiyj-ok))  

				;; true or poss consistent pair xi yj found
				(progn
				  (if *ao-debug* 
				      (comment1 "   Not fail3-p xiyj-ok  " xiyj-ok))

				  ;; add link object between two consistent DomVals
				  (addLink xi srcVar yj VarV2 constraint-fn)

				  (setq xi-ok t)
				  ))

			    )))) ;; loop for next yj in target domain range

		     ;; no yj exists which even poss satisfies constraint-fn for xi
		     (if (not xi-ok)
			 (progn 

			   ;; DSVP deletes object from domain and follows existing 
			   ;;  links propagating deletions where appropriate.
			   (setq updateVarList (deleteSrcValPropagate xi srcVar ))
			   )

		       ;; at least one yj exists which >= poss satisfies constraint-fn
		       ;;  for xi
		       (progn

			 ;; note in aggressive version we know all of yj traversed,
			 ;; and xi marked accordingly - therefore we can try to
			 ;; simplify the  hierarchy of xi ...
			 (if (simplify xi (sizeOfDomain domV2))
			     (setq updateVarList (keepSrcValPropagate xi domV1) )) 
		       
			 ;; reset all hierarchy of xi to 0 mark vals ONLY if not deleted
			 (resetVisit xi)
			 )) 
		     )))))  ;; next xi - dolist xi

    updateVarlist   ;; return the updated variable list

    )) ;; ao-revise (aggressive)

;; ***************************************************************************

(defun deleteSrcValPropagate ( xi xi-var )
"
  THIS IS THE AGGRESSIVE IMPLEMENTATION.

 We wish to destroy the xi DomVal which has been deleted from its domain list,
 and propagate this deletion to other domain values which are involved in Links in
 which xi is a target.  In particular, any link for a SRC domain value which
 has no other targeted siblings of xi needs to have its SRC recursively deleted.

 The variables containing any SRC which is deleted should be recorded and
 returned for later use as targets in revisions - thus the output of
 deleteSrcValPropagate is a list of variable NAMES.
"
;; PSEUDOCODE ....

;; For each link in HasLInks (xi's now useless justifications), delete the Link
;;  object and remove the reverse reference from the target domain value.

;; For each link in TargetedByLinks (values for which xi WAS the
;; justification), then :
;;     AGGRESSIVE CASE
;;        If other linked siblings exists, remove self from the link only
;;         else (am only linked justifier), delete the link object and 
;;         RECURSIVELY delete the source domain value dSVP.

  (if *ao-debug* (comment2 "DeleteSrcValPropagate ... xi xi-var" xi xi-var))
  
  ;; update the domain value's variable domain list appropriately
  (setf (CVariable-DomainValueList xi-var)
	(remove xi (CVariable-DomainValueList xi-var)))

  (let* (
	 (HLinks  (DomVal-HasLinks xi))
	 (TLinks  (DomVal-TargetedByLinks xi))
	 (returnL  (list xi))                   ;; return list of affected Variables
	 )

    (delete-forward-hlinks HLinks)

    (dolist (TL TLinks)
	    (let* (
		   (newTList  (remove-target xi (Link-TargetList TL)))
		   )

	      ;; linked siblings exist in link ? or have we trashed the last one ?
	      (if (not (null newTList))  
		  (progn
		    (if *ao-debug* 
			(comment1 "DSVP: linked siblings exist newTList"  newTList))

		    (setf (Link-TargetList TL) newTList)
		    )

		;; no linked siblings exists in link anymore ... recurse
		(let* (
		       (linkSrcV  (Link-SourceVar TL))
		       (linkSrcD  (Link-Source    TL))
		       )

		  (if *ao-debug* (comment2 "DSVP: removing a link: LSV LSD"
					   linkSrcV linkSrcD))

		  ;; delete the linked SOURCE domval in tlist recursively
		  (setq returnL 
			(append returnL
				(deleteSrcValPropagate linkSrcD linkSrcV)))

		  ;; delete the link object itself (free it ?)
		  (free-storage-link TL)
		  ))))

    ;; delete DomVal object itself
    (free-storage-domval xi )

    ;; return list of affected variables
    returnL     
    ))

;; ***************************************************************************

(defun keepSrcValPropagate ( xi xi-var )
"
  THIS IS THE AGGRESSIVE IMPLEMENTATION.

 While xi is retained, its hierarchy has been pruned, thus potentially changing
 the way in which xi participates in relations with other domain values.  In
 particular,   any domain values involved in Links in which xi is a target 
 need to be re-checked, starting with xi itself.

 Any SRC which cannot be re-justified needs to be deleteSrcValpropagated (see above)

 The variables containing any SRC which is deleted should be recorded and
 returned for later use as targets in revisions - thus the output of
 deleteSrcValPropagate is a list of variable NAMES.
"
;; PSEUDOCODE ....

;; For each link in TargetedByLinks (values for which xi WAS the
;; justification), then :
;;     AGGRESSIVE CASE
;;        RE-TEST  linked constraint, 
;;        if successful no change required, 
;;        else unsuccessful : 
;;             remove self from the link 
;;             If other linked siblings exists no further change required, 
;;             else (am only linked justifier) : 
;;                  delete the link object and 
;;                  RECURSIVELY delete the source domain value dSVP.
;;

  (if *ao-debug* (comment1 "\n KEEPSrcValPropagate ... " xi ))

  (let* (
	 (TLinks (DomVal-TargetedByLinks xi))
	 (returnL nil)
	 )

    (dolist (TL TLinks)
	    (let* (
		   (tlist     (Link-TargetList TL))
		   (srcVar    (Link-SourceVar  TL))
		   (srcD      (Link-Source     TL))
		   (c-fn      (Link-Relation   TL))
		   (re-assert (applyr srcD srcVar xi xi-var c-fn))
		   )

	      (if (fail3-p re-assert)    ;; re-assertion necc failed
		  (progn

		    ;; remove Link from DomVal TargetedBy list
		    (if (null (setf (DomVal-TargetedByLinks xi) (remove TL TLinks)))

			;; link targetlist has become empty -> link failed
			(let* (
			       (src-HasList (DomVal-HasLinks srcD))
			       )
			  ;; remove this link from src haslink list
			  (setf (DomVal-HasLinks srcD) (remove TL src-HasList))

			  ;; delete this link
			  (free-storage-link TL)

			  ;; delete source var, note any vars with deletions
			  (setq returnL (deleteSrcValPropagate srcD srcVar))
			  ))
			 
		    ;; remove DomVal from Link TargetList
		    (setf (LInk-TargetList TL) (remove xi tlist))
		    )
		(progn ;; re-assertion succeeded - nothing to do
		  ))))
    returnL
    ))