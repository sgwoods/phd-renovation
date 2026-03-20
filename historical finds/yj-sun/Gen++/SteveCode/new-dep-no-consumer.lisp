;;***********************************************************************************
;; To build an assoc list (((var-name file line).(list-of-last-modified-comp)) ....)
;; normally the list-of-last-modified-comp should contain just one element except
;; this component is on a loop  

;;***********************************************************************************
;;  
(defun list-all-var-of-func ( func-name )
  (first (last (gethash func-name *control-hash*))))

(defun list-all-comp-index-of-func ( func-name )
  (nth 3 (gethash func-name *control-hash*)))
;;***********************************************************************************
;;(defun my-acons ( x y a &optional (temp nil) )
;;  (cond ((endp a) temp )
;;	((equal x (caar a)) (cons (cons x y) (rest a)))  	
;;	(T (cons (first a) (my-acons x y (rest a) temp))))) 
;;***********************************************************************************
(defun my-acons ( x y a &optional (temp nil) )
  (cond ((endp a) (list (cons x y)))
	((equal x (caar a)) (cons (cons x y) (rest a)))  	
	(T (cons (first a) (my-acons x y (rest a) temp))))) 
;;***********************************************************************************
;; if all elements of this-list is in other list 
(defun in-other-list ( this-list atom-or-list )
  (cond ((atom atom-or-list) nil)
	((endp this-list) T) 
	((member (first this-list) atom-or-list)
	 (in-other-list (rest this-list) atom-or-list))
	(T nil)) 
  )
(defun compare-atom-or-list (atom-or-list-1 atom-or-list-2 )
  (cond ((atom atom-or-list-1) (equal atom-or-list-1 atom-or-list-2))
	(T (in-other-list atom-or-list-1 atom-or-list-2)))
  )

;; '(a . (2 3)) is the same as '(a . (3 2))  
(defun compare-assoc-aux( assoc-list-1 assoc-list-2 n)
  (cond ((eq n 0) T)
	((compare-atom-or-list 
	  (cdar assoc-list-1) 
	  (rest (assoc (caar assoc-list-1) assoc-list-2 :test #'equal)))
	 (compare-assoc-aux (rest assoc-list-1) assoc-list-2 (- n 1)))
	(T nil))
  )

(defun compare-assoc( assoc-list-1 assoc-list-2 )
  (cond ((eq (length assoc-list-1) (length assoc-list-2)) 
		  (compare-assoc-aux assoc-list-1 assoc-list-2 (length assoc-list-1)))
		(T nil)) 
  )
;;***********************************************************************************
;; if var is in modified-var-list, the associated value of var in assoc-list will
;; be changed to comp-index 
(defun modify-var-assoc-list (comp-index modified-var-list assoc-list )
  ;;(print assoc-list) 
  (cond ((endp modified-var-list) assoc-list)
	(T 
	 ;;(rplacd (assoc (first modified-var-list) 
	 ;;	     assoc-list :test #'equal) comp-index )    
	 ;; (modify-var-assoc-list comp-index (rest modified-var-list) 
	 ;;					assoc-list) 
	 (modify-var-assoc-list comp-index (rest modified-var-list) 
				(my-acons (first modified-var-list) comp-index 
					  assoc-list))))   
  )
;;***********************************************************************************
;; comp-index will be added to a var's assoc-list if comp-index change that var 
(defun add-to-var-assoc-list (comp-index modified-var-list assoc-list )
  (cond ((endp modified-var-list) assoc-list)
	(T
	 (let* ((this-var (first modified-var-list)) 
		(stmts-set-this-var (assoc this-var assoc-list :test #'equal))) 
	   (cond ((equal comp-index (rest stmts-set-this-var))
		  (add-to-var-assoc-list comp-index (rest modified-var-list) 
					 assoc-list))
		 ((member comp-index (rest stmts-set-this-var))
		  (add-to-var-assoc-list comp-index (rest modified-var-list) 
					 assoc-list))
		 (T  (cond ((atom stmts-set-this-var) 
			    (setq stmts-set-this-var (list stmts-set-this-var))) 
			   (T nil)) 	
		     ;;	(rplacd  (assoc this-var assoc-list :test #'equal) 
		     ;;	(cons comp-index stmts-set-this-var) )
		     ;;	(add-to-var-assoc-list comp-index (rest modified-var-list)
		     ;;				 assoc-list)
		     (add-to-var-assoc-list 
		      comp-index 
		      (rest modified-var-list)
		      (my-acons this-var 
				(cons comp-index stmts-set-this-var)
				assoc-list)))))))
  )
;;***********************************************************************************
;;***********************************************************************************
;; if atom-list-1 and atom-list-2 are both atoms return a list of them 
;; otherwise combine them, remove same elements 
(defun add-to-atom-list ( atom-list-1 atom-list-2 )
  (cond ((NULL atom-list-1) atom-list-2)
	((NULL atom-list-2) atom-list-1)  
	((equal atom-list-1 atom-list-2) atom-list-2 )
	((and (atom atom-list-1) 
	      (atom atom-list-2)) (list atom-list-1 atom-list-2)) 
	((and (atom atom-list-1)
	      (not (member atom-list-1 atom-list-2))) 
	 (cons atom-list-1 atom-list-2)) 
	((atom atom-list-1) atom-list-2)
	((not (atom atom-list-2)) 
	 (add-to-list atom-list-1 atom-list-2))  
	(T  (add-to-atom-list atom-list-2 atom-list-1)))  
  
  ) 
;;***********************************************************************************
;; Combine the associated value of the same key of two assoc-list to make a new one  
;;(defun combine-two-assoc-list ( a-list-1 a-list-2 )
;;  (cond ((endp a-list-1) a-list-2)  	
;;	(T (let* ((this-key (caar a-list-1))
;;		  (content1  (cdar a-list-1))
;;		  (content2  (rest (assoc this-key a-list-2 :test 'equal))))
;;	     (combine-two-assoc-list (rest a-list-1)
;;				     (my-acons this-key  
;;					       (add-to-atom-list content1 content2) 
;;					       a-list-2)))    
;;	   )))

;; Combine the associated value of the same key of two assoc-list to make a new one  
(defun combine-two-assoc-list ( a-list-1 a-list-2 )
  (cond ((endp a-list-1) a-list-2)  	
	(T (let* ((this-key (caar a-list-1))
		  (content1  (cdar a-list-1))
		  (content2  (rest (assoc this-key a-list-2 :test 'equal))))
	     (combine-two-assoc-list (rest a-list-1)
				     (my-acons this-key  
					       (add-to-atom-list content1 content2) 
					       a-list-2)))    
	   )))
;;***********************************************************************************
(defun subset (small-list larger-list &optional (op 'eq))
  (cond ((endp small-list) T)
	((member (first small-list) larger-list :test op)
	 (subset (rest small-list) larger-list op))
	(T nil))   
  )
;;***********************************************************************************
(defun get-parents-list ( comp-index )
  (let ((parents-list	(nth 1 (get-comp-hash comp-index))))
    (if (> (length parents-list) 2)
	(format t 
		"~%component ~a has more than 2 parents!"
		comp-index))   
    parents-list)  
  ) 

(defun computable ( computed-list comp-index )
  (subset (get-parents-list comp-index) computed-list ) 
  )

(defun get-first-computable-aux (computed-list open-list )
  (cond ((endp open-list) nil)
	((computable computed-list (first open-list))
	 (first open-list))
	(T (get-first-computable-aux computed-list (rest open-list))))   
  )

(defun get-first-computable ( computed-list open-list )
  (cond ((null open-list) nil) 
	(T 
	 (let ((comp-index (get-first-computable-aux computed-list open-list)))
	   (cond (comp-index comp-index)
		 (T (first open-list)))) ))  
  ) 
;;***********************************************************************************
(defun get-comp-hash (comp-index)
	(gethash comp-index *component-hash*) 
	)

(defun get-dependency ( comp-index )
  (let ((comp-hash (get-comp-hash comp-index)))
    (nth 6 comp-hash)) 		    
  )

;;***********************************************************************************
;;(defun i-modify-dependency (comp-index)
;;	(let* ((comp-hash (get-comp-hash comp-index))
;;	       (this-dependency (nth 6 comp-hash))
;;	       (this-modified-var-list (nth 5 comp-hash)))  
;;	  (modify-var-assoc-list 
;;	   comp-index 	
;;	   this-modified-var-list this-dependency))
;;	) 
(defun remove-intermediate-var ( dependency )
	(cond ((endp dependency) nil) 
		  ((eq (length (caar dependency)) 1) 
				(remove-intermediate-var (rest dependency))) 
		  (T 
			 (cons (first dependency)
				(remove-intermediate-var (rest dependency))))) 
)

(defun purify-dependency ( dependency comp-index next-index )
	(let* ((this-comp (get-comp-hash comp-index))
		   (next-comp (get-comp-hash next-index))
		   (this-stmt (nth 2 this-comp))
		   (next-stmt (nth 2 next-comp)))
	(cond ((eql this-stmt next-stmt) dependency )
		  (T (remove-intermediate-var dependency))))

)

(defun i-modify-dependency (comp-index next-index)
	(let* ((comp-hash (get-comp-hash comp-index))
	       (this-dependency (nth 6 comp-hash))
	       (this-modified-var-list (nth 5 comp-hash))  
		   (new-dependency (modify-var-assoc-list 
				    comp-index 	
				    this-modified-var-list this-dependency)))
	  (purify-dependency new-dependency comp-index next-index) 
	  )) 

;; Assume at most one component has two parents 
(defun compute-dependency ( comp-index )
  (let* ((parents-list (get-parents-list comp-index)))
    (cond ((endp parents-list) nil);;  *all-var-of-this-func* ) 
	  ((eq (length parents-list) 1)   
	   (i-modify-dependency (first parents-list) comp-index))
	  ((eq (length parents-list) 2)
	   (let ((first-dep (i-modify-dependency (first parents-list) comp-index))
		 (second-dep (i-modify-dependency (second parents-list) comp-index)))
	     (combine-two-assoc-list first-dep second-dep )))
	  (T nil)))  
  )
;;***********************************************************************************
(defun set-dependency ( comp-index dependency )
  (let ((comp-hash (get-comp-hash comp-index)))
    (if (eq (length comp-hash) 7) ;ever been set a dependency  
	(setf (nth 6 (gethash comp-index *component-hash*)) dependency)  
      (setf (gethash comp-index *component-hash*)
	    (append comp-hash (list dependency))))) 
  )  
;;***********************************************************************************
(defun add-atom-to-list-if-not-in ( a-atom a-list )
  (cond ((NULL a-atom) a-list)
	((member a-atom a-list) a-list) 
	(T (cons a-atom a-list)))   
  ) 
;;***********************************************************************************
(defun modify-open-list (this-comp open-list )
  (let* ((children (nth 0 (get-comp-hash this-comp))) 
	 (temp-open-list (remove this-comp open-list ))) 
    (cond ((NULL children) temp-open-list)
	  ((atom children) 
	   (if (member children temp-open-list) 
	       temp-open-list   
	     (cons children temp-open-list)))
	  (T (let ((first-child (first children)) 
		   (second-child (second children))
		   (temp-open-list (remove this-comp open-list)))
	       (add-atom-to-list-if-not-in 
		first-child
		(add-atom-to-list-if-not-in second-child temp-open-list)))))) 		 												   
  ) 
;;***********************************************************************************
;;***********************************************************************************
(defun component-dependency ( computed-list open-list )
  ;;  (format t
  ;;    "~%Computed-list ~a !"
  ;;    computed-list)
  ;;  (format t
  ;;      "~%Open-list ~a !"
  ;;      open-list)
  (cond ((null open-list) nil)
	(T
	 (let ((computable-comp (get-first-computable computed-list open-list)))
	   (cond ((member computable-comp computed-list) ;a loop
		  ;;  (format t
		  ;;      "~%Find a loop at ~a !"
		  ;;      computable-comp)
		  (let* ((existing-dep (get-dependency computable-comp)) 
      			 (newer-dep (compute-dependency computable-comp)))
		    (cond ((compare-assoc existing-dep newer-dep) ;same now 
			   (component-dependency computed-list
						 (remove computable-comp open-list)))
			  (T              ; not same, redo  
			   (set-dependency computable-comp newer-dep) 
			   (component-dependency 
			(member computable-comp computed-list)
			(modify-open-list
			 computable-comp open-list))
			   ))))
		 (T 	;not a loop
		  (let ((newer-dep (compute-dependency computable-comp)))
		    (set-dependency computable-comp newer-dep)  
		    (component-dependency (cons computable-comp computed-list)
					  (modify-open-list
					   computable-comp open-list)))))))) 
  )
;;***********************************************************************************
;;***********************************************************************************
(defun remove-vars-not-in-accessed-list( accessed-var-list this-hash-value)
  (cond ((endp this-hash-value) nil)
	((member (caar this-hash-value) accessed-var-list :test #'equal)
	 (cons (first this-hash-value) 
	       (remove-vars-not-in-accessed-list accessed-var-list
						 (rest this-hash-value))))  
	(T 
	       (remove-vars-not-in-accessed-list accessed-var-list
						 (rest this-hash-value))))  
  ) 
;;***********************************************************************************
;; Very important functions here for program setup to recognize plans 
;;***********************************************************************************
;; After all computations, finalize the *component-hash* with
;; Key: comp-index
;; Content: (comp-body dependency-list)
;;
;; *situations* is set in program-setup.lisp, and has a list of
;; all components as (comp-index nodetype)
;;
;; Later we will use *situations* to generate a new hashtable which is
;; Key: nodetype
;; Content: list of all components of this node type

(defun finalize-hash-value( in-hash-value dependency-list )
  (list (nth 3 in-hash-value) dependency-list) 
  )   
;;***********************************************************************************
;;
;;remove unaccessed variables from the dependency list
;;
(defun old-1-reset-var-dependency( comp-index accessed-var-list) 
  ;;(nth 6 hash-value) is the var-dependency
  (let ((this-hash-value (get-comp-hash comp-index)))
    ;; (setf (nth 6 (get-comp-hash comp-index)) 
    ;; (remove-vars-not-in-accessed-list accessed-var-list ..this-hash-value))
    (setf (gethash comp-index *component-hash*) 
	  (finalize-hash-value this-hash-value  	
			       (remove-vars-not-in-accessed-list 
				accessed-var-list 
				(nth 6 this-hash-value)))))
  ;;(print (cons comp-index (get-comp-hash comp-index)))
  ) 

;;
;;not remove unaccessed variables from the dependency list, for the purpose of 
;;checking control-data-dependency
;;Dec 26, I found it's taking longer time in matching with the results from here
;;than from the above function. Since we only need to check control-data-dependency
;;with components that are type Loop, we can combine old-reset-var-dependency and
;;this function, that is, apply the above function to all components that are not
;;type Loop, apply this function to Loop
;;
(defun old-2-reset-var-dependency( comp-index accessed-var-list) 
  ;;(nth 6 hash-value) is the var-dependency
  (let ((this-hash-value (get-comp-hash comp-index)))
    ;; (setf (nth 6 (get-comp-hash comp-index)) 
    ;; (remove-vars-not-in-accessed-list accessed-var-list ..this-hash-value))
    (setf (gethash comp-index *component-hash*) 
	  (finalize-hash-value this-hash-value  	
				(nth 6 this-hash-value))))
  ;;(print (cons comp-index (get-comp-hash comp-index)))
  ) 

;;
;; New reset function
;;
(defun reset-var-dependency( comp-index accessed-var-list) 
  ;;(nth 3 hash-value) is the component body
  ;;(nth 6 hash-value) is the var-dependency
  (let* ((this-hash-value (get-comp-hash comp-index))
	 (comp-type (first (nth 3 this-hash-value))))
    ;; (setf (nth 6 (get-comp-hash comp-index)) 
    ;; (remove-vars-not-in-accessed-list accessed-var-list ..this-hash-value))
    (if (equal comp-type 'Loop) 
	(setf (gethash comp-index *component-hash*) 
	      (finalize-hash-value this-hash-value  	
				   (nth 6 this-hash-value)))
      (setf (gethash comp-index *component-hash*) 
	    (finalize-hash-value this-hash-value  	
				 (remove-vars-not-in-accessed-list 
				  accessed-var-list 
				  (nth 6 this-hash-value))))))
  ;;(print (cons comp-index (get-comp-hash comp-index)))
  )


;;***********************************************************************************
;; We need a function to modify the hash value of component by removing those
;; variables which are not accessed in this component
(defun modify-component-hash-value( comp-list )
  (cond ((endp comp-list) nil) 
	(T 
	 (let* ((comp-index (first comp-list))       
		;; nth 4 is the accessed variable list 
		;;(comp-index (first comp)) 
		(accessed-var-list (nth 4 (get-comp-hash comp-index))))
	   (reset-var-dependency comp-index accessed-var-list)
	   (modify-component-hash-value (rest comp-list)))))  
  )
;;***********************************************************************************
(defun single-func-dependency( func-name )
  (format t 
	  "~%Processing ~a now!"
	  func-name)  
  (format t 
	  "~%Computing dependency in  ~a now!"
	  func-name)  
  ;;  (comp-dependency (first (gethash func-name *control-hash*)) 
  ;;		   *all-var-of-this-func*   
  ;;		   nil)  		
  (component-dependency nil (list (first (gethash func-name *control-hash*)))) 
  (format t 
	  "~%Modifying dependency in  ~a now!"
	  func-name)  
  (modify-component-hash-value (list-all-comp-index-of-func func-name))  
  ) 
;;***********************************************************************************
(defun all-functions-inner-dependency( func-list )
  (cond ((endp func-list) nil)
	(T 
	 (setq *all-var-of-this-func* (list-all-var-of-func (first func-list))) 
	 (single-func-dependency (first func-list))
	 (all-functions-inner-dependency (rest func-list)))) 
  ) 
;;***********************************************************************************
(defun test-main ( comp-file control-file stats-file)
  (setup-data comp-file control-file stats-file)
  (all-functions-inner-dependency *all-function-list*)
  ;;  (modify-component-hash-value *all-component-list*) 
  )   
;;***********************************************************************************
(defun output-sit-hash (&key
			(comp-file "../../writing/whileC.component")
			(control-file "../../writing/whileC.control")
			(stats-file "../../writing/whileC.stats") 
			(output-file "../../writing/whileC.pout"))
  
  (test-main comp-file control-file stats-file) 
  
  (setq *sit-hash-stream*
	(open output-file
	      :direction :output
	      :if-exists :overwrite
	      :if-does-not-exist :create))
  (format *sit-hash-stream* "~a~%~%" *situations*)
  (dolist (one-sit *situations*)
	  (progn 
	    (dolist (sit-element (rest one-sit))
		    (format *sit-hash-stream* 
			    "~a:  ~a~%"
			    (first sit-element)
			    (get-comp-hash (first sit-element))))
	    (format *sit-hash-stream* "~%~%") 	
	    ))  	  
  (close *sit-hash-stream*) 
  ) 

