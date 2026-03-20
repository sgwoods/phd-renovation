(setq *template-object-list* 
      (list

 
'("average-array-template"
  (
	(e1 (Assign Id1 Id2))				;mean = 0 
	(e2 (Assign Id3 Id4))				;i = 0 
    (e21 (Loop)) 
	(e3 (Less Id5 Id6 Id31))				;i<n 
	(e4 (Index Id7 Id8 Id9))			;a[i] --Id9 

	(e5 (PlusAssign Id10 Id11))         ;mean += Id9 
	(e6 (Plus Id12 Id13 Id14))			;i++ ==> Id14 = i + 1
	(e7 (Assign Id15 Id16))				;i = Id14  
	(e8 (DivAssign Id17 Id18))          ;mean /= n 
  )
  (
	(control-data-dependency (e21 e1)) ; data set at e1 is in dependency-list of e21 
	(control-data-dependency (e21 e2))  
	(possible-data-dependency (e3 e2) Id5)
	(possible-data-dependency (e3 e7) Id5)
	(possible-data-dependency (e4 e2) Id8) 

	(possible-data-dependency (e4 e7) Id8) 
	(guaranteed-data-dependency (e5 e4) Id11) 
	(possible-data-dependency (e5 e1) Id10)
	(possible-data-dependency (e5 e5) ID10) 
	(guaranteed-data-dependency (e7 e6) Id16)  

	(possible-data-dependency (e8 e1) Id17)
	(possible-data-dependency (e8 e5) Id17) 
	(same-data-dependency (e3 e8) (Id6 Id18))

  ) 
 )

;; template-array-template-9-12  -  template-array-template-9-17
;; are templates with decomposed PreInc or postincre 

'("average-array-template-9-12"
  (
	(e1 (Assign Id1-1 Id1-2))				;mean = 0 
	(e2 (Assign Id2-1 Id2-2))				;i = 0 
    (e21 (Loop)) 
	(e3 (Less Id3-1 Id3-2 Id3-3))			;i<n 
	(e4 (Index Id4-1 Id4-2 Id4-3))			;a[i] --Id4-3 

	(e5 (PlusAssign Id5-1 Id5-2)) 			;mean += Id4-3
	(e6 (Plus Id6-1 Id6-2 Id6-3))			;i++ ==> Id6-3 = i + 1
	(e7 (Assign Id7-1 Id7-2))				;i = Id6-3  
	(e8 (DivAssign Id8-1 Id8-2))			;mean /= n 
  )
  (
	(control-data-dependency (e21 e1)) ; data set at e1 is in dependency-list of e21 
	(control-data-dependency (e21 e2))  
	(possible-data-dependency (e3 e2) Id3-1)
	(possible-data-dependency (e3 e7) Id3-1)
	(possible-data-dependency (e4 e2) Id4-2) 

	(possible-data-dependency (e4 e7) Id4-2) 
	(guaranteed-data-dependency (e5 e4) Id5-2) 
	(possible-data-dependency (e5 e1) Id5-1)
	(possible-data-dependency (e5 e5) ID5-1) 
	(guaranteed-data-dependency (e7 e6) Id7-2)  

	(possible-data-dependency (e8 e5) Id8-1) 
	(same-data-dependency (e3 e8) (Id3-2 Id8-2))

  ) 
 )

'("average-array-template-9-13"
  (
	(e1 (Assign Id1-1 Id1-2))				;mean = 0 
	(e2 (Assign Id2-1 Id2-2))				;i = 0 
    (e21 (Loop)) 
	(e3 (Less Id3-1 Id3-2 Id3-3))			;i<n 
	(e4 (Index Id4-1 Id4-2 Id4-3))			;a[i] --Id4-3 

	(e5 (PlusAssign Id5-1 Id5-2)) 			;mean += Id4-3
	(e6 (Plus Id6-1 Id6-2 Id6-3))			;i++ ==> Id6-3 = i + 1
	(e7 (Assign Id7-1 Id7-2))				;i = Id6-3  
	(e8 (DivAssign Id8-1 Id8-2))			;mean /= n 
  )
  (
	(control-data-dependency (e21 e1)) ; data set at e1 is in dependency-list of e21 
	(control-data-dependency (e21 e2))  
	(possible-data-dependency (e3 e2) Id3-1)
	(possible-data-dependency (e3 e7) Id3-1)
	(possible-data-dependency (e4 e2) Id4-2) 

	(possible-data-dependency (e4 e7) Id4-2) 
	(guaranteed-data-dependency (e5 e4) Id5-2) 
	(possible-data-dependency (e5 e1) Id5-1)
	(possible-data-dependency (e5 e5) ID5-1) 
	(guaranteed-data-dependency (e7 e6) Id7-2)  

	(possible-data-dependency (e8 e1) Id8-1)
	(possible-data-dependency (e8 e5) Id8-1) 
	(same-data-dependency (e3 e8) (Id3-2 Id8-2))

  ) 
 )


'("average-array-template-9-14"
  (
	(e1 (Assign Id1-1 Id1-2))				;mean = 0 
	(e2 (Assign Id2-1 Id2-2))				;i = 0 
    (e21 (Loop)) 
	(e3 (Less Id3-1 Id3-2 Id3-3))			;i<n 
	(e4 (Index Id4-1 Id4-2 Id4-3))			;a[i] --Id4-3 

	(e5 (PlusAssign Id5-1 Id5-2)) 			;mean += Id4-3
	(e6 (Plus Id6-1 Id6-2 Id6-3))			;i++ ==> Id6-3 = i + 1
	(e7 (Assign Id7-1 Id7-2))				;i = Id6-3  
	(e8 (DivAssign Id8-1 Id8-2))			;mean /= n 
  )
  (
	(control-data-dependency (e21 e1)) ; data set at e1 is in dependency-list of e21 
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
	(possible-data-dependency (e8 e1) Id8-1)
	(possible-data-dependency (e8 e5) Id8-1) 
	(same-data-dependency (e3 e8) (Id3-2 Id8-2))

  ) 
 )


'("average-array-template-9-15"
  (
	(e1 (Assign Id1-1 Id1-2))				;mean = 0 
	(e2 (Assign Id2-1 Id2-2))				;i = 0 
    (e21 (Loop)) 
	(e3 (Less Id3-1 Id3-2 Id3-3))			;i<n 
	(e4 (Index Id4-1 Id4-2 Id4-3))			;a[i] --Id4-3 

	(e5 (PlusAssign Id5-1 Id5-2)) 			;mean += Id4-3
	(e6 (Plus Id6-1 Id6-2 Id6-3))			;i++ ==> Id6-3 = i + 1
	(e7 (Assign Id7-1 Id7-2))				;i = Id6-3  
	(e8 (DivAssign Id8-1 Id8-2))			;mean /= n 
  )
  (
	(control-data-dependency (e21 e1)) ; data set at e1 is in dependency-list of e21 
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
	(possible-data-dependency (e8 e1) Id8-1)
	(possible-data-dependency (e8 e5) Id8-1) 
	(same-data-dependency (e3 e8) (Id3-2 Id8-2))

  ) 
 )

'("average-array-template-9-16"
  (
	(e1 (Assign Id1-1 Id1-2))				;mean = 0 
	(e2 (Assign Id2-1 Id2-2))				;i = 0 
    (e21 (Loop)) 
	(e3 (Less Id3-1 Id3-2 Id3-3))			;i<n 
	(e4 (Index Id4-1 Id4-2 Id4-3))			;a[i] --Id4-3 

	(e5 (PlusAssign Id5-1 Id5-2)) 			;mean += Id4-3
	(e6 (Plus Id6-1 Id6-2 Id6-3))			;i++ ==> Id6-3 = i + 1
	(e7 (Assign Id7-1 Id7-2))				;i = Id6-3  
	(e8 (DivAssign Id8-1 Id8-2))			;mean /= n 
  )
  (
	(control-data-dependency (e21 e1)) ; data set at e1 is in dependency-list of e21 
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
	(possible-data-dependency (e7 e2) Id7-1)
	(possible-data-dependency (e8 e1) Id8-1)
	(possible-data-dependency (e8 e5) Id8-1) 

	(same-data-dependency (e3 e8) (Id3-2 Id8-2))

  ) 
 )

'("average-array-template-9-17"
  (
	(e1 (Assign Id1-1 Id1-2))				;mean = 0 
	(e2 (Assign Id2-1 Id2-2))				;i = 0 
    (e21 (Loop)) 
	(e3 (Less Id3-1 Id3-2 Id3-3))			;i<n 
	(e4 (Index Id4-1 Id4-2 Id4-3))			;a[i] --Id4-3 

	(e5 (PlusAssign Id5-1 Id5-2)) 			;mean += Id4-3
	(e6 (Plus Id6-1 Id6-2 Id6-3))			;i++ ==> Id6-3 = i + 1
	(e7 (Assign Id7-1 Id7-2))				;i = Id6-3  
	(e8 (DivAssign Id8-1 Id8-2))			;mean /= n 
  )
  (
	(control-data-dependency (e21 e1)) ; data set at e1 is in dependency-list of e21 
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
	(e1 (Assign Id1-1 Id1-2))				;mean = 0 
	(e2 (Assign Id2-1 Id2-2))				;i = 0 
    (e21 (Loop)) 
	(e3 (Less Id3-1 Id3-2 Id3-3))			;i<n 
	(e4 (Index Id4-1 Id4-2 Id4-3))			;a[i] --Id4-3 

	(e5 (PlusAssign Id5-1 Id5-2)) 			;mean += Id4-3
	(e6 (PreInc Id6-1))                     ;++i	
	(e8 (DivAssign Id8-1 Id8-2))			;mean /= n 
  )
  (
	(control-data-dependency (e21 e1)) ; data set at e1 is in dependency-list of e21 
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
	(e1 (Assign Id1-1 Id1-2))				;mean = 0 
	(e2 (Assign Id2-1 Id2-2))				;i = 0 
    (e21 (Loop)) 
	(e3 (Less Id3-1 Id3-2 Id3-3))			;i<n 
	(e4 (Index Id4-1 Id4-2 Id4-3))			;a[i] --Id4-3 

	(e5 (PlusAssign Id5-1 Id5-2)) 			;mean += Id4-3
	(e6 (PreInc Id6-1))                     ;++i	
	(e8 (DivAssign Id8-1 Id8-2))			;mean /= n 
  )
  (
	(control-data-dependency (e21 e1)) ; data set at e1 is in dependency-list of e21 
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
	(e1 (Assign Id1-1 Id1-2))				;mean = 0 
	(e2 (Assign Id2-1 Id2-2))				;i = 0 
    (e21 (Loop)) 
	(e3 (Less Id3-1 Id3-2 Id3-3))			;i<n 
	(e4 (Index Id4-1 Id4-2 Id4-3))			;a[i] --Id4-3 

	(e5 (PlusAssign Id5-1 Id5-2)) 			;mean += Id4-3
	(e6 (PreInc Id6-1))                     ;++i	
	(e8 (DivAssign Id8-1 Id8-2))			;mean /= n 
  )
  (
	(control-data-dependency (e21 e1)) ; data set at e1 is in dependency-list of e21 
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


'("zero-array-template"
  (
	(elem2 LessEq (Id2 (int)) (Id3 (int)) (Id4 (int)) )
	(elem3 While (Id5 (int)) )
	(elem4 Begin (Id6 (block)))
	(elem5 Index (Id7 (int)) (Id8 (int)) (Id9 (int)))
	(elem6 Assign (Id10 (int)) (Id1 (int)))
	(elem7 End (Id11 (block)))
	(elem8 Assign (Id12 (int)) (Id13 (int)))
	(elem9 Plus (Id14 (int)) (1 (int)) (Id15 (int)))
	(elem10 Assign (Id16 (int)) (Id17 (int)))
  )
  (
 	(same-name-p (elem2 elem3) (Id4 Id5))
	(same-name-p (elem2 elem5) (Id2 Id8))
	(same-name-p (elem4 elem7) (Id6 Id11))
	(same-name-p (elem5 elem6) (Id9 Id10))
	(same-name-p (elem2 elem8) (Id2 Id13))
	(same-name-p (elem2 elem9) (Id2 Id14))
	(same-name-p (elem2 elem10) (Id2 Id16))
	(same-name-p (elem9 elem10) (Id15 Id17))  

	(same-line (elem2 elem3))
	(same-line (elem5 elem6))
	(same-line (elem8 elem9))
	(same-line (elem9 elem10)) 
	
	(before-p (elem2 elem9)) 
	(is-zero (elem6 elem6) (Id1 Id1))

	(before-p (elem3 elem4)) 
	(close-to-p (elem3 elem4) 4)
	(before-p (elem2 elem3))
	(close-to-p (elem2 elem3) 4 )

	(before-p (elem3 elem6))
	(before-p (elem6 elem7))
	(before-p (elem8 elem7))
  )
)

'("count-input-template"
  (
	(elem1 Zero (Id1 (int)))
	(elem2 While (Id2 (boolean)))
	(elem3 Equals (Id3 (int)) (1 (int)) (Id4 (boolean)))
	(elem4 Call (scanf (function)) (Id5 (format)) (Id6 (addrOf)) (Id7 (int)))   
	(elem5 Begin (Id8 (block)))
	(elem6 Increment (Id9 (int)))
	(elem7 End (Id10 (block)))
  )
  (
	(before-p (elem1 elem2))
	(same-name-p (elem2 elem3) (Id2 Id4))
	(close-to-p (elem2 elem5) 20)
	(before-p (elem5 elem6))
	(before-p (elem6 elem7))	 	
	(same-name-p (elem3 elem4) (Id3 Id7))
	(same-name-p (elem5 elem7) (Id8 Id10)) 
	(same-name-p (elem1 elem6) (Id1 Id9))  
  )
)

    '( "quilici-t1"
	  (
	   (q1-c While      (ResultA (boolean)))
	   (q1-d Begin      (Block1 (block)))
	   (q1-g Assign (NameC (array (char))) (IndexC (int))
		 (ElemB (char)))
	   (q1-e End        (Block2 (block)))

	   (q1-i Increment  (IndexD (int)))
	   (q1-a Decl       (NameA (array (char) (0 10000))))
	   (q1-b Zero       (IndexA (int)))
	   (q1-f Assign (NameB (array (char))) (IndexB (int))
		 (ElemA (char)) )
	   (q1-h Not-Equals (ElemC (char)) (NULL (char)) (ResultB (boolean)))
	   )
  	  (
	   (before-p    (q1-c q1-d))    
	   (close-to-p  (q1-c q1-d) 10)
	   (before-p    (q1-d q1-g))
	   (same-name-p (q1-d q1-e) (Block1 Block2))
	   (before-p    (q1-g q1-e))
	   
	   (before-p    (q1-b q1-c))    
	   (before-p    (q1-a q1-b))    
	   (before-p    (q1-b q1-h))    
	   (before-p    (q1-d q1-e))    
	   (before-p    (q1-f q1-h))    
	   (before-p    (q1-g q1-i))    
	   (before-p    (q1-d q1-i))
	   (before-p    (q1-i q1-e))
	   (same-name-p (q1-c q1-h) (ResultA ResultB))
	   (same-name-p (q1-f q1-h) (ElemA ElemC))
	   (same-name-p (q1-a q1-f) (NameA NameB))
	   (same-name-p (q1-a q1-g) (NameA NameC))
	   (same-name-p (q1-b q1-f) (IndexA IndexB))
	   (same-name-p (q1-b q1-g) (IndexA IndexC))
	   (same-name-p (q1-b q1-i) (IndexA IndexD))
	   ))

       '( "quilici-t1-large"
	  (
	   (q1-c While      (ResultA (boolean)))
	   (q1-d Begin      (Block1 (block)))
	   (q1-g Assign (NameC (array (char))) (IndexC (int))
		 (ElemB (char)))
	   (q1-e End        (Block2 (block)))

	   (q1-i Increment  (IndexD (int)))
	   (q1-a  Decl      (NameA (array (char) (0 10000))))
	   (q1-a2 Decl      (NameA2 (char)))
	   (q1-a3 Decl      (NameA3 (char)))
	   (q1-a4 Decl      (NameA4 (char)))
	   (q1-b Zero       (IndexA (int)))
	   (q1-f Assign (NameB (array (char))) (IndexB (int))
		 (ElemA (char)) )
	   (q1-h Not-Equals (ElemC (char)) (NULL (char)) (ResultB (boolean)))
	   (q1-p1 Print     (NameP1  (char)))
	   (q1-p2 Print     (Newline (char)))
	   )
  	  (
	   (before-p    (q1-c q1-d))    
	   (close-to-p  (q1-c q1-d) 10)
	   (before-p    (q1-d q1-g))
	   (same-name-p (q1-d q1-e) (Block1 Block2))
	   (before-p    (q1-g q1-e))
	   
	   (before-p    (q1-b q1-g))
	   (before-p    (q1-b q1-c))
	   (before-p    (q1-d q1-f))    
	   (before-p    (q1-d q1-i))    
	   (before-p    (q1-a2 q1-g))    
	   (before-p    (q1-a3 q1-f))    
	   (before-p    (q1-g  q1-p1))    
	   (before-p    (q1-p1 q1-e))    
	   (before-p    (q1-i q1-e))    
	   (before-p    (q1-f q1-h))    
	   (before-p    (q1-h q1-e))    
	   (before-p    (q1-a3 q1-p1))    
	   (before-p    (q1-a4 q1-p2))    

	   (same-name-p (q1-c q1-h) (ResultA ResultB))
	   (same-name-p (q1-f q1-h) (ElemA ElemC))
	   (same-name-p (q1-a q1-f) (NameA NameB))
	   (same-name-p (q1-a q1-g) (NameA NameC))
	   (same-name-p (q1-b q1-f) (IndexA IndexB))
	   (same-name-p (q1-b q1-g) (IndexA IndexC))
	   (same-name-p (q1-b q1-i) (IndexA IndexD))

	   (same-name-p (q1-a2 q1-g) (NameA2 ElemB))
	   (same-name-p (q1-a3 q1-f) (NameA3 ElemA))
	   (same-name-p (q1-p1 q1-g) (NameP1 ElemB))
	   (same-name-p (q1-a4 q1-p2) (NameA4 Newline))

	   ))

       '( "quilici-t1-index"
	  (
	   (q1-c While      (ResultA (boolean)))
	   (q1-d Begin      (Block1 (block)))
	   (q1-g Assign (NameC (array (char))) (IndexC (int))
		 (ElemB (char)))
	   (q1-e End        (Block2 (block)))
	   )
	  (
	   (before-p    (q1-c q1-d))    
	   (close-to-p  (q1-c q1-d) 10)
	   (before-p    (q1-d q1-g))
	   (same-name-p (q1-d q1-e) (Block1 Block2))
	   (before-p    (q1-g q1-e))
	   ))

       '( "quilici-t1-new"
	  (
	   (q1-g Assign (NameC (array (char))) (IndexC (int))
		 (ElemB (char)))


	   (q1-c While      (ResultA (boolean)))
	   (q1-d Begin      (Block1 (block)))
	   (q1-e End        (Block2 (block)))
	   (q1-i Increment  (IndexD (int)))
	   (q1-a Decl       (NameA (array (char) (0 10000))))
	   (q1-b Zero       (IndexA (int)))
	   (q1-f Assign (NameB (array (char))) (IndexB (int))
		 (ElemA (char)) )
	   (q1-h Not-Equals (ElemC (char)) (NULL (char)) (ResultB (boolean)))
	   )
  	  (
	   (before-p    (q1-c q1-g))
	   (close-to-p  (q1-c q1-d) 10)
	   (before-p    (q1-c q1-d))    
	   (before-p    (q1-d q1-g))
	   (same-name-p (q1-d q1-e) (Block1 Block2))
	   (before-p    (q1-d q1-e))    	   
	   (before-p    (q1-g q1-e))

	   (before-p    (q1-b q1-c))    
	   (before-p    (q1-a q1-b))    
	   (before-p    (q1-b q1-h))    
	   (before-p    (q1-f q1-h))    
	   (before-p    (q1-g q1-i))    
	   (before-p    (q1-d q1-i))
	   (before-p    (q1-i q1-e))
	   (same-name-p (q1-c q1-h) (ResultA ResultB))
	   (same-name-p (q1-f q1-h) (ElemA ElemC))
	   (same-name-p (q1-a q1-f) (NameA NameB))
	   (same-name-p (q1-a q1-g) (NameA NameC))
	   (same-name-p (q1-b q1-f) (IndexA IndexB))
	   (same-name-p (q1-b q1-g) (IndexA IndexC))
	   (same-name-p (q1-b q1-i) (IndexA IndexD))
	   ))

       '( "quilici-t2"
	  (
	   (q1-c While      (ResultA (boolean)))
	   (q1-d Begin      (Block1 (block)))
	   (q1-g Assign (NameC (array (char))) (IndexC (int))
		 (ElemB (char)))
	   (q1-e End        (Block2 (block)))

	   (q1-i Increment  (IndexD (int)))
	   (q1-a Decl       (NameA (array (char) (0 10000))))
	   (q1-b Zero       (IndexA (int)))
	   (q1-f Assign (NameB (array (char))) (IndexB (int))
		 (ElemA (char)) )
	   (q1-h Not-Equals (ElemC (char)) (NULL (char)) (ResultB (boolean)))
	   )
  	  (
	   (before-p    (q1-c q1-d))    
	   (close-to-p  (q1-c q1-d) 10)
	   (before-p    (q1-d q1-g))
	   (same-name-p (q1-d q1-e) (Block1 Block2))
	   (before-p    (q1-g q1-e))
	   
	   (before-p    (q1-b q1-c))    
	   (before-p    (q1-a q1-b))    
	   (before-p    (q1-b q1-h))    
	   (before-p    (q1-d q1-e))    
	   (before-p    (q1-f q1-h))    
	   (before-p    (q1-g q1-i))    
	   (before-p    (q1-d q1-i))
	   (before-p    (q1-i q1-e))
	   (same-name-p (q1-c q1-h) (ResultA ResultB))
	   (same-name-p (q1-f q1-h) (ElemA ElemC))
	   (same-name-p (q1-a q1-f) (NameA NameB))
	   (same-name-p (q1-a q1-g) (NameA NameC))
	   (same-name-p (q1-b q1-f) (IndexA IndexB))
	   (same-name-p (q1-b q1-g) (IndexA IndexC))
	   (same-name-p (q1-b q1-i) (IndexA IndexD))
	   ))
	  
       '( "adt-t2"
	  (
	   (t2-a Decl  (NameA  (array (char) (25 200))))
	   (t2-b For   (index1 (int))          (initVal (int)) (endVal (int)))
	   (t2-c Begin (Block1 (block)))
	   (t2-d Print (NameD (array (int char))) (index2 (int)))
	   (t2-e End   (Block2 (block)))
	   )
	  (
	   (before-p    (t2-a t2-b))
	   (before-p    (t2-b t2-c))
	   (before-p    (t2-c t2-d))
	   (before-p    (t2-d t2-e))
	   (same-name-p   (t2-c t2-e) (Block1 Block2))
	   (same-name-p   (t2-a t2-d) (NameA  NameD))
	   (same-name-p   (t2-b t2-d) (index1 index2))
	   (close-to-p    (t2-b t2-c) 15)
	   ))

       '( "adt-t1"
	  (
	   (t1-a Decl   (NameA (array (int char) (10 100))))
	   (t1-b Decl   (NameB (int)))
	   (t1-c Decl   (NameC (int char)))
	   (t1-d Zero   (NameD (array (int char))) (IdxD (int)))
	   (t1-e Assign (NameE (array (int char))) (IdxE (int))
		 (ElemE (int char)))
	   )
	  (
	   (before-p    (t1-a t1-d))
	   (before-p    (t1-b t1-d))
	   (before-p    (t1-c t1-e))
	   (before-p    (t1-d t1-e))

	   (same-name-p  (t1-d t1-a) (NameD NameA))
	   (same-name-p  (t1-b t1-d) (NameB IdxD))
	   (same-name-p  (t1-e t1-c) (ElemE NameC))
	   (same-name-p  (t1-e t1-b) (IdxE  NameB))
	   (same-name-p  (t1-f t1-a) (NameE NameA))
	   ))

       '( "adt-clct1"
	  (
	   (t1-a Decl   (TypeA (struct)))
	   (t1-a Decl   (PtrA (pointer (struct TypeA))))
	   (t1-a Decl   (NameA (pointer (struct) ))) 
	   )
	  (
	   (before-p    (t1-a t1-d))
	   (struct-contains TypeA ( (StrPtr (pointer (struct TypeA)))
				    (StrVal (int char))
				    ))
	   (same-name-p  (t1-d t1-a) (NameD NameA))
	   ))
       ))

;;	   (same-type-elem-array-p  (t1-e t1-a) (ElemE NameA))
;;	   (same-type-p  (t1-d t1-a) (NameD NameA))
;;	   (same-type-p  (t1-f t1-a (NameE) NameA))

;; (t1-f Print  (NameF (array (int char))) (IdxF (int)))
;; (t1-g Print  (NameG (int char)))
;;
;; ( t1-?  For  (index (int)) (initVal (int)) (endVal (int)))