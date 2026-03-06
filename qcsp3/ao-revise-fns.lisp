(in-package #:phd-qcsp3)
;; ao-revise-fns.lisp
;;

;;
;; This file contains methods required for both revision algorithms.
;;

(defun load-aor (&optional (sys *unix*) )
  (if sys
      (load "ao-revise-fns.lisp")
    (load "HD:Languages:Allegro Common Lisp:qcsp:ao-revise-fns.lisp")
    ))

;; ***************************************************************************

(defun addLink ( xi varxi yj varyj constraint-fn )
"
 Update/create a link function from xi -> yj for constraint-fn.
"

  (if *ao-debug* 
      (comment5 "addLink xi varxi yj varyj c-fn" 
		xi varxi yj varyj constraint-fn))

  (let* (
	 (existing-link  (exists-link-p xi varyj ))
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
	      (if *ao-debug*
		  (comment3 
       "AddLink Warning: Domval <yj> already in <xi>-><varyj> link targetlist"
	        yj xi varyj))
	    (setf (Link-TargetList existing-link) (cons yj link-tlist)))

	  ;; update target domval yj targeted-by list
	  (setf (DomVal-TargetedByLinks yj) (cons existing-link yj-Llist))
	  )

      ;; create a new link and insert it into the source and target lists
      ;;   respectively 
      (createLink xi varxi yj varyj constraint-fn))) )

;; ***************************************************************************

(defun exists-link-p ( S varTa )
  (let* (
	 (S-HasLinks (DomVal-HasLinks S))
	 (S-Link-Ta   (member varTa S-HasLinks
			     :test #'(lambda (a b) (equal a (Link-TargetVar
							     b)))))
	 )
    (if (null S-Link-Ta)
	nil
      (car S-Link-Ta))) )

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
		   (hlDlist  (Link-TargetList  HL))  ;; list of targ dom vals
		   )
	      (dolist (hlD hlDlist)  ;; for each domain value targeted
		      (let* (
			     (hlD-tbl  (DomVal-TargetedByLinks hlD))
			     )
			;; delete reverse reference to this Link HL
			(setf (DomVal-TargetedByLinks hlD) (remove HL hlD-tbl))
			(if *ao-debug* 
			    (comment2 "Delete reverse reference: HL, hlD-tbl"
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
 Simply return the domain ( ... xi ... ) with xi removed,match keys via names..
"
  (remove-if #'(lambda (x) (eq (DomVal-Name x) (DomVal-Name xi)))  domain))
  

;; ***************************************************************************

(defun sizeOfDomain ( domain-list )
"
 Simply return the size of the domain-list for use in determining how many
 MARKS on a hierarchy element indicates the ability to delete it entirely.
 Note elements in list that are marked DELETED are not counted.
"
 (count-if-not #'(lambda (x) (listp (DomVal-Name x))) domain-list))

;; ***************************************************************************

(defun simplify ( xi N relation )
"  
  Traverse the domain hierarchy for xi, deleting all node parent and child
  links which have a Mark/relation value of N.  Note that a Mark value
  exceeding N is a sign of data structure corruption - report if encountered.
  Note that it would be nice to DESTROY and DE-ALLOCATE the deleted structures
  if one could  figure out how to do this in ACL.

  April 6/96: revised to accomodate multiple constraint functions (relation) 
  in order to accomodate the passive revision which requires a MEMORY
  so that partial applications can be made against different variables with 
  a different function.  We assume a function is unique for a particular 
  variable pair for simplicity.  That is, some function fn exists ONLY for
  ONE pair of variables v1 v2 - if we have an identically constructed function
  for other pairs ie v1 v3, we must define a separate instance of the
  function. 
 
  Return t if xi hierarchy modified, nil otherwise
"
  (if *ao-debug* (comment3 "Simplify xi N relation call ..."
			   xi N relation ))

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
      (setq chgup (simplify-up xi N relation))

      ;; LeftChild
      (if (not (null lc))
	  (setq chgdownl (simplify-down lc N relation 'lc)))

      ;; RightChild
      (if (not (null rc))
	  (setq chgdownr (simplify-down rc N relation 'rc)))

      (or chgup chgdownl chgdownr)
      )) )

(defun simplify-down ( x N relation dir )
  (if (eq dir 'lc)   
      
      ;; deal with right parent
      (let* (
	     (rp  (DomVal-RightParent x))
	     (rpm (lookup-mark x relation 'rp)) 
	     (chg nil)
	     )
	(if (= rpm N)
	  (progn  ;; destroy self,  subtree
	    (setf (DomVal-LeftChild rp) nil)  
	    (setf (DomVal-LeftChildFail rp) t)
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
		  (setq chg (simplify-down lc N relation 'lc)))
	      (if (not (null rc))
		  (setq chg (simplify-down rc N relation 'rc)))
	      )))
	chg ; return t if change made, nil else
	)
	
    ;; deal with left parent
    (let* (
	   (lp  (DomVal-LeftParent x))
	   (lpm (lookup-mark x relation 'lp)) 
	   (chg nil)
	   )
      (if (= lpm N)
	  (progn  ;; destroy self,  subtree
	    (setf (DomVal-RightChild lp) nil)  
	    (setf (DomVal-RightChildFail lp) t)
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
		  (setq chg (simplify-down lc N relation 'lc)))
	      (if (not (null rc))
		  (setq chg (simplify-down rc N relation 'rc)))
	      )))
      chg ; return t if change made, nil else
      )
    )) ; defun
    

(defun simplify-up ( xi N relation )
  (let* (
	 (lp  (DomVal-LeftParent      xi))
	 (lpm (lookup-mark xi relation 'lp)) 
	 (rp  (DomVal-RightParent     xi))
	 (rpm (lookup-mark xi relation 'rp)) 
	 (chg nil)                          ;; set if modification made
	 )
      
    ;; LeftParent
    (if (not (null lp))
	(if (= lpm N)
	    (progn  ;; destroy leftparent subtree
	      (free-storage-subtree  lp 'lp)
	      (setf (DomVal-LeftParent xi) nil)
	      (setf (DomVal-LeftParentFail xi) t)
	      (setq chg t)
	      )
	  (if (> lpm N)   ;; structure in error
	      (progn 
		(comment3 "DomVal lp mark value too high : name, mark, N"
			  (DomVal-Name xi) lpm N))
	    ;; recurse on lp subtree
	    (if (simplify-up lp N relation) (setq chg t))
	    )))
    
    ;; RightParent
    (if (not (null rp))
	(if (= rpm N)
	    (progn  ;; destroy rightparent subtree
	      (free-storage-subtree  rp 'rp)
	      (setf (DomVal-RightParent xi) nil)
	      (setf (DomVal-RightParentFail xi) t)
	      (setq chg t)
	      )
	  (if (> rpm N)   ;; structure in error
	      (progn 
		(comment3 "DomVal rp mark value too high : name, mark, N"
			  (DomVal-Name xi) rpm N))
	    ;; recurse on rp subtree
	    (if (simplify-up rp N relation) (setq chg t))
	    )))
    chg ; return t if changed, nil otherwise
    ))
      
;; ***************************************************************************

(defun resetVisit ( xi relation )
" 
 Reset the hierarchy of DomVal xi to marked values of 0 throughout.  A
 recursive traverse  routine is used.
"
(if (null xi)
    nil
  (progn
    (reset-mark xi relation 'lp 0 nil) 
    (reset-mark xi relation 'rp 0 nil) 
    (let* (
	   (lc (DomVal-LeftChild   xi))
	   (rc (DomVal-RightChild  xi))
	   (lp (DomVal-LeftParent  xi))
	   (rp (DomVal-RightParent xi))
	   )
      (if lc (resetDown lc relation))
      (if rc (resetDown rc relation))
      (if lp (resetUp   lp relation))
      (if rp (resetUp   rp relation)) 
      ))))

(defun resetDown ( x relation )
  (reset-mark x relation 'lp 0 nil) 
  (reset-mark x relation 'rp 0 nil) 

  (let* (
	 (lc (DomVal-LeftChild  x))
	 (rc (DomVal-RightChild x))
	 )
    (if lc (resetDown lc relation ))
    (if rc (resetDown rc relation)) 
    ))

(defun resetUp ( x relation )
  (reset-mark x relation 'lp 0 nil) 
  (reset-mark x relation 'rp 0 nil) 
    (let* (
	   (lp (DomVal-LeftParent  x))
	   (rp (DomVal-RightParent x))
	   )
      (if lp (resetUp   lp relation ))
      (if rp (resetUp   rp relation )) 
      ))

;; ---------------------------------------------------------------------------
;; Garbage collection routines ....
;; ---------------------------------------------------------------------------

(defun free-storage-link ( linkobject )
  (if *ao-debug* (comment1 "Delete/Free Link object : " linkobject))
  (if (eq (Link-Status linkobject) 'DELETED)
      (if *ao-debug*
	  (comment1 "Warning *** Deleting an already deleted Link object:" 
		    linkobject))
    (setf (Link-Status linkobject)  'DELETED)))

(defun free-storage-domval ( domval )
  (if *ao-debug* (comment1 "Delete/Free DomVal object : " domval))
  (if (listp (DomVal-Name domval))
      (comment1 "ERROR *** Deleting an already deleted DomVal object : " 
		domval)
    (setf (DomVal-Name domval)  (list (DomVal-Name domval) 'DELETED))))

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

(defun get-next-undel ( dv )
" Return the next sibling of domain value dv which is not deleted, or nil. "
  (if (null dv) 
      nil
    (let (
	  (ns (DomVal-NextSibling dv))
	  )
      (if (null ns)
	  nil
	(if (not (listp (DomVal-Name  ns)))
	    ns
	  (get-next-undel ns))))))
