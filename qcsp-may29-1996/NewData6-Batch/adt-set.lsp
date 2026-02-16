;; adt-setup.lisp
(defun cadts () (compile-file "adt-setup")  (load "adt-setup"))
(defun ladts () (load "adt-setup.lisp"))
(defun madts () (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:adt-setup.lisp"))
;;
;; ADT legacy situation and template descriptions
;;

(setq *debug-local* nil)

(setq *adt-setup-loaded* 'nil)
(setq HERE 0)

;; legacy instantiation of example(s)
;;
;; (lineid  linenumber  Stmt )
;;

;;(defconstant *situations*
(setq *situations*
      (list
       '( "q-i1"
	  (adtq1-a 100 (Decl       array  A    char   99  ))
	  (adtq1-b 200 (Zero       Idx                    ))
	  (adtq1-c 300 (While      Result                 ))
	  (adtq1-d 310 (Begin      block1                 ))
	  (adtq1-g 400 (Assign     A      Idx  ElemB      ))
	  (adtq1-i 500 (Increment  Idx                    ))
	  (adtq1-e 600 (End        block1                 ))
	  (adtq1-f 700 (Assign     A      Idx  Elem       )) 
	  (adtq1-h 800 (Not-Equals Elem   NULL Result     ))
	  )

       '( "q-i2"
	  (adtq1-a 100 (Decl       array  A    char   99  ))
	  (adtq1-b 200 (Zero       Idx                    ))
	  (adtq1-c 300 (While      Result                 ))
	  (adtq1-d 310 (Begin      block1                 ))
	  (adtq1-g 400 (Assign     A      Idx  ElemB      ))
	  (adtq1-i 500 (Increment  Idx                    ))
	  (adtq1-e 600 (End        block1                 ))
	  (adtq1-f 700 (Assign     A      Idx  Elem       )) 
	  (adtq1-h 800 (Not-Equals Elem   NULL Result     ))

	  (adtq2-a 1100 (Decl       array  A2   char   99  ))
	  (adtq2-b 1120 (Zero       Idx2                   ))
	  (adtq2-c 1140 (While      Result2                ))
	  (adtq2-d 1145 (Begin      block2                 ))
	  (adtq2-g 1165 (Assign     A2     Idx2  ElemB2    ))
	  (adtq2-i 1185 (Increment  Idx2                   ))
	  (adtq2-e 1205 (End        block2                 ))
	  (adtq2-f 1225 (Assign     A2     Idx2  Elem2     )) 
	  (adtq2-h 1245 (Not-Equals Elem2  NULL Result2    ))
	  )

       '( "h-i1"
	  (adtq1-a  100  (Decl       array  A     char   99 ))
	  (adtq1-a2 200  (Decl       char   ElemB           ))
	  (adtq1-a3 300  (Decl       char   Elem            )) 
	  (adtq1-a4 350  (Decl       char   NEWLINE         )) 
	  (adtq1-b  400  (Zero       Idx                    ))
	  (adtq1-c  500  (While      Result                 ))
	  (adtq1-d  510  (Begin      block1                 ))
	  (adtq1-g  600  (Assign     A      Idx  ElemB      ))
	  (adtq1-p1 700  (Print      ElemB                  ))
	  (adtq1-i  800  (Increment  Idx                    ))
	  (adtq1-f  900  (Assign     A      Idx  Elem       )) 
	  (adtq1-h 1000 (Not-Equals  Elem   NULL Result     ))
	  (adtq1-e 1100 (End         block1                 ))
	  (adtq1-p2 1200 (Print      NEWLINE                 ))
	  )

       '( "h-i2"
	  (adtq1-a  100  (Decl       array  A     char   99 ))
	  (adtq1-a2 200  (Decl       char   ElemB           ))
	  (adtq1-a3 300  (Decl       char   Elem            )) 
	  (adtq1-a4 350  (Decl       char   NEWLINE         )) 
	  (adtq1-b  400  (Zero       Idx                    ))
	  (adtq1-c  500  (While      Result                 ))
	  (adtq1-d  510  (Begin      block1                 ))
	  (adtq1-g  600  (Assign     A      Idx  ElemB      ))
	  (adtq1-p1 700  (Print      ElemB                  ))
	  (adtq1-i  800  (Increment  Idx                    ))
	  (adtq1-f  900  (Assign     A      Idx  Elem       )) 
	  (adtq1-h 1000 (Not-Equals  Elem   NULL Result     ))
	  (adtq1-e 1100 (End         block1                 ))
	  (adtq1-p2 1200 (Print      NEWLINE                 ))

	  (adtq2-a  1500  (Decl       array  A2     char   99 ))
	  (adtq2-a2 1520  (Decl       char   ElemB2           ))
	  (adtq2-a3 1540  (Decl       char   Elem2            )) 
	  (adtq2-b  1580  (Zero       Idx2                    ))
	  (adtq2-c  1600  (While      Result2                 ))
	  (adtq2-d  1605  (Begin      block2                 ))
	  (adtq2-g  1625  (Assign     A2      Idx2  ElemB2      ))
	  (adtq2-p1 1645  (Print      ElemB2                  ))
	  (adtq2-i  1665  (Increment  Idx2                    ))
	  (adtq2-f  1685  (Assign     A2      Idx2  Elem2       )) 
	  (adtq2-h  1705  (Not-Equals  Elem2   NULL Result2     ))
	  (adtq2-e  1725  (End         block2                 ))
	  (adtq2-p2 1745  (Print      NEWLINE                 ))
	  )

        '( "adt-t1-1"
	   ( adt1-1a  100 (Decl    array arr1 int 25 ))
	   ( adt1-1b  200 (Decl    int   index1      ))
	   ( adt1-1c  300 (Decl    int   val1        ))
	   ( adt1-1d  400 (Zero    arr1  index1      ))
	   ( adt1-1e  500 (Assign  arr1  index1 val1 ))
	   )

	'( "adt-t2-1"
	   ( adt2-1a  10  (Decl  array A      char  30      ))
	   ( adt2-1b  20  (Decl  array B      char  75      ))
	   ( adt2-1c  30  (Decl  array C      char  100     ))
	   ( adt2-1d  40  (For   I     start1 end1          ))
	   ( adt2-1d1 50  (Begin block1                     ))
	   ( adt2-1d2 60  (Print A     I                    ))
	   ( adt2-1d3 70  (End   block1                     ))
	   ( adt2-1e  140 (For   J     start2 end2          ))
	   ( adt2-1e1 150 (Begin block2                     ))
	   ( adt2-1e2 160 (Print B     J                    ))
	   ( adt2-1e3 170 (End  block2                      ))
	   ( adt2-1f  240  (For   K    start3 end3          ))
	   ( adt2-1f1 250  (Begin block3                    ))
	   ( adt2-1f2 260  (Print C    K                    ))
	   ( adt2-1f3 270  (End   block3                    ))
	   )
	))


;; ( adt1-1f  50 (Print  name ))
;; ( adt1-1f  50 (Print  arrName index))
;; ( adt1-1f  50 (Print  arrName index))
;; ( adt1-1f  50 (Check  name name))
;; ( adt1-1f  50 (For    index initVal endVal Sub-Sit-Obj
;;                                            ( adt1-1f  51 (Zero  ... ) )
;;                                            ( adt1-1f  51 (Assign... ) )
;;                                            ( adt1-1f  51 (Print arrName...))
;; ( dt1-1f  50 (For  idx1 initVal endVal (adt1-1f 51 (Zero  bA1 idx1))) )

;;  for (i= N..M)
;;    printf("%s",B[i]);
;;
;; 	     ( adt1-?  99 (For index initVal endVal Stmt))
;;           Stmt one of Assign, Zero, Print w/ index used
;;     ie/ (Assign baseArray index newVal)  where newVal is sameType as baseArr
;;     ie/ (Zero   baseArray index)
;;     ie/ (Print  baseArray index)

;; 1. stmt-type-list  2. decl-type-list  3. decl-type-list w/o array


;;(defconstant *distributions*
(setq *distributions*
      '(
	( "dist1" 
	  ( 
	   (While      1) 
	   (Zero       1) 
	   (Block      2) 
	   (Increment  2) 
	   (Not-Equals 2) 
	   (Assign     3) 
	   (Decl       4) 

	   (For        1) 
	   (Print      2) 
	   (Check      4) 
	    )
	  ( (array 1) (int 2) (char 2) (real 1) (boolean 1) )
	  ( (int 2)  (char 2) (real 1) (boolean 1) ) )

	( "dist2" 
	  ( 
	   (While      1) 
	   (Zero       1) 
	   (Block      1) 
	   (Increment  1) 
	   (Not-Equals 1) 
	   (Assign     1) 
	   (Decl       1) 

	   (For        1) 
	   (Print      1) 
	   (Check      1) 
	    )
	  ( (array 1) (int 1) (char 1) (real 1) (boolean 1) )
	  ( (int 1)  (char 1) (real 1) (boolean 1) ) )

	( "dist3" 
	  ( 
	   (While      1) 
	   (Zero       1) 
	   (Block      2) 
	   (Increment  2) 
	   (Not-Equals 2) 
	   (Assign     30) 
	   (Decl       30) 

	   (For        1) 
	   (Print      2) 
	   (Check      4) 
	    )
	  ( (array 1) (int 2) (char 2) (real 1) (boolean 1) )
	  ( (int 2)  (char 2) (real 1) (boolean 1) ) )

	( "old-dist1-pre-quilici"
	  (
	   ((Decl   1) 
	    (Zero   1) 
	    (Assign 1) 
	    (Print  1) 
	    (Check  1) 
	    (For    1) 
	    (Block  1))
	   ((array 1) (int 2) (char 2) (real 1) (boolean 1) )
	   ((int 2)  (char 2) (real 1) (boolean 1) )
	   ))
))

;;	     

;; **********************************************************************
;; All template options
;;
;;  note that the order in which constraints are listed here will determine
;;   the order in which they are checked in absence of a request to sort
;;   them before application time.
;; 
;; adt-t1
;;   t1-a decl array A (int or char) [N]  where n>9,<101 
;;   t1-b decl int B
;;   t1-c decl C (int or char)
;;   t1-d $D[IdxD] = nil   ;where D==A,IdxD==B,Type(D)=Type(A),
;;                   Type(IdxD)=int implicit
;;   t1-e $E[IdxE] = $ParE ;where E==A,IdxE==B,ElemE==C,Type(E)=ArrType(A),
;;                   Type(IdxE)=int implicit
;;   t1-f print $F[IdxF] ;where F==A,IdxF==B,Type(F)=Type(A),
;;                   Type(IdxF)=int implicit
;;   t1-g print $G ;where G==?, Type(G)=(int char)
;;        

;;(defconstant *template-object-list* 
(setq *template-object-list* 
      (list 
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