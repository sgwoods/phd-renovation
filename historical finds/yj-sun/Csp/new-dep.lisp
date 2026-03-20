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
;	   (format t "computing ~a now ~%" computable-comp)
	   (cond ((member computable-comp computed-list) ;a loop
;		  (format t
;			  "~%Find a loop at ~a !"
;			  computable-comp)
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
;;(defun remove-vars-not-in-accessed-list( accessed-var-list this-hash-value)
;;  (cond ((endp this-hash-value) nil)
;;	((member (caar this-hash-value) accessed-var-list :test #'equal)
;;	 (cons (first this-hash-value) 
;;	       (remove-vars-not-in-accessed-list accessed-var-list
;;						 (rest this-hash-value))))  
;;	(T 
;;	       (remove-vars-not-in-accessed-list accessed-var-list
;;						 (rest this-hash-value))))  
;;  )
;; In the above function, some elements in the accessd-var-list are not in the 
;; this-hash-value because these elements are not modified anywhere in the program.
;; We're going to modify this function such that each of these elements has an
;; entry in this-hash-value: (element . NIL ), if the element is a variable declared
;; in the program (not an intermediately generated one or a constant).

(defun remove-vars-not-in-accessed-list-helper( accessed-var-list this-hash-value)
  (cond ((endp this-hash-value) nil)
	((member (caar this-hash-value) accessed-var-list :test #'equal)
	 (cons (first this-hash-value) 
	       (remove-vars-not-in-accessed-list-helper accessed-var-list
						 (rest this-hash-value))))  
	(T 
	       (remove-vars-not-in-accessed-list-helper accessed-var-list
						 (rest this-hash-value))))  
  )

(defun add-accessed-var-if-no-entry (accessed-var-list this-hash-value)
  (let ((this-var (first accessed-var-list)))
    (cond ((endp accessed-var-list) this-hash-value)
	  ((and (> (length this-var) 1) ;declared variable has three elements
		(not (member this-var this-hash-value :test 
			     #'(lambda (x y)
				 (equal x (first y))))))
	   (add-accessed-var-if-no-entry (rest accessed-var-list)
					 (acons this-var nil this-hash-value)))
	  (T
	   (add-accessed-var-if-no-entry (rest accessed-var-list)
					 this-hash-value))))
		     

)
 
(defun remove-vars-not-in-accessed-list( accessed-var-list this-hash-value)
  (remove-vars-not-in-accessed-list-helper
   accessed-var-list 
   (add-accessed-var-if-no-entry accessed-var-list
				 this-hash-value))

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
  (add-consumer-list (list-all-comp-index-of-func func-name))
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
;; 4/16/97 Yongjun Zhang
;; We need to add a data structure which is a two level hash table to do 
;; one-instance-TO-one-type node consistency evaluation. This two level
;; hash table is:
;; 
;; Level one: *comp-to-comp-hash*   (hash-key: component-name
;;                                   hash-value: comp-name-hash-table)
;;     *comp-to-comp-hash* is a global hash table
;; Level two: the comp-name-hash-table
;;            (hash-key: component-type (of consumer of value set in this component)
;;             hash-value: number of consumers of a component-type)
;;       One special case: the hash-key is the name of this component, and the
;;             corresponding hash-value is a list of consumer types
;;
;; April 28, 1997, changed:
;; Level two: the comp-name-hash-table
;;            (hash-key: component-type
;;            hash-value: list of consumer names
;; 
(setf *comp-to-comp-hash* (make-hash-table))

;;==================================================================================
;; The main function to add the consumer list for all the components
(defun add-consumer-list ( comp-list )
  (create-hash-table-for-all-comps comp-list)
  (modify-hash-table-for-all-comps comp-list))

;;==================================================================================
;;
;;Functions to be called by node-consistency checking
;;

(defun update-consumer-list (consumer-list var-type )
  (let ((count-list (assoc var-type consumer-list)))

    (cond ((null count-list)
	   (acons var-type 1 consumer-list))
	  (T 
	   (rplacd (assoc var-type consumer-list)
		   (+ 1 (rest count-list)))
	   consumer-list)))
  )


;; get consumer list of a variable in the template
(defun get-consumer-list ( this-variable-name 
			   variables 
			   constraints 
			   &optional (temp nil) (counted nil))
  (let* ((one-constraint (first constraints))
	 (cons-type (first one-constraint))
	 (first-var (first (second one-constraint)))
	 (second-var (second (second one-constraint)))
	 (first-var-type (caadr (assoc first-var variables))))
 
    (cond ((endp constraints) temp)
	  ((member first-var counted) ;;counted once already
	   (get-consumer-list this-variable-name
			      variables
			      (rest constraints)
			      temp
			      counted))
	  ((and (member cons-type '(guaranteed-data-dependency
				    possible-data-dependency
				    control-data-dependency))
		(eql second-var this-variable-name))
	   (setq temp (update-consumer-list temp first-var-type))
	   (get-consumer-list this-variable-name
			      variables
			      (rest constraints)
			      temp
			      (cons first-var counted)))
	  (T 
	   (get-consumer-list this-variable-name
			      variables
			      (rest constraints)
			      temp
			      counted))))
				    
)



;; Return the consumer-counter stored in the hash table
(defun consumer-count-in-code ( this-instance other-type )
  (let* ((consumer-list (gethash other-type (gethash this-instance *comp-to-comp-hash*)))
	 (count (length consumer-list)))
;;    (cond ((NULL count) 0)
;;	  (T count)))
    count)
)
;; Return the consumer-list stored in the hash table, whose elements belong to other-type
(defun consumer-list-in-code ( this-instance other-type )
  (gethash other-type (gethash this-instance *comp-to-comp-hash*))
)


;; The following two functions are to be called by Steve's node consistency
;; checking. 

;; return an assocaite list: ((type-1 . count-1) (type-2 . count-2) ...)
;; this assoc-list is convenient for modification of the count in this
;; function
(defun get-consumer-list-from-template ( this-variable-name template )
;;  (format t "CHECKING ~a ~%" this-variable-name)
  (let ((variables (nth 1 template))
	(constraints (nth 2 template)))
    (get-consumer-list this-variable-name variables constraints))
  )


(defun check-one-to-type-consistency ( this-instance consumer-list )
;;this-instance is the name of a program component
;;comsumer-list is got from the template, having the format of ((type . count) ..)
  (let* ((consumer-type (caar consumer-list))
	(consumer-cnt (cdar consumer-list))
;;	(consumer-cnt (length (cdar consumer-list))) 
	(consumer-cnt-in-code (consumer-count-in-code this-instance consumer-type)))
    (cond ((endp consumer-list) T)
	  ((>= consumer-cnt-in-code consumer-cnt) 
	   (check-one-to-type-consistency this-instance (rest consumer-list)))
	  (T nil)))
)

;; 4/29/97 To form a function to decide which variable to instantiate
;; It takes in two parms, parm1 is a list of pair variable-name/variable-instance,
;; which is the partial solution. 
;; Parm2 is a precomputed consumer list, it's a two-level associate list:
;;          ((e1  ((consumer-var-1 type-1)
;;		   (consumer-var-2 type-2)))
;;	     (e2 ...
;;		 )
;;	     ...
;;	     (en ..
;;		 )
;;	     )
;; It returns a list
;;           (variable-to-instantiate instance-list)

;; There are two functions to be called by the search engine for furthur pruning: 
;;  function-1 generate-two-level-consumer-type-list ( template ), must be called
;; before any search
;;  function-2 get-next-variable-to-instantiate( partial-solution consumer-type-list)
;;  
;;
(defun get-next-variable-to-instantiate ( partial-solution consumer-type-list )
  (let* (
	 (instantiated-vars (mapcar #'car partial-solution))
	 (possible-searches (extract-possible-searches instantiated-vars 
						       consumer-type-list))
	 (all-var-ins-paris (get-all-var-ins-pairs partial-solution 
						   possible-searches))
	 (shortest-pair     (find-shortest-var-ins-pairs all-var-ins-pairs)))
    shortest-pair)	 
  )

;; get the var-ins pair that has the fewest instances
(defun find-shortest-var-ins-pairs ( all-var-ins-pairs )
  (let* ((min-pair (first all-var-in--pairs))
	(min-var (first min-pair))
	(inslist (second min-pair))
	(flen (length inslist)))
       (dolist (next-entry (rest all-var-ins-pairs))
	       ((cond ((< (length (second next-entry))
			  flen)
		       (setq min-var (car next-entry))
		       (setq inslist (second next-entry)))
		      (T nil))))
       (cond ((endp inslist) nil)
	     (T
	      (list min-var inslist))))
       
)


;; find all possible var-instance pairs
;; parm2 new-consumer-list is genereted by extract-possible-searches
(defun get-all-var-ins-pairs (partial-solution new-consumer-list)
    (cond ((endp new-consumer-list) nil)
	  (T 
	   (let* ((one-element (first new-consumer-list))
		  (producer-var (first one-element))
		  (producer-ins (second (assoc producer-var partial-solution)))
		  (producer-consumer-hash-in-code (gethash producer-ins 
							   *comp-to-comp-hash*)))
	     (append 
	      (get-one-var-ins-pairs producer-consumer-hash-in-code
				     (second one-element))
	      (get-all-var-ins-pairs partial-solution 
				     (rest new-consumer-list)))))))

(defun get-one-var-ins-pairs (consumer-hash ct-list)
  (cond ((endp ct-list) nil)
	(T
	 (let* ((one-element ct-list)
		(first-var (first one-element))
		(first-type (second one-element)))
	   (consumer-list-of-type (gethash first-type consumer-hash))
	   (cond ((endp consumer-list-of-type)
		  (get-one-var-ins-pairs consumer-hash (rest ct-list)))
		 (T
		  (cons (list first-var consumer-list-of-type)
			(get-one-var-ins-pairs consumer-hash
					       (rest ct-list))))))))
)

;; return a modified consumer-type-list
;; at the first level, there are entries only for instantiated variables
;; at the second level, there are entries only for non-instantiated variables 
(defun extract-possible-searches ( instantiated-vars consumer-type-list )
  (let* ((one-element (first consumer-type-list))
	 (producer (first one-element))
	 (all-consumers (second one-element)))
    (cond ((endp consumer-type-list) nil)
	  ((member producer instantiated-vars) 
	   (cons (cons producer
		       (filter-consumer instantiated-vars all-consumers))
		 (extract-possible-searches  instantiated-vars
					    (rest consumer-type-list))))
	  (T
	   (extract-possible-searches instantiated-vats
				      (rest consumer-type-list)))))
)

;; return a list of consumers, non of which is instantiated yet.
;; called by extract-possible-searches
(defun filter-consumer (instantiated-vars all-consumers)
  (let* ((one-element (first all-consumers))
	 (one-consumer (first one-element)))
    (cond ((endp all-consumers) nil)
	  ((member one-consumer instantiated-vars)
	   (filter-consumer instantiated-vars (rest all-consumers)))
	  (T
	   (cons one-element
		 (filter-consumer instantiated-vars (rest all-consumers))))))
)


;;To be called before any search, this function is to generate the two-level 
;;associate list described above
(defun generate-two-level-consumer-type-list ( template )
  (let ((variables (nth 1 template))
	(constraints (nth 2 template)))
    (get-consumer-type-list variables constraints))
)

;;=============================================================================

(defun get-consumer-type-list ( variables constraints )
  (cond ((endp variables) nil)
	(T (cons (get-one-consumer-type-list (caar variables)
					     variables
					     constraints)
		 (get-consumer-type-list (rest variables)
					 constraints))))
	 
)

;; get consumer list of a variable in the template
(defun get-one-consumer-type-list ( this-variable-name 
				    variables 
				    constraints 
				    &optional (temp nil) (counted nil))
  (let* ((one-constraint (first constraints))
	 (cons-type (first one-constraint))
	 (first-var (first (second one-constraint)))
	 (second-var (second (second one-constraint)))
	 (first-var-type (caadr (assoc first-var variables))))
 
    (cond ((endp constraints) (list this-variable-name temp))
	  ((member first-var counted) ;;counted once already
	   (get-consumer-list this-variable-name
			      variables
			      (rest constraints)
			      temp
			      counted))
	  ((and (member cons-type '(guaranteed-data-dependency
				    possible-data-dependency
				    control-data-dependency))
		(eql second-var this-variable-name))
	   (setq temp (cons (list  first-var first-var-type)
			    temp))
	   (get-one-consumer-type-list this-variable-name
				       variables
				       (rest constraints)
				       temp
				       (cons first-var counted)))
	  (T 
	   (get-one-consumer-type-list this-variable-name
				       variables
				       (rest constraints)
				       temp
				       counted))))
				    
)

 
;;==================================================================================
(defun hash-table-name ( comp-name )
  (setf (gethash comp-name *comp-to-comp-hash*) (make-hash-table)))
	
;;==================================================================================
(defun create-hash-table-for-all-comps (comp-list )
  (mapcar #'hash-table-name comp-list))

;;==================================================================================
(defun get-comps-dependent-on (adl-list)
  (cond ((endp adl-list) nil)
	((NULL (cdar adl-list))
	  (get-comps-dependent-on (rest adl-list)))
	((atom (cdar adl-list))
	 (cons (cdar adl-list) (get-comps-dependent-on (rest adl-list))))
	(T
	 (append (cdar adl-list) (get-comps-dependent-on (rest adl-list)))))
  )
;;==================================================================================
(defun add-type-to-one-consumer-list (this-comp this-type comp-name)
;;this-comp is the consumer, comp-name is the producer
  (let* ((this-hash-table (gethash comp-name *comp-to-comp-hash*))
	 (consumer-list (gethash this-type this-hash-table))
	 (count-of-this-type (length consumer-list))
	 (all-types (gethash comp-name this-hash-table)))

    (cond ((NULL count-of-this-type)
;;	   (setf (gethash this-type this-hash-table) 1)
;;4/29/97
;;used to be just a count of consumers belonging to a certain type
;;changed to be a list of consumers belonging to a certain type
	   (setf (gethash this-type this-hash-table) (list this-comp))
	   (setf (gethash comp-name this-hash-table) (list this-type)))
	  (T
;;	   (setf (gethash this-type this-hash-table) (+ count-of-this-type 1))
	   (setf (gethash this-type this-hash-table) (cons this-comp consumer-list))
	   (cond ((member this-type all-types) nil) 
		 (T (setf (gethash comp-name this-hash-table) 
			  (cons this-type all-types)))))))
		    
  )
;;==================================================================================
(defun add-type-to-all-consumer-list (this-comp this-type all-comps-dependent-on)
  (cond ((endp all-comps-dependent-on) nil)
	(T (add-type-to-one-consumer-list this-comp this-type (first all-comps-dependent-on))
	   (add-type-to-all-consumer-list this-comp this-type (rest all-comps-dependent-on))))
)

;;==================================================================================
(defun hash-table-affected-by-one-comp ( comp-name )
  (let* ((hashed-value (gethash comp-name *component-hash*))
	 (this-type (caar hashed-value))
	 (all-comps-dependent-on (get-comps-dependent-on (second hashed-value))))
    (add-type-to-all-consumer-list comp-name this-type all-comps-dependent-on)
    )
)

;;==================================================================================  
(defun modify-hash-table-for-all-comps ( comp-list )
  (mapcar #'hash-table-affected-by-one-comp comp-list))

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


