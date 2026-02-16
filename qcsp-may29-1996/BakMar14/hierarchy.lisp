;;
;; hierarchy.lisp
;;
(defun load-hier (&optional (sys *unix*) )
  (if sys
      (load "hierarchy.lisp")
    (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:hierarchy.lisp")
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
  )

;; note the mark counter is on the parent link only, the child link would 
;;  be redundant

(defstruct (DomVal
	    (:print-function
	     (lambda ( p s k )
       (format s "DomVal <~A, lp=~A, rp=~A, lc=~A, rc=~A hasL=~A, targBy=~A>"
		       (DomVal-Name p)
		       (if (DomVal-LeftParent p)
			   (DomVal-Name (DomVal-LeftParent p))
			 'none)
		       (if (DomVal-RightParent p)
			   (DomVal-Name (DomVal-RightParent p))
			 'none)
		       (if (DomVal-LeftChild p)
			   (DomVal-Name (DomVal-LeftChild p))
			 'none)
		       (if (DomVal-RightChild p)
			   (DomVal-Name (DomVal-RightChild p))
			 'none)
		       (show-targeted (DomVal-HasLinks p))
		       (show-sources  (DomVal-TargetedByLinks p))
		       ))))

  (Name             'unset)
  (Root             nil )    ;; only the FOCUS DomVal is Root = t
  (NextSibling      'unset ) ;; nil indicates that DomVal is last DomVal in domain
  (PrevSibling      'unset ) ;; nil indicates that DomVal is first DomVal in domain
  (LeftParent       nil )
  (LeftParentType   nil )
  (LeftParentMark   0   )
  (RightParent      nil )
  (RightParentType  nil )
  (RightParentMark  0   )    
  (LeftChild        nil )
  (LeftChildType    nil )
  (RightChild       nil )
  (RightChildType   nil )
  (HasLInks         nil )      ;; list of Links sourced by this DomVal
  (TargetedByLinks  nil ))     ;; list of Links targeting  this DomVal

(defstruct (Link
	    (:print-function
	    (lambda ( p s k )
	      (format s "Link < src=~A, tlist=~A, status=~A >"
		      (if (not (null (Link-Source p)))
			  (DomVal-Name (Link-Source p)) nil)
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
  (mapcar #'(lambda (x) (DomVal-Name x)) DomValList))

(defun show-targeted ( HasLs ) 
"
 From the source, take a list of HasLinks and show which DomVal names are pointed
 ie ( ... (Var (val val)) (Var (val val)) ... )
"
  (mapcar #'(lambda (L)
	      (list  (Link-TargetVar L)
		     (domval-list-to-names (Link-TargetList L))))
	  HasLs))

(defun show-sources ( TargetLs ) 
"
 From the target, take a list of TargetedByLinks and show which DomVal names are 
 pointing at me ie ( ... (Var val) ... (Var val) ... ). Each entry is one link.
"
  (mapcar #'(lambda (L)
	      (list  (Link-SourceVar L)
		     (DomVal-Name (Link-Source    L))))
	  TargetLs))

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
		    (DomVal-Name val) (DomVal-Name lc) lct (get-markit val lc 'lc))
	  (traverse-down lc)))
    (if rc 
	(progn
	  (comment4 "Has-right-child <this -> child, type, mark> " 
		    (DomVal-Name val) (DomVal-Name rc) rct (get-markit val rc 'rc))
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
		    (DomVal-Name val) (DomVal-Name lp) lpt (get-markit val lp 'lp))
	  (traverse-up lp)))

    (if rp 
	(progn
	  (comment4 "Has-right-parent <this -> parent, type, mark> "
		    (DomVal-Name val) (DomVal-Name rp) rpt (get-markit val rp 'rp))
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
		    (DomVal-Name val) (DomVal-Name lc) lct (get-markit val lc 'lc))
	  (traverse-down lc)))
    (if rc 
	(progn
	  (comment4 "Has-right-child <this -> child, type, mark> " 
		    (DomVal-Name val) (DomVal-Name rc) rct (get-markit val rc 'rc))
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
		    (DomVal-Name val) (DomVal-Name lp) lpt (get-markit val lp 'lp))
	  (traverse-up lp)))

    (if rp 
	(progn
	  (comment4 "Has-right-parent <this -> parent, type, mark> " 
		    (DomVal-Name val) (DomVal-Name rp) rpt (get-markit val rp 'rp))
	  (traverse-up rp))) )
  ) ; defun    

;; Set Functions

(defun markit  (xi x-pc case)
  (cond  

   ( (eq case 'lp)
     (progn
       (if *debug-app* (comment2 "....Marking xi -> left parent x-pc" 
				(DomVal-Name xi) (DomVal-Name x-pc)))
       (setf (DomVal-LeftParentMark xi) (1+ (DomVal-LeftParentMark xi))) ))

   ( (eq case 'rp)
     (progn
       (if *debug-app* (comment2 "....Marking xi -> right parent x-pc" 
				(DomVal-Name xi) (DomVal-Name x-pc)))
       (setf (DomVal-RightParentMark xi) (1+ (DomVal-RightParentMark xi))) ))

   ( (eq case 'lc)
     (progn
       (if *debug-app* (comment2 "....Marking xi -> left child x-pc" 
				(DomVal-Name xi) (DomVal-Name x-pc)))
     (setf (DomVal-RightParentMark x-pc) (1+ (DomVal-RightParentMark x-pc))) ))

   ( (eq case 'rc)
     (progn
       (if *debug-app* (comment2 "....Marking xi -> right child x-pc" 
				(DomVal-Name xi) (DomVal-Name x-pc)))
       (setf (DomVal-LeftParentMark x-pc) (1+ (DomVal-LeftParentMark x-pc))) ))

   ( t
     'error-in-markit-case )))

(defun get-markit  (xi x-pc case)
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
     'error-in-get-mark-case )))

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
     'error-in-set-mark-case )))

