(in-package #:phd-qcsp3)
;;
;; ao-ac3.lisp
;;

;;
;; This file contains the and/or hierarchical arc consistency algorithm
;;  motivated by the original AC3 algorithm, extended to maintain 
;;  explicit justification linkages.
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

(defvar *ao-debug*)     ;; global debug flag  for AO related functions
(defvar *debug-app* t)  ;; global debug flag  for apply related functions
(defvar *constraint-count* 0)  ;; global counter of constraint applications
	
(defun ao-ac3 ( graph  maxDepth &key 
		       (revise-mode 'step) 
		       (debug-mode  nil)
		       )
(let* (
       (targetList (graph-variable-list graph)) ; start w/ list all variables
       )

  (initialize-global-counters debug-mode)

  (loop                     ;; iterate over variables in targetList

   (if (null targetList)    ;; exit condition - empty targetList
       (return))

	(let* (
	       ;; select a target var from targetList
               (thisTarget     (select-target targetList))             

	       ;; identify vars which are the source of directed relations to
	       ;;  the current target variable "thisTarget"
	       (srcVarList     (getSourceVariables graph thisTarget))
	       )

	  ;; remove thisTarget fr targetList
	  (setq targetList   (remove-var-list thisTarget targetList))  

	  (dolist (srcVar srcVarList)        ; iterate over srcs fr thisTarget
		  (let*
		      (
		       ;; get applicable constraint function srcVar->thisTarget
		       (constraint-fn  
			(get-constraint-fn graph srcVar thisTarget))
		       (reviseVars nil)
		       )

		    ;; revise src domain in place destructively - return NULL
		    ;; if no var domains affected, otherwise returns the list
		    ;; of affected variables  
		    (if (null constraint-fn)
			(progn
			  (comment2 "Unexpected null cfn in AOac3:" srcVar
				    thisTarget)
			  (setq reviseVars nil)
			  )
		      (progn

			(setq reviseVars
			      (ao-revise srcVar thisTarget constraint-fn
					 maxDepth :mode revise-mode ))
			))

		    (if (not (null reviseVars))     ;; ie if some vars revised
			(progn
			  ;;    insure that revised srcVar is a later target   
			  (setq targetList (targetUnion reviseVars targetList))
			  )) ; if
		    ) ;; let*
		  ) ;; dolist srcVarList
	  ) ;; let*  
	) ;; loop targetList

  graph   ;; return final reduced (in place) graph for later use
  ))

;; ---------------------------------------------------------------------------
;; AO-AC3 support functions / heuristic selectors

(defun select-target ( targetList )
"
Select a target var from targetList - selection order might be NB,
  however, for simplicity here take the first one
" 
  (first targetList))

(defun targetUnion ( reviseVars targetList )
" 
   Add the reviseVars to the targetList ... replacing existing targetVars
   with the new reviseVars where appropriate. 

   Note perhaps some ordering is useful for this function on appending ?
"
 (remove-duplicates (append targetList reviseVars)) )

;; ---------------------------------------------------------------------------

(defun initialize-global-counters ( debug-mode )

  (setq *constraint-count* 0)

  (setq *debug-app* debug-mode)
  (setq *ao-debug*  debug-mode)

)
