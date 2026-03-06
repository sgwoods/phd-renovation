(in-package #:phd-qcsp3)
;;
;; hierarchy.lisp
;;

;;
;; This file contains the defintion for CSP objects DomVal and Link as well
;; as the necessary accessor and update functions to maintain justification
;; linkages and hierarchical marking for later simplification of hierarchies.
;;

(defun load-hier (&optional (sys *unix*) )
  (if sys
      (load "hierarchy.lisp")
    (load "HD:Languages:Allegro Common Lisp:qcsp:hierarchy.lisp")
    ))

(defstruct (CVariable
	    (:print-function
	     (lambda ( p s k )
	       (format s "CVariable <~A, dom=~A>"
		       (CVariable-Name p)
		       (domval-list-to-names (CVariable-DomainValueList p))
		       ))))

  (Name             'unset)
  (DomainValueList  nil)
  (FirstDomainValue nil)
  )

;; note the mark counter list is on the parent link only, the child link would 
;;  be redundant

(defstruct (DomVal
	    (:print-function
	     (lambda ( p s k )
       (format s "DomVal <~A,  hasL=~A, targBy=~A>"
		       (DomVal-Name p)
		       (show-targeted (DomVal-HasLinks p))
		       (show-sources  (DomVal-TargetedByLinks p))
		       ))))

  (Name             'unset)
  (Root             nil )    ;; only the FOCUS DomVal is Root = t
  (MyRoot           nil )    ;; if not Root=t, store the Root value for lookup
  (NextSibling      'unset ) ;; nil indicates that DomVal is last dom DomVal
  (PrevSibling      'unset ) ;; nil indicates that DomVal is first dom DomVal
  (LeftParent       nil )
  (LeftParentFail   nil )
  (LeftParentType   nil )
  (LeftParentMark   '() )    ;; contains ( (relation N) ... (relation N) ) 
  (LeftParentMark-LRP nil)   ;; Last Marked by Last Root Pair (root root)
  (RightParent      nil )
  (RightParentFail  nil )
  (RightParentType  nil )
  (RightParentMark  '() )    ;; contains ( (relation N) ... (relation N) ) 
  (RightParentMark-LRP nil)  ;; Last Marked by Last Root Pair (root root)
  (LeftChild        nil )
  (LeftChildType    nil )
  (LeftChildFail    nil )
  (RightChild       nil )
  (RightChildType   nil )
  (RightChildFail   nil )
  (HasLInks         nil )      ;; list of Links sourced by this DomVal
  (TargetedByLinks  nil )      ;; list of Links targeting  this DomVal
  (MyCVariable      nil )      ;; associated variable for this domain value
  )

(defstruct (Link
	    (:print-function
	    (lambda ( p s k )
	      (format s "Link < src=~A, tlist=~A, status=~A >"
		      (if (DomVal-p (Link-Source p))
			  (DomVal-Name (Link-Source p)) 
			nil)
		      (domval-list-to-names (Link-TargetList p))
		      (Link-Status     p)
		      ))) )
  (SourceVar   nil)
  (Source      nil)     ;; Source DomVal
  (TargetVar   nil)
  (TargetList  nil)     ;; Target DomVal list
  (Relation    nil)     ;; applicable constraint function
  (Status      'ok)     ;; ok or deleted
  )
   
;; Link Type Accessor Functions

(defun domval-list-to-names ( DomValList )
  (if (null DomValList)
      nil
    (mapcar #'(lambda (x) (if (DomVal-p x)
			      (DomVal-Name x) 
			    x ))
	    DomValList)))

(defun show-targeted ( HasLs ) 
"
 From the source, take a list of HasLinks and show which DomVal names are 
 pointed  ie ( ... (Var (val val)) (Var (val val)) ... )
"
  (if (null HasLs)
      nil
    (mapcar #'(lambda (L)
		(list  (if (Link-p L) 
			   (Link-TargetVar L)  
			 L)
		       (domval-list-to-names (Link-TargetList L))))
	    HasLs)))

(defun show-sources ( TargetLs ) 
"
 From the target, take a list of TargetedByLinks and show which DomVal names
 are  pointing at me ie ( ... (Var val) ... (Var val) ... ). Each entry is one
 link. 
"
  (if (null TargetLs)
      nil
    (mapcar #'(lambda (L)
		(list  (if (Link-p L) 
			   (Link-SourceVar L) 
			 L)
		       (if (and (Link-p L) (Domval-p (Link-Source L)))
			   (DomVal-Name (Link-Source    L))
			 L )))
	    TargetLs)))

;; Accessor Functions

(defun leaf-p ( x )
  (or  (top-leaf-p x) (bottom-leaf-p x)))

(defun top-leaf-p ( x )
   (and (null (DomVal-LeftParent x)) (null (DomVal-RightParent x))))

(defun bottom-leaf-p ( x )
  (and (null (DomVal-LeftChild x)) (null (DomVal-RightChild x))))


;; Take a look ... 

(defun traverse ( val )

  ;; output this domVal
  (comment1 "This domVal is:  name" (DomVal-Name val))

  ;; if has-children traverse down
  (let* (
	 (lc (DomVal-LeftChild val))
	 (rc (DomVal-RightChild val))
	 (lct (DomVal-LeftChildType val))
	 (rct (DomVal-RightChildType val))
	 )
    (if lc 
	(progn
	  (comment4 "Has-left-child <this -> child, type, mark> " 
		    (DomVal-Name val) (DomVal-Name lc) 
		    lct (get-markit val lc 'lc))
	  (traverse-down lc)))
    (if rc 
	(progn
	  (comment4 "Has-right-child <this -> child, type, mark> " 
		    (DomVal-Name val) (DomVal-Name rc) 
		    rct (get-markit val rc 'rc))
	  (traverse-down rc))) )

  ;; if has-parents traverse  up
  (let* (
	 (lp (DomVal-LeftParent val))
	 (rp (DomVal-RightParent val))
	 (lpt (DomVal-LeftParentType val))
	 (rpt (DomVal-RightParentType val))
	 )
    (if lp 
	(progn
	  (comment4 "Has-left-parent <this -> parent, type, mark> "
		    (DomVal-Name val) (DomVal-Name lp) 
		    lpt (get-markit val lp 'lp))
	  (traverse-up lp)))

    (if rp 
	(progn
	  (comment4 "Has-right-parent <this -> parent, type, mark> "
		    (DomVal-Name val) (DomVal-Name rp) 
		    rpt (get-markit val rp 'rp))
	  (traverse-up rp))) )
  ) ; defun
   
(defun traverse-down ( val )
  
  ;; output this domVal
  (comment1 "This domVal is:  name" (DomVal-Name val))

  ;; if has-children traverse down
  (let* (
	 (lc (DomVal-LeftChild val))
	 (rc (DomVal-RightChild val))
	 (lct (DomVal-LeftChildType val))
	 (rct (DomVal-RightChildType val))
	 )
    (if lc 
	(progn
	  (comment4 "Has-left-child <this -> child, type > "
		    (DomVal-Name val) (DomVal-Name lc) 
		    lct (get-markit val lc 'lc))
	  (traverse-down lc)))
    (if rc 
	(progn
	  (comment4 "Has-right-child <this -> child, type, mark> " 
		    (DomVal-Name val) (DomVal-Name rc) 
		    rct (get-markit val rc 'rc))
	  (traverse-down rc))) ) 
  ) ; defun

(defun traverse-up ( val )

  ;; output this domVal
  (comment1 "This domVal is:  name" (DomVal-Name val))

  ;; if has-parents traverse  up
  (let* (
	 (lp (DomVal-LeftParent val))
	 (rp (DomVal-RightParent val))
	 (lpt (DomVal-LeftParentType val))
	 (rpt (DomVal-RightParentType val))
	 )
    (if lp 
	(progn
	  (comment4 "Has-left-parent <this -> parent, type, mark> " 
		    (DomVal-Name val) (DomVal-Name lp) 
		    lpt (get-markit val lp 'lp))
	  (traverse-up lp)))

    (if rp 
	(progn
	  (comment4 "Has-right-parent <this -> parent, type, mark> " 
		    (DomVal-Name val) (DomVal-Name rp) 
		    rpt (get-markit val rp 'rp))
	  (traverse-up rp))) )
  ) ; defun    

;; Set Functions

(defun markit  (xi x-pc relation case yj)
"
 Increment the arc mark as indicated.  If arc marked by same root pair last (ie
 arc failed once for this root value already) do NOT mark it again. It is
 enough to fail once for each root and in this way we can decide to delete or
 not based on the size of the current Y domain.  
"
  (cond  

   ( (eq case 'lp)
     (progn
       (if *debug-app* (comment2 "....Marking xi -> left parent x-pc" 
				(DomVal-Name xi) (DomVal-Name x-pc)))

       (reset-mark xi relation 'lp (1+ (lookup-mark xi relation 'lp)) yj)
       ))
   ( (eq case 'rp)
     (progn
       (if *debug-app* (comment2 "....Marking xi -> right parent x-pc" 
				(DomVal-Name xi) (DomVal-Name x-pc)))

       (reset-mark xi relation 'rp (1+ (lookup-mark xi relation 'rp)) yj) 
       ))

   ( (eq case 'lc)
     (progn
       (if *debug-app* (comment2 "....Marking xi -> left child x-pc" 
				(DomVal-Name xi) (DomVal-Name x-pc)))

       (reset-mark x-pc relation 'rp (1+ (lookup-mark x-pc relation 'rp)) yj)
       ))

   ( (eq case 'rc)
     (progn
       (if *debug-app* (comment2 "....Marking xi -> right child x-pc" 
				(DomVal-Name xi) (DomVal-Name x-pc)))

       (reset-mark x-pc relation 'lp (1+ (lookup-mark x-pc relation 'lp)) yj)
       )) 
   
   ( t
     'error-in-markit-case )
   ))

(defun root-pair-equal (rp1 rp2)
  (if (not (and (listp rp1) (listp rp2)))
      (progn
	;; (comment2 "RPE err : not list params" rp1 rp2)
	nil )
    (let (
	  (rp1a (first rp1)) (rp1b (second rp1))
	  (rp2a (first rp2)) (rp2b (second rp2))
	  )
      (if (not (and (domval-p rp1a) (domval-p rp1b) 
		    (domval-p rp2a) (domval-p rp2b)))
	  (progn
	    ;; (comment2 "RPE err : not domvalp params" rp1 rp2)
	    nil )
	(if (and (eq rp1a rp2a) (eq rp1b rp2b))
	    t
	  nil )))) )

(defun lookup-mark (xi relation case)
  " Lookup the Marked value between xi, x-pc, case for given relation. "

  (cond
   ( (eq case 'rp)
     (progn
       (member-key relation (DomVal-RightParentMark xi))
       ))
   ( (eq case 'lp)
     (progn
       (member-key relation (DomVal-LeftParentMark xi))
       ))
   ( t
     (progn
       (comment1 "Error in lookup-mark case: " case)
       nil
       ))
   ))

(defun member-key (tkey tlist)
  " Find the val from tlist= ( (key val) ... (key val) )
    where key=tkey. Note if not found, return 0 as an initial value"

  (let ( (fnd (member tkey tlist :test #'(lambda (x y) (eq x (car y))))) )
    ;; (comment3 "member-key tkey tlist and fnd" tkey tlist fnd)
    (if (not (null fnd)) (cadar fnd)  0)) )

(defun reset-mark (xi relation case N yj)
"
 For a given hierarchy node, reset the mark corresp to relation to N.
 However, if arc marked by samme root pair as the last update 
 do not update the mark value.
"
  (cond
   ( (eq case 'lp)
     (if (= N 0)
	 (progn
	   (setf (DomVal-LeftParentMark     xi) 
		 (update-key relation (DomVal-LeftParentMark xi) 0))
	   (setf (DomVal-LeftParentMark-LRP xi) nil)
	   )
       (if (not (root-pair-equal (list (DomVal-MyRoot xi) (DomVal-MyRoot yj))
				 (DomVal-LeftParentMark-LRP xi)))
	   (progn
	     (setf (DomVal-LeftParentMark xi) 
		   (update-key relation (DomVal-LeftParentMark xi) N))
	     (setf (DomVal-LeftParentMark-LRP xi)
		   (list (DomVal-MyRoot xi) (DomVal-MyRoot yj))) )
	 (progn
	   (if *debug-app* 
	       (comment "Root pair found identical - no Marking done"))
	   ))) ) 
   ( (eq case 'rp)
     (if (= N 0)
	 (progn
	   (setf (DomVal-RightParentMark     xi)
		   (update-key relation (DomVal-RightParentMark xi) 0))
	   (setf (DomVal-RightParentMark-LRP xi) nil)
	   )
       (if (not (root-pair-equal (list (DomVal-MyRoot xi) (DomVal-MyRoot yj))
				 (DomVal-RightParentMark-LRP xi)))
	   (progn
	     (setf (DomVal-RightParentMark xi) 
		   (update-key relation (DomVal-RightParentMark xi) N))
	     (setf (DomVal-RightParentMark-LRP xi)
		   (list (DomVal-MyRoot xi) (DomVal-MyRoot yj))) )
	 (progn
	   (if *debug-app* 
	       (comment "Root pair found identical - no Marking done")) 
	   ))) )
   ( t
     (progn
       (comment1 "Error in reset-mark case: " case)
       nil
       ))
   ))

(defun update-key (tkey tlist newvalue)
  " Replace the val from tlist = ( (key val) ... (key val) )
    with newvalue where key=tkey. "
  (if (not (eq 0 (member-key tkey tlist)))
      (substitute-if (list tkey newvalue) 
		     #'(lambda (x) (eq tkey (car x))) tlist)
    (setf tlist (cons (list tkey newvalue) tlist)) ))

(defun get-markit  (xi x-pc case)
" This routine is used only by print routines in traverse to show
  the current status of the xi x-pc link.  Show the entire
  list of values ( (relation N) ... (relation N)) in this case. "
  (cond  
   ( (eq case 'lp)
     (DomVal-LeftParentMark xi) )
   ( (eq case 'rp)
     (DomVal-RightParentMark xi) )
   ( (eq case 'lc)
     (DomVal-RightParentMark x-pc) )
   ( (eq case 'rc)
     (DomVal-LeftParentMark x-pc) )
   ( t
     'error-in-get-mark-case )) )

(defun set-markit  (xi x-pc case N)
  (cond  
   ( (eq case 'lp)
     (setf (DomVal-LeftParentMark xi) N))
   ( (eq case 'rp)
     (setf (DomVal-RightParentMark xi) N))
   ( (eq case 'lc)
     (setf (DomVal-RightParentMark x-pc) N))
   ( (eq case 'rc)
     (setf (DomVal-LeftParentMark x-pc) N))
   ( t
     'error-in-set-mark-case )) )
