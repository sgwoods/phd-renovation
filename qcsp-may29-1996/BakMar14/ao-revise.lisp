;; ao-revise.lisp  (non-aggressive or stepped linking version)
;;

(defun aor-s (&optional (sys *unix*) )
  (if sys
      (progn
	(load	"ao-revise.lisp")
	(load	"ao-revise-fns.lisp"))
    (progn
      (load	"Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-revise.lisp")
      (load	"Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-revise-fns.lisp"))))

  
(defun ao-revise ( srcVar thisTarget constraint-fn maxDepth )
" 
 THIS IS THE STEPPED LINKING VERSION of AO-REVISE - 

   Revision of source domain results in domain values being linked only  as far
   as necessary to justify their continued existence.  Consequently, LINKs are
   COMPLETE only if all values in Domain(Target) have been checked - and LINKs
   are STRONG only if the final value of Domain(Target) is the linked target value,
   otherwise there always exist other Domain(Target) values to check.

 Return affected VarList if srcVar domain is revised (and existing links followed,
 thus possibly affecting other variables ... if no revisions  are made, return nil

 Revisions are made "in-place" to domain values and source variable domain.
"
  (let* (
	 (updateVarList nil)
	 (domV1         (cdr srcVar))
	 (domV2         (cdr thisTarget))
	 )

    (dolist ( xi  domV1 )          ;; iterate over the range of the source variable

	    (let* (
		   (xiyj-ok 'fail)  ;; this source, target pair is not justified yet
		   (yj      nil)   ;; target domain value under consideration
		   (restd   domV2) ;; target domain range under consideratoin   
		   )

	      ;; iterate over the range of the target variable until a consistent
	      ;;  target dom value is found or none remain to check
	      (loop
		                   
	       (if (or (null restd)             ;; exit 1 - no more yj to consider
		       (not (fail3-p xiyj-ok))) ;; exit 2 - this xiyj pair success
		   (return))          ;; exit from yj target loop on exit condition

	       (setq yj    (car restd))  ;; get the next target candidate yj
	       (setq restd (cdr restd))  ;; shorten remaining yj candidate set

	       ;; note xi is MARKED in place by applyR algorithm ....
	       (setq xiyj-ok (applyR xi yj constraint-fn maxDepth 0))

	       ) ;; loop for next yj in target domain range

	       
	       (if (not (fail3-p xiyj-ok))  

		   ;; true or poss consistent pair xi yj found
		   (progn
		     ;; add link object between two consistent DomVals
		     (addLink xi yj constraint-fn)

		     ;; if the target domain is exhausted then it is possible to
		     ;; simplify the hierarchy of xi based on MARKs made 
		     ;;  - destructive (in place) simplification of xi hierarchy
		     (if (null restd)
			 (if (simplify xi (sizeOf domV2) domV1)
			     (setq updateVarList (keepSrcValPropagate xi))))
		     )

		 ;; NO true or poss consistent pair xi yj found, xi is inconsistent
		 (progn 

		   ;; delete xi entirely from source domain domV1
		   (setq domV1 (deleteDomVal xi domV1))

		   ;; followup xi's deletion via links propagating deletions;
		   ;;   any variable affected is returned in updateVarList
		   (setq updateVarList (deleteSrcValPropagate xi))           
		   ))

	       ;; reset all hierarchy of xi to 0 mark values
	       (resetVisit xi)
		      
	      )) ;; next xi - dolist xi

    updateVarlist   ;; return the updated variable list

    )) ;; ao-revise

;; ***************************************************************************

(defun deleteSrcValPropagate ( xi xi-var )
"
  THIS IS THE STEPPED IMPLEMENTATION.  Documented in AGGRESSIVE version.
"
;;     STEPPED CASE
;;        If no other siblings exists AFTER current one, delete the link
;;         object and RECURSIVELY delete the source domain value dSVP.
;;         else (siblings exist) try each domain value in order trying to find
;;         a satisfying sibling : if FOUND, update Link ; if NOT FOUND,
;;         RECURSIVELY delete the source domain value dSVP. 

  (let* (
	 (HLinks  (DomVal-HasLinks xi))
	 (TLinks  (DomVal-TargetedByLinks xi))
	 )

    (delete-forward-hlinks HLinks)

    (dolist (TL TLinks)
	    (let* (
		   (tlist (Link-TargetList TL))
		   )
	      (if (not (null tlist))  ;; linked siblings exist in link
		  (progn
		    (setf (Link-TargetList TL) (remove-target xi tlist))
		    )
		;; no linked siblings exists in link
		(let* (
		       (linkSrcV  (Link-SourceVar TL))
		       (linkSrcD  (Link-Source    TL))
		       )

		  ;; delete the linked SOURCE domval in tlist recursively
		  (deleteSrcValPropagate linkSrcD linkSrcV)

		  ;; delete the link object itself (free it ?)
		  ;; (free-storage-link TL)
		  ))))))

;; ***************************************************************************

(defun keepSrcValPropagate ( xi xi-var )
"
  THIS IS THE STEPPED IMPLEMENTATION.  Documented in AGGRESSIVE version.
"

;; For each link in TargetedByLinks (values for which xi WAS the
;; justification), then :
;;
;;     STEPPED CASE
;;        RE-TEST  linked constraint, 
;;        if successful no change required, 
;;        else unsuccessful :
;;             If no other siblings exists AFTER current one, delete the link
;;                object and RECURSIVELY delete the source domain value dSVP.
;;             else (siblings exist) try each remaining domain value in order 
;;                  trying to find a satisfying sibling : 
;;                  if FOUND, update Link ; 
;;                  else NOT FOUND,
;;                       RECURSIVELY delete the source domain value dSVP. 

(list xi xi-var)
)


