(in-package #:phd-qcsp3)
;; gsat.lisp

(defun cgs () (compile-file "gsat")  (load "gsat"))
(defun lgs () (load "gsat.lisp"))

(defun adt-gsat ( varset
		  cset 
		  )
  (let* (
	 (*max-restarts* 100)
	 (*max-flips* 200)
	 (found nil)
	 (i 1)
	 (j 1)
	 (k 1)
	 (best-score 0) ;;best score for a trie
	 (flip-score 0)
	 (idx -1)
	 (best-idx -1)
	 (num-vbles (length varset))
	 (values nil)
	 )

    (loop while (and (not found) (<= j *max-flips*)) do

	  (setq values (rand-vals varset))
	  (incf i)
	  (setq j 1)

	  (loop while (and (not found) (<= j *max-flips*)) do
		
		(incf j)
		(setf best-score 0)

		(let* (
		       (rand-start (random num-vbles))
		       (the-score (score values varset cset))
		       (score (first the-score))
		       (conflict-vector (rest the-score))
		       )
		  (if (= score num-vbles)
		      (setq found t)
		    (progn 
		      ;; find a vble in conflict
		      (setq idx rand-start)
		      (setq k 1)
		      (loop while (not (nth idx conflict-vector)) do
			    (setq idx (mod (+ rand-start k) num-vbles))
			    (incf k)
			    )
		      (setq best-value (nth idx values))

		      (dolist (r (range-of idx varset))  ;; ?
			      (setf (nth idx values) r)
			      ;; calculate score
			      (setq score (first (score nvalues)))  ;; ?
			      (if (< best-score score)
				  (progn
				    (setq best-score score)
				    (setq best-value r)))
			      )
		      (setf (nth idx values) best-value) )))))))

(defun rand-vals (varset)
  (let (
	(result nil)
	)
    (dolist (vardom varset result)
	    (let* (
		   (var   (car vardom))
		   (range (cdr vardom))
		   (val   (nth (random (length range)) range))
		   )
	      (setq result (append result (list val) ))))))

(defun score (values varset cset)
" 
Return a vector of T's and Nil's such that for each variable and domain
value pair (in order), a T is returned if it does not conflict with 
any other variable and constraint in the problem.  Precede the list by N.
"
(let* (
       (count 0)
       (count-true 0)
       (result '())
       (vals (dolist (val values result)
		     (let* (
			    (var (car (nth count varset)))
			    (sc1 (score-one var val varset cset values count))
			    )
		       (incf count)
		       (when sc1 (incf count-true))
		       (setq result (append result (list sc1)))
		       ))))
  (cons count-true result)))


(defun score-one ( var val varset cset values varvalpos)
"
Return T if the var and value pair has no conflicts in varset and cset
 using the variable assignments listed in "values", nil otherwise.
"
  (let* (
	 (rel-vars   (get-related-variables-1 var cset))
	 (gen-soln   (set-part-soln var values varset))
	 )

    ;; iterate over all "other variables" calling consistent-p,
    (check-consis-set var val rel-vars gen-soln)
    ))

(defun check-consis-set (var val rel-vars part-soln)
  (if (null rel-vars)
      t
    (let* (
	   (thisvar  (car rel-vars))
	   (restvars (cdr rel-vars))
	   (thisval  (getval thisvar part-soln))
	   )

      (if (first (consistent-p var val thisvar thisval part-soln))
	  (check-consis-set var val restvars part-soln)
	nil))))

(defun getval (key part-soln)
  (if (null part-soln)
      nil
    (let* (
	   (thiskey (first (car part-soln)))
	   (thisval (second (car part-soln)))
	   )
		
    (if (equal key thiskey)
	thisval
      (getval key (cdr part-soln))))))
  
(defun set-part-soln (var values varset)
  (let* (
	 (almost (soln-generate values varset))
	 )
    (remove-if #'(lambda (x) (equal (car x) var)) almost)))
  
(defun soln-generate ( values varset )
  (let (
	(len-val (length values))
	(len-var (length varset))
	)
    (if (not (= len-val len-var))
	'error-lists-unequal-length
      (soln-generate2 values varset))))

(defun soln-generate2 ( values varset )
  (if (null values)
      nil
  (append (list (list (caar varset) (car  values)))
	  (soln-generate2 (cdr values) (cdr varset)))))
	  
      
(defun range-of (n varset)
  (rest (nth n varset))
)
