(in-package #:phd-qcsp-alex)
;;functions for static ordering experiments
;;basically we permute the constraint list of a given template, reorder
;;its components with repect to each permutation to make sure the components
;;are connected by constraints, otherwise, discard this permutation
;;

(defun permutate-list ( a-list )
  (let ((result nil))
    (cond ((endp a-list) nil)
	  ((eq (length a-list) 1) (list a-list))
	  ((eq (length a-list) 2) 
	   (list a-list (list (second a-list) (first a-list))))
	  (t (dolist (element a-list result)
		     (setf 
		      result 
		      (append result
			      (mapcar #'(lambda(x)
					  (cons element x))
				      (permutate-list (remove element a-list)))))))))
  )


(defun test ()
  (format t 
	  "~a" 
	  (permutate-list '(1 2 3) )))

(defun constraints-connected ( constraints )
  (let ((affected-variables (nth 1 (first constraints)))
	(count 0)
	(result t))
    (loop (when (or (not result) (eq count (length constraints)))
		(return result))
	  (let* ((this-constraint (nth count constraints))
		 (this-affected (nth 1 this-constraint )))
	    (if (and (null (member (first this-affected) affected-variables))
		     (null (member (second this-affected) affected-variables)))
		(setq result nil)
	      (setq affected-variables (append affected-variables this-affected))))
	  (setq count (+ count 1)))
    ))

(defun remove-disconnected-constraints ( constraints-list )
  (remove-if-not #'constraints-connected constraints-list)
  )


(defun append-element-if-not-in ( element a-list )
  (if (member element a-list)
      a-list
    (append a-list (list element)))
  )

(defun get-reordered-variables ( variable-list index-list )   
  (mapcar #'(lambda (x)
	      (assoc x variable-list)) index-list)
  )

(defun reorder-variable ( template connected-constraints )
  (let* ((result1 nil)
	 (result2 nil))
    (dolist (element connected-constraints)
	    (let* (
		   (affected-list (nth 1 element))
		   (first-affected (first affected-list))
		   (second-affected (second affected-list)))
	      (setq result1 (append-element-if-not-in first-affected result1))
	      (setq result1 (append-element-if-not-in second-affected result1))
	      ))
    
    (dolist (element connected-constraints)
	    (let* (
		   (affected-list (nth 1 element))
		   (first-affected (first affected-list))
		   (second-affected (second affected-list)))
	      (setq result2 (append-element-if-not-in second-affected result2))
	      (setq result2 (append-element-if-not-in first-affected result2))
	      )) 
    ;; if one constraint affect only one variable, this must be modified.
    ;;
    ;;
    ;;notice
    (list (get-reordered-variables (nth 1 template)  result1)
	  (get-reordered-variables (nth 1 template)  result2)))
  
  )

(defun permutate-template-constraints( template )
  (let* ((constraints-of-different-order (permutate-list (nth 2 template)))
	 (connected-constraints-list (remove-disconnected-constraints 
				      constraints-of-different-order))
	 (result nil)
	 (count 0))
    (dolist (element connected-constraints-list)
	    (let ((two-variable-set (reorder-variable template element)))
	      (progn 
		(setq result 			
		      (append result 
			      (list  
			       (list 
				(format nil "~a-~a" (nth 0 template) count)
				(first two-variable-set)
				element
				))
			      (list  
			       (list 
				(format nil "~a-~a" (nth 0 template) (+ count 1))
				(second two-variable-set)
				element
				))))))
	    
	    (setq count (+ count 2)))
    result)
  )

(defun select-templates ( &key
			  (template-id "traverse-array-template-5-7")
			  (position-list '(536 2088 132)))
  (let ((template-list (permutate-template-constraints (get-templ-object template-id))))
    (dolist (element position-list)
	    (format t "Template ~a: ~a~%" element (nth element template-list))))
)

(defun p-constraint-exp(&key
			(data-file-list '(("testdata/dmaxc.component" 
					   "testdata/dmaxc.control" 
					   "testdata/dmaxc.stats")))
			(template-id "alloc-array-error-check-template-4-3" )
			(output-file "my-output-file"))
  
  (static-cons-order-exp data-file-list
			 (permutate-template-constraints (get-templ-object template-id))
			 output-file)
  )

(defun static-cons-order-exp( data-file-list template-body-list output-file )
  ;;explore random template tree 
  (setq *my-result-stream*  (open output-file
				  :direction :output
				  :if-exists :overwrite
				  :if-does-not-exist :create))
  (format *my-result-stream* "~a~%" "(")
  (dolist (files-element data-file-list)
	  (progn
	    (format *my-result-stream* " ~a~%" "(")
	    (load "new-setup.fasl")
	    (format t
		    "~%Do files: ~a!"
		    files-element) 
	    (test-main (nth 0 files-element)
		       (nth 1 files-element)
		       (nth 2 files-element))
	    (dolist (template template-body-list)
		    (progn
	
		      (adt :template-id "special" 
			   :search-mode "qu"
;;			   :forward-checking t
			   :advance-sort 'quilici
			   :adv-sort-const nil
			   ;; :debug-csp t 
			   ;; :debug-node t
			   :override-template template)
		      (format t 
			      "~a~%Recognized instances: ~a~%" 
			      *current-template*
			      (length *solution-set*))	
		      (add-result-to-file  *my-result-stream*  
					   (nth 0 files-element))
		      
		      ))
	    (format *my-result-stream* "~% ~a~%" ")")
	    
	    ))
  (format *my-result-stream* "~%~a~%" ")")
  (close *my-result-stream*))


(defun add-result-to-file ( output-stream component-file )
  "
make a list of results we are interested in and append it to a file.
Those results are:
(0 plan-name)
(1 number-of-components-of-the-plan)
(2 number-of-constraints-of-the-plan)
(3 program-name)
(4 number-of-components-of-the-program)
(5 number-of-this-plan-related-components)
(6 ratio-of-5-over-4)
(7 average-domain-size)
(8 max-domain-size)
(9 min-domain-size)
(10 constaint-checks)
(11 successful-constraint-checks)
(12 failed-constraint-checks) 
(13 ratio-of-11-over-10)
"
(let* ((r0 (nth 0 *current-template*))
       (r1 (length (nth 1 *current-template*)))
       (r2 (length (nth 2 *current-template*)))
       (r3 component-file)
       (r4 (length *current-situation*))
       (r5 (get-number-of-cur-plan-related-components))
       (r6 (coerce (/ r5 r4) 'float))
       (r7 *RECALL-avg-var-len*)
       (r10 *constraint-cks*)
       (r11 *constraint-success*)
       (r12 *constraint-failure*)
       (r13 (coerce (/ r11 r10) 'float))
       (r14 (length *solution-set*))

;;following are added on April 27, 1997  
       (r15 *RECALL-search-time*)
       (r16 *constraint-possible-data-dependency-cks*)
       (r17 *constraint-guaranteed-data-dependency-cks*)
       (r18 *constraint-same-data-dependency-cks*)
       (r19 *constraint-control-data-dependency-cks*)
       (r20 *constraint-same-variable-cks*)
       (r21 (coerce (/ r15 r10) 'float))
 
       (r22 *node-consistency-checks*)
       (r23 *node-type-consistency-checks*)
       (r24 *node-type-consistency-ck-ok*)
       (r25 *node-type-consistency-ck-fail*)


		)
  
  (format output-stream  "~a~%"
	  ;;	  (list r0 r1 r2 r3 r4 r5 r6 r7 r10 r11 r12 r13 r14)))
	  ;; (list r4 r10 r14)))
  (list r0 r1 r2 r3 r4 r5 r6 r7 r10 r11 r12 r13 r14 r15 r16 r17 r18 r19 r20 r21 r22 r23 r24 r25))))

)

(defun single-min-max-avg ( data-element 
			    min-out-stream 
			    max-out-stream
			    avg-out-stream)
  (let ((psize (nth 4 (car data-element)))
	(count 0)
	(avg-cks 0)
	(min-cks (nth 8 (car data-element)))
	(min-posi 0)
	(max-cks (nth 8 (car data-element)))
	(max-posi 0))
    (dolist (element data-element)
	    (let ((this-cks (nth 8 element)))
	      (setq avg-cks (+ avg-cks this-cks))
	      (if (> min-cks this-cks)
		  (progn (setq min-cks this-cks)
			 (setq min-posi count)))
	      (if (< max-cks this-cks)
		  (progn (setq max-cks this-cks)
			 (setq max-posi count)))
	    (setq count (+ count 1))))
    
    (setq avg-cks (coerce (/ avg-cks count) 'float))
    (format t "template number ~a min: ~a ~a~%" min-posi psize min-cks)
    (format t "template number ~a max: ~a ~a~%" max-posi psize max-cks)
    (format t "avg: ~a ~a~%" psize avg-cks)
    (format min-out-stream "~a ~a~%" psize min-cks)
    (format max-out-stream "~a ~a~%" psize max-cks)
    (format avg-out-stream "~a ~a~%" psize avg-cks)) 
  )

(defun data-min-max-avg ( data-file 
			  min-out-file
			  max-out-file
			  avg-out-file)
  (setq *min-stream*  (open min-out-file
			     :direction :output
			     :if-exists :overwrite
			     :if-does-not-exist :create))
  (setq *max-stream*  (open max-out-file
			    :direction :output
			    :if-exists :overwrite
			    :if-does-not-exist :create))
  (setq *avg-stream*  (open avg-out-file
			    :direction :output
			    :if-exists :overwrite
			    :if-does-not-exist :create))
  
  (with-open-file (in-stream 
		   data-file
		   :direction :input)
		  (let ((data-list (read in-stream nil *end-of-file* nil)))
		    (dolist (data-element data-list)
			    (single-min-max-avg data-element
						*min-stream*
						*max-stream*
						*avg-stream*))))
  (close *min-stream*)
  (close *max-stream*)
  (close *avg-stream*)
  )

(defun test-min-max ()
  (data-min-max-avg "testdata/Static/static-5-7-prefilter-result"
		    "testdata/Static/prefilter-min"
		    "testdata/Static/prefilter-max"
		    "testdata/Static/prefilter-avg")

)











