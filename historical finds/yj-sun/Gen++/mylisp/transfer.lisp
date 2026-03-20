;;**************************************************************************
; transfer.lisp: to transfer results from gen++ to files of expected format

;;**************************************************************************
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
					(setf (nth 3 comp) statement-index) comp)
					statement-body))
			statement))


;;**************************************************************************
(defun extract-component-list ( statement )
        (nth 1 statement))

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
(defun get-index-var (statement)
    (list (nth 0 statement) (nth 2 statement) (nth 3 statement))) 
;;**************************************************************************	

(defun extract-stmt-var( infile outfile )
	(with-open-file (out-stream outfile
						:direction :output 
						:if-exists :supersede)
	(with-open-file (in-stream infile
						:direction :input)
	(let ((temp NIL))
		(loop
			(let ((exp (read in-stream nil *end-of-file* nil)))
				(if (eof-p exp) (return))
				(setq temp (append temp (list ( get-index-var exp))))))
				(print temp out-stream)))))

;;**************************************************************************	

(defun append-components( infile outfile )
	(with-open-file (out-stream outfile
						:direction :output 
						:if-exists :supersede)
	(with-open-file (in-stream infile
						:direction :input)
	(let ((temp NIL))
		(loop
			(let ((exp (read in-stream nil *end-of-file* nil)))
				(if (eof-p exp) (return))
				(setq temp (append temp exp))))
				(print temp out-stream)))))

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
 

;;**************************************************************************
;; The following two data structures result from the original gen++ analyzer  
;
; Data structure of component-file
; 
;  ......
;  ( stmtIndex
;     (
;        ......
;          (compIndex compOrder lineNumber compBody accessedList modifiedList)
;        ......
;     )
;     (
;          ......
;          (accessdVar definedPosition)
;          ......
;     )
;     (
;          ......
;          (modifiedVar definedPosition)
;          ......
;     )
;  )
; ......
;
; Data structure of control-file  
;     ......
;     ( functionName
;          ......
;          (stmtIndex childStmtIndex) || (stmtIndex condIndex trueIndex falseIndex)
;          ......
;     )
;     ......
;  
;;###########################################################################
; The following structures are what we want for data-dependence check
;
; Data structure of component-list
;  (       
;          ......
;      (compIndex compOrder funcName stmtIndex compBody accessdList modifiedList)
;          ......
;  )
;
; Data structure of flow-list
;  (
;      ......
;      ( functionName
;           ......
;           (stmtIndex childStmtIndex) || (stmtIndex condIndex trueIndex falseIndex)
;           ......
;      )
;      ......
;  )
;
; Data structure of stmtVar-list
; (
;      ......
;   (stmtIndex
;      (
;          ......
;          (accessdVar definedPosition)
;          ......
;      )
;      (
;          ......
;          (modifiedVar definedPosition)
;          ......
;      )
;   )
;      ......
; )
;;**************************************************************************
;;**************************************************************************
  
(defun transfer-component-files( component-file  
                       component-list-file stmtvar-list-file)

	(transduce-file component-file  "temp1" #'set-statement-index)
	(transduce-file "temp1" "temp2" #'extract-component-list)
    (append-components "temp2" component-list-file)
;    (transduce-file "temp1" "temp2" #'get-index-var)
;	(transduce-file-list "temp2" stmtvar-list-file)
	(extract-stmt-var "temp1" stmtvar-list-file) 
)

;;**************************************************************************
(defun transfer-control-files( control-file  control-list-file )
	(transduce-file-list control-file  control-list-file)
)

