;;
;; applyR.lisp
;;

(defun load-applyr (&optional (sys *unix*) )
  (if sys
      (progn
	(load  "applyr.lisp")
	(load "comment.lisp")
	)
    (progn
      (load "HD:Languages:Allegro Common Lisp:qcsp:applyr.lisp")    
      (load "HD:Languages:Allegro Common Lisp:qcsp:comment.lisp"))
      ))

(defun applyR ( xi yj relation curMode maxDepth  curDepth markflg)
" 
  Returns tri logic value: one of true, fail, poss
  Optional in-place marking of xi hierarchy - default yes. 
 "

 (if *debug-app*
    (comment5 "ApplyR call : xi, yj, depth markflg mode" 
	  (if xi (DomVal-Name xi) nil)  (if yj (DomVal-Name yj) nil)   
	  curDepth markflg curMode))

  (let* (
	 (return-val 'unset)
	 )

    (if (or (null xi) (null yj))
      
	;; return
	(setq return-val 'poss)

      (let* (
	     (Rlocal  (apply-relation xi yj relation))
	     )

	;; count constraint application
	(setq *constraint-count* (1+ *constraint-count*))

	(if (fail3-p Rlocal)    ;; ie Rlocal = fail
	    (progn
	      ;; ie xi is focus DomVal ...
	      ;;   mark any existing parents, children as invalid necc
	      (if (and (DomVal-Root xi) markflg)  
		  (let* (
			 (xlp    (DomVal-LeftParent  xi))
			 (xrp    (DomVal-RightParent xi))
			 (xlc    (DomVal-LeftChild   xi))
			 (xrc    (DomVal-RightChild  xi))
			 )
		    (if xlp (markit xi xlp relation 'lp yj))
		    (if xrp (markit xi xrp relation 'rp yj))
		    (if xlc (markit xi xlc relation 'lc yj))
		    (if xrc (markit xi xrc relation 'rc yj))
		    ))
	      ;; return
	      (setq return-val 'fail)
	    ) ; progn

	  (cond

	   ( (eq curMode 'initial)
	     (setq return-val
		   (let* (  (dn (applyDown xi yj relation maxDepth 
					   curDepth markflg))  )
		     (if (fail3-p dn)
			 'fail
		       (let ( (up (applyUp xi yj relation maxDepth 
					   curDepth markflg)) )
			 (and3 (list dn up)) )))) )
     
	   ( (eq curMode 'down)
	     (setq return-val (applyDown xi yj relation maxDepth 
					 curDepth markflg)) )

	   ( (eq curMode 'up)
	     (setq return-val (applyUp   xi yj relation maxDepth 
					 curDepth markflg)) )

	   ( t  
	     (setq return-val 'error-in-curMode) )
	 )) ; cond, if
	)) ; if

    (if *debug-app*    (comment3 "applyR xi yj return-val" 
				 (if xi (DomVal-Name xi) nil)
				 (if yj (DomVal-Name yj) nil) 
				 return-val))

    return-val

    )) ;; defun

(defun apply-relation ( xa yb relation )
  (if (listp (Domval-Name xa)) 
      (comment1 "Warn applyR with X value DELETED : " xa))
  (if (listp (Domval-Name xa)) 
      (comment1 "Warn applyR with Y value DELETED : " yb))
  (apply relation (list xa yb)))

(defun applyUp ( xi yj relation maxDepth curDepth markflg)
" Returns tri logic value: one of true, fail, poss "

;;(if *debug-app*(comment3 "ApplyUp call : xi, yj, depth" 
;;			 (DomVal-Name xi) (DomVal-Name yj) curDepth))

  (let* (
	 (newDepth (1+ curDepth))
	 (return-val 'unset)
	 )
    (if (> newDepth maxDepth)
	
	;; return
	(setq return-val 'true)

      (if (or (top-leaf-p xi) (top-leaf-p yj))

	    ;; return
	    (setq return-val 'poss)

	(let* (
	       (xlp    (DomVal-LeftParent  xi))
	       (xrp    (DomVal-RightParent xi))
	       (ylp    (DomVal-LeftParent  yj))
	       (ylp-fail (DomVal-LeftParentFail  yj))
	       (yrp    (DomVal-RightParent yj))
	       (yrp-fail (DomVal-RightParentFail yj))

	       (RLL (if (and (null ylp) ylp-fail)
			'fail
		      (applyR xlp ylp relation 'up maxDepth 
			      newDepth markflg )))
	       (RLR (if (and (null yrp) yrp-fail)
			'fail
		      (applyR xlp yrp relation 'up maxDepth 
			      newDepth markflg )))
	       (RRL (if (and (null ylp) ylp-fail)
			'fail
		      (applyR xrp ylp relation 'up maxDepth 
			      newDepth markflg )))
	       (RRR (if (and (null yrp) yrp-fail)
			'fail
		      (applyR xrp yrp relation 'up maxDepth 
			      newDepth markflg )))
      
	       (RL (or3 (list RLL RLR)))
	       (RR (or3 (list RRL RRR)))
	       )

	  (if (and (fail3-p RL) markflg)
	      (markit   xi xlp relation 'lp yj))

	  (if (and (fail3-p RR) markflg)
	      (markit   xi xrp relation 'rp yj))

	  (setq return-val (or3 (list RL RR)))
	  )) ; if
	) ; if

;;    (if *debug-app*    (comment3 "applyUp xi yj return-val" 
;;				 (DomVal-Name xi) (DomVal-Name yj) return-val))
    return-val

    )) ; defun applyUp
    

(defun applyDown ( xi yj relation maxDepth curDepth markflg )
" ApplyDown returns a tri logic value one of true fail poss "

;;(if *debug-app* (comment3 "ApplyDown call : xi, yj, depth" 
;;			  (DomVal-Name xi) (DomVal-Name yj) curDepth))

  (let* (
	 (newDepth (1+ curDepth))
	 (return-val   'unset)
	 )
    (if (> newDepth maxDepth)

	;; return
	(setq return-val 'true)

      (if (or (bottom-leaf-p xi) (bottom-leaf-p yj)) ;; <- problem
	
	  ;; return
	  (setq return-val 'poss)

	(let* (
	       (xlc    (DomVal-LeftChild  xi))
	       (xlc-type (DomVal-LeftChildType xi))  
	       (xrc    (DomVal-RightChild xi))
	       (ylc    (DomVal-LeftChild  yj))
	       (ylc-type (DomVal-LeftChildType yj))
	       (ylc-fail (DomVal-LeftChildFail yj))
	       (yrc    (DomVal-RightChild yj))
	       (yrc-fail (DomVal-RightChildFail yj))

	       (RLL (if (and (null ylc) ylc-fail)
			(progn
			  (if *debug-app*
	       (comment3 ">>RLL Null Left Chd and Left Child Fail xi yj ylc"
				   xi yj ylc))
			  'fail)
		      (applyR xlc ylc relation 'down maxDepth 
			      newDepth markflg )))
	       (RLR (if (and (null yrc) yrc-fail) 
			(progn 
			  (if *debug-app*
		(comment3 ">>RLR Null Right Chd and Right Child Fail xi yj ylc"
				   xi yj ylc))
			  'fail)
		      (applyR xlc yrc relation 'down maxDepth 
			      newDepth markflg )) )
	       (RRL (if (and (null ylc) ylc-fail) 
			(progn
			  (if *debug-app*
		(comment3 ">>RRL Null Left Chd and Left Child Fail xi yj ylc"
				   xi yj ylc))
			  'fail)
		      (applyR xrc ylc relation 'down maxDepth 
			      newDepth markflg )))
	       (RRR (if (and (null yrc) yrc-fail) 
			(progn 
			  (if *debug-app*
		(comment3 ">>RRR Null Right Cld and Right Child Fail xi yj ylc"
				   xi yj ylc))
			  'fail)
		      (applyR xrc yrc relation 'down maxDepth 
			      newDepth markflg )))
    	       )

	  ;;
	  ;; note downlinks are paired and/and or or/or never split a/o or o/a
	  ;;

	  (cond

	   ;; **************************************************
	   ;; OR/OR case
	   ;;
	   ( (and (eq xlc-type 'or) (eq ylc-type 'or))   
	     (let* (
		    (RL (or3 (list RLL RLR)))
		    (RR (or3 (list RRL RRR)))
		    )
	       
	       (if (and (fail3-p RL) markflg)
		   (markit   xi xlc relation 'lc yj))

	       (if (and (fail3-p RR) markflg)
		   (markit   xi xrc relation 'rc yj))

	       ;; return
	       (setq return-val (or3 (list RL RR))) )) 

	   ;; ************j*************************************
	   ;; AND/AND case
	   ;;
	   ( (and (eq xlc-type 'and) (eq ylc-type 'and))
	     (let* (
		    (RDOWN (and3 (list RLL RLR RRL RRR)))
		    )

	       (if (and (fail3-p RDOWN) markflg)
		   (progn
		     (markit   xi xlc relation 'lc yj)
		     (markit   xi xrc relation 'rc yj)))

	       ;; return
	       (setq return-val RDOWN) ))

	   ;; **************************************************
	   ;; OR/AND case
	   ;;
	   ( (and (eq xlc-type 'or) (eq ylc-type 'and))
	     (let* (
		    (RL (and3 (list RLL RLR)))
		    (RR (and3 (list RRL RRR)))
		    )
	       (if (and (fail3-p RL) markflg)
		   (markit   xi xlc relation 'lc yj))

	       (if (and (fail3-p RR) markflg)
		   (markit   xi xrc relation 'rc yj))

	       ;; return
	       (setq return-val (or3 (list RL RR))) ))

	   ;; **************************************************
	   ;; AND/OR case
	   ;;
	   ( (and (eq xlc-type 'and) (eq ylc-type 'or))
	     (let* (
		    (RL (and3 (list RLL RRL)))
		    (RR (and3 (list RLR RRR)))
		    )

	       (if (and (fail3-p RL) (fail3-p RR))
		   (progn
		     (if markflg (markit   xi xlc relation 'lc yj))
		     (if markflg (markit   xi xrc relation 'rc yj))
		     
		     ;; return
		     (setq return-val 'fail))

		 ;; return
		 (setq return-val 'true)) ))

	   ( t
		 ;; return ERROR
	     (progn
	       (comment2 "Error in graph from condition: xtype ytype" 
			 xlc-type ylc-type)
	       (setq return-val 'error-in-graph-from-cond)))

	   ) ; cond

	  return-val  ;; applyDown return value

	  )) ; if
      ) ; if
    )) ; defun applyDown


(defun or3 ( orvals )
" return tri logic value (pessimistic) OR  of a list of tri logic values "
  (if (null orvals)
      'fail
    (if (atom (car orvals))
	(if (member 'true orvals) 
	    'true
	  (if (member 'poss orvals) 
	      'poss
	    'fail))
    (let* (
	   (thisform  (first orvals))
	   (restforms (rest  orvals))
	   (thisval   (apply (car thisform) (cdr thisform)))
	   (sofar thisval)
	   )

      (loop

       (if (or (null restforms) (eq sofar 'true)) (return))
       
       (setq thisform  (car restforms))
       (setq restforms (cdr restforms))   
       (setq thisval (apply (car thisform) (cdr thisform)))

       (if (eq thisval 'true)
	   (setq sofar 'true)
	 (if (eq thisval 'poss)
	     (setq sofar 'poss) 
	   (if (not (eq thisval 'fail))
	       (progn
		 (comment3 "Error in or3: thisform thisval nil" 
			   thisform thisval nil)
		 (setq sofar 'fail)
		 ))))
       ) ; loop

      ;; return result
      sofar
      )))) ; defun or3

(defun and3 ( andvals )
" return tri logic value (pessimistic) AND  of a list of tri logic values "
  (if (null andvals)
      'fail
    (if (atom (car andvals))
	(if (member 'fail andvals) 
	    'fail 
	  (if (member 'poss andvals) 
	      'poss
	    'true))

    (let* (
	   (thisform  (first andvals))
	   (restforms (rest  andvals))
	   (thisval   (apply (car thisform) (cdr thisform)))
	   (sofar thisval)
	   )

      (loop

       (if (or (null restforms) (eq sofar 'fail)) (return))
       
       (setq thisform  (car restforms))
       (setq restforms (cdr restforms))   
       (setq thisval (apply (car thisform) (cdr thisform)))

       (if (eq thisval 'fail)
	   (setq sofar 'fail)
	 (if (eq thisval 'poss)
	     (setq sofar 'poss) 
	   (if (not (eq thisval 'true))
	       (progn
		 (comment3 "Error in and3: thisform thisval nil" 
			   thisform thisval nil)
		 (setq sofar 'fail)
		 ))))
       ) ; loop

      ;; return result
      sofar
      )))) ; defun and3

(defun not3 ( notval )
" return tri logic value of not "
  (if (eq notval 'true)
      'fail
    (if (eq notval 'poss)
	'fail
      'true)))

(defun poss3-p ( val )
" return binary logic t iff val is poss "
 (eq val 'poss))

(defun fail3-p ( val )
" return binary logic t iff val is fail "
 (eq val 'fail))

(defun true3-p ( val )
" return binary logic t iff val is true "
 (eq val 'true))
