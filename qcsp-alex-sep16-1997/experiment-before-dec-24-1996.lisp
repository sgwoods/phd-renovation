;;************************************************************************************* 
(load "adt-template.fasl")

(setq *template-list-1*	'("average-array-template-9-12" 
			  "average-array-template-9-13"
			  "average-array-template-9-14"
			  "average-array-template-9-15"
			  "average-array-template-9-16"
			  "average-array-template-9-17"))

(setq *template-list-2* '("average-array-template-8-12"
			  "average-array-template-8-13"
			  "average-array-template-8-14")) 	


(setq *template-list-3* '("reset-value-template-2-1"
			  "increment-template-2-2"
			  "copy-array-element-template-3-2"
			  "alloc-array-error-check-template-4-3"
			  "traverse-array-template-5-7"
			  "addup-array-template-6-9"
			  "copy-array-template-7-11"
			  "averagearray-template-8-12"
			  "sum-square-array-9-16"))  

(setq *template-list-4* '("increment-template-2-2"))
(setq *template-list-5* '("traverse-array-template-5-7"))

(setq *data-file-list*		
      '(("testdata/dmaxc.component" "testdata/dmaxc.control" "testdata/dmaxc.stats") 
	("testdata/dmax3c.component" "testdata/dmax3c.control" "testdata/dmax3c.stats")
	("testdata/dmax6c.component" "testdata/dmax6c.control" "testdata/dmax6c.stats")
	("testdata/dmax9c.component" "testdata/dmax9c.control" "testdata/dmax9c.stats")
	("testdata/dmax12c.component" "testdata/dmax12c.control" "testdata/dmax12c.stats")
	
	("testdata/dmax15c.component" "testdata/dmax15c.control" "testdata/dmax15c.stats")
	("testdata/dmax18c.component" "testdata/dmax18c.control" "testdata/dmax18c.stats")
	("testdata/dmax21c.component" "testdata/dmax21c.control" "testdata/dmax21c.stats")
	("testdata/dmax24c.component" "testdata/dmax24c.control" "testdata/dmax24c.stats")
	("testdata/dmax27c.component" "testdata/dmax27c.control" "testdata/dmax27c.stats")
	
	("testdata/dmax30c.component" "testdata/dmax30c.control" "testdata/dmax30c.stats")
	("testdata/dmax33c.component" "testdata/dmax33c.control" "testdata/dmax33c.stats")
	("testdata/dmax36c.component" "testdata/dmax36c.control" "testdata/dmax36c.stats")
	("testdata/dmax39c.component" "testdata/dmax39c.control" "testdata/dmax39c.stats")
	("testdata/dmax42c.component" "testdata/dmax42c.control" "testdata/dmax42c.stats")
	
	("testdata/dmax45c.component" "testdata/dmax45c.control" "testdata/dmax45c.stats")
	("testdata/dmax48c.component" "testdata/dmax48c.control" "testdata/dmax48c.stats")
	("testdata/dmax51c.component" "testdata/dmax51c.control" "testdata/dmax51c.stats")
	("testdata/dmax54c.component" "testdata/dmax54c.control" "testdata/dmax54c.stats")
	)) 

(load "new-dep.fasl")

(defun experiment ( data-file-list template-list &optional (print-template nil))
  (dolist (files-element data-file-list)
	  (progn
	    (load "new-setup.fasl")
	    (format t
		    "~%Do files: ~a!"
		    files-element) 
	    (test-main (nth 0 files-element)
		       (nth 1 files-element)
		       (nth 2 files-element))
	    (dolist (template template-list)
		    (progn
		      (adt :template-id template
			   :forward-checking t
			   :dynamic-rearrangement t
			   :debug nil  
			   :debug-csp nil) 
;;			   :output-file "test-output-file")
		      (if print-template 
			  (format t "~%Template ~a," 
				  (get-templ-object template))
			(format t "~%Template ~a," 
				(first (get-templ-object template))))	
		      (format t "~%Result length is ~a!~%"
			      (length *solution-set*)))))))

(defun special-experiment ( data-file-list template-body-list-list )
;;explore random template tree 
  (dolist (files-element data-file-list)
	  (progn
	    (load "new-setup.fasl")
	    (format t
		    "~%Do files: ~a!"
		    files-element) 
	    (test-main (nth 0 files-element)
		       (nth 1 files-element)
		       (nth 2 files-element))
	    (let ((count 0)
		  (ave-constr 0)
		  (temp-cnt 0)) 
	      (dolist (template-body-list template-body-list-list)
		      (progn 
			(setq ave-constr 0) 
			(setq temp-cnt 0) 
			(dolist (template template-body-list)
				(progn
				  (adt :template-id "special" 
				       :forward-checking t
				       :dynamic-rearrangement t 
				       :override-template template)
				  (format 
				   t
				   "Level ~a Number ~a Template ~a,~%Result length is ~a!~%"
				   count
				   temp-cnt 
				   template 
				   (length *solution-set*))
				  (setq temp-cnt (+ temp-cnt 1)) 
				  (setq ave-constr 
					(+ ave-constr 
					   (+ *constraint-success* 
					      *constraint-failure*)))))	
			
			(format t
				"Level ~a, average constraint checks is ~a!~%~%"
				count
				(coerce (/ ave-constr (length template-body-list)) 
					'float))    
			(setq count (+ count 1)))			
		      )))))


;;************************************************************************************* 
;; Functions to generate template tree  
(defun remove-item (alist which-one)
  (cond ((endp alist) nil)
	((eq which-one 0) (rest alist))
	(T (cons (first alist) 
		 (remove-item (rest alist) (- which-one 1)))))
  )

(defun get-affected-components ( constraint-list )  
  (cond ((endp constraint-list) nil)
	(T (append (second (first constraint-list)) 
		   (get-affected-components (rest constraint-list)))))
  )

(defun pick-random (template-list how-many &optional (temp nil))
  (cond ((null template-list) temp) 
	((eq how-many 0) temp)
	(T
	 (let ((to-remove (random (length template-list))))  
	   (pick-random (remove-item template-list to-remove)
			(- how-many 1)
			(cons (nth to-remove template-list)
			      temp)))))   
  )

(defun stablize-template ( template )
  (let*
      ((affected-components (get-affected-components (third template)))
       (components 
	(remove-if #'(lambda (x)
		       (not (member (first x) affected-components)))
		   (second template))))
    (list
     (format nil "test-~a-~a" (length components) 
	     (length (third template))) 
     components 	
     (third template)))  	
  )

(defun remove-one-constraint (template constraint-num )
  (stablize-template 
   (list (first template)
	 (second template)
	 (remove-item (third template) constraint-num) ) 
   ) 
  )

(defun generate-one-set (template) 
  (let* ((result nil)
	 (all-constraints (third template)) 
	 (cnumber (length all-constraints)))
    (dotimes (count cnumber result)
	     (setf result (cons (remove-one-constraint template count)	
				result))))  	
  )

(defun generate-set (original-template-list &optional (temp nil)) 
  (cond ((endp original-template-list) temp)
	(T 
	 (generate-set (rest original-template-list) 
		       (append temp (generate-one-set 
				     (first original-template-list))))))  
  ) 

(defun generate-random-templates ( original-template-list depth branch-factor)
  (let* ((result (list original-template-list))
	 (temp-result (generate-set original-template-list)))
    (dotimes (count depth result)
	     (progn 
	       (setf temp-result    
		     (pick-random temp-result (* (+ 1 count) branch-factor)))
	       (cond ((not (null temp-result)) 
		      (setf result (append result (list temp-result)))))  
	       (setf temp-result (generate-set temp-result)))) 
    )	
  )

(defun total-number ( result )
  (cond ((endp result) 0)
	(T (+ (length (first result))
	      (total-number (rest result))))) 
  )

;;************************************************************************************* 
(defun gen ( &key
	     (template-id "sum-square-array-9-16")
	     (how-many 3)
	     (branch-factor 3))
  (let ((result  
	 (generate-random-templates (list (get-templ-object template-id)) 
				    how-many 
				    branch-factor))) 
    (format t
	    "~%Total generated templates: ~a"
	    (total-number result))
    result)) 

;;************************************************************************************* 
(defun all-exp-1 ()  
  (experiment  *data-file-list* *template-list-3* nil)
  )

(defun all-exp-2 ()
  (let ((data-file-list
	 '(("testdata/dmax3c.component" 
	    "testdata/dmax3c.control" 
	    "testdata/dmax3c.stats"))) 
	(test-list (gen :how-many 5 :branch-factor 5)))
    (special-experiment data-file-list test-list))) 	

(defun all-exp-3 ()  
  (experiment  *data-file-list* *template-list-4* nil)
  )

(defun all-exp-30 ()  
  (experiment  *data-file-list* *template-list-5* nil)
  )

(defun static-exp ()
	(p-constraint-exp :data-file-list *data-file-list*)  
)

(defun abnormaly ()
  (let ((data-file-list
	 '(
       ("testdata/dmax6c.component" 
	    "testdata/dmax6c.control" 
	    "testdata/dmax6c.stats")
       ("testdata/dmax7c.component" 
	    "testdata/dmax7c.control" 
	    "testdata/dmax7c.stats")
       ("testdata/dmax8c.component" 
	    "testdata/dmax8c.control" 
	    "testdata/dmax8c.stats")
	   ("testdata/dmax9c.component" 
	    "testdata/dmax9c.control" 
	    "testdata/dmax9c.stats")
	   ("testdata/dmax10c.component" 
	    "testdata/dmax10c.control" 
	    "testdata/dmax10c.stats")
	   ("testdata/dmax11c.component" 
	    "testdata/dmax11c.control" 
	    "testdata/dmax11c.stats")
	   ("testdata/dmax12c.component" 
	    "testdata/dmax12c.control" 
	    "testdata/dmax12c.stats"))))
    (experiment data-file-list '("sum-square-array-9-16"))))

(defun explore-9 ()
  (let ((data-file-list
	 '(("testdata/dmax9c.component" 
	    "testdata/dmax9c.control" 
	    "testdata/dmax9c.stats"))) 
	(test-list (gen :how-many 5 :branch-factor 5)))
    (special-experiment data-file-list test-list))) 	

(defun all-exp-4 ()
  (let ((data-file-list
	 '(("testdata/dmax3c.component" 
	    "testdata/dmax3c.control" 
	    "testdata/dmax3c.stats")))) 
    (experiment data-file-list '("sum-square-array-9-16"))))

(load "constr-order-exp.fasl")
;;************************************************************************************* 

