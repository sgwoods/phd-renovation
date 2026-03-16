(in-package #:phd-qcsp3)
;;
;; ao-ac-new.lisp
;;

(defun ao-ac-new ( graph  maxDepth &key (revise-mode 'step)  
			  (debug-mode  nil)   )
(let* (
       (targetList (graph-variable-list graph)) )

  (initialize-global-counters debug-mode)

  (loop                     

   (if (null targetList) (return))
   
   (let* (
	  (thisTarget     (select-target targetList))             
	  (srcVarList     (getSourceVariables graph thisTarget))  )
     
	  (setq targetList   (remove-var-list thisTarget targetList))  

	  (dolist (srcVar srcVarList)             
		  (let*
		      (
		       (constraint-fn  
			(get-constraint-fn graph srcVar thisTarget))
		       (reviseVars nil)       
		       )

		    (if (null constraint-fn)
			(progn
			  (comment2 "Unexpected null cfn in AOac3:" 
				    srcVar thisTarget)
			  (setq reviseVars nil)
			  )

		      (progn
			
			(setq reviseVars
			      (ao-revise srcVar thisTarget constraint-fn
					 maxDepth :mode revise-mode )) 
			))
		      
		    ;; (if (not (null reviseVars))     
		    ;;	(setq targetList (targetUnion reviseVars targetList)) )

		    ))))
  graph  
  ))
