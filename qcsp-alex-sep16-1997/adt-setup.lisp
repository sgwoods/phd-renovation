(in-package #:phd-qcsp-alex)
#+sbcl (declaim (sb-ext:muffle-conditions sb-kernel:redefinition-warning))
;; adt-setup.lisp
(defun cadts () (compile-file "adt-setup")  (load "adt-setup"))
(defun ladts () (load "adt-setup.lisp"))
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
       '( "quilici-i1"
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

;; ***************************************************************************
;; Quilici templates (restored from qcsp3 for memory-search/ADT testing).
;; Additional C-program templates are in adt-template.lisp (yjzhang extension).
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

;; ***************************************************************************
;; Functions to create N random program statements (situation objects)
;;  note we cannot re-use statement numbers ....
;; 

(defun create-ran-situation (size-sit stmt-types types array-types)
  (let (
	(newlist  nil)
	)
    (setq *ran-stmt-type-lst*      (create-random-lst stmt-types))
    (setq *ran-decl-type-lst*      (create-random-lst types))
    (setq *ran-array-type-lst*     (create-random-lst array-types))

    (dotimes (n size-sit newlist)
      (setq newlist  (append (ran-sit-objects)  newlist)))

    newlist
    ))

(defun create-random-lst (prop-lst)
  (let ( (in-prog nil )	)
    (dolist (this prop-lst in-prog)
      (setq in-prog (append (n-vals (first this) (second this)) in-prog)) )))

(defun n-vals (what many)
  (let ( (newlist nil) )
    (dotimes (n many newlist)
      (setq newlist (cons what newlist)))))


(defun ran-sit-objects ()
"Create a random situation object as *noise* for the Situation."
  (let (
	(stype (random-element *ran-stmt-type-lst*))
	(sid   (create-sit-id))
	(sloc  (get-line-number))
      )

(cond

  ( (eq stype 'Decl)
    (progn
      (list (generate-ran-Decl sid sloc)) 
      ))

  ( (eq stype 'Zero)
    (progn
      (list (generate-ran-Zero sid sloc))
      ))

  ( (eq stype 'Assign)
    (progn
      (list (generate-ran-Assign sid sloc))
      ))

  ( (eq stype 'Increment)
    (progn
      (list (generate-ran-Increment sid sloc))
      ))

  ( (eq stype 'While)
    (progn
      (generate-ran-While sid sloc)
      ))
	
  ( (eq stype 'Not-Equals)
    (progn
      (list (generate-ran-Not-Equals sid sloc))
      ))

  ( (eq stype 'Print)
    (progn
      (list (generate-ran-Print sid sloc))
      ))
  
  ( (eq stype 'Check)
    (progn
      (list (generate-ran-Check sid sloc))
      ))

  ( (eq stype 'For)
    (progn
      (generate-ran-For sid sloc)
      ))
  
  ( (eq stype 'Block)
    (progn
      (generate-ran-Block sid sloc)
      ))

  ( t
    (progn
      'error
    ))
  )))

(setq HERE 2)

(defun generate-ran-Decl (sid sloc)
  (let (
	(declName (create-var-name))
	(declType (random-element *ran-decl-type-lst*))
	)
    (if (eq declType 'array)
	(let (
	      (typeOfarray (random-element *ran-array-type-lst*))
	      (sizeOfarray (random *max-array-size*))
	      )
	  (setq *current-array-list* (cons (list declName 
						 typeOfarray
						 sizeOfarray)
					   *current-array-list*))
	  (list sid sloc 
		(list 'Decl 'array declName typeOfarray sizeOfarray)))
      (progn
	(if (eq declType 'int)
	    (setq *current-int-list* (cons declName *current-int-list*))
	  (if (eq declType 'char)
	      (setq *current-char-list* (cons declName *current-char-list*))
	    (if (eq declType 'real)
		(setq *current-real-list* (cons declName *current-real-list*))
	      (if (eq declType 'boolean)
		  (setq *current-boolean-list* (cons declName
						     *current-boolean-list*))
		(abort-fail "type-record-error" )))))
	(list sid sloc
	      (list 'Decl declType declName)) ))))

(defun generate-ran-int  ()
  (let (
	(newIntName (create-var-Name))
	)
    (setq *current-int-list* (cons newIntName *current-int-list*))
    newIntName))

(defun generate-ran-bool  ()
  (let (
	(newBoolName (create-var-Name))
	)
    (setq *current-boolean-list* (cons newBoolName *current-boolean-list*))
    newBoolName))
	  
(defun generate-ran-Zero (sid sloc &optional 
		      (index (get-rand-int))
		      (basePair  (random-element *current-array-list*)) )
  (if (eq (random 2) 1)
      (let* (
	     (baseArray (first basePair))
	     (baseType  (second basePair))
	     (index     (get-rand-int))
	     )
	(list sid sloc (list 'Zero baseArray index)))
    (let* (
	   (type (random-element *ran-array-type-lst*))
	   (base (get-rand-instance type))
	   )
      (list sid sloc (list 'Zero base )))))

(defun generate-ran-Increment (sid sloc &optional 
		      (index (get-rand-int))
		      (basePair  (random-element *current-array-list*)) )
  (if (eq (random 2) 1)
      (let* (
	     (baseArray (first basePair))
	     (baseType  (second basePair))
	     (index     (get-rand-int))
	     )
	(list sid sloc (list 'Increment baseArray index)))
    (let* (
	   (type (random-element *ran-array-type-lst*))
	   (base (get-rand-instance type))
	   )
      (list sid sloc (list 'Increment base )))))

(defun generate-ran-Assign (sid sloc &optional 
			(index (get-rand-int))
			(basePair (random-element *current-array-list*)))
  (if (eq (random 2) 1)
      (let* (
	     (baseArray (first basePair))
	     (baseType  (second basePair))
	     (newval    (get-rand-instance baseType))
	     )
	(list sid sloc (list 'Assign baseArray index newVal)))
    (let* (
	   (type (random-element *ran-array-type-lst*))
	   (base   (get-rand-instance type))
	   (newVal (get-rand-instance type))
	   )
      (list sid sloc (list 'Assign base newVal)))))

(defun generate-ran-Not-Equals (sid sloc )
  (let* (
	 (baseType  (random-element *ran-decl-type-lst*))
	 (val1      (get-rand-instance baseType))
	 (val2      (get-rand-instance baseType))
	 (sel       (random 2))
	 (assign    (generate-ran-new-bool))
	 )
    (list sid sloc (list 'Not-Equals val1 val2 assign))
    ))

(defun generate-ran-Print-nonArr (sid sloc)
  (let* (	
	 (someType (random-element *ran-array-type-lst*))
	 (element (get-rand-instance someType))
	 )
    (list sid sloc (list 'Print element))))

(setq HERE 3)

(defun generate-ran-Print-arr (sid sloc &optional (index (get-rand-int)))
  (let (
	(ar (get-rand-exist-array))
	)
    (list sid sloc (list 'Print ar index))))

(defun generate-ran-Print (sid sloc &optional (index 'firstint))
  "if given an index, always print an array"
  (if (and (eq (random 2) 0) (eq index 'firstint))
      (generate-ran-Print-nonArr sid sloc)
    (generate-ran-Print-arr sid sloc index)))

(defun generate-ran-Check (sid sloc)
" Some random function with random types of parameters"
  (let* (
	 (someType1 (random-element *ran-decl-type-lst*))
	 (element1  (get-rand-instance someType1))
	 (someType2 (random-element *ran-decl-type-lst*))
	 (element2  (get-rand-instance someType2))
	)
    (list sid sloc (list 'Check element1 element2) )))

(defun generate-ran-Block (sid sloc)
" Some random function with random types of parameters"
  (let* (
	 (max-begin-space   25)            

	 (block-name (create-block-name))
	 (end-sid    (create-sit-id))
	 (end-sloc   (get-specific-line
		      (+ sloc (random max-begin-space))))
	)
    (list
     (list sid     sloc      (list  'Begin block-name ))
     (list end-sid end-sloc  (list  'End   block-name )))))

(defun generate-ran-Stmt ( sid sloc index basePair baseType)
  "one of Assign, Zero, Print, w/ index used"
  (let ( 
	(sel (random 4))
	)
    (if (eq sel 0)
	(generate-ran-Zero sid (get-specific-line (1+ sloc)) index)
      (if (eq sel 1)
	  (generate-ran-Assign sid (get-specific-line (1+ sloc)) index basePair)
	(if (eq sel 2)
	    (generate-ran-Increment sid (get-specific-line (1+ sloc)) index)
	  (generate-ran-Print-arr sid (get-specific-line (1+ sloc)) index))))))

(defun generate-ran-For (sid sloc)
  (let* (
	 (max-begin-space   14)              ;; how much room in the for ?

	 (other-sid  (gentemp "other-sid"))
	 (other-sloc (get-specific-line
		      (+ (1+ (random max-begin-space)) sloc)))   ;; ie 1 to 14 diff

	 (block-name (create-block-name))
	 (begin-sid  (gentemp "begin-sid"))
	 (begin-sloc (get-specific-line 
		      (1+ sloc)))              ;; begin right after for

	 (end-sid  (gentemp "end-sid"))
	 (end-sloc (get-specific-line
		    (1+ other-sloc)))

	 (index     (generate-ran-int))
	 (basePair  (random-element *current-array-list*))
	 (baseArray (first  basePair))
	 (baseType  (second basePair))
	 (baseSize  (third  basePair))
	 (initVal   (random (1+ baseSize)))
	 (endVal    (random (1+ baseSize)))
	 (inloop-stmt (generate-ran-Stmt 
		       other-sid other-sloc index basePair baseType))
	)

    (setq *current-block-list* (cons block-name *current-block-list*))

    (list (list sid sloc (list 'For index initVal endVal))
	  (list begin-sid begin-sloc (list 'Begin block-name ))
	  inloop-stmt
	  (list end-sid end-sloc (list 'End block-name ))
	  )) )

(defun generate-ran-While (sid sloc)
  (let* (
	 (max-begin-space   14)              ;; how much room in the while ?

	 (begin-sid  (gentemp "begin-sid"))
	 (begin-sloc (get-specific-line (1+ sloc)))     ;; begin right after while
	 (other-sloc (get-specific-line
		      (+ (1+ (random max-begin-space)) sloc)))
	 (block-name (create-block-name))
  	 (end-sid  (gentemp "end-sid"))
	 (end-sloc (get-specific-line (1+ other-sloc)))
	 (condition (generate-ran-new-bool))
	 )
	 
    (setq *current-block-list* (cons block-name *current-block-list*))

    (list
     (list sid sloc (list 'While condition))
     (list begin-sid begin-sloc (list 'Begin block-name ))
     (list end-sid   end-sloc   (list 'End   block-name ))
     )))

;; 
;; ---------------------------------------------------------------------------
;; 

(defun generate-ran-new-bool ()
  (let* (
	 (len  (length *current-boolean-list*))
	 (pick (random 2))
	 )
    (if (eq pick 0)
	(random-element *current-boolean-list*)
      (generate-ran-bool))))
	
;; 
;; ---------------------------------------------------------------------------
;; 

(defun create-var-name()
"Create unique variable name"
  (gentemp "var-name"))

(defun create-block-name()
"Create unique block name"
  (gentemp "block"))
  
(defun create-sit-id ()
"Create unique situation identifier."
  (gentemp "sit-gen"))

(defun random-element (elist)
"Return a random element from a list."
  (nth (random (length elist)) elist))

(defun random-order (elist)
"Re-order a list in random order"
(if (null elist)
    nil
  (let (
	(pos (random (length elist)))
	)
    (append (list (nth pos elist))
	    (random-order (remove (nth pos elist) elist)) )
    )) )

(defun random-position (&optional (boundx *max-line-number*))
"
 Generate a random x position less than boundx.
"
 (random boundx))

;; ---------------------------------------------------------------------------

(defun get-rand-exist-array ( )
  (first (random-element *current-array-list*)))

(defun get-rand-exist-array-type ( type )
  (random-element (restrict-array-list type)))

(defun restrict-array-list ( type )
  (remove-if #'(lambda (x) (not (eq (second x) type)))
	     *current-array-list*))

(defun remove-types-from-param-list ( param-list )
"Decl stmt sit objects have a param list with types, get rid of them"
  (remove-if #'(lambda (x) (is-type-p x)) param-list ))

(defun is-type-p ( x )
" True if x is a defined type keyword"
 (member x (cons 'block *actual-type-lst*)))

(defun simplify-types ( xlist )
  (if (null xlist)
      nil
    (append (list (caar xlist)) (simplify-types (cdr xlist)))))

(defun get-rand-int( )
  (random-element *current-int-list*))

(defun get-rand-char( )
  (random-element *current-char-list*))

(defun get-rand-real( )
  (random-element *current-real-list*))

(defun get-rand-boolean( )
  (random-element *current-boolean-list*))

(defun get-rand-block( )
  (random-element *current-block-list*))

(defun get-rand-instance (type)
  (if (eq type 'int)
      (get-rand-int)
    (if (eq type 'char)
	(get-rand-char)
      (if (eq type 'real)
	  (get-rand-real)
	(if (eq type 'boolean)
	    (get-rand-boolean)
	  (if (eq type 'array)
	      (get-rand-exist-array)
	  (if (eq type 'block)
	      (get-rand-block)
	    (progn
	      (comment2 "GRI type = " type)
	      (abort-fail "type-record-error in GRI"))
	    )))))))

;; ***************************************************************************
;; Functions to display objects
;; ***************************************************************************

(defun show (&optional (tid *template-id*) (sid *sit-object-id*))
  (show-situation sid) 
  (show-template tid)
  )

(defun show-template ( &optional (template-id *template-id*))
  (let (
	(template (get-templ-object template-id))
	)

    (if (eq template nil)
	nil
      (if (not (eq *output-stream* nil))
	  (let ()
	    (format *output-stream*
		    "~2&**** ~A ADT Template Description **** ~2&" template-id)
	    (format *output-stream*
		    "~&~& Template Slots : ~A ~&" (length 
						   (get-templ-slots template)))
	    (dolist (ts (get-templ-slots template))
	    (format *output-stream* "~&~&    Slot: ~A ~&" ts))
	    (format *output-stream*
		    "~&~& Constraints: ~A ~&" (length 
					     (get-templ-constraints template)))
	    (dolist (c (get-templ-constraints template))
	      (format *output-stream* "~&~& Constraint: ~A ~&" c))

	    ))))
  t)
	
(defun show-situation ( &optional (situation-id *sit-object-id*))
  (let (
	(situation (get-situation situation-id *situations*))
	)

    (if (eq situation nil)
	nil
      (if (not (eq *output-stream* nil))
	  (let ()
	    (format *output-stream*
		    "~2&***** ~A Situation Description ***** ~2&" situation-id)
	    (format *output-stream*
		    "~&~& Situation elements : ~A ~&" (length situation) )
	    (dolist (sit situation)
		    (format *output-stream* "~&~&    Element: ~A ~&" sit))
	    )))))

(defun print-instance (&optional (sit-list *current-situation*))
" Iterate through list printing situation elements one at a time "
(if (not (eq *output-stream* nil))
    (if (null sit-list) 
	(format *output-stream* "End.~2&")
      (let* (
	     (line (car sit-list))
	     (id   (first line))
	     (no   (first (second line)))
	     (stmt (third line)) )

	(format *output-stream* "~& #~A ~A ~A~&" no id stmt)
	(print-instance (cdr sit-list))))))


(defun print-instance2 ()
" Iterate through list showing FULL situation elements one at a time "
  (let (
	(situation *current-situation*)
	)

    (if (eq situation nil)
	nil
      (if (not (eq *output-stream* nil))
	  (let ()
	    (format *output-stream*
		    "~2&***** CURRENT Situation Description ***** ~2&")
	    (format *output-stream*
		    "~&~& Situation elements : ~A ~&" (length situation) )
	    (dolist (sit situation)
	      (format *output-stream* "~&~&    Element: ~A ~&" sit))
	  
	    ))))
  t)

(defun adt-set-global-values (sit-id sit-noise 
				     random-ident temp-id   
				     rand-dist-id rand-dist-struct
				     long-output single-line-override 
				     suppress-single-line)
"
ADT problem set up.
"
(let (
      (adt-err nil)
      )

  ;; ------------------------------------------------------------------------
  ;;
  ;;

    ;; ------------------------------------------------------------------------
  ;; Situation setup 
  (if (not (equal (situation-setup sit-id 
				   sit-noise 
				   random-ident
				   rand-dist-id
				   rand-dist-struct
				   ) 
		  t))
      (progn
	(setq adt-err t)
	(comment1 "Situation setup error occurred." situation-setup)
	))

  ;; ------------------------------------------------------------------------
  ;; Template setup
;;  (format t "temp-id: ~a Going to set current-template as ~a~%" temp-id *override-template*) 
  (if (equal temp-id "special")
      (setq *current-template* *override-template*)
    (setq *current-template* 
	  (get-templ-object temp-id)))

  (if (eq *current-template* nil)
      (progn
	(setq adt-err t)
	(comment1 "Template not found or nil" temp-id)
	))
  (setq *template-id* temp-id)


  ;; ------------------------------------------------------------------------
  ;; output options

  ;; Output long option
  (setq *long-output* long-output)

  ;; Override output option
  (setq *single-line-override* single-line-override)

  ;; Override even a single line, output mapping only (solution-set)
  (setq *suppress-single-line* suppress-single-line)


  ;; ------------------------------------------------------------------------
  ;; specific counters for adt only  .... 
  (setq *constraint-before-cks* 0)    ;; before constraints
  (setq *constraint-same-name-cks* 0)
  (setq *constraint-close-to-cks* 0)
  (setq *constraint-same-type-cks* 0)
 
  (setq *constraint-sameline-cks* 0)     ;; Added by Yongjun Zhang  updt Apr/97
  (setq *constraint-iszero-cks* 0)   
  (setq *constraint-possible-data-dependency-cks* 0)
  (setq *constraint-guaranteed-data-dependency-cks* 0)
  (setq *constraint-same-data-dependency-cks* 0)
  (setq *constraint-control-data-dependency-cks* 0)
  (setq *constraint-same-variable-cks* 0)
  (setq *constraint-contained-in-condition-cks* 0)
  (setq *constraint-contained-in-true-cks* 0)
  (setq *constraint-contained-in-false-cks* 0)
  (setq *constraint-contained-in-loop-cks* 0)
 
;;two new counters follow
  (setq *constraint-success* 0)
  (setq *constraint-failure* 0)

  ;; ------------------------------------------------------------------------
  ;; old mpr constraints
  (setq *constraint-sch-cks* 0)    ;; spatial cohes constraints
  (setq *sch-save* 0)              ;; spatial cohes savings - dom vals remv
  (setq *constraint-pos-cks* 0)    ;; right/left/ahead/behind constraints
  (setq *constraint-med-cks* 0)    ;; medial  constraints
  (setq *constraint-ech-cks* 0)    ;; echelon constraints
  (setq *constraint-same-orient-cks* 0)
  (setq *constraint-same-activity-cks* 0)
  (setq *constraint-same-size-cks* 0)

  ;; ------------------------------------------------------------------------
  ;;
  (setq *node-consistency-calls*  0)  ;; cost of initial filtering
  (setq *node-consistency-checks* 0)
  (setq *node-type-consistency-checks* 0)
  (setq *node-type-consistency-ck-ok* 0)
  (setq *node-type-consistency-ck-fail* 0)

  (setq *ts-match-type-count*     0)

  (setq *unique-restrict-count* 0) ;; uniqueness rejections

 (if adt-err
     nil
   t)
))

;; ---------------------------------------------------------------------------
;; line number manipulation routines
;;

(defun get-label-line-number ( line )
  (second (second line)))

(defun get-actual-line-number ( line )
  (first (second line)))

;; Restructure situation example to expected format after noise insertion
;;
(defun restructure-line-numbers ( lines )
  (let* (
	 (sorted-lines     (srt  lines))
	 )
    (renumber sorted-lines)))

; sort by line number
(defun srt ( lines ) 
  (let ( 
	(cplist (copy-list lines))
	)
    (sort cplist #'(lambda (x y) (< (second x) (second y) )))))

(defun renumber ( lines )
  (renumberC lines 0))
(defun renumberC ( lines n )
  (if (null lines)
      lines
    (let*
	(
	 (this      (car lines))
	 (this-1    (first this))
	 (this-2    (second this))
	 (this-rest (cddr this))
	 (rest      (cdr lines))
	 (newone    (append (list this-1 (list n this-2)) this-rest))
	 )
      (cons newone (renumberC rest (1+ n))))) )

;;; save versions for ADT

(defun save-situation ( name size )
"
(ADT version : code replaced in adt-setup function situation-setup.
"
  (comment2 "Error - this function should no longer be called via ADT code." 
            name size)

   nil)

(defun save-rand ( name )
"
Save current random-state object for later recreation of this run.
"
(let* (
       (random-file
	(concatenate 'string "ADT-Random/Rnd"
		     (string-downcase (string name))))
      )
  (setq *random-stream*
	(open random-file 
	      :direction :output 
	      :if-exists :error
	      :if-does-not-exist :create))
  (write *random-state* :stream *random-stream*)
  (close *random-stream*)
  ))

(defun load-rand (name)
"
Reload previously stored random-state object for recreation of previous run.
Changed Oct/94	 (nstring-downcase (string name))
"
(let* (
       (random-file (concatenate 'string "ADT-Random/Rnd"
				 (string-downcase (string name))))
       (random-stream (open random-file :direction :input))
      )
  (setq *random-state* (read random-stream))
  (close random-stream)
  ))

(defun unique-string ()
"
Create a unique string identifier to be used as a pathname for a Random ident file.  
Only return one that does not already exist.
"
(let (
      (newstr nil)
      (unique nil)
      )
  (loop 

   (if unique (return))

   (setq newstr nil)
   (dotimes (i 10)
	    (let (
		  (this (random 10))
		  )
	      (setq newstr (concatenate 'string newstr (num-to-letter this)))))
   
   (if (not (probe-file (concatenate 'string "ADT-Random/Rnd" 
				     (string-downcase (string newstr)))))
       (setq unique t)))
  newstr))

; (gnuplot ?) output specific to ADT

;; **************************************************
;;
(defun save-gnuplot ( name size )
"
(ADT  Version)
Output gnuplot suitable files for later display
of individual situations.
"
(let* (
       (type-red       (select-type 'AIHQ    *current-situation*))
       (type-green     (select-type 'ARM     *current-situation*))
       (type-purple    (select-type 'ARI     *current-situation*))
       (type-yellow    (select-type 'ART     *current-situation*))
       (red-file       (concatenate 'string "ADT-Situation/.Sit" 
			    "-" (string-downcase (string *sit-object-id*)) 
			    "-" (string-downcase (string *random-dist-name*)) 
			    "-" (string-downcase (string name)) 
			    "-" (num-to-string size) "." "r"))
       (green-file     (concatenate 'string "ADT-Situation/.Sit" 
			    "-" (string-downcase (string *sit-object-id*)) 
			    "-" (string-downcase (string *random-dist-name*)) 
			    "-" (string-downcase (string name)) 
			    "-" (num-to-string size) "." "g"))
       (yellow-file    (concatenate 'string "ADT-Situation/.Sit" 
			    "-" (string-downcase (string *sit-object-id*)) 
			    "-" (string-downcase (string *random-dist-name*)) 
			    "-" (string-downcase (string name)) 
			    "-" (num-to-string size) "." "y"))
       (purple-file    (concatenate 'string "ADT-Situation/.Sit" 
			    "-" (string-downcase (string *sit-object-id*)) 
			    "-" (string-downcase (string *random-dist-name*)) 
			    "-" (string-downcase (string name)) 
			    "-" (num-to-string size) "." "p"))
      )
  (if (not (probe-file red-file))  ;; have these been created already ?
      (progn
	;; Red
	(setq *gnuplot-stream* (open red-file :direction :output 
				     :if-exists :overwrite
				     :if-does-not-exist :create))
	(dolist (this type-red)
	  (format *gnuplot-stream* "~A~10T~A~&" (first this) (second this)) )
	(close *gnuplot-stream*)

	;; Green
	(setq *gnuplot-stream* (open green-file :direction :output 
				     :if-exists :overwrite
				     :if-does-not-exist :create))
	(dolist (this type-green)
	  (format *gnuplot-stream* "~A~10T~A~&" (first this) (second this)) )
	(close *gnuplot-stream*)

	;; Purple
	(setq *gnuplot-stream* (open purple-file :direction :output 
				     :if-exists :overwrite
				     :if-does-not-exist :create))
	(dolist (this type-purple)
	  (format *gnuplot-stream* "~A~10T~A~&" (first this) (second this)) )
	(close *gnuplot-stream*)

	;; Yellow
	(setq *gnuplot-stream* (open yellow-file :direction :output 
				     :if-exists :overwrite
				     :if-does-not-exist :create))
	(dolist (this type-yellow)
	  (format *gnuplot-stream* "~A~10T~A~&" (first this) (second this)) )
	(close *gnuplot-stream*))
    )))


;; ------------------------------------------------------------------------
;; Setup situation as required.  Reload if available, create if necessary.
;;
(defun situation-setup (sit-id sit-noise
			       random-ident rand-dist-id rand-dist-struct)

  (if (equal sit-id "special")
      ;;
      ;; special case - situation given as an override
      ;;
      (progn
	(setq *current-situation* *override-situation*)
	(return-from situation-setup t)))

  ;; 
  ;; normal case, reload from existing or create
  ;; 
  (let* (
	)
    ;; NOTE: dirstr/situation-file bindings removed — the file
    ;; save/reload code that used them is commented out.

    ;; 
    ;; Flags for noise creation
    ;;
    ;; array-list keeps track of instantiated types for other structs created
    ;;   to be consistent... ie/ more realistic : initially make one value
    ;;   for each type. List of list order is array, int, char, real, boolean

    (setq *current-array-list*   
	  '( (firstArrayI int 20)  (firstArrayC char 15) 
	     (firstArrayR real 50) (firstArrayB boolean 35)))
    (setq *current-block-list*  '( firstBlock ) )
    (setq *current-int-list*  '( firstInt ) )
    (setq *current-char-list* '( firstChar ) )
    (setq *current-real-list* '( firstReal ) )
    (setq *current-boolean-list* '( firstBoolean ) )
    ;; --- Maximums for element creation (noise)
    (setq *max-array-size* 201)

    (setq *sit-object-id*         sit-id)
    (setq *situation-noise-added* sit-noise)
    (setq *random-ident*          random-ident)
    (setq *random-dist-name*      rand-dist-id)
    (setq *random-dist*           rand-dist-struct)
    (setq *actual-type-lst*       (simplify-types (second *random-dist*)))

    ;; April 4/96 modification sgw
    ;; Note this parameter indirectly controls the density of the noise ...
    ;;  that is, the probability that the noise stmts added will intersperse
    ;;  the components of the template(s) we are searching for. 
    ;; (setq *max-line-number* 1000)     ;; THIS NEEDS TO BE SIT DEPENDENT ??
    (setq *max-line-number* 0)

;;    (if (probe-file situation-file)
	(if T 
	;;
	;; already-created, reload from existing saved situation
	;;
;;	(progn   ;; reload condition
;;	  (comment1 "Reload situation from existing file." situation-file)
;;	  (if (not (numberp sit-noise))
;;	      (progn
;;		(comment1 "Sit noise must be a number, cant reload" sit-noise)
;;		(return-from situation-setup nil))
;;	    (if (>= sit-noise 0)
;;		(progn
;;		  (let (
;;			(instream (open situation-file :direction :input))
;;			)
;;		    (comment1 "Opened existing situation file." instream)
;;		    (setq *current-situation* (read instream))
;;		    (close instream)
;;		    (return-from situation-setup t)
;;		    ))
;;	      (progn
;;		(comment1 "Sit noise < 0, cant reload" sit-noise)
;;		(return-from situation-setup nil)
;;		)
;;	      )))
      ;;
      ;; Existing file not found, create and save for later use
      ;;
      (progn  ;; generate condition

	(comment "Initializing a new case")

	; initialize from given starting point
	(setq *current-situation*  (get-situation sit-id *situations*))
	(if (eq *current-situation* nil)
	    (progn
	      (comment1 "Situation not found or empty" sit-id)
	      (return-from situation-setup nil)
	      ))

	;;
	;; generate set of line numbers to draw from in generating noise
	;;
	(setq *orig-nums* (get-orig-nums *current-situation*))

	(setq *max-line-number* (+ (get-max *orig-nums* sit-noise) sit-noise))
	(if *debug-local* (comment1 "Set max line number to " *max-line-number*))

	;; generate entire range of line numbers less solution
	(setq *line-number-set*
	      (remove-nums  *orig-nums* (gen-nums-to 0 *max-line-number*)))

	;; Noise addition to situation
	(if (not (numberp sit-noise))
	    (progn
	      (comment1 "Sit noise must be a number, cant generate" sit-noise)
	      (return-from situation-setup nil)
	      )
	  (if (>= sit-noise 0)
	      (let* (
		     (noise (create-ran-situation
			    sit-noise
			    (first  rand-dist-struct); stmttypes
			    (second rand-dist-struct); types
			    (third  rand-dist-struct); arraytyps
			    ))
		    )

		(setq *current-situation* (append *current-situation* noise))

		;; sort situation list by line number,
		;;  replace old line nos with new
		(setq *original-situation* *current-situation*)
		(setq *current-situation*  (restructure-line-numbers  *current-situation*))
		)
	    (abort-fail "sit-noise < 0")
	    ))

	;; not appropriate at moment for ADT
	;; (save-gnuplot   random-ident sit-noise)

	(return-from situation-setup t)
	))
    ))


;; ---------------------------------------------------------------------------
(setq *adt-setup-loaded* 't)

#+sbcl (declaim (sb-ext:unmuffle-conditions sb-kernel:redefinition-warning))
