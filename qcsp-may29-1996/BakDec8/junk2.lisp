 (setq c (nth 4 *variables*))
 (setq d (nth 3 *variables*))
 (setq g (nth 8 *variables*))
 (setq e (nth 2 *variables*))

(setq t1 (list c d g e))


(defun iterate (many)
  (let (
	(newmany nil)
	)
    (dolist (one many newmany)
	    (let (
		  (onemore (1+ one))
		  )
	      (setq newmany
		    (append newmany
			    (list onemore)))
	      )) ;; dolist
    )) ;; let  




  (let (
	(complete-solution-set nil)
	)
    (dolist (one-part-soln partial-solution-set complete-solution-set)
	    (let (
		  (one-revised nil)
		  )

	      (setq one-revised
		     (adt :situation-id situation-id
			    :sit-noise    sit-noise
			    :rand-dist     rand-dist
			    :random-ident  random-ident
			    :output-file   output-file
			    :long-output   long-output
			    :single-line-override    single-line-override

			    :template-id  whole-template-id  

			    :search-mode            2-search-mode 
			    :node-consis            2-node-consis 
			    :arc-consis             2-arc-consis 
			    :forward-checking       2-forward-checking 
			    :dynamic-rearrangement  2-dynamic-rearrangement 
			    :advance-sort           2-advance-sort
			    :sort-const             2-sort-const 
			    :adv-sort-const         2-adv-sort-const 
			    :one-solution-only      2-one-solution-only 

			    :part-soln    one-part-soln
			    ))

	      (setq complete-solution-set
		    (append complete-solution-set
			    (list one-revised)))
	      )) ;; dolist
    )) ;; let  

(setq results (memory-search "quilici-t1-index" "quilici-t1" :sit-noise 0))

(memory-search "quilici-t1-index" "quilici-t1" :sit-noise 0)

(defun replace-values (name value-lst)
  (let (
	(new-value-lst nil)
	)
    (setq new-value-lst
	  (dolist (entry *value-series* new-value-lst)
		  
		  (append new-value-lst
			  (list
			   (if (eq (car entry) name)
			       (list name value-lst)
			     entry))) )))
  (setq *value-series* new-value-lst)
  )
		  

(setq *value-series* '( ("a" (1 2))  ("b" (10 11))  ("c" (22 24)) ))
(insert-values "b" '(13 14))
(insert-values "d" '(99 100))