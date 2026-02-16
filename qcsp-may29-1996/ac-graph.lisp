;;
;; ac-graph.lisp
;;

;;
;; This  file contains the definition of a CSP graph for use in 
;;  our hierarchical arc consistency algorithms and testing, as 
;;  well as accessor and other functions relevant to this structure.
;;


(defun load-graph (&optional (sys *unix*) )
  (if sys
      (load "ac-graph.lisp")
    (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ac-graph.lisp")
    ))

(defstruct (AC-Graph
	    (:print-function
	     (lambda ( p s k )
	       (format s "AC-Graph  <~A, vars=~A, arcs=~A>"
		       (AC-Graph-Name p)
		       (variable-list-to-names (AC-Graph-CVariableList p))
		       (arc-list-to-names (AC-Graph-ArcList p))
		       ))))

  (Name             'unset)
  (CVariableList    nil)   ;; list of all variables in graph
  (ArcList          nil)   ;; list of ((srcV (trgV1 ... trgVn)) .. (srcV (t1
			   ;; ... tk)))
  (ConstraintList   nil)   ;; list of ((srcV trgV1 c-fn) (srcV trgV1 c-fn) ...)
  )

;; ---------------------------------------------------------------------------
;; Graph accessors

(defun graph-variable-list ( graph)
  (AC-Graph-CVariableList graph) )

(defun graph-arc-list ( graph)
  (AC-Graph-ArcList graph) )

(defun graph-constraint-list ( graph)
  (AC-Graph-ConstraintList graph) )

;; Part-Accessor Functions

(defun getSourceVariables ( graph thisTarget )
" 
Returns list of variables Vs where Vs is a source for a relation between
 Vs and thisTarget, ie all sources to target. 
"
  (let* ( 
	 (arclist (graph-arc-list graph)) 
	 (srclist  (remove-if 
		    #'(lambda (x) 
			(let (
			      (srcV  (first x))
			      (Vlist (second x)) )
			  (not (member thisTarget Vlist)) ))
		    arclist))
	 )
    (mapcar #'(lambda (x) (first x)) srclist) ))

(defun get-constraint-fn ( graph var1 var2 )
" Return the constraint function relevant only between var1 and var2. 
  This function needs to be evaluable for any two domain values ... 
  We assume there is only one function S -> T for any S and T.
"
  (let  ( (entry (find-if #'(lambda (x) 
			      (and (eq (first x) var1) (eq (second x) var2)))
			  (graph-constraint-list graph))) )
    (if (null entry)
	nil
      (third entry))) )

(defun remove-var-list ( var varlist )
  (let* ( (nm (CVariable-Name var)) )
    (remove-if #'(lambda (x) (equal nm (CVariable-Name x))) varlist)))

(defun variable-list-to-names ( VarList )
  (if (null VarList)
      nil
    (mapcar #'(lambda (x) (if (CVariable-p x)
			      (CVariable-Name x) 
			    x ))
	    VarList)))

(defun arc-list-to-names ( arclist )
  (if (null arclist)
      nil
    (mapcar #'(lambda (x) 
		(let (
		      (srcV  (first x))
		      (Vlist (second x))
		      )
		  (list (CVariable-Name srcV) (variable-list-to-names Vlist))))
	    arclist)))

