;;******************************************************************************
;;
;; The bodies of component Test and Loop are represented in the statement 
;; descriptions (stored in the component file) as: 
;; 
;; (Test If 
;;       (test-statement-name)   
;;       (true-part-statement-name-list)
;;       (false-part-statement-name-list)
;; )
;; (Loop For/While/Do
;;       (test-statement-name)
;;       (body-statement-name-list)
;; 

;; Now we need to replace these statement-names in the lists with the names of
;; their decomposed components.  If a statement contains a Test or a Loop 
;; component, it contains no other components. Thus, we are able to find all
;; Test and Loop components by first test the length of the component list 
;; in the statement description (it should be ONE) and then check the component
;; type. 
;;
;; The following group of functions are for this purpose.
;; 

(defun retrieve-comps-aux (statement-name statement-list)
  (cond ((endp statement-list) nil)
	((eql statement-name (caar statement-list)) 
	 (mapcar #'car 
		 (second (car statement-list))))
	(T (retrieve-comps-aux statement-name (rest statement-list)))))
	 

(defun retrieve-comps (statement-name-list statement-list)
  (cond ((endp statement-list) nil)
	(T (cons (retrieve-comps-aux (car statement-name-list)
				     statement-list)
		 (retrieve-comps (rest statement-name-list)
				 statement-list)))))

(defun modify-if-statement (this-statement statement-list)
  ;;if I have used struct as in C, this function could have been easily 
  ;;implemented.
  (let* ((comp-desc (first (second this-statement)))
	 (comp-body (nth 4 comp-desc)))
    (list (first this-statement)
	  (list 
	   (list (nth 0 comp-desc)
		 (nth 1 comp-desc)
		 (nth 2 comp-desc)
		 (nth 3 comp-desc)
		 (list (nth 0 comp-body)
		       (nth 1 comp-body)
		       (retrieve-comps (nth 2 comp-body) statement-list)
		       (retrieve-comps (nth 3 comp-body) statement-list)
		       (retrieve-comps (nth 4 comp-body) statement-list)
		       )
		(nth 5 comp-desc)
		(nth 6 comp-desc))))
    ))

(defun modify-loop-statement (this-statement statement-list)
  ;;if I have used struct as in C, this function could have been easily 
  ;;implemented.
  (let* ((comp-desc (first (second this-statement)))
	 (comp-body (nth 4 comp-desc)))
    (list (first this-statement)
	  (list 
	   (list (nth 0 comp-desc)
		 (nth 1 comp-desc)
		 (nth 2 comp-desc)
		 (nth 3 comp-desc)
		 (list (nth 0 comp-body)
		       (nth 1 comp-body)
		       (retrieve-comps (nth 2 comp-body) statement-list)
		       (retrieve-comps (nth 3 comp-body) statement-list)
		       )
		(nth 5 comp-desc)
		(nth 6 comp-desc))))
    ))


(defun modify-contained-list-in-one-statement ( this-statement statement-list )
  (let ((comp-body  (nth 4                                  ;; the comp body
			 (first (second this-statement))))) ;; the single comp
    (cond ((> (length (second this-statement)) 1) this-statement)
	  ((eql (car comp-body) 'Test) (modify-if-statement this-statement
							    statement-list))
	  ((eql (car comp-body) 'Loop) (modify-loop-statement this-statement
							      statement-list))
	  (T this-statement)))
  )
 

(defun modify-contained-list-in-statement-list ( statement-list )
  (let* ((this-statement (car statement-list))
	 (comp-body  (nth 4                                  ;; the comp body
			 (first (second 
				 this-statement))))   ;; the single comp
	 (comp-type (nth 0 comp-body)))
    (cond ((endp statement-list) nil)
	  ((eql comp-type 'Test) 
	   (cons 
	    (modify-if-statement this-statement statement-list)
	    (modify-contained-list-in-statement-list (rest statement-list))))
	  ((eql comp-type 'Loop) 
	   (cons 
	    (modify-loop-statement this-statement statement-list)
	    (modify-contained-list-in-statement-list (rest statement-list))))
	  (T 
	   (cons 
	    this-statement
	    (modify-contained-list-in-statement-list (rest statement-list)))))))

