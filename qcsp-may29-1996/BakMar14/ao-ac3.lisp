;;
;; ao-ac3.lisp
;;

;; INPUT
;; A graph structure containing variables Vi with domains D(Vi) and relations
;; among variables relation(Vi,Vj) and an integer maxDepth giving the maximum
;; depth to penetrate the domain hierarchy. 
;;
;; OUTPUT
;; An AO arc-consistent graph to depth maxDepth

(defun load-ao ( &optional (sys *unix*) )
  (if sys
	(load	     "ao-ac3.lisp")
    (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-ac3.lisp")))
	

(defun ao-ac3 ( graph  maxDepth )
(let* (
       (targetList (get-variables graph))    ;; start with a list of all variables
       )

  (loop                                      ;; iterate over variables in targetList

   (if  (empty-p targetList) (return))

	(let* (
	       ;; select a target from targetList - selection order might be NB,
	       ;;  however for simplicity here take the first one
               (thisTarget     (first  targetList))              ; (var d1 ... dn)

	       ;; identify variables which are the source of directed relations to
	       ;;  the current target variable "thisTarget"
	       (srcVarList     (getSrcVars  graph thisTarget))   ; (var d1 ... dn)
	       )

	  (setq targetList     (cdr targetList))  ; remove thisTarget fr targetList

	  (dolist (srcVar srcVarList)             ; iterate over srcs fr thisTarget
		  (let*
		      (
		       ;; get applicable constraint function srcVar->thisTarget
		       (constraint-fn  (get-constraint-fn graph srcVar thisTarget))

		       ;; revise src domain in place destructively
		       ;;  return NULL if no var domains affected,
		       ;;   otherwise returns the list of affected variables 
		       (reviseVars 
			(ao-revise srcVar thisTarget constraint-fn maxDepth))
		       )

		    (if (not (empty-p reviseVars))    ;; ie if no vars revised
			(progn
			  ;;    insure that revised srcVar is a later target   
			  (setq targetList (targetUnion reviseVar targetList))

			  )) ; if
		    ) ;; let*
		  ) ;; dolist srcVarList
	  ) ;; let*  
	) ;; loop targetList

  graph   ;; return final reduced (in place) graph for later use
  ))


(defun get-variables ( graph )
" Variables are of the form ( (V1 d1 d2 d3 ...) (v2 d1 d2 ..) ... ) "
  (first graph)
  )

(defun get-constraints ( graph )
" Constraints are of the form ( (constraint-fn Var Var) ... )  
  where constraint-fn can be applied with a pair of instantiated variables
  evaluating to one of the tri logic values true (if the constraint necessarily
  holds, poss (if the constraint is not know to hold but may0, or false (if the
  the constraint is know to not hold). "
 (second graph)
 )

(defun get-constraint-fn ( graph var1 var2 )
" Return the constraint function relevant only between var1 and var2. 
  This function needs to be evaluable for any two domain values ... 
"
;; note in general can call "get-related-constraints" from adt-simple.lisp,
;;  however, for our purposes for the simple example, there is only one
;;  constraint applicable ... ie r-relation.  Return a hook to the function
;;  itself so that it may be applied generically as (fn var1 var2) returning
;;  the tri logic value appropriate.  Note that it is sensible to define 
;;  a generic R-relation function that hides the details from this level and
;;  maps the previous t/nil evaluation to tri logic here.  Lookup and application
;;  can all be hiddern with a redefinition of R-relation in adt-simple.

  R-relation   ;; return a hook to the function to apply
)

(defun empty-p ( targetList )
  (null targetList)  )

(defun getSrcVars ( graph thisTarget )
" returns list of variables Vs where some relation between Vs and thisTarget
  exists, ie all sources to target. "


)

(defun targetUnion ( reviseVars targetList )
" Add the reviseVars to the targetList ... replacing existing targetVars
   with the new reviseVars where appropriate. "


)


