(defvar *end-of-file* (gensym)
	"A unique EOF marker")

(defun eof-p (x) (eq x *end-of-file*)) 

;;**************************************************************************
; In original transformation result from gen++, the structure of a component
; in a statement is (compIndex compOrder lineNumber (body) (accessdVarList)
; (modifiedVarList)), use this function to replace the field lineNumber of 
; all components with its corresponding statementIndex  

(defun set-statement-index ( statement )

	(let ((statement-index (car statement))
		  (statement-body (car (cdr statement))))
		(setf (nth 1 statement) 
				(mapcar #'(lambda (comp)
					(setf (nth 2 comp) statement-index) comp)
					statement-body))
			statement))

;;**************************************************************************

(defun extract-comp ( statement-list component-list)
	(cond ((NULL statement-list) NIL)
			(T  (append (nth 2 (car statement-list)) 
; the component list is the third element of a statement 
						(extract-comp (cdr statement-list) component-list)))))

;;**************************************************************************
; Given a list of statements, extract the component list part and append
; them as a component list
 
(defun extract-component (statement-list)
	(extract-comp statement-list nil))   

;;**************************************************************************	
; To read in file infile item by item, apply function fn to the item
; and save the result to file outfile  

(defun transduce-file( infile outfile fn )
	(with-open-file (out-stream outfile
						:direction :output 
						:if-exists :supersede)
	(with-open-file (in-stream infile
						:direction :input)
		(loop
			(let ((exp (read in-stream nil *end-of-file* nil)))
				(if (eof-p exp) (return))
				(print (funcall fn exp) out-stream))))))

;;**************************************************************************
; Given a file containing a list of elements but without the
; "( )" bracing them, add "( )" to generate a new file which
; is a single list.

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


;;**************************************************************************
; In its origianl form, a statement doesn't have a field showing which 
; function it belongs to, in insert-function-name-to-statement, the function
; name is added to the statement as the second element of a statement
 
(defun insert-function-name-to-statement infile outfile controlfile)
	(with-open-file (in-stream1 controlfile
						:direction :input)
	(with-open-file (in-stream2 infile
						:direction :input)
	(with-open-file (out-stream outfile
						:direction :output
						:if-exists :supersede)
	(let ((control-list (read in-stream1 nil *end-of-file* nil))
		  (statement-list (read in-stream2 nil *end-of-file* nil))
		  (func-count 0))
		(loop 
			(if (eq func-count (length control-list)) (return))
			(let ((func (nth func-count control-list))) 
  	

;;**************************************************************************


(defun trans-file( componentfile controlfile )
	(transduce-file componentfile  "temp" #'set-statement-index)
	(transduce-file-list "temp1" "temp2")
	(insert-function-name-to-statment "temp2" "newdisC.component" controlfile) 
	(transduce-file "newdisC.component" "components" #'extract-component) 
) 


