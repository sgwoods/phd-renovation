;;***********************************************************************************
; Three files will be used as the input: component-list control-list stmt-var-list  
; 
; Data structure of component-list
;  (   
;          ......
;      (compIndex compOrder funcName stmtIndex compBody accessdList modifiedList)
;          ......
;  )
;
; Data structure of control-list
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
; Data structure of stmt-var-list
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
;
;;***********************************************************************************
; Global variables: *component-list* *stmt-var-list* *control-list* 

(setf *component-list* 
'((DISC_1 1 DISTANCE DISC_STMT7 (MINUS X2 X1 RESULT1) (X2 X1 RESULT1)
  (RESULT1))
 (DISC_2 2 DISTANCE DISC_STMT7 (MINUS X2 X1 RESULT2) (X2 X1 RESULT2)
  (RESULT2))
 (DISC_3 3 DISTANCE DISC_STMT7 (MULT RESULT2 RESULT1 RESULT3)
  (RESULT2 RESULT1 RESULT3) (RESULT3))
 (DISC_4 4 DISTANCE DISC_STMT7 (ASSIGN VAL1 RESULT3) (VAL1 RESULT3) (VAL1))
 (DISC_5 5 DISTANCE DISC_STMT8 (MINUS Y2 Y1 RESULT4) (Y2 Y1 RESULT4)
  (RESULT4))
 (DISC_6 6 DISTANCE DISC_STMT8 (MINUS Y2 Y1 RESULT5) (Y2 Y1 RESULT5)
  (RESULT5))
 (DISC_7 7 DISTANCE DISC_STMT8 (MULT RESULT5 RESULT4 RESULT6)
  (RESULT5 RESULT4 RESULT6) (RESULT6))
 (DISC_8 8 DISTANCE DISC_STMT8 (ASSIGN VAL2 RESULT6) (VAL2 RESULT6) (VAL2))
 (DISC_9 9 DISTANCE DISC_STMT9 (PLUS VAL1 VAL2 RESULT7) (VAL1 VAL2 RESULT7)
  (RESULT7))
 (DISC_10 10 DISTANCE DISC_STMT9 (USERCALL SQRT RESULT7 RESULT8))
 (DISC_11 11 DISTANCE DISC_STMT9 (ASSIGN RESULT RESULT8) (RESULT RESULT8)
  (RESULT))
 (DISC_12 12 DISTANCE DISC_STMT10 (RETURN RESULT))
 (DISC_13 13 MAIN DISC_STMT17 (ASSIGN Y1 1) (Y1 1) (Y1))
 (DISC_14 14 MAIN DISC_STMT17 (ASSIGN X1 1) (X1 1) (X1))
 (DISC_15 15 MAIN DISC_STMT18 (ASSIGN Y2 4) (Y2 4) (Y2))
 (DISC_16 16 MAIN DISC_STMT18 (ASSIGN X2 4) (X2 4) (X2))
 (DISC_17 17 MAIN DISC_STMT19 (MINUS Y1 Y2 RESULT9) (Y1 Y2 RESULT9) (RESULT9))
 (DISC_18 18 MAIN DISC_STMT19 (MINUS Y1 Y2 RESULT10) (Y1 Y2 RESULT10)
  (RESULT10))
 (DISC_19 19 MAIN DISC_STMT19 (MULT RESULT10 RESULT9 RESULT11)
  (RESULT10 RESULT9 RESULT11) (RESULT11))
 (DISC_20 20 MAIN DISC_STMT19 (MINUS X1 X2 RESULT12) (X1 X2 RESULT12)
  (RESULT12))
 (DISC_21 21 MAIN DISC_STMT19 (MINUS X1 X2 RESULT13) (X1 X2 RESULT13)
  (RESULT13))
 (DISC_22 22 MAIN DISC_STMT19 (MULT RESULT13 RESULT12 RESULT14)
  (RESULT13 RESULT12 RESULT14) (RESULT14))
 (DISC_23 23 MAIN DISC_STMT19 (PLUS RESULT14 RESULT11 RESULT15)
  (RESULT14 RESULT11 RESULT15) (RESULT15))
 (DISC_24 24 MAIN DISC_STMT19 (USERCALL SQRT RESULT15 RESULT16))
 (DISC_25 25 MAIN DISC_STMT19 (ASSIGN RESULT RESULT16) (RESULT RESULT16)
  (RESULT))
 (DISC_26 26 MAIN DISC_STMT20 (USERCALL DISTANCE X1 Y1 X2 Y2 RESULT17))
 (DISC_27 27 MAIN DISC_STMT20 (ASSIGN RESULT RESULT17) (RESULT RESULT17)
  (RESULT)))) 
;  
;
; 
;;***********************************************************************************
;  
; same-stmt-find-path( comp1 comp2 )
;            return path between comp1 and comp2
(defun same-stmt-find-path( comp1 comp2 )
	(let ((cnt 0) 
          (temp (member comp1 *component-list* :test #'equal))
          (result NIL))
		(loop until (equal comp2 (nth cnt temp))
				do  
			  (setq result (append result (list (nth cnt temp))))  
			  (setq cnt (+ cnt 1))) 	
		(cond ((equal comp2 (nth cnt temp)) (list result) )
			  (T NIL))))

;;***********************************************************************************
;
; same-func-find-path( funcIndex stmtIndex1 stmtIndex2 )
; 
; check-changed( path data )
;  
; data-dep( comp2 comp1 data ) 
;    func1 = getFuncIndex( comp1 )
;    func2 = getFuncIndex( comp2 )
;    stmtIndex1 = getIndex( comp1 ) 
;    stmtIndex2 = getIndex( comp2 ) 
;    if( stmtIndex1 == stmtIndex2 ) 
;    {  
;         path = same-stmt-find-path( comp1 comp2 )  
;         return check-changed( path data )
;    }
;    else {
;         if( func1 == func2 )
;         {
;             paths = same-func-find-path( func1 stmtIndex1 stmtIndex2)
;	          return check-changed( path data )  Here possibly loop through all path
;         }
;         else
;         {
;             return NIL
;             Forget about it for now
;         }
;    }
;
;;***********************************************************************************
(defun in-accessed-list( data component )
	(cond ((member data (nth 5 component))
				(return T))
			(T NIL))) 
;;***********************************************************************************
(defun in-modified-list( data component )
	(cond ((member data (nth 6 component))
				(return T))
			(T NIL))) 
;;***********************************************************************************
(defun check-changed-in-one-path ( path data )
;	(print path)
;	(print data) 
	(let ((temp (mapcar #'(lambda( comp ) 
					(cond ( (member data (nth 6 comp)) T)
						  (T NIL)))  path)))   
;	(print temp) 
		(cond ((and (eq (car temp) T) (NULL (member t (cdr temp)) ))   
				 t)
				(T NIL))))
	
;;***********************************************************************************
(defun check-changed ( path-list data )
	(check-changed-in-one-path (car path-list) data )) 

;;***********************************************************************************
(defun get-component ( compIndex )
 	(let ((cnt 0)
		  (comp NIL))
		(loop (when (equal compIndex (car (nth cnt *component-list*))) 
 					(setf comp (nth cnt *component-list*))
					(return))
			  (setf cnt (+ cnt 1)))
			comp) 	
)

(defun get-func ( component )
	(nth 2 component) 
)

(defun get-stmt-index ( component )
	(nth 3 component) 
)

;;***********************************************************************************
(defun data-dep( comp2Index comp1Index data )
	(let* (
		  (comp1 (get-component comp1Index))
		  (comp2 (get-component comp2Index)) 
		  (func1 (get-func comp1))
		  (func2 (get-func comp2))
		  (stmtIndex1 (get-stmt-index comp1))
		  (stmtIndex2 (get-stmt-index comp2))
		  (path-list NIL))
  			(cond  ((eq stmtIndex1 stmtIndex2) 
						(setq path-list (same-stmt-find-path comp1 comp2)))
				   ( T NIL))  	 
 			(check-changed path-list data ))) 
 
;;***********************************************************************************
