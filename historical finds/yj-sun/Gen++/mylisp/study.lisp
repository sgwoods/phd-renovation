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
