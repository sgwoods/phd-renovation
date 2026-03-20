;;(defconstant *template-object-list* 

(setq
 *template-object-list* 
 (list
  
  '("reset-value-template-2-1"
    (
     (e1 (LessEq Id1-1 Id1-2 Id1-3))      ;if( fx <= 1e-5 )
     (e2 (Assign Id2-1 Id2-2))            ;    fx = 1e-5; 
     )
    (
     (same-data-dependency (e2 e1) (Id2-1 Id1-1))
     )
    )
  
  '("increment-template-2-2"
    (
     (e1 (Plus Id1-1 Id1-2 Id1-3))        ;temp = i + 1
     (e2 (Assign Id2-1 Id2-2))            ;i = temp
     )
    (
     (same-variable (e2 e1) (Id2-1 Id1-1))
     (guaranteed-data-dependency (e2 e1) Id2-2)
     )
    )

  '("copy-array-element-template-3-2"
    (
     (e1 (Index Id1-1 Id1-2 Id1-3))       ;temp1 = xcopy[i] 
     (e2 (Index Id2-1 Id2-2 Id2-3))       ;temp2 = x[i]
     (e3 (Assign Id3-1 Id3-2))            ;temp1 = temp2
     )
    (
     (guaranteed-data-dependency (e3 e1) Id3-2)
     (guaranteed-data-dependency (e3 e2) Id3-1)
     )
    )
  
   '("alloc-array-error-check-template-4-3"
    (
     (e1 (Mult Id1-1 Id1-2 Id1-3))        ;temp1 = n * 1
     (e2 (malloc Id2-1 Id2-2))            ;temp2 = malloc( temp1 )
     (e3 (Assign Id3-1 Id3-2))            ;xcopy = temp2
     (e4 (EqEq Id4-1 Id4-2 Id4-3))        ;temp2 == 0? 
     )
    (
     (guaranteed-data-dependency (e2 e1) Id2-1)
     (guaranteed-data-dependency (e3 e2) Id3-2)
     (guaranteed-data-dependency (e4 e2) Id4-1)
     )
    )
  
  '("traverse-array-template-5-7"
    (
     (e1 (Assign Id1-1 Id1-2))           ;i = 0
     (e2 (Loop))
     (e3 (Less Id3-1 Id3-2 Id3-3))       ;i<n
     (e4 (Index Id4-1 Id4-2 Id4-3))      ;
     (e5 (PreInc Id5-1))                 ;++i
     )
    (
     (control-data-dependency (e2 e1))
     (possible-data-dependency (e3 e1) Id3-1)
     (possible-data-dependency (e3 e5) Id3-1)
     (possible-data-dependency (e4 e1) Id4-2)
     (possible-data-dependency (e4 e5) Id4-2)
     
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) Id5-1)  
     )
    )
  
  '("addup-array-template-6-9"
    (
     (e1 (Assign Id1-1 Id1-2))           ;i = 0
     (e2 (Loop))
     (e3 (Less Id3-1 Id3-2 Id3-3))       ;i<n
     (e4 (Index Id4-1 Id4-2 Id4-3))      ;temp1 = x[i]
     (e5 (PlusAssign Id5-1 Id5-2))       ;mean += temp1
     (e6 (PreInc Id6-1))                 ;++i
     )
    (
     (control-data-dependency (e2 e1))
     (possible-data-dependency (e3 e1) Id3-1)
     (possible-data-dependency (e3 e6) Id3-1)
     (possible-data-dependency (e4 e1) Id4-2)
     (possible-data-dependency (e4 e6) Id4-2)

     (guaranteed-data-dependency (e5 e4) Id5-2)
     (possible-data-dependency (e5 e5) Id5-1)
     (possible-data-dependency (e6 e1) Id6-1)
     (possible-data-dependency (e6 e6) Id6-1)  
     )
    )

  '("copy-array-template-7-11"
    (
     (e1 (Assign Id1-1 Id1-2))           ;i = 0
     (e2 (Loop))
     (e3 (Less Id3-1 Id3-2 Id3-3))       ;i<n
     (e4 (Index Id4-1 Id4-2 Id4-3))      ;temp1 = xcopy[i]
     (e5 (Index Id5-1 Id5-2 Id5-3))      ;temp2 = x[i]
     (e6 (Assign Id6-1 Id6-2))           ;temp1 = temp2
     (e7 (PreInc Id7-1))
     )
    (
     (control-data-dependency (e2 e1))
     (possible-data-dependency (e3 e1) Id3-1)
     (possible-data-dependency (e3 e7) Id3-1)
     (possible-data-dependency (e4 e1) Id4-2)
     (possible-data-dependency (e4 e7) Id4-2)
     
     (possible-data-dependency (e5 e1) Id5-2)
     (possible-data-dependency (e5 e7) Id5-2)
     (guaranteed-data-dependency (e6 e4) Id6-1)
     (guaranteed-data-dependency (e6 e5) Id6-2)
     (possible-data-dependency (e7 e1) Id7-1)

     (possible-data-dependency (e7 e7) Id7-1)  
     )
    )

  '("average-array-template-8-12"
    (
     (e1 (Assign Id1-1 Id1-2))           ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))           ;i = 0 
     (e21 (Loop)) 
     (e3 (Less Id3-1 Id3-2 Id3-3))       ;i<n 
     (e4 (Index Id4-1 Id4-2 Id4-3))      ;a[i] --Id4-3 
     
     (e5 (PlusAssign Id5-1 Id5-2))       ;mean += Id4-3
     (e6 (PreInc Id6-1))                 ;++i	
     (e8 (DivAssign Id8-1 Id8-2))        ;mean /= n 
     )
    (
     (control-data-dependency (e21 e1))  
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e6) Id3-1)
     (possible-data-dependency (e4 e2) Id4-2) 
     
     (possible-data-dependency (e4 e6) Id4-2) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (possible-data-dependency (e6 e2) Id6-1)
     
     (possible-data-dependency (e8 e5) Id8-1) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
  )
  
  '("sum-square-array-9-16"
    (
     (e1 (Assign Id1-1 Id1-2))           ;sdx = 0
     (e2 (Assign Id2-1 Id2-2))           ;i=0
     (e3 (Loop))                          
     (e4 (Less Id4-1 Id4-2 Id4-3))       ;i<n
     (e5 (Index Id5-1 Id5-2 Id5-3))      ;temp1 = x[i]
     (e6 (Index Id6-1 Id6-2 Id6-3))      ;temp2 = x[i]
     (e7 (Mult Id7-1 Id7-2 Id7-3))       ;temp3 = temp1 * temp2
     (e8 (PlusAssign Id8-1 Id8-2))       ;sdx += temp3
     (e9 (PreInc Id9-1))                 ;++i
     )
    (
     (control-data-dependency (e3 e1))
     (control-data-dependency (e3 e2))
     (possible-data-dependency (e4 e2) Id4-1)
     (possible-data-dependency (e4 e9) Id4-1)
     (possible-data-dependency (e5 e2) Id5-2)

     (possible-data-dependency (e5 e9) Id5-2)
     (possible-data-dependency (e6 e2) Id6-2)
     (possible-data-dependency (e6 e9) Id6-2)     
     (same-variable (e6 e5) (Id6-1 Id5-1))
     (guaranteed-data-dependency (e7 e5) Id7-2)
     
     (guaranteed-data-dependency (e7 e6) Id7-1)
     (possible-data-dependency (e8 e1) Id8-1)
     (possible-data-dependency (e8 e8) Id8-1)
     (guaranteed-data-dependency (e8 e7) Id8-2)
     (possible-data-dependency (e9 e2) Id9-1)
     
     (possible-data-dependency (e9 e9) Id9-1)
     )
    )
  
  '("sample-variance-18-37"
    (
     ;;modified from average-array
     ;;added component e0
     (e0 (Assign Id0-1 Id0-2))            ;sdx = 0
     (e1 (Assign Id1-1 Id1-2))            ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))            ;i = 0 
     (e21 (Loop)) 
     (e3 (Less Id3-1 Id3-2 Id3-3))        ;i<n 

     (e4 (Index Id4-1 Id4-2 Id4-3))       ;temp1 = a[i] 
     (e5 (PlusAssign Id5-1 Id5-2))        ;mean += temp1
     ;;added component e51-e591
     (e51 (Index Id51-1 Id51-2 Id51-3))   ;temp2 = a[i]
     (e52 (Index Id52-1 Id52-2 Id52-3))   ;temp3 = a[i]
     (e53 (Mult Id53-1 Id53-2 Id53-3))    ;temp4 = temp2 * temp3

     (e54 (PlusAssign Id54-1 Id54-2))     ;sdx += temp4
     (e55 (Minus Id55-1 Id55-2 Id55-3))   ;temp5 = n - 1
     (e56 (Mult Id56-1 Id56-2 Id56-3))    ;temp6 = n * temp5 
     (e57 (Mult Id57-1 Id57-2 Id57-3))    ;temp7 = mean * mean;
     (e58 (Mult Id58-1 Id58-2 Id58-3))    ;temp8 = n * sdx;

     (e59 (Minus Id59-1 Id59-2 Id59-3))   ;temp9 = temp8 - temp7
     (e591 (Div Id591-1 Id591-2 Id591-3)) ;temp10 = temp9 / temp6
     (e6 (PreInc Id6-1))                  ;++i	
     )
    (
     (control-data-dependency (e21 e1))  
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e6) Id3-1)     
     (possible-data-dependency (e4 e2) Id4-2) 

     (possible-data-dependency (e4 e6) Id4-2) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (possible-data-dependency (e6 e2) Id6-1)

     (possible-data-dependency (e6 e6) Id6-1)

     ;;new constraints follow
     (control-data-dependency (e21 e0))
     (possible-data-dependency (e51 e2) Id51-2) 
     (possible-data-dependency (e51 e6) Id51-2) 
     (same-data-dependency (e51 e4) (Id51-1 Id4-1))
     (possible-data-dependency (e52 e2) Id52-2) 

     (possible-data-dependency (e52 e6) Id52-2)
     (same-data-dependency (e52 e4) (Id52-1 Id4-1))
     (guaranteed-data-dependency (e53 e51) Id53-1) 
     (guaranteed-data-dependency (e53 e52) Id53-2)  
     (possible-data-dependency (e54 e0) Id54-1) 

     (possible-data-dependency (e54 e54) Id54-1) 
     (guaranteed-data-dependency (e54 e53) Id54-2)  
     (same-data-dependency (e55 e3) (Id55-1 Id3-2))
     (same-data-dependency (e56 e3) (Id56-1 Id3-2))
     (guaranteed-data-dependency (e56 e55) Id56-2)

     (possible-data-dependency (e57 e1) Id57-1)
     (possible-data-dependency (e57 e5) Id57-1)
     (possible-data-dependency (e57 e1) Id57-2)
     (possible-data-dependency (e57 e5) Id57-2)
     (same-data-dependency (e58 e3) (Id58-1 Id3-2))

     (possible-data-dependency (e58 e0) Id58-2) 
     (possible-data-dependency (e58 e54) Id58-2)
     (guaranteed-data-dependency (e59 e58) Id59-1)
     (guaranteed-data-dependency (e59 e57) Id59-2)
     (guaranteed-data-dependency (e591 e59) Id591-1)

     (guaranteed-data-dependency (e591 e56) Id591-2)
     )
    )

  '("leap-year-21-28"
    ;;without variable type (int, double etc.) info
    ;;with additional other reasons, this is far from being a "good" template
   (
     (e1 (Div Id1-1 Id1-2 Id1-3))         ;temp1 = year/100
     (e1-0 (Assign Id1-0-1 Id1-0-2))      ;cc = temp1
     (e2 (Mult Id2-1 Id2-2 Id2-3))         ;temp2 = cc * 100
     (e3 (Minus Id3-1 Id3-2 Id3-3))       ;temp3 = year - temp2
     (e4 (Assign Id4-1 Id4-2))            ;yy = temp3

     (e5 (Div Id5-1 Id5-2 Id5-3))         ;temp4 = year/4
     (e50 (Assign Id50-1 Id50-2))         ;q = temp4
     (e6 (Mult Id6-1 Id6-2 Id6-3))         ;temp5 = q * 4
     (e7 (Minus Id7-1 Id7-2 Id7-3))       ;temp6 = year - temp5
     (e8 (Assign Id8-1 Id8-2))            ;r1 = temp6

     (e9  (Div Id9-1 Id9-2 Id9-3))        ;temp7 = year/400
     (e90 (Assign Id90-1 Id90-2))         ;q = temp7
     (e10 (Mult Id10-1 Id10-2 Id10-3))     ;temp8 = q * 400
     (e11 (Minus Id11-1 Id11-2 Id11-3))   ;temp9 = year - temp8
     (e12 (Assign Id12-1 Id12-2))         ;r2 = temp9

     (e13 (Test))                         ;
     (e14 (EqEq Id14-1 Id14-2 Id14-3))    ;r1 == 0 ; from e8
     (e15 (Test))                         ;
     (e16 (EqEq Id16-1 Id16-2 Id16-3))    ;yy == 0 ; from e4
     (e17 (Test))
     (e18 (EqEq Id18-1 Id18-2 Id18-3))    ;r2 == 0 ; from e12
     )
    (
     (guaranteed-data-dependency (e1-0 e1) Id1-0-2)
     (guaranteed-data-dependency (e2 e1-0) Id2-1)
     (guaranteed-data-dependency (e3 e2) Id3-2)
     (guaranteed-data-dependency (e4 e3) Id4-2)
;     (is-constant e1 Id1-2 100)
;     (is-constant e2 Id2-2 100

     (guaranteed-data-dependency (e50 e5) Id50-2)
     (guaranteed-data-dependency (e6 e50) Id6-1)
     (guaranteed-data-dependency (e7 e6) Id7-2)
     (guaranteed-data-dependency (e8 e7) Id8-2)
;     (is-constant e5 Id5-2 4)
;     (is-constant e6 Id6-2 4)
     
     (guaranteed-data-dependency (e90 e9) Id10-2)
     (guaranteed-data-dependency (e10 e90) Id10-1)
     (guaranteed-data-dependency (e11 e10) Id11-2)
     (guaranteed-data-dependency (e12 e11) Id12-2)
;     (is-constant e9 Id9-2 400)
;     (is-constant e10 Id10-2 400)

     (same-data-dependency (e3 e1) (Id3-1 Id1-1))
     (same-data-dependency (e5 e3) (Id5-1 Id3-1))
     (same-data-dependency (e7 e5) (Id7-1 Id5-1))
     (same-data-dependency (e9 e7) (Id9-1 Id7-1))
     (same-data-dependency (e11 e9) (Id11-1 Id9-1))

     (guaranteed-data-dependency (e14 e8) Id14-1) 
     (contained-in-condition (e14 e13))
     (guaranteed-data-dependency (e16 e4) Id16-1)
     (contained-in-condition (e16 e15))
     (guaranteed-data-dependency (e18 e12) Id18-1)
     (contained-in-condition (e18 e17))
     
     (contained-in-true (e15 e13))
     (contained-in-true (e17 e15))
    
     )
    )

  '("hack-leap-year-21-28"
    ;;without variable type (int, double etc.) info
    ;;with additional other reasons, this is far from being a "good" template
    (
     (e1 (Div Id1-1 Id1-2 Id1-3))         ;temp1 = year/100
     (e1-0 (Assign Id1-0-1 Id1-0-2))      ;cc = temp1
     (e2 (Mult Id2-1 Id2-2 Id2-3))         ;temp2 = cc * 100
     (e3 (Minus Id3-1 Id3-2 Id3-3))       ;temp3 = year - temp2
     (e4 (Assign Id4-1 Id4-2))            ;yy = temp3

     (e5 (Div Id5-1 Id5-2 Id5-3))         ;temp4 = year/4
     (e50 (Assign Id50-1 Id50-2))         ;q = temp4
     (e6 (Mult Id6-1 Id6-2 Id6-3))         ;temp5 = q * 4
     (e7 (Minus Id7-1 Id7-2 Id7-3))       ;temp6 = year - temp5
     (e8 (Assign Id8-1 Id8-2))            ;r1 = temp6

     (e9  (Div Id9-1 Id9-2 Id9-3))        ;temp7 = year/400
     (e90 (Assign Id90-1 Id90-2))         ;q = temp7
     (e10 (Mult Id10-1 Id10-2 Id10-3))     ;temp8 = q * 400
     (e11 (Minus Id11-1 Id11-2 Id11-3))   ;temp9 = year - temp8
     (e12 (Assign Id12-1 Id12-2))         ;r2 = temp9

     (e13 (Test))                         ;
     (e14 (EqEq Id14-1 Id14-2 Id14-3))    ;r1 == 0 ; from e8
     (e15 (Test))                         ;
     (e16 (EqEq Id16-1 Id16-2 Id16-3))    ;yy == 0 ; from e4
     (e17 (Test))
     (e18 (EqEq Id18-1 Id18-2 Id18-3))    ;r2 == 0 ; from e12
     )
    (
     (guaranteed-data-dependency (e1-0 e1) Id1-0-2)
     (guaranteed-data-dependency (e2 e1-0) Id2-1)
     (guaranteed-data-dependency (e3 e2) Id3-2)
     (guaranteed-data-dependency (e4 e3) Id4-2)
;     (is-constant e1 Id1-2 100)
;     (is-constant e2 Id2-2 100)

     (guaranteed-data-dependency (e50 e5) Id50-2)
     (guaranteed-data-dependency (e6 e50) Id6-1)
     (guaranteed-data-dependency (e7 e6) Id7-2)
     (guaranteed-data-dependency (e8 e7) Id8-2)
;     (is-constant e5 Id5-2 4)
;     (is-constant e6 Id6-2 4)
     
     (guaranteed-data-dependency (e90 e9) Id90-2)
     (guaranteed-data-dependency (e10 e90) Id10-1)
     (guaranteed-data-dependency (e11 e10) Id11-2)
     (guaranteed-data-dependency (e12 e11) Id12-2)
;     (is-constant e9 Id9-2 400)
;     (is-constant e10 Id10-2 400)

     (same-data-dependency (e3 e1) (Id3-1 Id1-1))
     (same-data-dependency (e5 e3) (Id5-1 Id3-1))
     (same-data-dependency (e7 e5) (Id7-1 Id5-1))
     (same-data-dependency (e9 e7) (Id9-1 Id7-1))
     (same-data-dependency (e11 e9) (Id11-1 Id9-1))

     (guaranteed-data-dependency (e14 e8) Id14-1) 
     (contained-in-condition (e14 e13))
     (guaranteed-data-dependency (e16 e4) Id16-1)
     (contained-in-condition (e16 e15))
     (guaranteed-data-dependency (e18 e12) Id18-1)
     (contained-in-condition (e18 e17))

     (contained-in-true (e15 e13))
     (contained-in-true (e17 e15))
     (guaranteed-data-dependency (e14 e13) Id14-3)
     (guaranteed-data-dependency (e16 e15) Id16-3)
     (guaranteed-data-dependency (e18 e17) Id18-3)

     )
    )

  '("leap-year-"
    (

     )
    (
    
     )
    )
  
  ;; template-array-template-9-13  -  template-array-template-9-18
  ;; are templates with decomposed PreInc or PostInc  

  '("average-array-template-9-13"
    (
     (e1 (Assign Id1-1 Id1-2))            ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))            ;i = 0 
     (e21 (Loop)) 
     (e3 (Less Id3-1 Id3-2 Id3-3))        ;i<n 
     (e4 (Index Id4-1 Id4-2 Id4-3))       ;temp1 = a[i]
     
     (e5 (PlusAssign Id5-1 Id5-2))        ;mean += temp1
     (e6 (Plus Id6-1 Id6-2 Id6-3))        ;++i ==> Id6-3 = i + 1
     (e7 (Assign Id7-1 Id7-2))            ;i = Id6-3  
     (e8 (DivAssign Id8-1 Id8-2))         ;mean /= n 
     )
    (
     (control-data-dependency (e21 e1))
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e7) Id3-1)
     (possible-data-dependency (e4 e2) Id4-2) 
     
     (possible-data-dependency (e4 e7) Id4-2) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (guaranteed-data-dependency (e7 e6) Id7-2)  
     
     (same-variable (e7 e6) (Id7-1 Id6-1))
     (possible-data-dependency (e8 e5) Id8-1) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )
  
  '("average-array-template-9-14"
    (
     (e1 (Assign Id1-1 Id1-2))            ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))            ;i = 0 
     (e21 (Loop)) 
     (e3 (Less Id3-1 Id3-2 Id3-3))        ;i<n 
     (e4 (Index Id4-1 Id4-2 Id4-3))       ;temp1 = a[i] 
     
     (e5 (PlusAssign Id5-1 Id5-2))        ;mean += temp1
     (e6 (Plus Id6-1 Id6-2 Id6-3))        ;++i ==> Id6-3 = i + 1
     (e7 (Assign Id7-1 Id7-2))            ;i = Id6-3  
     (e8 (DivAssign Id8-1 Id8-2))         ;mean /= n 
     )
    (
     (control-data-dependency (e21 e1))   
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e7) Id3-1)
     (possible-data-dependency (e4 e2) Id4-2) 
     
     (possible-data-dependency (e4 e7) Id4-2) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (guaranteed-data-dependency (e7 e6) Id7-2)  
     
     (same-variable (e7 e6) (Id7-1 Id6-1))
     (possible-data-dependency (e8 e1) Id8-1)
     (possible-data-dependency (e8 e5) Id8-1) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )
  
  
  '("average-array-template-9-15"
    (
     (e1 (Assign Id1-1 Id1-2))            ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))            ;i = 0 
     (e21 (Loop)) 
     (e3 (Less Id3-1 Id3-2 Id3-3))        ;i<n 
     (e4 (Index Id4-1 Id4-2 Id4-3))       ;temp1 = a[i] 
     
     (e5 (PlusAssign Id5-1 Id5-2))        ;mean += temp1
     (e6 (Plus Id6-1 Id6-2 Id6-3))        ;++i ==> Id6-3 = i + 1
     (e7 (Assign Id7-1 Id7-2))            ;i = Id6-3  
     (e8 (DivAssign Id8-1 Id8-2))         ;mean /= n 
     )
    (
     (control-data-dependency (e21 e1))  
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e7) Id3-1)
     (possible-data-dependency (e4 e2) Id4-2) 
     
     (possible-data-dependency (e4 e7) Id4-2) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (possible-data-dependency (e6 e2) Id6-1)
     
     (guaranteed-data-dependency (e7 e6) Id7-2)  
     (same-variable (e7 e6) (Id7-1 Id6-1))
     (possible-data-dependency (e8 e1) Id8-1)
     (possible-data-dependency (e8 e5) Id8-1) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )
  
  
  '("average-array-template-9-16"
    (
     (e1 (Assign Id1-1 Id1-2))            ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))            ;i = 0 
     (e21 (Loop)) 
     (e3 (Less Id3-1 Id3-2 Id3-3))        ;i<n 
     (e4 (Index Id4-1 Id4-2 Id4-3))       ;temp1 = a[i] 
     
     (e5 (PlusAssign Id5-1 Id5-2))        ;mean += temp1
     (e6 (Plus Id6-1 Id6-2 Id6-3))        ;++i ==> Id6-3 = i + 1
     (e7 (Assign Id7-1 Id7-2))            ;i = Id6-3  
     (e8 (DivAssign Id8-1 Id8-2))         ;mean /= n 
     )
    (
     (control-data-dependency (e21 e1))  
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e7) Id3-1)
     (possible-data-dependency (e4 e2) Id4-2) 
     
     (possible-data-dependency (e4 e7) Id4-2) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (possible-data-dependency (e6 e2) Id6-1)
     
     (possible-data-dependency (e6 e7) Id6-1)
     (guaranteed-data-dependency (e7 e6) Id7-2) 
     (same-variable (e7 e6) (Id7-1 Id6-1)) 
     (possible-data-dependency (e8 e1) Id8-1)
     (possible-data-dependency (e8 e5) Id8-1)
 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )
  
  '("average-array-template-9-17"
    (
     (e1 (Assign Id1-1 Id1-2))            ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))            ;i = 0 
     (e21 (Loop)) 
     (e3 (Less Id3-1 Id3-2 Id3-3))        ;i<n 
     (e4 (Index Id4-1 Id4-2 Id4-3))       ;temp1 = a[i] 
     
     (e5 (PlusAssign Id5-1 Id5-2))        ;mean += temp1
     (e6 (Plus Id6-1 Id6-2 Id6-3))        ;++i ==> Id6-3 = i + 1
     (e7 (Assign Id7-1 Id7-2))            ;i = Id6-3  
     (e8 (DivAssign Id8-1 Id8-2))         ;mean /= n 
     )
    (
     (control-data-dependency (e21 e1))  
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e7) Id3-1)
     (possible-data-dependency (e4 e2) Id4-2) 
     
     (possible-data-dependency (e4 e7) Id4-2) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (possible-data-dependency (e6 e2) Id6-1)
     
     (possible-data-dependency (e6 e7) Id6-1)
     (guaranteed-data-dependency (e7 e6) Id7-2)  
     (same-variable (e7 e6) (Id7-1 Id6-1))
     (possible-data-dependency (e7 e2) Id7-1)
     (possible-data-dependency (e8 e1) Id8-1)
     
     (possible-data-dependency (e8 e5) Id8-1) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )
  
  '("average-array-template-9-18"
    (
     (e1 (Assign Id1-1 Id1-2))            ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))            ;i = 0 
     (e21 (Loop)) 
     (e3 (Less Id3-1 Id3-2 Id3-3))        ;i<n 
     (e4 (Index Id4-1 Id4-2 Id4-3))       ;temp1 = a[i] 
     
     (e5 (PlusAssign Id5-1 Id5-2))        ;mean += temp1
     (e6 (Plus Id6-1 Id6-2 Id6-3))        ;++i ==> Id6-3 = i + 1
     (e7 (Assign Id7-1 Id7-2))            ;i = Id6-3  
     (e8 (DivAssign Id8-1 Id8-2))         ;mean /= n 
     )
    (
     (control-data-dependency (e21 e1))  
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e7) Id3-1)
     (possible-data-dependency (e4 e2) Id4-2) 
     
     (possible-data-dependency (e4 e7) Id4-2) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (possible-data-dependency (e6 e2) Id6-1)
     
     (possible-data-dependency (e6 e7) Id6-1)
     (guaranteed-data-dependency (e7 e6) Id7-2)  
     (same-variable (e7 e6) (Id7-1 Id6-1)) 
     (possible-data-dependency (e7 e2) Id7-1)
     (possible-data-dependency (e7 e7) Id7-1)

     (possible-data-dependency (e8 e1) Id8-1)
     (possible-data-dependency (e8 e5) Id8-1) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )
  
  ;; amended templates which use PreInc 
  
  
  '("average-array-template-8-12"
    (
     (e1 (Assign Id1-1 Id1-2))              ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))              ;i = 0 
     (e21 (Loop)) 
     (e3 (Less Id3-1 Id3-2 Id3-3))          ;i<n 
     (e4 (Index Id4-1 Id4-2 Id4-3))         ;temp1 = a[i] 
     
     (e5 (PlusAssign Id5-1 Id5-2))          ;mean += temp1
     (e6 (PreInc Id6-1))                    ;++i	
     (e8 (DivAssign Id8-1 Id8-2))           ;mean /= n 
     )
    (
     (control-data-dependency (e21 e1)) 
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e6) Id3-1)
     (possible-data-dependency (e4 e2) Id4-2) 
     
     (possible-data-dependency (e4 e6) Id4-2) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (possible-data-dependency (e6 e2) Id6-1)
     
     (possible-data-dependency (e8 e5) Id8-1) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
  )
  
  '("average-array-template-8-13"
    (
     (e1 (Assign Id1-1 Id1-2))              ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))              ;i = 0 
     (e21 (Loop)) 
     (e3 (Less Id3-1 Id3-2 Id3-3))          ;i<n 
     (e4 (Index Id4-1 Id4-2 Id4-3))         ;temp1 = a[i] 
     
     (e5 (PlusAssign Id5-1 Id5-2))          ;mean += temp1
     (e6 (PreInc Id6-1))                    ;++i	
     (e8 (DivAssign Id8-1 Id8-2))           ;mean /= n 
     )
    (
     (control-data-dependency (e21 e1))  
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e6) Id3-1)
     (possible-data-dependency (e4 e2) Id4-2) 
     
     (possible-data-dependency (e4 e6) Id4-2) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (possible-data-dependency (e6 e2) Id6-1)
     
     (possible-data-dependency (e8 e1) Id8-1)
     (possible-data-dependency (e8 e5) Id8-1) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )
  
  '("average-array-template-8-14"
    (
     (e1 (Assign Id1-1 Id1-2))              ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))              ;i = 0 
     (e21 (Loop)) 
     (e3 (Less Id3-1 Id3-2 Id3-3))          ;i<n 
     (e4 (Index Id4-1 Id4-2 Id4-3))         ;temp1 = a[i] 
     
     (e5 (PlusAssign Id5-1 Id5-2))          ;mean += temp1
     (e6 (PreInc Id6-1))                    ;++i	
     (e8 (DivAssign Id8-1 Id8-2))           ;mean /= n 
     )
    (
     (control-data-dependency (e21 e1)) 
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e6) Id3-1)
     (possible-data-dependency (e4 e2) Id4-2) 
     
     (possible-data-dependency (e4 e6) Id4-2) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (possible-data-dependency (e6 e2) Id6-1)
     
     (possible-data-dependency (e6 e6) Id6-1)
     (possible-data-dependency (e8 e1) Id8-1)
     (possible-data-dependency (e8 e5) Id8-1) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )  

  '("average-array-template-8-14-static"
    (
     (e1 (Assign Id1-1 Id1-2))              ;mean = 0 
     (e8 (DivAssign Id8-1 Id8-2))           ;mean /= n 
     (e21 (Loop))  
     (e2 (Assign Id2-1 Id2-2))              ;i = 0 
     (e5 (PlusAssign Id5-1 Id5-2))          ;mean += temp1
     
     (e3 (Less Id3-1 Id3-2 Id3-3))          ;i<n 
     (e6 (PreInc Id6-1))                    ;++i 
     (e4 (Index Id4-1 Id4-2 Id4-3))         ;temp1 = a[i]     
     )
    (
     (possible-data-dependency (e8 e1) Id8-1)
     (control-data-dependency (e21 e1)) 
     (control-data-dependency (e21 e2))  
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e6) Id3-1)
     (possible-data-dependency (e6 e2) Id6-1)
     (possible-data-dependency (e6 e6) Id6-1)
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     
     (possible-data-dependency (e4 e2) Id4-2)      
     (possible-data-dependency (e4 e6) Id4-2) 
     (possible-data-dependency (e8 e5) Id8-1) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )  
  
  '("average-array-template-8-14-static-1"
    (
     (e8 (DivAssign Id8-1 Id8-2))           ;mean /= n 
     (e1 (Assign Id1-1 Id1-2))              ;mean = 0 
     (e5 (PlusAssign Id5-1 Id5-2))          ;mean += temp1
     (e4 (Index Id4-1 Id4-2 Id4-3))         ;temp1 = a[i]     
     (e21 (Loop))  
     
     (e2 (Assign Id2-1 Id2-2))              ;i = 0 
     (e6 (PreInc Id6-1))                    ;++i 
     (e3 (Less Id3-1 Id3-2 Id3-3))          ;i<n 
     )
    (
     (possible-data-dependency (e8 e1) Id8-1)
     (possible-data-dependency (e8 e5) Id8-1) 
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (control-data-dependency (e21 e1)) 
     (possible-data-dependency (e4 e2) Id4-2)      
     (control-data-dependency (e21 e2))  
     
     (possible-data-dependency (e6 e2) Id6-1)
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e3 e6) Id3-1)
     
     (possible-data-dependency (e6 e6) Id6-1)
     (possible-data-dependency (e4 e6) Id4-2) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )  
  
  '("average-array-template-8-14-static-2"
    (
     (e5 (PlusAssign Id5-1 Id5-2))          ;mean += temp1
     (e4 (Index Id4-1 Id4-2 Id4-3))         ;temp1 = a[i] 
     (e8 (DivAssign Id8-1 Id8-2))           ;mean /= n 
     (e1 (Assign Id1-1 Id1-2))              ;mean = 0 
     (e2 (Assign Id2-1 Id2-2))              ;i = 0 
     (e6 (PreInc Id6-1))                    ;++i 
     (e3 (Less Id3-1 Id3-2 Id3-3))          ;i<n 
     (e21 (Loop))  
     )
    (
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     (possible-data-dependency (e8 e5) Id8-1) 
     (possible-data-dependency (e8 e1) Id8-1)
     (possible-data-dependency (e4 e2) Id4-2)
     (possible-data-dependency (e6 e2) Id6-1)
     
     (possible-data-dependency (e3 e6) Id3-1)
     (control-data-dependency (e21 e1))       
     (control-data-dependency (e21 e2))   
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) ID5-1) 
     
     (possible-data-dependency (e3 e2) Id3-1)
     (possible-data-dependency (e6 e6) Id6-1)
     (possible-data-dependency (e4 e6) Id4-2) 
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )  
  
  '("new-traverse-string-6-9"
    (
     (e1 (Assign Id1-1 Id1-2))           ;init: i = 0
     (e2 (Loop))
     (e3 (Index Id3-1 Id3-2 Id3-3))      ;access1: tmp1 = a[i]
     (e4 (NotEq Id4-1 Id4-2 Id4-3))      ;test: tmp1 != 0
     (e5 (Index Id5-1 Id5-2 Id5-3))      ;access2: tmp2 = a[i]
     (e6 (PreInc Id6-1))                 ;update: ++i
     )
    (
     (control-data-dependency (e2 e1))          ;initbef
     (possible-data-dependency (e3 e1) Id3-2)   ;acc1bef
     (guaranteed-data-dependency (e4 e3) Id4-1) ;acc1bef
     (contained-in-condition (e3 e2))           ;testin
     (contained-in-condition (e4 e2))           ;testin

     (contained-in-loop (e5 e2))                ;acc2in
     (contained-in-loop (e6 e2))                ;updin
     (possible-data-dependency (e5 e6) Id5-2)   ;updaft
     (possible-data-dependency (e3 e6) Id3-2)   ;
     
     )
    )
  ))

 
