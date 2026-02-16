;; ao-revise-fns.lisp  
;;

(defun load-aor (&optional (sys *unix*) )
  (if sys
      (load "ao-revise-fns.lisp")
    (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-revise-fns.lisp")
    ))

;; ***************************************************************************

(defun addLink ( xi varxi yj varyj constraint-fn )
"
 Update/create a link function from xi -> yj for constraint-fn.
"
  (let* (
	 (existing-link  (exists-link-p xi varyj  constraint-fn))
	 )
    (if (not (null existing-link))

	;; update existing link from domval xi to varyj by including
	;; yj in in the set of pointed-to target domvals, also update
	;; the targeted domval yj to be aware of this link
	(let* (
	       (link-tlist (Link-TargetList         existing-link))
	       (yj-Llist   (DomVal-TargetedByLinks  yj))
	       )
	  ;; update link with new target yj
	  (if (member (DomVal-Name yj) (domval-list-to-names link-tlist))
	      (comment3 
	       "Warning: Domval <yj> already in <xi>-><varyj> link targetlist"
	       yj xi varyj)
	    (setf (Link-TargetList existing-link) (cons yj link-tlist)))

	  ;; update target domval yj targeted-by list
	  (setf (DomVal-TargetedByLinks yj) (cons existing-link yj-Llist))
	  )

      ;; create a new link and insert it into the source and target lists
      ;;   respectively 
      (createLink xi varxi yj varyj constraint-fn))))

;; ***************************************************************************

(defun exists-link-p ( S varTa constraint-fn )
  (let* (
	 (S-HasLinks (DomVal-HasLinks S))
	 (S-Link-Ta   (member varTa S-HasLinks
			     :test #'(lambda (a b) (equal a (Link-TargetVar
							     b)))))
	 )
    (if (null S-Link-Ta)
	nil
      (car S-Link-Ta))))

;; ***************************************************************************

(defun createLink ( xi varxi yj varyj constraint-fn )
"
 Create a NEW Link object between domain values.
"
  (let* (
	 (newlink  (make-link :sourcevar varxi :source xi 
			      :targetvar varyj :targetlist (list yj)
			      :relation constraint-fn
			      :status   'ok))
	 (oldHasLinks  (DomVal-HasLinks        xi))
	 (oldTargetBy  (DomVal-TargetedByLinks yj)) 
	 )
    ;; update the SOURCE DomVal
    (setf (DomVal-HasLinks        xi) (cons newlink oldHasLinks))
    ;; update the TARGET DomVal
    (setf (DomVal-TargetedByLinks yj) (cons newlink oldTargetBy))

    newlink
    )) ; defun

;; ***************************************************************************

(defun delete-forward-hlinks ( HLinks )
"
 For each Link in HasLink list, 
   For each Target DomVal in Link TargetList
       Remove reference to Link in DomVal.TargetedByList
 and delete Link itself
"
  (if (null HLinks)
      nil
    (dolist (HL HLinks)
	    (let* (
		   (hlDlist  (Link-TargetList  HL))  ;; list of target domain values
		   )
	      (dolist (hlD hlDlist)  ;; for each domain value targeted
		      (let* (
			     (hlD-tbl  (DomVal-TargetedByLinks hlD))
			     )
			;; delete reverse reference to this Link HL
			(setf (DomVal-TargetedByLinks hlD) (remove HL hlD-tbl))
			(if *ao-debug* (comment2 "Delete reverse reference: HL, hlD-tbl"
						 HL hlD-tbl)) 
			)))
	    ;; delete link object itself
	    (free-storage-link HL)
	    )))

;; ***************************************************************************

(defun remove-target ( dv dvlist )
" 
 Remove domain value dv from domain valuelist dvlist returning dvlist - dv.
"
  (let* ( (nm (DomVal-Name dv)) )
    (remove-if #'(lambda (x) (equal nm (DomVal-Name x))) dvlist)))

;; ***************************************************************************

(defun deleteDomVal ( xi domain )
"
 Simply return the domain ( ... xi ... )  with xi removed, match keys via names..
"
  (remove-if #'(lambda (x) (eq (DomVal-Name x) (DomVal-Name xi)))  domain))
  

;; ***************************************************************************

(defun sizeOfDomain ( domain-list )
"
 Simply return the size of the domain-list for use in determining how many
 MARKS on a hierarchy element indicates the ability to delete it entirely.
"
  (length domain-list))

;; ***************************************************************************

(defun simplify ( xi N )
"  
  Traverse the domain hierarchy for xi, deleting all node parent and child
  links which have a Mark value of N.  Note that a Mark value exceeding N is
  a sign of data structure corruption - report if encountered.  Note that it
  would be nice to DESTROY and DE-ALLOCATE the deleted structures if one could
  figure out how to do this in ACL.

  Return t if xi hierarchy modified, nil otherwise
"
  (if (null xi)
      nil

    (let* (
	   (lc (DomVal-LeftChild xi))
	   (rc (DomVal-RightChild xi))
	   (chgup   nil)
	   (chgdownl nil)
	   (chgdownr nil)
	   )

      ;; Left and Right Parents
      (setq chgup (simplify-up xi N))

      ;; LeftChild
      (if (not (null lc))
	  (setq chgdownl (simplify-down lc N 'lc)))

      ;; RightChild
      (if (not (null rc))
	  (setq chgdownr (simplify-down rc N 'rc)))

      (or chgup chgdownl chgdownr)
      )))

(defun simplify-down ( x N dir )
  (if (eq dir 'lc)   
      
      ;; deal with right parent
      (let* (
	     (rp  (DomVal-RightParent x))
	     (rpm (DomVal-RightParentMark x))
	     (chg nil)
	     )
	(if (= rpm N)
	  (progn  ;; destroy self,  subtree
	    (setf (DomVal-LeftChild rp) nil)  
	    (free-storage-subtree  x 'lc)
	    (setq chg t)
	    )
	  (if (> rpm N)   ;; structure in error
	      (progn 
		(comment3 "DomVal rp mark value too high : name, mark, N"
			  (DomVal-Name x) rpm N))

	    ;; do not delete, recurse though
	    (let* (
		   (lc (DomVal-LeftChild  x))
		   (rc (DomVal-RightChild x))
		   )
	      (if (not (null lc))
		  (setq chg (simplify-down lc N 'lc)))
	      (if (not (null rc))
		  (setq chg (simplify-down rc N 'rc)))
	      )))
	chg ; return t if change made, nil else
	)
	
    ;; deal with left parent
    (let* (
	   (lp  (DomVal-LeftParent x))
	   (lpm (DomVal-LeftParentMark x))
	   (chg nil)
	   )
      (if (= lpm N)
	  (progn  ;; destroy self,  subtree
	    (setf (DomVal-RightChild lp) nil)  
	    (free-storage-subtree  x 'rc)
	    (setq chg t)
	    )
	  (if (> lpm N)   ;; structure in error
	      (progn 
		(comment3 "DomVal lp mark value too high : name, mark, N"
			  (DomVal-Name x) lpm N))
	    ;; do not delete, recurse though
	    (let* (
		   (lc (DomVal-LeftChild  x))
		   (rc (DomVal-RightChild x))
		   )
	      (if (not (null lc))
		  (setq chg (simplify-down lc N 'lc)))
	      (if (not (null rc))
		  (setq chg (simplify-down rc N 'rc)))
	      )))
      chg ; return t if change made, nil else
      )
    )) ; defun
    

(defun simplify-up ( xi N )
  (let* (
	 (lp  (DomVal-LeftParent      xi))
	 (lpm (DomVal-LeftParentMark  xi))
	 (rp  (DomVal-RightParent     xi))
	 (rpm (DomVal-RightParentMark xi))
	 (chg nil)                          ;; set if modification made
	 )
      
    ;; LeftParent
    (if (not (null lp))
	(if (= lpm N)
	    (progn  ;; destroy leftparent subtree
	      (free-storage-subtree  lp 'lp)
	      (setf (DomVal-LeftParent xi) nil)
	      (setq chg t)
	      )
	  (if (> lpm N)   ;; structure in error
	      (progn 
		(comment3 "DomVal lp mark value too high : name, mark, N"
			  (DomVal-Name xi) lpm N))
	    ;; recurse on lp subtree
	    (if (simplify-up lp N) (setq chg t))
	    )))
    
    ;; RightParent
    (if (not (null rp))
	(if (= rpm N)
	    (progn  ;; destroy rightparent subtree
	      (free-storage-subtree  rp 'rp)
	      (setf (DomVal-RightParent xi) nil)
	      (setq chg t)
	      )
	  (if (> rpm N)   ;; structure in error
	      (progn 
		(comment3 "DomVal rp mark value too high : name, mark, N"
			  (DomVal-Name xi) rpm N))
	    ;; recurse on rp subtree
	    (if (simplify-up rp N) (setq chg t))
	    )))
    chg ; return t if changed, nil otherwise
    ))
      
;; ***************************************************************************

(defun resetVisit ( xi )
" 
 Reset the hierarchy of DomVal xi to marked values of 0 throughout.  A recursive
traverse  routine is used.
"
(if (null xi)
    nil
  (progn
    (setf (DomVal-LeftParentMark   xi) 0)
    (setf (DomVal-RightParentMark  xi) 0)
    (let* (
	   (lc (DomVal-LeftChild   xi))
	   (rc (DomVal-RightChild  xi))
	   (lp (DomVal-LeftParent  xi))
	   (rp (DomVal-RightParent xi))
	   )
      (if lc (resetDown lc))
      (if rc (resetDown rc))
      (if lp (resetUp   lp))
      (if rp (resetUp   rp)) 
      ))))

(defun resetDown ( x )
  (setf (DomVal-LeftParentMark   x) 0)
  (setf (DomVal-RightParentMark  x) 0)

  (let* (
	 (lc (DomVal-LeftChild  x))
	 (rc (DomVal-RightChild x))
	 )
    (if lc (resetDown lc))
    (if rc (resetDown rc)) ))

(defun resetUp ( x )
  (setf (DomVal-LeftParentMark   x) 0)
  (setf (DomVal-RightParentMark  x) 0)
    (let* (
	   (lp (DomVal-LeftParent  x))
	   (rp (DomVal-RightParent x))
	   )
      (if lp (resetUp   lp))
      (if rp (resetUp   rp)) ))

;; ---------------------------------------------------------------------------
;; Garbage collection routines ....
;; ---------------------------------------------------------------------------

(defun free-storage-link ( linkobject )
  (progn
    (if *ao-debug* (comment1 "Delete/Free Link object : " linkobject))
    (setf (Link-Status linkobject)  'DELETED)))

(defun free-storage-domval ( domval )
  (progn
    (if *ao-debug* (comment1 "Delete/Free DomVal object : " domval))
    (setf (DomVal-Name domval)            (list (DomVal-Name domval) 'DELETED))
    (setf (DomVal-HasLinks domval)        nil)
    (setf (DomVal-TargetedByLinks domval) nil)

    ;; For ROOT domvals only, re-link the domain list to exclude this DomVal now deleted
    (if (DomVal-Root domval)
	(let* (
	       (prevVal (DomVal-PrevSibling domval))
	       (nextVal (DomVal-NextSibling domval))
	       )
	  (if prevVal
	      (if nextVal
		  (progn
		    (setf (DomVal-NextSibling (DomVal-PrevSibling domval))
			  (DomVal-NextSibling domval))
		    (setf (DomVal-PrevSibling (DomVal-NextSibling domval))
			  (DomVal-PrevSibling domval))		    )
		(progn
		  (setf (DomVal-NextSibling (DomVal-PrevSibling domval))  nil)     ))
	    (if nextVal
		(progn
		  (setf (DomVal-PrevSibling (DomVal-NextSibling domval))  nil)	      )
	      (progn 
		;; do nothing, domval is last in variable domain range
		)))))

    (setf (DomVal-NextSibling domval) nil)
    (setf (DomVal-NextSibling domval) nil)
    ))

(defun free-storage-subtree ( domval direction )
  (if (null domval) 
      nil
    (cond 
     ((eq direction 'lc)
      (let* (
	     (lc (DomVal-LeftChild   domval))
	     (rc (DomVal-RightChild  domval))
	     )

	(free-storage-domval  domval)
	(free-storage-subtree lc 'lc) 
	(free-storage-subtree rc 'rc) 
	))


     ((eq direction 'rc)
      (let* (
	     (lc (DomVal-LeftChild   domval))
	     (rc (DomVal-RightChild  domval))
	     )
	(free-storage-domval  domval)
	(free-storage-subtree lc 'lc) 
	(free-storage-subtree rc 'rc ) 
	))

     ((eq direction 'lp)
      (let* (
	     (lp (DomVal-LeftParent  domval))
	     (rp (DomVal-RightParent domval))
	     )
	(free-storage-domval  domval)
	(free-storage-subtree lp 'lp) 
	(free-storage-subtree rp 'rp) 
	))

     ((eq direction 'rp)
      (let* (
	     (lp (DomVal-LeftParent  domval))
	     (rp (DomVal-RightParent domval))
	     )
	(free-storage-domval  domval)
	(free-storage-subtree lp 'lp) 
	(free-storage-subtree rp 'rp) 
	))

     (t (progn
	  (comment1 "free storage subtree cond direction error : "  direction)
	  nil)) )))

