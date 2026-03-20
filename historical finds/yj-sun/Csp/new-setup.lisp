;;******************************************************************************
;; new-setup.lisp: to transfer results from gen++ to files of expected format

;;******************************************************************************
(defvar *end-of-file* (gensym)
  "A unique EOF marker")

(defun eof-p (x) (eq x *end-of-file*)) 

(defun my-reverse( in-list &optional (temp nil))
  (cond ((endp in-list) temp)
	(T  (my-reverse (rest in-list) 
			(cons (first in-list) temp)))))   
;;******************************************************************************
;; The following two data structures result from the original gen++ analyzer  
;;
;; Data structure of component-file
;; 
;;  ......
;;  ( stmtIndex
;;     (
;;       ......
;;          (compIndex compOrder funcName lineNumber compBody 
;;                                                   accessedList modifiedList)
;;        ......
;;     )
;;     (
;;          ......
;;          (accessdVar definedPosition)
;;          ......
;;     )
;;     (
;;          ......
;;          (modifiedVar definedPosition)
;;          ......
;;    )
;;  )
;; ......
;;
;; Data structure of control-file  
;;     ......
;;     ( functionName
;;   	(arglist) 
;; 
;;          ......
;;     (stmtIndex childStmtIndex) || (stmtIndex condIndex trueIndex falseIndex)
;;          ......
;;     )
;;     ......
;;  
;;******************************************************************************
;; Objective of the following functions is to establish two hash-table, one is 
;; *component-hash*, the other is *control-hash*. And two other global list 
;; *all-component-list* (list of all tuple (comp-index comp-body))  and 
;; *all-function-list* 
;; (list of all function names)  
;;  
;; Specifically, *component-hash* is
;;( :key compIndex
;;  :content (next-compIndex-if-know-or-nil 
;;            func-name    ;;this element is modified to be parent comp-indices-list 
;;            stmt-index
;;            compBody
;;            list-of-(accessed-variable defined-file defined-line)
;;            list-of-(modified-variable defined-file defined-line)
;;           )
;;)
;;             
;; *control-hash* is
;;( :key stmt-index
;;  :content (first-comp    
;;            (next-stmt-index || condIndex trueIndex falseIndex) 
;;           )
;;)
;; or
;;( :key func-name
;;  :content (first-stmt arg-list list-of-all-stmts-of-this-func 
;;             list-of-all-comp-indices list-of-all-var)
;;)  
;; list-of-all-stmts-of-this-func is for the purpose of finding the first stmt
;; to be executed in this function a list of all 
;; list-all-var is a list of all vars accessed in this function. It has the 
;; format of ((var1) (var2) ...), it will be used for an associated list as
;; ((var1 . comp-lastly-set-var1) (var2 . * ) ..) Notice that comp-lastl-set-var
;; could be either an atom which is one compindex or list of comp-indices in
;; the case of there are multiple entries to this comp,   
;;******************************************************************************

;;******************************************************************************
;; Inside the component, the variable list has no definition position, we will 
;; refer to the statement variable list to add the definition position
;; e.g, in *.component file, each component has accessed-var and modified var
;; like (.. (a b c) (c)). the last part for each stmt in the component file 
;; is (.. ((a file1 line3) (b file1 line4) (c file1 line5)) ((c file1 line5))) 
;; this is referred to change (.. (a b c) (c)) to have position infor.

;; Some intermediately generated vars like file_R_4 is not in the stmt-var-part
;; this function is to tell wether or not. if so, return format (a file1 line3)
;; otherwise return nil   

(defun in-defined-list (one-var defined-list)
  (cond ((endp defined-list) nil)
	((eql one-var (first (first defined-list))) (first defined-list))
	(T (in-defined-list one-var (rest defined-list)))))

;;-----------------------------------------------------------------------------
;; To modify the component var-list by calling the above functions

(defun modify-variable-list( no-define-posi-list define-posi-list)
  (mapcar #'(lambda (one-var)
	      (let ((temp (in-defined-list one-var define-posi-list))) 
		(cond (temp temp)
		      (T (list one-var))))) 	 
	  no-define-posi-list) 
  )

;;-----------------------------------------------------------------------------
(defun modify-component-list( stmt-index component-list accessed-list )
  (cond ((endp component-list) nil)
	(T (cons 
	    (list
	     (nth 0 (car component-list))   ;;component name of the first elem
	     (nth 0 (cadr component-list))  ;;component name of the second elem
	     (nth 2 (car component-list))   ;;function name
	     stmt-index                     ;;stmt-index this comp belongs to
	     (nth 4 (car component-list))   ;;component body of this first elem
	     (modify-variable-list (nth 5 (car component-list)) accessed-list)
	     (modify-variable-list (nth 6 (car component-list)) accessed-list) 
	     )
	    (modify-component-list stmt-index (rest component-list) accessed-list)
	    ))))

(defun modify-stmt ( stmt )
  (list (first stmt)
	(modify-component-list (first stmt) (second stmt) (nth 2 stmt))) 	
  
  ) 
;;******************************************************************************
;; Given a file containing a set of separated  elements, add  "( )" to brace  
;; them thus generating a new file which is a single list.

(defun transduce-file-list( infile outfile )
  (with-open-file (out-stream outfile
			      :direction :output
			      :if-exists :supersede)
		  (with-open-file (in-stream infile
					     :direction :input)
				  (princ "(" out-stream)
				  (loop
				   (let ((exp (read in-stream nil *end-of-file* nil)))
				     (if (eof-p exp) (return))
				     (print exp out-stream)))
				  (princ ")" out-stream))))
;;******************************************************************************
(defun transduce-separate-to-list( infile  )
  (with-open-file (in-stream infile
			     :direction :input)
		  (let ((temp nil))  
		    (loop
		     (let ((exp (read in-stream nil *end-of-file* nil)))
		       (if (eof-p exp) (return))
		       (setq temp (cons exp temp))))
		    (my-reverse temp))))

;;******************************************************************************

(defun transduce-comp-file-list( infile outfile )
  (with-open-file (out-stream outfile
			      :direction :output
			      :if-exists :supersede)
		  (with-open-file (in-stream infile
					     :direction :input)
				  (princ "(" out-stream)
				  (loop
				   (let ((exp (read in-stream nil *end-of-file* nil)))
				     (if (eof-p exp) (return))
				     (print (modify-stmt exp) out-stream)))
				  (princ ")" out-stream))))

;;******************************************************************************
(defun transduce-comp-list( infile )
  (with-open-file (in-stream infile
			     :direction :input)
		  (let ((temp nil))  
		    (loop
		     (let ((exp (read in-stream nil *end-of-file* nil)))
		       (if (eof-p exp) (return))
		       (setq temp (cons (modify-stmt exp) temp))))
		    (my-reverse temp))))


;;******************************************************************************
;;
;;Extract the component descriptions from the statement descriptions to form
;;a list of all component descriptions.
;;
(defun extract-comp ( statement-list )
  (cond ((endp statement-list) nil)
	(T  (append (nth 1 (first statement-list))
		    (extract-comp (rest statement-list) )))))


;;******************************************************************************
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
  (cond ((endp statement-name-list) nil)
	(T (append 
	    (retrieve-comps-aux (car statement-name-list)
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
 

(defun modify-contained-list-in-statement-list ( partial-statement-list 
						 whole-statement-list )
  (let* ((this-statement (car partial-statement-list))
	 (comp-body  (nth 4                           ;; the comp body
			 (first (second 
				 this-statement))))   ;; the single comp
	 (comp-type (nth 0 comp-body)))
    (cond ((endp partial-statement-list) nil)
	  ((eql comp-type 'Test) 
	   (cons 
	    (modify-if-statement this-statement whole-statement-list)
	    (modify-contained-list-in-statement-list (rest 
						      partial-statement-list)
						     whole-statement-list)))
	  ((eql comp-type 'Loop) 
	   (cons 
	    (modify-loop-statement this-statement whole-statement-list)
	    (modify-contained-list-in-statement-list (rest 
						      partial-statement-list)
						     whole-statement-list)))
	  (T 
	   (cons 
	    this-statement
	    (modify-contained-list-in-statement-list (rest 
						      partial-statement-list)
						     whole-statement-list))))))


;;******************************************************************************
;; Above are for component file transformation to expected list 	
;;******************************************************************************
(defun comp-list-to-hash( comp-list )
  (cond ((endp comp-list) nil)
	(T (let* ((comp (first comp-list))
		  (index-comp (first comp)))
	     (setf (gethash index-comp *component-hash*) (rest comp))
	     (comp-list-to-hash (rest comp-list)))))
  )
;;******************************************************************************
;; main program to build hash table *component-hash*  from the original 
;; component file. The argument comp-list is actually the statement-list
 
(defun comp-file-to-hash( comp-list )
  (comp-list-to-hash 
   (extract-comp 
    (modify-contained-list-in-statement-list 
     comp-list comp-list)))) 
;;******************************************************************************
;;******************************************************************************
(defun old-append-rest( in-list &optional (temp nil))
  (cond ((endp in-list) temp)
	(T (old-append-rest (rest in-list) 
			    (append temp (rest (first in-list)))))))

(defun append-rest( in-list )
  (cond ((endp in-list) nil)
	(T  (append (rest (first in-list)) 
		    (append-rest (rest in-list)))))) 

;;******************************************************************************
(defun find-first-stmt ( func-body )
  (let* ((func-stmts-list (rest (rest func-body)))
	 (candidate-first-list (mapcar #'first func-stmts-list))
	 (all-children-list (append-rest func-stmts-list)))
    (first (remove-if 
	    #'(lambda ( stmt-index )
		(member stmt-index all-children-list))
	    candidate-first-list))))

;;******************************************************************************
;; return a list of ((var1) (var2) ... ); notice varIdx is (name file posi)  
;;(defun get-all-var-in-func (func-name comp-list &optional (temp nil))
;;  (cond ((endp comp-list) (mapcar #'list temp))
;;	((eql func-name (second (gethash (caar comp-list) *component-hash*)))
;;	 (get-all-var-in-func func-name (rest comp-list) 
;;			      (add-to-list (nth 4 (gethash (caar comp-list) 
;;							   *component-hash*))
;;					   temp)))
;;	(T 
;;	 (get-all-var-in-func func-name (rest comp-list) temp ))))  

(defun get-all-var-in-func (func-name comp-list &optional (temp nil))
  (cond ((endp comp-list) (mapcar #'list temp))
	((eql func-name (second (gethash (caar comp-list) *component-hash*)))
	 (get-all-var-in-func func-name (rest comp-list) 
			      (add-to-list (nth 4 (gethash (caar comp-list) 
							   *component-hash*))
					   temp)))
	(T 
	 (get-all-var-in-func func-name (rest comp-list) temp ))))  

(defun get-all-comp-index-in-func (func-name comp-list )
  (let* ((this-comp (first comp-list))
	 (this-comp-index (first this-comp))
	 (this-hash-value (gethash this-comp-index *component-hash*))) 
    (cond ((endp comp-list) nil)
	  ((eql func-name (second this-hash-value))
	   (cons this-comp-index 
		 (get-all-comp-index-in-func func-name (rest comp-list))))
	  (T 
	   (get-all-comp-index-in-func func-name (rest comp-list))))))

;;******************************************************************************
;; The function name refer to list (first-comp-of-first-stmt func-args-list 
;; all-stmts-list all-var-list) 
(defun hash-func-name( func-body stmt-list)
  (let ((all-comps (extract-comp stmt-list))) 
    (setf (gethash (first func-body)  *control-hash*) 
	  (list (get-first-comp (find-first-stmt func-body) stmt-list) 
	      (second func-body)
	      (get-all-stmt-index (cddr func-body))
	      (get-all-comp-index-in-func (first func-body) all-comps)  
	      (get-all-var-in-func (first func-body) all-comps)  
	      ))))

;;******************************************************************************
(defun get-first-comp( stmt-index stmt-list )
  (cond ((endp stmt-list) nil)
	((eql stmt-index (first (first stmt-list)))
	 ;;(mapcar #'first (second (first stmt-list))) 
	 (first (first (second (first stmt-list))))) 
	;;this is to extract "a" from ((s-idx ((a ..)(b ..))..))if s-idx = stmt-index 
	(T (get-first-comp stmt-index (rest stmt-list))))) 
;;******************************************************************************
;; Hash each stmt-index 
;; The stmt-indx refer to list (first-of-its-components list-of-children)
;; If the statement is a branch, its list-of-children has three elements, the 
;; first one is the cond-stmt, the second one is true-stmt-index, and the last
;; one is the false-stmt-index
;; Else if the statment if a cond-stmt, the list-of-children may be nil or other
;; cond-stmt or other statements 
;; Else is the most common case, the list-of-children has only one element which
;; is the index of this statement's only child.

;;here we might miss one case, which is the condStmt, following programs
;;fix this problem
;;(defun hash-func-body ( control-list stmt-list )
;;  (mapcar #'(lambda ( one-control )
;;	      (setf (gethash (first one-control) *control-hash*)
;;		    (list (get-first-comp (first one-control) stmt-list)
;;			  (rest one-control))))
;;	  control-list))     

;; utility function 
(defun add-to-list (to-be-added original-list)
  (cond ((endp to-be-added) original-list)
	((endp (member (first to-be-added) original-list :test #'equal))
	 (add-to-list (rest to-be-added)
		      (cons (first to-be-added) original-list)))
	(T (add-to-list (rest to-be-added) original-list))))

(defun add-to-stmt (to-be-added original-list)
  (cond ((endp to-be-added) original-list)
	((endp (member (first to-be-added) original-list))
	 (add-to-stmt (rest to-be-added) 
		      (cons (first to-be-added) original-list))) 
	(T (add-to-stmt (rest to-be-added) original-list))))

(defun get-all-stmt-index ( control-list &optional (temp nil))
  (cond ((endp control-list) temp )
	(T  (get-all-stmt-index (rest control-list) 
				(add-to-stmt (first control-list) temp)))))   

(defun fetch-this-control ( stmt-index control-list )
  (cond ((endp control-list) nil )
	((eql stmt-index (first (first control-list)))
	 (first control-list)) 
	(T (fetch-this-control stmt-index (rest control-list)))))  

(defun hash-func-body ( control-list stmt-list )
  (let ((all-stmt-index-list (get-all-stmt-index control-list))) 
    (mapcar #'(lambda ( stmt-index )
		(setf (gethash stmt-index *control-hash*)
		      (list (get-first-comp stmt-index stmt-list)
			    (rest (fetch-this-control stmt-index control-list)))))
	    all-stmt-index-list)))     
;;******************************************************************************
(defun func-to-hash( func-body stmt-list )
  (hash-func-name func-body stmt-list)
  (hash-func-body (rest (rest func-body)) stmt-list))  	
;;******************************************************************************
(defun control-list-to-hash ( func-control-list stmt-list )
  (cond ((endp func-control-list) nil)
	(T (prog1 (func-to-hash (first func-control-list) stmt-list)
	     (control-list-to-hash (rest func-control-list) stmt-list)))))  

;;******************************************************************************
;; main program to hash the control-file, refering to comp-file for a stmt's
;; first component 
(defun control-file-to-hash( control-list comp-list)
  (control-list-to-hash
	 control-list
	 	comp-list)) 
;;******************************************************************************
;;******************************************************************************
;;(defun reset-child-in-hash( comp-index )
;;  (let* ((comp (gethash comp-index *component-hash*))
;;	 (stmt-index (nth 2 comp)))
;;    (cond ((= 1 (length (second (gethash stmt-index *control-hash*))))
;;	   (setf (gethash comp-index *component-hash*)
;;		 (cons 
;;		  (first (gethash            ;the first component of a stmt  
;;			  (first (second (gethash stmt-index *control-hash*)))
;;			  *control-hash*)) 
;;		  (rest comp))
;;		 ))
;;	  (T nil))))

(defun reset-child-in-hash( comp-index )

;; There is a known bug, that is, if there are two control path:
;; (a b)
;; (a c)
;; we didn't handle it. It's due to our understanding that for this
;; kind of links, there shouldn't be two with same left-value.
;; Thus, when we hash the control list, we have considered this
;; situation, which happens to the Do loop. 
;; It shouldn't be hard to modify the code to deal with this, but
;; because of lack of time, we postponed it. 

  (let* ((comp (gethash comp-index *component-hash*))
	 (stmt-index (nth 2 comp))
	 (this-stmt (gethash stmt-index *control-hash*))
	 (child-of-this (second this-stmt)))

    (cond ((= 1 (length child-of-this)) ;there is only one child
					;the stmt pattern is (1 2)
					;comp-index is 1's last comp
					;this-stmt is (1st-comp (2))
					;set path comp-index-->
					;the first comp of 2  
	   (setf (gethash comp-index *component-hash*)
		 (cons 
		  (first (gethash       ;the first component of a stmt  
			  (first child-of-this)
			  *control-hash*)) 
		  (rest comp))))
	  ((= 3 (length child-of-this)) ;there is a branch 
					;the stmt pattern is (1 2 3 4)
					;comp-index is 1's last comp
					;this-stmt is (1st-comp (2 3 4))
					;2 is cond-stmt
					;set path 1-2 2->list-of 3 and 4's
					;first comp 
	   (progn 
;;	     (print "comehere") 
	     ;;	     (print comp-index) 
	     ;;	     (print comp)
	     ;;	     (print child-of-this) 
	     
	     (setf (gethash comp-index *component-hash*)
		   (cons
		    (first (gethash     ;set path comp-index-->2's 1st comp 
			    (first child-of-this)
			    *control-hash*))
		    (rest comp)))    
	     (let* (
		    (true-index (second child-of-this))
		    (false-index (first (last child-of-this))) 	
		    (this-comp-index-of-cond
		     (first (gethash (first child-of-this) *control-hash*)))
		    (this-comp-of-cond
		     (gethash  
		      this-comp-index-of-cond
		      *component-hash*)) 
		    (last-comp-index-of-cond 
					;loop to find 2's last comp 
		     (loop 
		      (when (NULL (first this-comp-of-cond)) 
			    (return this-comp-index-of-cond))  
		      (setf this-comp-index-of-cond
			    (first this-comp-of-cond)) 
		      (setf this-comp-of-cond
			    (gethash (first this-comp-of-cond)
				     *component-hash*))))
		    (comp (gethash last-comp-index-of-cond *component-hash*)))
;;	       (print last-comp-index-of-cond) 
	       (setf (gethash last-comp-index-of-cond *component-hash*)
					;set path 2's last comp -->
					;list of 3 and 4's first comp 
		     (cons
		      (list 
		       (first (gethash true-index *control-hash*))
		       (first (gethash false-index *control-hash*))
		       )
		      (rest comp))))))  
	  
	  (T nil))))
;;******************************************************************************
(defun modify-child-if-child-is-nil ( comp-list )
  (cond ((endp comp-list) nil )
	((equal (first (gethash (first comp-list) *component-hash*)) nil)
	 (prog1 
	     (reset-child-in-hash (first comp-list))
 	   (modify-child-if-child-is-nil (rest comp-list))))
	(T (modify-child-if-child-is-nil (rest comp-list)))))  
;;******************************************************************************
(defun modify-func-field-of-hash-to-nil-to-hold-incoming-comps ( comp-list )
  (mapcar #'(lambda(x) 
	      (setf (nth 1 (get-comp-hash x)) nil))
	  comp-list))  
;;******************************************************************************
(defun modify-my-in-coming-comps (this-comp incoming-comp)
  (cond ((NULL this-comp) nil)
	(T 
	 (let ((in-coming (nth 1 (get-comp-hash this-comp)))) 
	   (setf (nth 1 (get-comp-hash this-comp))
		 (cons incoming-comp in-coming)))))
  ) 
;;******************************************************************************
(defun modify-incoming-comps ( comp-list )
  (let* ((this-index (first comp-list))
	 (this-next (first (gethash this-index *component-hash*))))
    (cond ((NULL comp-list) nil)
	  ((null this-next) 
	   (modify-incoming-comps (rest comp-list)))
	  (T
	   (cond ((atom this-next) 
		  (modify-my-in-coming-comps this-next this-index) 
		  (modify-incoming-comps (rest comp-list)))
		 
		 (T 
		  (modify-my-in-coming-comps (first this-next)
					     this-index) 
		  (modify-my-in-coming-comps (second this-next)
					     this-index) 
		  (modify-incoming-comps (rest comp-list)))
		 
		 ))))	
  )  

;;******************************************************************************
(defun modify-component-hash ( comp-list )
  (let* ((comp-list (extract-comp comp-list))
	 (comp-index-list (mapcar #'first comp-list)))
    (modify-child-if-child-is-nil comp-index-list)
    (modify-func-field-of-hash-to-nil-to-hold-incoming-comps comp-index-list)  
    (modify-incoming-comps comp-index-list) 
    ) 
  )
;;******************************************************************************
(defun get-type-set ( nodetype-list &optional (temp nil))
  (cond ((endp nodetype-list) (mapcar #'list temp))
	((member (first nodetype-list) temp) 
	 (get-type-set (rest nodetype-list) temp))
	(T
	 (get-type-set (rest nodetype-list) 
		       (cons (first nodetype-list) temp))))
  )
;;******************************************************************************
(defun compute-stats (nodetype-list type-set)
  (let* ((this-type (first nodetype-list))
	 (current-count (rest (assoc this-type type-set)))) 
    (cond ((endp nodetype-list) type-set )
	  ((NULL current-count)    
	   (compute-stats (rest nodetype-list)
			  (my-acons this-type 1 type-set)))
	  (T 
	   (compute-stats (rest nodetype-list)
			  (my-acons this-type 
				    (+ 1 current-count) type-set)))))
  )
;;******************************************************************************
(setq *null-statements* '(bridgenull ifstatement finish))
(setq *null-statements* nil)

(defun add-counts ( comp-stats &optional (temp 0))
  (cond ((endp comp-stats) temp)
	((member (caar comp-stats) *null-statements*)
	 (add-counts (rest comp-stats) temp)) 
	(T (add-counts (rest comp-stats) (+ temp (cdar comp-stats)))))  
  )
(defun compute-stats-ratio ( comp-stats )
  (let ((total-counts (add-counts comp-stats)))
    (mapcar #'(lambda (x)
		(cons (first x) 
		      (list
		       (rest x)
		       (coerce (/ (rest x) total-counts) 'float)))) comp-stats))
  )
;;******************************************************************************
(defun out-length ( atom-or-list )
  (cond ((atom atom-or-list) 1)
	(T (length atom-or-list))) 
  )

(defun count-out-degree( comp-index-list &optional (temp 0) )
  (cond ((endp comp-index-list) temp)
	(T 
	 (let* ((comp (get-comp-hash (first comp-index-list)))
		(out-index (first comp))
		(out-count (out-length out-index)))
	   (count-out-degree (rest comp-index-list) (+ temp out-count)))))
  
  )
;;******************************************************************************
(defun count-in-degree ( comp-index-list &optional (temp 0))
  (cond ((endp comp-index-list) temp)
	(T  
	 (let* ((comp (get-comp-hash (first comp-index-list)))
		(in-index (second comp))
		(in-count (length in-index)))
	   (count-in-degree (rest comp-index-list) (+ temp in-count)))))   	
  ) 
;;******************************************************************************
(defun save-stats (nodetype-list comp-index-list stats-file)
  (let* ((type-set (get-type-set nodetype-list))
	 (comp-stats (compute-stats nodetype-list type-set))
	 (comp-stats (compute-stats-ratio comp-stats))
	 (total-out-degree (count-out-degree comp-index-list))
	 (total-in-degree (count-in-degree comp-index-list)) 
	 )
    (progn
      (setq *stats-stream*
          (open stats-file
		:direction :output
		:if-exists :overwrite
		:if-does-not-exist :create))
      (format *stats-stream* "~%;; ")
      (write stats-file      :stream *stats-stream*)
      (format *stats-stream* " total number of components: ~a " (length nodetype-list))
      (format t "~%Total number of components: ~a " (length nodetype-list))
      (format *stats-stream* "~2%")
      (write comp-stats :stream *stats-stream*)
      (format *stats-stream* "~%Total in-degree: ~a  Total out-degree: ~a" 
	      total-in-degree total-out-degree)
      (format *stats-stream* "~%Average node degree: ~a ~%~%"
	      (coerce (/ (+ total-in-degree total-out-degree) 
			 (length nodetype-list)) 'float)) 	
      (close *stats-stream*)
      ))
  )

;;******************************************************************************
;;
;;no need to save stats everytime, once is enough
;;
(defun setup-data( comp-file control-file stats-file &optional (save-stats nil))
  
  (setq *control-hash* (make-hash-table))
  (setq *component-hash* (make-hash-table))

  (setq *true-hash* (make-hash-table)) ;;added as (key: comp-name
					;          value: container)
					;where the contained is a Test, 
					;if x is contained in the true part
					;of a Test, the value is the Test, 
					;otherwise, nil

  (let ((control-list (transduce-separate-to-list control-file))
	(comp-list   (transduce-comp-list comp-file)))
    (comp-file-to-hash comp-list)
    (control-file-to-hash control-list comp-list)
    (modify-component-hash comp-list)
    (setf *situations* 
	  (list (cons "my-sit" 
		      (mapcar #'(lambda (x)
				  (list (first x) (first (nth 4 x))))
			      (extract-comp comp-list)))))
    (setf *all-function-list* 
	  (mapcar #'first control-list) )  


    (if save-stats 
	(save-stats (mapcar #'(lambda (x)
				(first (nth 4 x))) (extract-comp comp-list))
		    (mapcar #'first (extract-comp comp-list))
		    stats-file))) 
  
  )

;;******************************************************************************
;;
(defun dump-setup-data (&key
            (comp-file "../../writing/whileC.component")
            (control-file "../../writing/whileC.control")
            (stats-file "../../writing/whileC.stats")
            (output-file "../../writing/whileC.sout"))
 
  (setup-data comp-file control-file stats-file)
 
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


