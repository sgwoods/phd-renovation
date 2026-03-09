(in-package #:phd-qcsp-alex)
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
(defun my-acons ( x y a &optional (temp nil) )
  (cond ((endp a) temp )
	((equal x (caar a)) (cons (cons x y) (rest a)))  	
	(T (cons (first a) (my-acons x y (rest a) temp))))) 
;;***********************************************************************************
;;(defun compare-assoc-aux( assoc-list-1 assoc-list-2 )
;;  (cond ((endp assoc-list-1) T)  
;;	((equal (assoc (first (first assoc-list-1)) assoc-list-2 :test #'equal) 
;;		(first assoc-list-1))
;;	 (compare-assoc-aux (rest assoc-list-1) assoc-list-2))
;;	(T nil)) 
;; )
;;(defun compare-assoc( assoc-list-1 assoc-list-2 )
;; (cond ((eq (length assoc-list-1) (length assoc-list-2))
;;	 (compare-assoc-aux assoc-list-1 assoc-list-2))
;;	(T nil))  
;; )

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
	((compare-atom-or-list (cdar assoc-list-1) 
			       (rest (assoc (caar assoc-list-1) assoc-list-2 :test #'equal)))
	 (compare-assoc-aux (rest assoc-list-1) assoc-list-2 (- n 1)))
	(T nil))
  )

(defun compare-assoc( assoc-list-1 assoc-list-2 )
  (compare-assoc-aux assoc-list-1 assoc-list-2 (length assoc-list-1))
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
		     (add-to-var-assoc-list comp-index (rest modified-var-list)
					    (my-acons this-var 
						      (cons comp-index stmts-set-this-var)
						      assoc-list)))))))
  )
;;***********************************************************************************
;; (comps-of-loop 'a '(h g f e a b)) is (E F G H)  
;; called when 'a is the next comp and 'a is already on the path  
(defun comps-of-loop ( comp-index path &optional (temp nil) )
  (cond ((endp path) temp)
	((not (eql comp-index (first path))) 
	 (comps-of-loop comp-index (rest path) (cons (first path) temp))) 
	(T temp))  
  )
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
(defun combine-two-assoc-list ( a-list-1 a-list-2 )
  (cond ((endp a-list-1) a-list-2)  	
	(T (let* ((this-key (caar a-list-1))
		  (content1  (cdar a-list-1))
		  (content2  (rest (assoc this-key a-list-2 :test 'equal))))
	  (combine-two-assoc-list (rest a-list-1)
	     (my-acons this-key  
				       (add-to-atom-list content1  content2) a-list-2)))    
	     )))

;;***********************************************************************************
;; Recursion to set the var-list of (first path) to assoc-list and modify assoc-list
;; by calling modify-var-assoc-list(..)    
(defun set-var-on-given-path ( path assoc-list )
	(cond ((endp path) nil )
		(T (let* ((this-index (first path))
				(this-comp (gethash this-index *component-hash*)) 
				(new-assoc-list 
	  		(modify-var-assoc-list this-index (nth 5 this-comp) assoc-list)))  
    		(setf (nth 6 (gethash (first path)  *component-hash*)) assoc-list)
			(set-var-on-given-path (rest path) new-assoc-list)))) 		
) 
;;***********************************************************************************
;; from the loop re-entry 
;; the input assoc-list from the re-entry need to be combined with start-comp-index's
;; then update start-comp-index's     
(defun redo-var-assoc-on-loop ( start-comp-index loop-path assoc-list path)
  (let* ((this-comp (gethash start-comp-index *component-hash*)) 
	 (next-index (first this-comp)) ; if next-index has a branch not on pth,
								 	; need updating too  
	 (current-assoc 
	  (combine-two-assoc-list assoc-list (nth 6 this-comp)))
	 (new-assoc
	  (modify-var-assoc-list start-comp-index (nth 5 this-comp) current-assoc)))  

    (setf (nth 6 (gethash start-comp-index *component-hash*)) current-assoc)
									; updating this component 
;;    (set-var-on-given-path loop-path new-assoc)
   									; updating all components on loop path 
;;	(cond ((atom next-index) nil)
;;		  (T (let* ((next1 (first next-index))
;;					(next2 (second next-index)))
;;			(cond ((member next1 loop-path) 
;;					(comp-dependency next2 new-assoc (member start-comp-index path)))  	  
;;				((member next2 loop-path) 
;;					(comp-dependency next1 new-assoc (member start-comp-index path)))  	  
;;			))))  
	new-assoc 
   ))
;;***********************************************************************************
(defun comp-dependency ( comp-index var-assoc-list path )
					; this var-assoc-list is what
					; set by parents  
;; (print (cons comp-index path)) 
  (let* (
	 (comp (gethash comp-index *component-hash*))
	 (next-index (first comp))
	 (existing-assoc (nth 6 comp)) 
	 (temp-assoc 
	    (modify-var-assoc-list comp-index (nth 5 comp) var-assoc-list))) 
					; compute new assoc-list for
					; for its children   	
    (cond 
     ((null comp-index) nil)                       ; NULL index, froget about it
	 ((and existing-assoc 
		(compare-assoc existing-assoc var-assoc-list))
		(print "same now") 
			nil)  
     ((endp (member comp-index path))   ; new comp, not on the path 
;      (print "path-follow")
;      (print path)  
;      (print var-assoc-list) 
      (cond ((NULL existing-assoc)
				(setf (gethash comp-index *component-hash*)
	    					(append comp (list var-assoc-list))))
			(T (setf (nth 6 (gethash comp-index *component-hash*))
	  			(combine-two-assoc-list var-assoc-list existing-assoc))))
      (cond 
       ((null next-index) nil)
       ((atom next-index)
			(comp-dependency next-index temp-assoc (cons comp-index path))) 
       (T 
			(comp-dependency (first next-index) temp-assoc (cons comp-index path)) 
       		(comp-dependency (second next-index) temp-assoc (cons comp-index path)))))
     (T                                ;Already on the path, a loop 
					;Starting from comp-index 
      (print "loop detected")

;	 (print (cons comp-index path)) 
;;      (print var-assoc-list) 

	  (let ((new-assoc 
      (let* ((loop-path (comps-of-loop comp-index path )))
		(redo-var-assoc-on-loop comp-index loop-path var-assoc-list path))))
		
		(comp-dependency next-index new-assoc (list comp-index)))  

		)
	)))
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
(defun reset-var-dependency( comp-index accessed-var-list) 
;;(nth 6 hash-value) is the var-dependency
	(let ((this-hash-value (gethash comp-index *component-hash*)))
;		(setf (nth 6 (gethash comp-index *component-hash*)) 
;			(remove-vars-not-in-accessed-list accessed-var-list ..this-hash-value))
	(setf (gethash comp-index *component-hash*) 
		(finalize-hash-value this-hash-value  	
			(remove-vars-not-in-accessed-list accessed-var-list 
						(nth 6 this-hash-value)))))
;		 	(print (cons comp-index (gethash comp-index *component-hash*)))
) 
;;***********************************************************************************
;; We need a function to modify the hash value of component by removing those
;; variables which are not accessed in this component
(defun modify-component-hash-value( comp-list )
	(cond ((endp comp-list) nil) 
		(T 
			(let* ((comp-index (first comp-list))       ;; nth 4 is the accessed variable list 
				;;(comp-index (first comp)) 
				(accessed-var-list (nth 4 (gethash comp-index *component-hash*))))
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
  (comp-dependency (first (gethash func-name *control-hash*)) 
		   *all-var-of-this-func*   
		   nil)  		
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
(defun test-main ( comp-file control-file )
  (setup-data comp-file control-file )
  (all-functions-inner-dependency *all-function-list*)
;;  (modify-component-hash-value *all-component-list*) 
  )   
;;***********************************************************************************



