(in-package #:phd-qcsp3)
;;
;; Extended example  March 5, 1996 sgw (see notes)
;;

;;
;; This file contains the set up of our illustrative generic CSP example
;; used to describe the behaviour of the four instantiations of hierarchical
;; arc consistency propagation.
;;
;; Defined here are the domain value hierarchies and the inter-value 
;; constraint function.
;;

(defun load-extend (&optional (sys *unix*) )
  (if sys
      (load "example-extend.lisp")
   (load "HD:Languages:Allegro Common Lisp:qcsp:example-extend.lisp")
    ))

;; ***************************************************************************
;;
;; Construct extended example for better testing and back propagation demo
;;    using explicitly generated links ... note this example has been extended
;;    to accomodate the next pointers for the domain lists required by the
;;    stepped revision approach to linking
;;
;; ***************************************************************************

;; ---------------------------------------------------------------------------
;; Variable V1 ranges over A1, A2 and A3

(setq A1 (make-DomVal))
(setq P1 (make-DomVal))
(setq Q1 (make-DomVal))
(setq Q2 (make-DomVal))
(setq P2 (make-DomVal))
(setq Q3 (make-DomVal))
(setq Q4 (make-DomVal))
(setq C1 (make-DomVal))
(setq X1 (make-DomVal))
(setq X2 (make-DomVal))
(setq C2 (make-DomVal))
(setq X3 (make-DomVal))
(setq X4 (make-DomVal))

(setq A2 (make-DomVal))
(setq P3 (make-DomVal))
(setq P4 (make-DomVal))
(setq C3 (make-DomVal))
(setq X5 (make-DomVal))
(setq X6 (make-DomVal))
(setq C4 (make-DomVal))
(setq X7 (make-DomVal))
(setq X8 (make-DomVal))

(setq A3 (make-DomVal))
(setq C5 (make-DomVal))
(setq X9 (make-DomVal))
(setq X10 (make-DomVal))
(setq C6 (make-DomVal))
(setq X11 (make-DomVal))
(setq X12 (make-DomVal))

;; ---------------------------------------------------------------------------
;; Variable V2 ranges over B1, B2 and B3

(setq B1 (make-DomVal))
(setq R1 (make-DomVal))
(setq S1 (make-DomVal))
(setq S2 (make-DomVal))
(setq R2 (make-DomVal))
(setq S3 (make-DomVal))
(setq S4 (make-DomVal))
(setq T1 (make-DomVal))
(setq U1 (make-DomVal))
(setq U2 (make-DomVal))
(setq T2 (make-DomVal))
(setq U3 (make-DomVal))
(setq U4 (make-DomVal))

(setq B2 (make-DomVal))
(setq R3 (make-DomVal))
(setq S5 (make-DomVal))
(setq S6 (make-DomVal))
(setq R4 (make-DomVal))
(setq S7 (make-DomVal))
(setq S8 (make-DomVal))
(setq T3 (make-DomVal))
(setq U5 (make-DomVal))
(setq U6 (make-DomVal))
(setq T4 (make-DomVal))
(setq U7 (make-DomVal))
(setq U8 (make-DomVal))

(setq B3 (make-DomVal))
(setq R5 (make-DomVal))
(setq R6 (make-DomVal))
(setq T5 (make-DomVal))
(setq U9 (make-DomVal))
(setq U10 (make-DomVal))
(setq T6 (make-DomVal))
(setq U11 (make-DomVal))
(setq U12 (make-DomVal)) 

;; ---------------------------------------------------------------------------
;; Variable V3 ranges over E1 and E2

(setq E1 (make-DomVal))
(setq J1 (make-DomVal))
(setq J2 (make-DomVal))
(setq K3 (make-DomVal))
(setq K4 (make-DomVal))
(setq L1 (make-DomVal))
(setq M1 (make-DomVal))
(setq M2 (make-DomVal))
(setq L2 (make-DomVal))
(setq M3 (make-DomVal))
(setq M4 (make-DomVal))

(setq E2 (make-DomVal))
(setq J3 (make-DomVal))
(setq J4 (make-DomVal))
(setq L3 (make-DomVal))
(setq M5 (make-DomVal))
(setq M6 (make-DomVal))
(setq L4 (make-DomVal)) 

(setq *print-circle* t)

(setq V0 (make-CVariable :name 'V0 :DomainValueList (list E1 E2)    :FirstDomainValue E1 ))
(setf (DomVal-MyCVariable     E1)  V0)
(setf (DomVal-MyCVariable     E2)  V0)

(setq V1 (make-CVariable :name 'V1 :DomainValueList (list A1 A2 A3) :FIrstDomainValue A1 ))
(setf (DomVal-MyCVariable     A1)  V1)
(setf (DomVal-MyCVariable     A2)  V1)
(setf (DomVal-MyCVariable     A3)  V1)

(setq V2 (make-CVariable :name 'V2 :DomainValueList (list B1 B2 B3) :FirstDomainValue B1 ))
(setf (DomVal-MyCVariable     B1)  V2)
(setf (DomVal-MyCVariable     B2)  V2)
(setf (DomVal-MyCVariable     B3)  V2)

;; ---------------------------------------------------------------------------
;; R-relation embeds the constraint functions between V0->V1, V1->V2 and V2-V0
;;

(defun R-relation (x y)

  (if (or (listp (DomVal-Name x)) (listp (DomVal-Name y)))
      (progn
	(comment2 "R-relation passed deleted x or y" x y)
	nil
	))

	  (cond 

	   ;; --------------------------------------------------
	   ;; V1 --) V2 function

	   ( (eq (Domval-Name x) 'A1)
	     (cond
	      ( (eq (Domval-Name y) 'B1) 'poss )
	      ( (eq (Domval-Name y) 'B2) 'poss )
	      ( (eq (Domval-Name y) 'B3) 'fail )
	      ( t 'invalid-Y-parameter )))

	   ( (eq (Domval-Name x) 'A2)
	     (cond
	      ( (eq (Domval-Name y) 'B1) 'poss )
	      ( (eq (Domval-Name y) 'B2) 'poss )
	      ( (eq (Domval-Name y) 'B3) 'true )
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'A3)
	     (cond
	      ( (eq (Domval-Name y) 'B1) 'fail )
	      ( (eq (Domval-Name y) 'B2) 'fail )
	      ( (eq (Domval-Name y) 'B3) 'poss )
	      ( t 'invalid-y-parameter )))

	   ;;
	   ;; Up Values ...
	   ;;

	   ( (eq (Domval-Name x) 'P1)
	     (cond
	      ( (eq (Domval-Name y) 'R1) 'fail)
	      ( (eq (Domval-Name y) 'R2) 'poss)
	      ( (eq (Domval-Name y) 'R3) 'poss)
	      ( (eq (Domval-Name y) 'R4) 'fail) 
	      ( (eq (Domval-Name y) 'R5) 'dc) 
	      ( (eq (Domval-Name y) 'R6) 'dc)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'P2)
	     (cond
	      ( (eq (Domval-Name y) 'R1) 'fail)
	      ( (eq (Domval-Name y) 'R2) 'poss)
	      ( (eq (Domval-Name y) 'R3) 'fail)
	      ( (eq (Domval-Name y) 'R4) 'poss) 
	      ( (eq (Domval-Name y) 'R5) 'dc) 
	      ( (eq (Domval-Name y) 'R6) 'dc)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'P3)
	     (cond
	      ( (eq (Domval-Name y) 'R1) 'fail)
	      ( (eq (Domval-Name y) 'R2) 'fail)
	      ( (eq (Domval-Name y) 'R3) 'fail)
	      ( (eq (Domval-Name y) 'R4) 'fail)
	      ( (eq (Domval-Name y) 'R5) 'fail)
	      ( (eq (Domval-Name y) 'R6) 'true)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'P4)
	     (cond
	      ( (eq (Domval-Name y) 'R1) 'fail)
	      ( (eq (Domval-Name y) 'R2) 'poss)
	      ( (eq (Domval-Name y) 'R3) 'true)
	      ( (eq (Domval-Name y) 'R4) 'fail)
	      ( (eq (Domval-Name y) 'R5) 'fail)
	      ( (eq (Domval-Name y) 'R6) 'fail)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'Q1)
	     (cond 
	      ( (eq (Domval-Name y) 'S1) 'dc)
	      ( (eq (Domval-Name y) 'S2) 'dc)
	      ( (eq (Domval-Name y) 'S3) 'true)
	      ( (eq (Domval-Name y) 'S4) 'true) 
	      ( (eq (Domval-Name y) 'S5) 'fail) 
	      ( (eq (Domval-Name y) 'S6) 'fail) 
	      ( (eq (Domval-Name y) 'S7) 'dc)
	      ( (eq (Domval-Name y) 'S8) 'dc)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'Q2)
	     (cond 
	      ( (eq (Domval-Name y) 'S1) 'dc)
	      ( (eq (Domval-Name y) 'S2) 'dc)
	      ( (eq (Domval-Name y) 'S3) 'true)
	      ( (eq (Domval-Name y) 'S4) 'fail) 
	      ( (eq (Domval-Name y) 'S5) 'fail) 
	      ( (eq (Domval-Name y) 'S6) 'fail) 
	      ( (eq (Domval-Name y) 'S7) 'dc)
	      ( (eq (Domval-Name y) 'S8) 'dc)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'Q3)
	     (cond 
	      ( (eq (Domval-Name y) 'S1) 'dc)
	      ( (eq (Domval-Name y) 'S2) 'dc)
	      ( (eq (Domval-Name y) 'S3) 'fail) 
	      ( (eq (Domval-Name y) 'S4) 'fail) 
	      ( (eq (Domval-Name y) 'S5) 'dc)
	      ( (eq (Domval-Name y) 'S6) 'dc)
	      ( (eq (Domval-Name y) 'S7) 'fail) 
	      ( (eq (Domval-Name y) 'S8) 'fail) 
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'Q4)
	     (cond 
	      ( (eq (Domval-Name y) 'S1) 'dc)
	      ( (eq (Domval-Name y) 'S2) 'dc)
	      ( (eq (Domval-Name y) 'S3) 'fail) 
	      ( (eq (Domval-Name y) 'S4) 'fail) 
	      ( (eq (Domval-Name y) 'S5) 'dc)
	      ( (eq (Domval-Name y) 'S6) 'dc)
	      ( (eq (Domval-Name y) 'S7) 'fail) 
	      ( (eq (Domval-Name y) 'S8) 'fail) 
	      ( t 'invalid-y-parameter )))

	   ;;
	   ;; Down Values ...
	   ;;

	   ( (eq (Domval-Name x) 'C1)
	     (cond
	      ( (eq (Domval-Name y) 'T1) 'poss)
	      ( (eq (Domval-Name y) 'T2) 'fail)
	      ( (eq (Domval-Name y) 'T3) 'fail) 
	      ( (eq (Domval-Name y) 'T4) 'poss)
	      ( (eq (Domval-Name y) 'T5) 'dc)
	      ( (eq (Domval-Name y) 'T6) 'dc)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'C2)
	     (cond
	      ( (eq (Domval-Name y) 'T1) 'fail)
	      ( (eq (Domval-Name y) 'T2) 'fail)
	      ( (eq (Domval-Name y) 'T3) 'fail)
	      ( (eq (Domval-Name y) 'T4) 'fail)
	      ( (eq (Domval-Name y) 'T5) 'dc)
	      ( (eq (Domval-Name y) 'T6) 'dc)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'C3)
	     (cond
	      ( (eq (Domval-Name y) 'T1) 'poss)
	      ( (eq (Domval-Name y) 'T2) 'fail)
	      ( (eq (Domval-Name y) 'T3) 'fail) 
	      ( (eq (Domval-Name y) 'T4) 'poss)
	      ( (eq (Domval-Name y) 'T5) 'true)
	      ( (eq (Domval-Name y) 'T6) 'true)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'C4)
	     (cond
	      ( (eq (Domval-Name y) 'T1) 'fail)
	      ( (eq (Domval-Name y) 'T2) 'fail)
	      ( (eq (Domval-Name y) 'T3) 'fail)
	      ( (eq (Domval-Name y) 'T4) 'poss)
	      ( (eq (Domval-Name y) 'T5) 'fail)
	      ( (eq (Domval-Name y) 'T6) 'fail)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'X1)
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'fail)
	      ( (eq (Domval-Name y) 'U2) 'true)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'true) 
	      ( (eq (Domval-Name y) 'U8) 'true) 
	      ( (eq (Domval-Name y) 'U9) 'dc)
	      ( (eq (Domval-Name y) 'U10) 'dc)
	      ( (eq (Domval-Name y) 'U11) 'dc)
	      ( (eq (Domval-Name y) 'U12) 'dc)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'X2)
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'fail)
	      ( (eq (Domval-Name y) 'U2) 'fail)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'fail) 
	      ( (eq (Domval-Name y) 'U8) 'fail) 
	      ( (eq (Domval-Name y) 'U9) 'dc)
	      ( (eq (Domval-Name y) 'U10) 'dc)
	      ( (eq (Domval-Name y) 'U11) 'dc)
	      ( (eq (Domval-Name y) 'U12) 'dc)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'X3)
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'dc)
	      ( (eq (Domval-Name y) 'U2) 'dc)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'dc)
	      ( (eq (Domval-Name y) 'U8) 'dc)
	      ( (eq (Domval-Name y) 'U9) 'dc)
	      ( (eq (Domval-Name y) 'U10) 'dc)
	      ( (eq (Domval-Name y) 'U11) 'dc)
	      ( (eq (Domval-Name y) 'U12) 'dc)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'X4) 
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'dc) 
	      ( (eq (Domval-Name y) 'U2) 'dc)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'dc)
	      ( (eq (Domval-Name y) 'U8) 'dc)
	      ( (eq (Domval-Name y) 'U9) 'dc)
	      ( (eq (Domval-Name y) 'U10) 'dc)
	      ( (eq (Domval-Name y) 'U11) 'dc)
	      ( (eq (Domval-Name y) 'U12) 'dc)
	      ( t 'invalid-y-parameter ))) 

	   ( (eq (Domval-Name x) 'X5) 
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'fail) 
	      ( (eq (Domval-Name y) 'U2) 'poss)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'true)
	      ( (eq (Domval-Name y) 'U8) 'true)
	      ( (eq (Domval-Name y) 'U9) 'true)
	      ( (eq (Domval-Name y) 'U10) 'fail)
	      ( (eq (Domval-Name y) 'U11) 'true)
	      ( (eq (Domval-Name y) 'U12) 'poss)
	      ( t 'invalid-y-parameter ))) 

	   ( (eq (Domval-Name x) 'X6) 
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'true) 
	      ( (eq (Domval-Name y) 'U2) 'fail)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'fail)
	      ( (eq (Domval-Name y) 'U8) 'fail)
	      ( (eq (Domval-Name y) 'U9) 'poss)
	      ( (eq (Domval-Name y) 'U10) 'fail)
	      ( (eq (Domval-Name y) 'U11) 'true)
	      ( (eq (Domval-Name y) 'U12) 'poss)
	      ( t 'invalid-y-parameter ))) 

	   ( (eq (Domval-Name x) 'X7) 
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'dc) 
	      ( (eq (Domval-Name y) 'U2) 'dc)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'poss)
	      ( (eq (Domval-Name y) 'U8) 'fail)
	      ( (eq (Domval-Name y) 'U9) 'dc)
	      ( (eq (Domval-Name y) 'U10) 'dc)
	      ( (eq (Domval-Name y) 'U11) 'dc)
	      ( (eq (Domval-Name y) 'U12) 'dc)
	      ( t 'invalid-y-parameter ))) 

	   ( (eq (Domval-Name x) 'X8) 
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'dc) 
	      ( (eq (Domval-Name y) 'U2) 'dc)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'true)
	      ( (eq (Domval-Name y) 'U8) 'fail)
	      ( (eq (Domval-Name y) 'U9) 'dc)
	      ( (eq (Domval-Name y) 'U10) 'dc)
	      ( (eq (Domval-Name y) 'U11) 'dc)
	      ( (eq (Domval-Name y) 'U12) 'dc)
	      ( t 'invalid-y-parameter ))) 

	   ( (eq (Domval-Name x) 'X9) 
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'dc) 
	      ( (eq (Domval-Name y) 'U2) 'dc)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'dc)
	      ( (eq (Domval-Name y) 'U8) 'dc)
	      ( (eq (Domval-Name y) 'U9) 'true)
	      ( (eq (Domval-Name y) 'U10) 'true)
	      ( (eq (Domval-Name y) 'U11) 'true)
	      ( (eq (Domval-Name y) 'U12) 'poss)
	      ( t 'invalid-y-parameter ))) 

	   ( (eq (Domval-Name x) 'X10) 
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'dc) 
	      ( (eq (Domval-Name y) 'U2) 'dc)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'dc)
	      ( (eq (Domval-Name y) 'U8) 'dc)
	      ( (eq (Domval-Name y) 'U9) 'fail)
	      ( (eq (Domval-Name y) 'U10) 'fail)
	      ( (eq (Domval-Name y) 'U11) 'poss)
	      ( (eq (Domval-Name y) 'U12) 'true)
	      ( t 'invalid-y-parameter ))) 

	   ( (eq (Domval-Name x) 'X11) 
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'dc) 
	      ( (eq (Domval-Name y) 'U2) 'dc)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'dc)
	      ( (eq (Domval-Name y) 'U8) 'dc)
	      ( (eq (Domval-Name y) 'U9) 'true)
	      ( (eq (Domval-Name y) 'U10) 'fail)
	      ( (eq (Domval-Name y) 'U11) 'poss)
	      ( (eq (Domval-Name y) 'U12) 'poss)
	      ( t 'invalid-y-parameter ))) 

	   ( (eq (Domval-Name x) 'X12) 
	     (cond 
	      ( (eq (Domval-Name y) 'U1) 'dc) 
	      ( (eq (Domval-Name y) 'U2) 'dc)
	      ( (eq (Domval-Name y) 'U3) 'dc)
	      ( (eq (Domval-Name y) 'U4) 'dc)
	      ( (eq (Domval-Name y) 'U5) 'dc)
	      ( (eq (Domval-Name y) 'U6) 'dc)
	      ( (eq (Domval-Name y) 'U7) 'dc)
	      ( (eq (Domval-Name y) 'U8) 'dc)
	      ( (eq (Domval-Name y) 'U9) 'poss)
	      ( (eq (Domval-Name y) 'U10) 'fail)
	      ( (eq (Domval-Name y) 'U11) 'poss)
	      ( (eq (Domval-Name y) 'U12) 'true)
	      ( t 'invalid-y-parameter ))) 

	   ;; --------------------------------------------------
	   ;; V0 --) V1 function

	   ( (eq (Domval-Name x) 'E1)
	     (cond
	      ( (eq (Domval-Name y) 'A1) 'true )
	      ( (eq (Domval-Name y) 'A2) 'poss )
	      ( (eq (Domval-Name y) 'A3) 'fail )
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'E2)
	     (cond
	      ( (eq (Domval-Name y) 'A1) 'poss )
	      ( (eq (Domval-Name y) 'A2) 'poss )
	      ( (eq (Domval-Name y) 'A3) 'poss )
	      ( t 'invalid-y-parameter )))

	   ;;
	   ;; Up Values ...
	   ;;

	   ( (eq (Domval-Name x) 'J1)
	     (cond
	      ( (eq (Domval-Name y) 'P1) 'true)
	      ( (eq (Domval-Name y) 'P2) 'fail)
	      ( (eq (Domval-Name y) 'P3) 'fail)
	      ( (eq (Domval-Name y) 'P4) 'fail) 
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'J2)
	     (cond
	      ( (eq (Domval-Name y) 'P1) 'fail)
	      ( (eq (Domval-Name y) 'P2) 'fail)
	      ( (eq (Domval-Name y) 'P3) 'true)   ;; CHANGE APR 15 from 'fail
	      ( (eq (Domval-Name y) 'P4) 'true) 
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'J3)
	     (cond
	      ( (eq (Domval-Name y) 'P1) 'true)
	      ( (eq (Domval-Name y) 'P2) 'fail)
	      ( (eq (Domval-Name y) 'P3) 'fail)
	      ( (eq (Domval-Name y) 'P4) 'fail) 
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'J4)
	     (cond
	      ( (eq (Domval-Name y) 'P1) 'fail)
	      ( (eq (Domval-Name y) 'P2) 'fail)
	      ( (eq (Domval-Name y) 'P3) 'fail)
	      ( (eq (Domval-Name y) 'P4) 'fail) 
	      ( t 'invalid-y-parameter )))

	   ;;
	   ;; Down Values ...
	   ;;

	   ( (eq (Domval-Name x) 'L1)
	     (cond 
	      ( (eq (Domval-Name y) 'C1) 'true)
	      ( (eq (Domval-Name y) 'C2) 'fail)
	      ( (eq (Domval-Name y) 'C3) 'true)
	      ( (eq (Domval-Name y) 'C4) 'fail) 
	      ( (eq (Domval-Name y) 'C5) 'fail) 
	      ( (eq (Domval-Name y) 'C6) 'true) 
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'L2)
	     (cond 
	      ( (eq (Domval-Name y) 'C1) 'true)
	      ( (eq (Domval-Name y) 'C2) 'fail)
	      ( (eq (Domval-Name y) 'C3) 'true)
	      ( (eq (Domval-Name y) 'C4) 'fail) 
	      ( (eq (Domval-Name y) 'C5) 'true) 
	      ( (eq (Domval-Name y) 'C6) 'true) 
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'L3)
	     (cond 
	      ( (eq (Domval-Name y) 'C1) 'true)
	      ( (eq (Domval-Name y) 'C2) 'fail)
	      ( (eq (Domval-Name y) 'C3) 'fail)
	      ( (eq (Domval-Name y) 'C4) 'fail) 
	      ( (eq (Domval-Name y) 'C5) 'true) 
	      ( (eq (Domval-Name y) 'C6) 'true) 
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'L4)
	     (cond 
	      ( (eq (Domval-Name y) 'C1) 'fail)
	      ( (eq (Domval-Name y) 'C2) 'fail)
	      ( (eq (Domval-Name y) 'C3) 'fail)
	      ( (eq (Domval-Name y) 'C4) 'fail) 
	      ( (eq (Domval-Name y) 'C5) 'true) 
	      ( (eq (Domval-Name y) 'C6) 'fail) 
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'M1)
	     (cond
	      ( (eq (Domval-Name y) 'X1) 'true)
	      ( (eq (Domval-Name y) 'X2) 'fail)
	      ( (eq (Domval-Name y) 'X3) 'dc)
	      ( (eq (Domval-Name y) 'X4) 'dc)
	      ( (eq (Domval-Name y) 'X5) 'true)
	      ( (eq (Domval-Name y) 'X6) 'true)
	      ( (eq (Domval-Name y) 'X7) 'dc)
	      ( (eq (Domval-Name y) 'X8) 'dc)
	      ( (eq (Domval-Name y) 'X9) 'dc)
	      ( (eq (Domval-Name y) 'X10) 'dc)
	      ( (eq (Domval-Name y) 'X11) 'fail)
	      ( (eq (Domval-Name y) 'X12) 'true)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'M2)
	     (cond
	      ( (eq (Domval-Name y) 'X1) 'fail)
	      ( (eq (Domval-Name y) 'X2) 'fail)
	      ( (eq (Domval-Name y) 'X3) 'dc)
	      ( (eq (Domval-Name y) 'X4) 'dc)
	      ( (eq (Domval-Name y) 'X5) 'fail)
	      ( (eq (Domval-Name y) 'X6) 'fail)
	      ( (eq (Domval-Name y) 'X7) 'dc)
	      ( (eq (Domval-Name y) 'X8) 'dc)
	      ( (eq (Domval-Name y) 'X9) 'dc)
	      ( (eq (Domval-Name y) 'X10) 'dc)
	      ( (eq (Domval-Name y) 'X11) 'true)
	      ( (eq (Domval-Name y) 'X12) 'fail)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'M3)
	     (cond
	      ( (eq (Domval-Name y) 'X1) 'true)
	      ( (eq (Domval-Name y) 'X2) 'fail)
	      ( (eq (Domval-Name y) 'X3) 'dc)
	      ( (eq (Domval-Name y) 'X4) 'dc)
	      ( (eq (Domval-Name y) 'X5) 'true)
	      ( (eq (Domval-Name y) 'X6) 'poss)
	      ( (eq (Domval-Name y) 'X7) 'dc)
	      ( (eq (Domval-Name y) 'X8) 'dc)
	      ( (eq (Domval-Name y) 'X9) 'fail)
	      ( (eq (Domval-Name y) 'X10) 'fail)
	      ( (eq (Domval-Name y) 'X11) 'fail)
	      ( (eq (Domval-Name y) 'X12) 'true)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'M4)
	     (cond
	      ( (eq (Domval-Name y) 'X1) 'true)
	      ( (eq (Domval-Name y) 'X2) 'fail)
	      ( (eq (Domval-Name y) 'X3) 'dc)
	      ( (eq (Domval-Name y) 'X4) 'dc)
	      ( (eq (Domval-Name y) 'X5) 'poss)
	      ( (eq (Domval-Name y) 'X6) 'true)
	      ( (eq (Domval-Name y) 'X7) 'dc)
	      ( (eq (Domval-Name y) 'X8) 'dc)
	      ( (eq (Domval-Name y) 'X9) 'fail)
	      ( (eq (Domval-Name y) 'X10) 'fail)
	      ( (eq (Domval-Name y) 'X11) 'true)
	      ( (eq (Domval-Name y) 'X12) 'fail)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'M5)
	     (cond
	      ( (eq (Domval-Name y) 'X1) 'true)
	      ( (eq (Domval-Name y) 'X2) 'fail)
	      ( (eq (Domval-Name y) 'X3) 'dc)
	      ( (eq (Domval-Name y) 'X4) 'dc)
	      ( (eq (Domval-Name y) 'X5) 'dc)
	      ( (eq (Domval-Name y) 'X6) 'dc)
	      ( (eq (Domval-Name y) 'X7) 'dc)
	      ( (eq (Domval-Name y) 'X8) 'dc)
	      ( (eq (Domval-Name y) 'X9) 'fail)
	      ( (eq (Domval-Name y) 'X10) 'fail)
	      ( (eq (Domval-Name y) 'X11) 'true)
	      ( (eq (Domval-Name y) 'X12) 'fail)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'M6)
	     (cond
	      ( (eq (Domval-Name y) 'X1) 'true)
	      ( (eq (Domval-Name y) 'X2) 'fail)
	      ( (eq (Domval-Name y) 'X3) 'dc)
	      ( (eq (Domval-Name y) 'X4) 'dc)
	      ( (eq (Domval-Name y) 'X5) 'dc)
	      ( (eq (Domval-Name y) 'X6) 'dc)
	      ( (eq (Domval-Name y) 'X7) 'dc)
	      ( (eq (Domval-Name y) 'X8) 'dc)
	      ( (eq (Domval-Name y) 'X9) 'fail)
	      ( (eq (Domval-Name y) 'X10) 'fail)
	      ( (eq (Domval-Name y) 'X11) 'fail)
	      ( (eq (Domval-Name y) 'X12) 'true)
	      ( t 'invalid-y-parameter )))

	   ;; --------------------------------------------------
	   ;; V2 --) V0 function

	   ( (eq (Domval-Name x) 'B1)
	     (cond
	      ( (eq (Domval-Name y) 'E1) 'fail )
	      ( (eq (Domval-Name y) 'E2) 'fail )
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'B2)
	     (cond
	      ( (eq (Domval-Name y) 'E1) 'fail )
	      ( (eq (Domval-Name y) 'E2) 'fail )
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'B3)
	     (cond
	      ( (eq (Domval-Name y) 'E1) 'true )
	      ( (eq (Domval-Name y) 'E2) 'fail )
	      ( t 'invalid-y-parameter )))

	   ;;
	   ;; Up Values ...
	   ;;

	   ( (eq (Domval-Name x) 'R5)
	     (cond
	      ( (eq (Domval-Name y) 'J1) 'fail)
	      ( (eq (Domval-Name y) 'J2) 'fail)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'R6)
	     (cond
	      ( (eq (Domval-Name y) 'J1) 'fail)
	      ( (eq (Domval-Name y) 'J2) 'true)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'T5)
	     (cond
	      ( (eq (Domval-Name y) 'L1) 'true)
	      ( (eq (Domval-Name y) 'L2) 'true)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'T6)
	     (cond
	      ( (eq (Domval-Name y) 'L1) 'poss)
	      ( (eq (Domval-Name y) 'L2) 'poss)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'U9)
	     (cond 
	      ( (eq (Domval-Name y) 'M1) 'true)
	      ( (eq (Domval-Name y) 'M2) 'fail)
	      ( (eq (Domval-Name y) 'M3) 'true)
	      ( (eq (Domval-Name y) 'M4) 'true) 
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'U10)
	     (cond 
	      ( (eq (Domval-Name y) 'M1) 'fail)
	      ( (eq (Domval-Name y) 'M2) 'fail)
	      ( (eq (Domval-Name y) 'M3) 'fail)
	      ( (eq (Domval-Name y) 'M4) 'fail)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'U11)
	     (cond 
	      ( (eq (Domval-Name y) 'M1) 'true)
	      ( (eq (Domval-Name y) 'M2) 'fail)
	      ( (eq (Domval-Name y) 'M3) 'true)
	      ( (eq (Domval-Name y) 'M4) 'poss)
	      ( t 'invalid-y-parameter )))

	   ( (eq (Domval-Name x) 'U12)
	     (cond 
	      ( (eq (Domval-Name y) 'M1) 'true)
	      ( (eq (Domval-Name y) 'M2) 'fail)
	      ( (eq (Domval-Name y) 'M3) 'poss)
	      ( (eq (Domval-Name y) 'M4) 'true) 
	      ( t 'invalid-y-parameter )))

	   ( t  'invalid-X-parameter )

	   )) ; defun

(setq  Rfn #'(lambda (x y) (r-relation x y)))    ;; applicable constraint function
		 
;; ***************************************************************************
;;
;; Domain Value A1 hierarchy
;;
;; ***************************************************************************

;; A1 ok

(setf (DomVal-Name            A1)  'A1)
(setf (DomVal-MyRoot          A1)  A1)
(setf (DomVal-Root            A1)  t)
(setf (DomVal-LeftParent      A1)  P1)
(setf (DomVal-LeftParentType  A1)  'or)
(setf (DomVal-RightParent     A1)  P2)
(setf (DomVal-RightParentType A1)  'or)
(setf (DomVal-LeftChild       A1)  C1)
(setf (DomVal-LeftChildType   A1)  'or)
(setf (DomVal-RightChild      A1)  C2)
(setf (DomVal-RightChildType  A1)  'or)
(setf (DomVal-NextSibling     A1)  A2)
(setf (DomVal-PrevSibling     A1)  nil)

;; P1 ok

(setf (DomVal-Name            P1)  'P1)
(setf (DomVal-MyRoot          P1)  A1)
(setf (DomVal-LeftParent      P1)  Q1)
(setf (DomVal-LeftParentType  P1)  'or)
(setf (DomVal-RightParent     P1)  Q2)
(setf (DomVal-RightParentType P1)  'or)
(setf (DomVal-LeftChild       P1)  nil)
(setf (DomVal-LeftChildType   P1)  nil)
(setf (DomVal-RightChild      P1)  A1)
(setf (DomVal-RightChildType  P1)  'or)

;; Q1 ok

(setf (DomVal-Name            Q1)  'Q1)
(setf (DomVal-MyRoot          Q1)   A1)
(setf (DomVal-LeftParent      Q1)  nil)
(setf (DomVal-LeftParentType  Q1)  nil)
(setf (DomVal-RightParent     Q1)  nil)
(setf (DomVal-RightParentType Q1)  nil)
(setf (DomVal-LeftChild       Q1)  nil)
(setf (DomVal-LeftChildType   Q1)  nil)
(setf (DomVal-RightChild      Q1)  P1)
(setf (DomVal-RightChildType  Q1)  'or)

;; Q2 ok

(setf (DomVal-Name            Q2)  'Q2)
(setf (DomVal-MyRoot          Q2)  A1)
(setf (DomVal-LeftParentType  Q2)  nil)
(setf (DomVal-RightParent     Q2)  nil)
(setf (DomVal-RightParentType Q2)  nil)
(setf (DomVal-LeftChild       Q2)  P1)
(setf (DomVal-LeftChildType   Q2)  'or)
(setf (DomVal-RightChild      Q2)  nil)
(setf (DomVal-RightChildType  Q2)  nil)

;; P2 ok

(setf (DomVal-Name            P2)  'P2)
(setf (DomVal-MyRoot          P2)  A1)
(setf (DomVal-LeftParent      P2)  Q3)
(setf (DomVal-LeftParentType  P2)  'or)
(setf (DomVal-RightParent     P2)  Q4)
(setf (DomVal-RightParentType P2)  'or)
(setf (DomVal-LeftChild       P2)  A1)
(setf (DomVal-LeftChildType   P2)  'or)
(setf (DomVal-RightChild      P2)  nil)
(setf (DomVal-RightChildType  P2)  nil)

;; Q3

(setf (DomVal-Name            Q3)  'Q3)
(setf (DomVal-MyRoot          Q3)  A1)
(setf (DomVal-LeftParent      Q3)  nil)
(setf (DomVal-LeftParentType  Q3)  nil)
(setf (DomVal-RightParent     Q3)  nil)
(setf (DomVal-RightParentType Q3)  nil)
(setf (DomVal-LeftChild       Q3)  nil)
(setf (DomVal-LeftChildType   Q3)  nil)
(setf (DomVal-RightChild      Q3)  P2)
(setf (DomVal-RightChildType  Q3)  'or)


;; Q4

(setf (DomVal-Name            Q4)  'Q4)
(setf (DomVal-MyRoot          Q4)  A1)
(setf (DomVal-LeftParent      Q4)  nil)
(setf (DomVal-LeftParentType  Q4)  nil)
(setf (DomVal-RightParent     Q4)  nil)
(setf (DomVal-RightParentType Q4)  nil)
(setf (DomVal-LeftChild       Q4)  P2)
(setf (DomVal-LeftChildType   Q4)  'or)
(setf (DomVal-RightChild      Q4)  nil)
(setf (DomVal-RightChildType  Q4)  nil)

;; C1

(setf (DomVal-Name            C1)  'C1)
(setf (DomVal-MyRoot          C1)  A1)
(setf (DomVal-LeftParent      C1)  nil)
(setf (DomVal-LeftParentType  C1)  nil)
(setf (DomVal-RightParent     C1)  A1)
(setf (DomVal-RightParentType C1)  'or)
(setf (DomVal-LeftChild       C1)  X1)
(setf (DomVal-LeftChildType   C1)  'or)
(setf (DomVal-RightChild      C1)  X2)
(setf (DomVal-RightChildType  C1)  'or)

;; X1

(setf (DomVal-Name            X1)  'X1)
(setf (DomVal-MyRoot          X1)  A1)
(setf (DomVal-LeftParent      X1)  nil)
(setf (DomVal-LeftParentType  X1)  nil)
(setf (DomVal-RightParent     X1)  C1)
(setf (DomVal-RightParentType X1)  'or)
(setf (DomVal-LeftChild       X1)  nil)
(setf (DomVal-LeftChildType   X1)  nil)
(setf (DomVal-RightChild      X1)  nil)
(setf (DomVal-RightChildType  X1)  nil)

;; X2

(setf (DomVal-Name            X2)  'X2)
(setf (DomVal-MyRoot          X2)  A1)
(setf (DomVal-LeftParent      X2)  C1)
(setf (DomVal-LeftParentType  X2)  'or)
(setf (DomVal-RightParent     X2)  nil)
(setf (DomVal-RightParentType X2)  nil)
(setf (DomVal-LeftChild       X2)  nil)
(setf (DomVal-LeftChildType   X2)  nil)
(setf (DomVal-RightChild      X2)  nil)
(setf (DomVal-RightChildType  X2)  nil)

;; C2

(setf (DomVal-Name            C2)  'C2)
(setf (DomVal-MyRoot          C2)  A1)
(setf (DomVal-LeftParent      C2)  A1)
(setf (DomVal-LeftParentType  C2)  'or)
(setf (DomVal-RightParent     C2)  nil)
(setf (DomVal-RightParentType C2)  nil)
(setf (DomVal-LeftChild       C2)  X3)
(setf (DomVal-LeftChildType   C2)  'or)
(setf (DomVal-RightChild      C2)  X4)
(setf (DomVal-RightChildType  C2)  'or)

;; X3

(setf (DomVal-Name            X3)  'X3)
(setf (DomVal-MyRoot          X3)  A1)
(setf (DomVal-LeftParent      X3)  nil)
(setf (DomVal-LeftParentType  X3)  nil)
(setf (DomVal-RightParent     X3)  C2)
(setf (DomVal-RightParentType X3)  'or)
(setf (DomVal-LeftChild       X3)  nil)
(setf (DomVal-LeftChildType   X3)  nil)
(setf (DomVal-RightChild      X3)  nil)
(setf (DomVal-RightChildType  X3)  nil)

;; X4

(setf (DomVal-Name            X4)  'X4)
(setf (DomVal-MyRoot          X4)  A1)
(setf (DomVal-LeftParent      X4)  C2)
(setf (DomVal-LeftParentType  X4)  'or)
(setf (DomVal-RightParent     X4)  nil)
(setf (DomVal-RightParentType X4)  nil)
(setf (DomVal-LeftChild       X4)  nil)
(setf (DomVal-LeftChildType   X4)  nil)
(setf (DomVal-RightChild      X4)  nil)
(setf (DomVal-RightChildType  X4)  nil)


;; ***************************************************************************
;;
;; Domain Value A2 hierarchy
;;
;; ***************************************************************************

;; A2 ok

(setf (DomVal-Name            A2)  'A2)
(setf (DomVal-MyRoot          A2)  A2)
(setf (DomVal-Root            A2)  t)
(setf (DomVal-LeftParent      A2)  P3)
(setf (DomVal-MyRoot          A2)  A2)
(setf (DomVal-LeftParentType  A2)  'or)
(setf (DomVal-RightParent     A2)  P4)
(setf (DomVal-RightParentType A2)  'or)
(setf (DomVal-LeftChild       A2)  C3)
(setf (DomVal-LeftChildType   A2)  'or)
(setf (DomVal-RightChild      A2)  C4)
(setf (DomVal-RightChildType  A2)  'or)
(setf (DomVal-NextSibling     A2)  A3)
(setf (DomVal-PrevSibling     A2)  A1)

;; P3 ok

(setf (DomVal-Name            P3)  'P3)
(setf (DomVal-MyRoot          P3)  A2)
(setf (DomVal-RightChild      P3)  A2)
(setf (DomVal-RightChildType  P3)  'or)

;; P4 ok

(setf (DomVal-Name            P4)  'P4)
(setf (DomVal-MyRoot          P4)  A2)
(setf (DomVal-LeftChild       P4)  A2)
(setf (DomVal-LeftChildType   P4)  'or)

;; C3

(setf (DomVal-Name            C3)  'C3)
(setf (DomVal-LeftParent      C3)  nil)
(setf (DomVal-MyRoot          C3)  A2)
(setf (DomVal-LeftParentType  C3)  nil)
(setf (DomVal-RightParent     C3)  A2)
(setf (DomVal-RightParentType C3)  'or)
(setf (DomVal-LeftChild       C3)  X5)
(setf (DomVal-LeftChildType   C3)  'and)
(setf (DomVal-RightChild      C3)  X6)
(setf (DomVal-RightChildType  C3)  'and)

;; X5

(setf (DomVal-Name            X5)  'X5)
(setf (DomVal-LeftParent      X5)  nil)
(setf (DomVal-MyRoot          X5)  A2)
(setf (DomVal-LeftParentType  X5)  nil)
(setf (DomVal-RightParent     X5)  C3)
(setf (DomVal-RightParentType X5)  'and)
(setf (DomVal-LeftChild       X5)  nil)
(setf (DomVal-LeftChildType   X5)  nil)
(setf (DomVal-RightChild      X5)  nil)
(setf (DomVal-RightChildType  X5)  nil)

;; X6

(setf (DomVal-Name            X6)  'X6)
(setf (DomVal-LeftParent      X6)  C3)
(setf (DomVal-MyRoot          X6)  A2)
(setf (DomVal-LeftParentType  X6)  'and)
(setf (DomVal-RightParent     X6)  nil)
(setf (DomVal-RightParentType X6)  nil)
(setf (DomVal-LeftChild       X6)  nil)
(setf (DomVal-LeftChildType   X6)  nil)
(setf (DomVal-RightChild      X6)  nil)
(setf (DomVal-RightChildType  X6)  nil)

;; C4

(setf (DomVal-Name            C4)  'C4)
(setf (DomVal-LeftParent      C4)  A2)
(setf (DomVal-MyRoot          C4)  A2)
(setf (DomVal-LeftParentType  C4)  'or)
(setf (DomVal-RightParent     C4)  nil)
(setf (DomVal-RightParentType C4)  nil)
(setf (DomVal-LeftChild       C4)  X7)
(setf (DomVal-LeftChildType   C4)  'and)
(setf (DomVal-RightChild      C4)  X8)
(setf (DomVal-RightChildType  C4)  'and)

;; X7

(setf (DomVal-Name            X7)  'X7)
(setf (DomVal-LeftParent      X7)  nil)
(setf (DomVal-MyRoot          X7)  A2)
(setf (DomVal-LeftParentType  X7)  nil)
(setf (DomVal-RightParent     X7)  C4)
(setf (DomVal-RightParentType X7)  'and)
(setf (DomVal-LeftChild       X7)  nil)
(setf (DomVal-LeftChildType   X7)  nil)
(setf (DomVal-RightChild      X7)  nil)
(setf (DomVal-RightChildType  X7)  nil)

;; X8

(setf (DomVal-Name            X8)  'X8)
(setf (DomVal-LeftParent      X8)  C4)
(setf (DomVal-MyRoot          X8)  A2)
(setf (DomVal-LeftParentType  X8)  'and)
(setf (DomVal-RightParent     X8)  nil)
(setf (DomVal-RightParentType X8)  nil)
(setf (DomVal-LeftChild       X8)  nil)
(setf (DomVal-LeftChildType   X8)  nil)
(setf (DomVal-RightChild      X8)  nil)
(setf (DomVal-RightChildType  X8)  nil)

;; ***************************************************************************
;;
;; Domain Value A3 hierarchy
;;
;; ***************************************************************************

;; A3 ok

(setf (DomVal-Name            A3)  'A3)
(setf (DomVal-MyRoot          A3)  A3)
(setf (DomVal-Root            A3)  t)
(setf (DomVal-LeftParent      A3)  nil)
(setf (DomVal-LeftParentType  A3)  nil)
(setf (DomVal-RightParent     A3)  nil)
(setf (DomVal-RightParentType A3)  nil)
(setf (DomVal-LeftChild       A3)  C5)
(setf (DomVal-LeftChildType   A3)  'and)
(setf (DomVal-RightChild      A3)  C6)
(setf (DomVal-RightChildType  A3)  'and)
(setf (DomVal-NextSibling     A3)  nil)
(setf (DomVal-PrevSibling     A3)  A2)

;; C5

(setf (DomVal-Name            C5)  'C5)
(setf (DomVal-MyRoot          C5)   A3)
(setf (DomVal-LeftParent      C5)  nil)
(setf (DomVal-LeftParentType  C5)  nil)
(setf (DomVal-RightParent     C5)  A3)
(setf (DomVal-RightParentType C5)  'and)
(setf (DomVal-LeftChild       C5)  X9)
(setf (DomVal-LeftChildType   C5)  'and)
(setf (DomVal-RightChild      C5)  X10)
(setf (DomVal-RightChildType  C5)  'and)

;; X9

(setf (DomVal-Name            X9)  'X9)
(setf (DomVal-MyRoot          X9)   A3)
(setf (DomVal-LeftParent      X9)  nil)
(setf (DomVal-LeftParentType  X9)  nil)
(setf (DomVal-RightParent     X9)  C5)
(setf (DomVal-RightParentType X9)  'and)
(setf (DomVal-LeftChild       X9)  nil)
(setf (DomVal-LeftChildType   X9)  nil)
(setf (DomVal-RightChild      X9)  nil)
(setf (DomVal-RightChildType  X9)  nil)

;; X10

(setf (DomVal-Name            X10)  'X10)
(setf (DomVal-MyRoot          X10)   A3)
(setf (DomVal-LeftParent      X10)  C5)
(setf (DomVal-LeftParentType  X10)  'and)
(setf (DomVal-RightParent     X10)  nil)
(setf (DomVal-RightParentType X10)  nil)
(setf (DomVal-LeftChild       X10)  nil)
(setf (DomVal-LeftChildType   X10)  nil)
(setf (DomVal-RightChild      X10)  nil)
(setf (DomVal-RightChildType  X10)  nil)

;; C6

(setf (DomVal-Name            C6)  'C6)
(setf (DomVal-MyRoot          C6)   A3)
(setf (DomVal-LeftParent      C6)  A3)
(setf (DomVal-LeftParentType  C6)  'and)
(setf (DomVal-RightParent     C6)  nil)
(setf (DomVal-RightParentType C6)  nil)
(setf (DomVal-LeftChild       C6)  X11)
(setf (DomVal-LeftChildType   C6)  'and)
(setf (DomVal-RightChild      C6)  X12)
(setf (DomVal-RightChildType  C6)  'and)

;; X11

(setf (DomVal-Name            X11)  'X11)
(setf (DomVal-MyRoot          X11)   A3)
(setf (DomVal-LeftParent      X11)  nil)
(setf (DomVal-LeftParentType  X11)  nil)
(setf (DomVal-RightParent     X11)  C6)
(setf (DomVal-RightParentType X11)  'and)
(setf (DomVal-LeftChild       X11)  nil)
(setf (DomVal-LeftChildType   X11)  nil)
(setf (DomVal-RightChild      X11)  nil)
(setf (DomVal-RightChildType  X11)  nil)

;; X12

(setf (DomVal-Name            X12)  'X12)
(setf (DomVal-MyRoot          X12)   A3)
(setf (DomVal-LeftParent      X12)  C6)
(setf (DomVal-LeftParentType  X12)  'and)
(setf (DomVal-RightParent     X12)  nil)
(setf (DomVal-RightParentType X12)  nil)
(setf (DomVal-LeftChild       X12)  nil)
(setf (DomVal-LeftChildType   X12)  nil)
(setf (DomVal-RightChild      X12)  nil)
(setf (DomVal-RightChildType  X12)  nil)

;; ***************************************************************************
;;
;; Domain Value B1 hierarchy
;;
;; ***************************************************************************

;; B1 ok

(setf (DomVal-Name            B1)  'B1)
(setf (DomVal-MyRoot          B1)  B1)
(setf (DomVal-Root            B1)  t)
(setf (DomVal-LeftParent      B1)  R1)
(setf (DomVal-LeftParentType  B1)  'or)
(setf (DomVal-RightParent     B1)  R2)
(setf (DomVal-RightParentType B1)  'or)
(setf (DomVal-LeftChild       B1)  T1)
(setf (DomVal-LeftChildType   B1)  'or)
(setf (DomVal-RightChild      B1)  T2)
(setf (DomVal-RightChildType  B1)  'or)
(setf (DomVal-NextSibling     B1)  B2)
(setf (DomVal-PrevSibling     B1)  nil)

;; R1 ok

(setf (DomVal-Name            R1)  'R1)
(setf (DomVal-MyRoot          R1)   B1)
(setf (DomVal-LeftParent      R1)  S1)
(setf (DomVal-LeftParentType  R1)  'or)
(setf (DomVal-RightParent     R1)  S2)
(setf (DomVal-RightParentType R1)  'or)
(setf (DomVal-LeftChild       R1)  nil)
(setf (DomVal-LeftChildType   R1)  nil)
(setf (DomVal-RightChild      R1)  B1)
(setf (DomVal-RightChildType  R1)  'or)

;; S1 ok

(setf (DomVal-Name            S1)  'S1)
(setf (DomVal-MyRoot          S1)   B1)
(setf (DomVal-LeftParent      S1)  nil)
(setf (DomVal-LeftParentType  S1)  nil)
(setf (DomVal-RightParent     S1)  nil)
(setf (DomVal-RightParentType S1)  nil)
(setf (DomVal-LeftChild       S1)  nil)
(setf (DomVal-LeftChildType   S1)  nil)
(setf (DomVal-RightChild      S1)  R1)
(setf (DomVal-RightChildType  S1)  'or)

;; S2 ok

(setf (DomVal-Name            S2)  'S2)
(setf (DomVal-MyRoot          S2)   B1)
(setf (DomVal-LeftParent      S2)  nil)
(setf (DomVal-LeftParentType  S2)  nil)
(setf (DomVal-RightParent     S2)  nil)
(setf (DomVal-RightParentType S2)  nil)
(setf (DomVal-LeftChild       S2)  R1)
(setf (DomVal-LeftChildType   S2)  'or)
(setf (DomVal-RightChild      S2)  nil)
(setf (DomVal-RightChildType  S2)  nil)

;; R2 ok

(setf (DomVal-Name            R2)  'R2)
(setf (DomVal-MyRoot          R2)   B1)
(setf (DomVal-LeftParent      R2)  S3)
(setf (DomVal-LeftParentType  R2)  'or)
(setf (DomVal-RightParent     R2)  S4)
(setf (DomVal-RightParentType R2)  'or)
(setf (DomVal-LeftChild       R2)  B1)
(setf (DomVal-LeftChildType   R2)  'or)
(setf (DomVal-RightChild      R2)  nil)
(setf (DomVal-RightChildType  R2)  nil)

;; S3

(setf (DomVal-Name            S3)  'S3)
(setf (DomVal-MyRoot          S3)   B1)
(setf (DomVal-LeftParent      S3)  nil)
(setf (DomVal-LeftParentType  S3)  nil)
(setf (DomVal-RightParent     S3)  nil)
(setf (DomVal-RightParentType S3)  nil)
(setf (DomVal-LeftChild       S3)  nil)
(setf (DomVal-LeftChildType   S3)  nil)
(setf (DomVal-RightChild      S3)  R2)
(setf (DomVal-RightChildType  S3)  'or)


;; S4

(setf (DomVal-Name            S4)  'S4)
(setf (DomVal-MyRoot          S4)   B1)
(setf (DomVal-LeftParent      S4)  nil)
(setf (DomVal-LeftParentType  S4)  nil)
(setf (DomVal-RightParent     S4)  nil)
(setf (DomVal-RightParentType S4)  nil)
(setf (DomVal-LeftChild       S4)  R2)
(setf (DomVal-LeftChildType   S4)  'orl)
(setf (DomVal-RightChild      S4)  nil)
(setf (DomVal-RightChildType  S4)  nil)

;; T1

(setf (DomVal-Name            T1)  'T1)
(setf (DomVal-MyRoot          T1)   B1)
(setf (DomVal-LeftParent      T1)  nil)
(setf (DomVal-LeftParentType  T1)  nil)
(setf (DomVal-RightParent     T1)  B1)
(setf (DomVal-RightParentType T1)  'or)
(setf (DomVal-LeftChild       T1)  U1)
(setf (DomVal-LeftChildType   T1)  'or)
(setf (DomVal-RightChild      T1)  U2)
(setf (DomVal-RightChildType  T1)  'or)

;; U1

(setf (DomVal-Name            U1)  'U1)
(setf (DomVal-MyRoot          U1)   B1)
(setf (DomVal-LeftParent      U1)  nil)
(setf (DomVal-LeftParentType  U1)  nil)
(setf (DomVal-RightParent     U1)  T1)
(setf (DomVal-RightParentType U1)  'or)
(setf (DomVal-LeftChild       U1)  nil)
(setf (DomVal-LeftChildType   U1)  nil)
(setf (DomVal-RightChild      U1)  nil)
(setf (DomVal-RightChildType  U1)  nil)

;; U2

(setf (DomVal-Name            U2)  'U2)
(setf (DomVal-MyRoot          U2)   B1)
(setf (DomVal-LeftParent      U2)  T1)
(setf (DomVal-LeftParentType  U2)  'or)
(setf (DomVal-RightParent     U2)  nil)
(setf (DomVal-RightParentType U2)  nil)
(setf (DomVal-LeftChild       U2)  nil)
(setf (DomVal-LeftChildType   U2)  nil)
(setf (DomVal-RightChild      U2)  nil)
(setf (DomVal-RightChildType  U2)  nil)

;; T2

(setf (DomVal-Name            T2)  'T2)
(setf (DomVal-MyRoot          T2)   B1)
(setf (DomVal-LeftParent      T2)  B1)
(setf (DomVal-LeftParentType  T2)  'or)
(setf (DomVal-RightParent     T2)  nil)
(setf (DomVal-RightParentType T2)  nil)
(setf (DomVal-LeftChild       T2)  U3)
(setf (DomVal-LeftChildType   T2)  'or)
(setf (DomVal-RightChild      T2)  U4)
(setf (DomVal-RightChildType  T2)  'or)

;; U3

(setf (DomVal-Name            U3)  'U3)
(setf (DomVal-MyRoot          U3)   B1)
(setf (DomVal-LeftParent      U3)  nil)
(setf (DomVal-LeftParentType  U3)  nil)
(setf (DomVal-RightParent     U3)  T2)
(setf (DomVal-RightParentType U3)  'or)
(setf (DomVal-LeftChild       U3)  nil)
(setf (DomVal-LeftChildType   U3)  nil)
(setf (DomVal-RightChild      U3)  nil)
(setf (DomVal-RightChildType  U3)  nil)

;; U4

(setf (DomVal-Name            U4)  'U4)
(setf (DomVal-MyRoot          U4)   B1)
(setf (DomVal-LeftParent      U4)  T2)
(setf (DomVal-LeftParentType  U4)  'or)
(setf (DomVal-RightParent     U4)  nil)
(setf (DomVal-RightParentType U4)  nil)
(setf (DomVal-LeftChild       U4)  nil)
(setf (DomVal-LeftChildType   U4)  nil)
(setf (DomVal-RightChild      U4)  nil)
(setf (DomVal-RightChildType  U4)  nil)


;; ***************************************************************************
;;
;; Domain Value B2 hierarchy
;;
;; ***************************************************************************

;; B2 ok

(setf (DomVal-Name            B2)  'B2)
(setf (DomVal-MyRoot          B2)  B2)
(setf (DomVal-Root            B2)  t)
(setf (DomVal-LeftParent      B2)  R3)
(setf (DomVal-LeftParentType  B2)  'or)
(setf (DomVal-RightParent     B2)  R4)
(setf (DomVal-RightParentType B2)  'or)
(setf (DomVal-LeftChild       B2)  T3)
(setf (DomVal-LeftChildType   B2)  'or)
(setf (DomVal-RightChild      B2)  T4)
(setf (DomVal-RightChildType  B2)  'or)
(setf (DomVal-NextSibling     B2)  B3)
(setf (DomVal-PrevSibling     B2)  B1)

;; R3 ok

(setf (DomVal-Name            R3)  'R3)
(setf (DomVal-MyRoot          R3)  B2)
(setf (DomVal-LeftParent      R3)  S5)
(setf (DomVal-LeftParentType  R3)  'or)
(setf (DomVal-RightParent     R3)  S6)
(setf (DomVal-RightParentType R3)  'or)
(setf (DomVal-LeftChild       R3)  nil)
(setf (DomVal-LeftChildType   R3)  nil)
(setf (DomVal-RightChild      R3)  B2)
(setf (DomVal-RightChildType  R3)  'or)

;; S5 ok

(setf (DomVal-Name            S5)  'S5)
(setf (DomVal-MyRoot          S5)  B2)
(setf (DomVal-LeftParent      S5)  nil)
(setf (DomVal-LeftParentType  S5)  nil)
(setf (DomVal-RightParent     S5)  nil)
(setf (DomVal-RightParentType S5)  nil)
(setf (DomVal-LeftChild       S5)  nil)
(setf (DomVal-LeftChildType   S5)  nil)
(setf (DomVal-RightChild      S5)  R3)
(setf (DomVal-RightChildType  S5)  'or)

;; S6 ok

(setf (DomVal-Name            S6)  'S6)
(setf (DomVal-MyRoot          S6)  B2)
(setf (DomVal-LeftParent      S6)  nil)
(setf (DomVal-LeftParentType  S6)  nil)
(setf (DomVal-RightParent     S6)  nil)
(setf (DomVal-RightParentType S6)  nil)
(setf (DomVal-LeftChild       S6)  R3)
(setf (DomVal-LeftChildType   S6)  'or)
(setf (DomVal-RightChild      S6)  nil)
(setf (DomVal-RightChildType  S6)  nil)

;; R4 ok

(setf (DomVal-Name            R4)  'R4)
(setf (DomVal-MyRoot          R4)  B2)
(setf (DomVal-LeftParent      R4)  S7)
(setf (DomVal-LeftParentType  R4)  'or)
(setf (DomVal-RightParent     R4)  S8)
(setf (DomVal-RightParentType R4)  'or)
(setf (DomVal-LeftChild       R4)  B2)
(setf (DomVal-LeftChildType   R4)  'or)
(setf (DomVal-RightChild      R4)  nil)
(setf (DomVal-RightChildType  R4)  nil)

;; S7

(setf (DomVal-Name            S7)  'S7)
(setf (DomVal-MyRoot          S7)  B2)
(setf (DomVal-LeftParent      S7)  nil)
(setf (DomVal-LeftParentType  S7)  nil)
(setf (DomVal-RightParent     S7)  nil)
(setf (DomVal-RightParentType S7)  nil)
(setf (DomVal-LeftChild       S7)  nil)
(setf (DomVal-LeftChildType   S7)  nil)
(setf (DomVal-RightChild      S7)  R4)
(setf (DomVal-RightChildType  S7)  'or)


;; S8

(setf (DomVal-Name            S8)  'S8)
(setf (DomVal-MyRoot          S8)  B2)
(setf (DomVal-LeftParent      S8)  nil)
(setf (DomVal-LeftParentType  S8)  nil)
(setf (DomVal-RightParent     S8)  nil)
(setf (DomVal-RightParentType S8)  nil)
(setf (DomVal-LeftChild       S8)  R4)
(setf (DomVal-LeftChildType   S8)  'or)
(setf (DomVal-RightChild      S8)  nil)
(setf (DomVal-RightChildType  S8)  nil)

;; T3

(setf (DomVal-Name            T3)  'T3)
(setf (DomVal-MyRoot          T3)  B2)
(setf (DomVal-LeftParent      T3)  nil)
(setf (DomVal-LeftParentType  T3)  nil)
(setf (DomVal-RightParent     T3)  B2)
(setf (DomVal-RightParentType T3)  'or)
(setf (DomVal-LeftChild       T3)  U5)
(setf (DomVal-LeftChildType   T3)  'or)
(setf (DomVal-RightChild      T3)  U6)
(setf (DomVal-RightChildType  T3)  'or)

;; U5

(setf (DomVal-Name            U5)  'U5)
(setf (DomVal-MyRoot          U5)  B2)
(setf (DomVal-LeftParent      U5)  nil)
(setf (DomVal-LeftParentType  U5)  nil)
(setf (DomVal-RightParent     U5)  T3)
(setf (DomVal-RightParentType U5)  'or)
(setf (DomVal-LeftChild       U5)  nil)
(setf (DomVal-LeftChildType   U5)  nil)
(setf (DomVal-RightChild      U5)  nil)
(setf (DomVal-RightChildType  U5)  nil)

;; U6

(setf (DomVal-Name            U6)  'U6)
(setf (DomVal-MyRoot          U6)  B2)
(setf (DomVal-LeftParent      U6)  T3)
(setf (DomVal-LeftParentType  U6)  'or)
(setf (DomVal-RightParent     U6)  nil)
(setf (DomVal-RightParentType U6)  nil)
(setf (DomVal-LeftChild       U6)  nil)
(setf (DomVal-LeftChildType   U6)  nil)
(setf (DomVal-RightChild      U6)  nil)
(setf (DomVal-RightChildType  U6)  nil)

;; T4

(setf (DomVal-Name            T4)  'T4)
(setf (DomVal-MyRoot          T4)  B2)
(setf (DomVal-LeftParent      T4)  B2)
(setf (DomVal-LeftParentType  T4)  'or)
(setf (DomVal-RightParent     T4)  nil)
(setf (DomVal-RightParentType T4)  nil)
(setf (DomVal-LeftChild       T4)  U7)
(setf (DomVal-LeftChildType   T4)  'or)
(setf (DomVal-RightChild      T4)  U8)
(setf (DomVal-RightChildType  T4)  'or)

;; U7

(setf (DomVal-Name            U7)  'U7)
(setf (DomVal-MyRoot          U7)  B2)
(setf (DomVal-LeftParent      U7)  nil)
(setf (DomVal-LeftParentType  U7)  nil)
(setf (DomVal-RightParent     U7)  T4)
(setf (DomVal-RightParentType U7)  'or)
(setf (DomVal-LeftChild       U7)  nil)
(setf (DomVal-LeftChildType   U7)  nil)
(setf (DomVal-RightChild      U7)  nil)
(setf (DomVal-RightChildType  U7)  nil)

;; U8

(setf (DomVal-Name            U8)  'U8)
(setf (DomVal-MyRoot          U8)  B2)
(setf (DomVal-LeftParent      U8)  T4)
(setf (DomVal-LeftParentType  U8)  'or)
(setf (DomVal-RightParent     U8)  nil)
(setf (DomVal-RightParentType U8)  nil)
(setf (DomVal-LeftChild       U8)  nil)
(setf (DomVal-LeftChildType   U8)  nil)
(setf (DomVal-RightChild      U8)  nil)
(setf (DomVal-RightChildType  U8)  nil)

;; ***************************************************************************
;;
;; Domain Value B3 hierarchy
;;
;; ***************************************************************************

;; B3 ok

(setf (DomVal-Name            B3)  'B3)
(setf (DomVal-MyRoot          B3)  B3)
(setf (DomVal-LeftParent      B3)  R5)
(setf (DomVal-LeftParentType  B3)  'or)
(setf (DomVal-RightParent     B3)  R6)
(setf (DomVal-RightParentType B3)  'or)
(setf (DomVal-LeftChild       B3)  T5)
(setf (DomVal-LeftChildType   B3)  'and)
(setf (DomVal-RightChild      B3)  T6)
(setf (DomVal-RightChildType  B3)  'and)
(setf (DomVal-NextSibling     B3)  nil)
(setf (DomVal-PrevSibling     B3)  B2)

;; R5 ok

(setf (DomVal-Name            R5)  'R5)
(setf (DomVal-MyRoot          R5)  B3)
(setf (DomVal-LeftParent      R5)  nil)
(setf (DomVal-LeftParentType  R5)  nil)
(setf (DomVal-RightParent     R5)  nil)
(setf (DomVal-RightParentType R5)  nil)
(setf (DomVal-LeftChild       R5)  nil)
(setf (DomVal-LeftChildType   R5)  nil)
(setf (DomVal-RightChild      R5)  B3)
(setf (DomVal-RightChildType  R5)  'or)

;; R6 ok

(setf (DomVal-Name            R6)  'R6)
(setf (DomVal-MyRoot          R6)  B3)
(setf (DomVal-LeftParent      R6)  nil)
(setf (DomVal-LeftParentType  R6)  nil)
(setf (DomVal-RightParent     R6)  nil)
(setf (DomVal-RightParentType R6)  nil)
(setf (DomVal-LeftChild       R6)  B3)
(setf (DomVal-LeftChildType   R6)  'or)
(setf (DomVal-RightChild      R6)  nil)
(setf (DomVal-RightChildType  R6)  nil)

;; T5

(setf (DomVal-Name            T5)  'T5)
(setf (DomVal-MyRoot          T5)  B3)
(setf (DomVal-LeftParent      T5)  nil)
(setf (DomVal-LeftParentType  T5)  nil)
(setf (DomVal-RightParent     T5)  B3)
(setf (DomVal-RightParentType T5)  'and)
(setf (DomVal-LeftChild       T5)  U9)
(setf (DomVal-LeftChildType   T5)  'or)
(setf (DomVal-RightChild      T5)  U10)
(setf (DomVal-RightChildType  T5)  'or)

;; U9

(setf (DomVal-Name            U9)  'U9)
(setf (DomVal-MyRoot          U9)  B3)
(setf (DomVal-LeftParent      U9)  nil)
(setf (DomVal-LeftParentType  U9)  nil)
(setf (DomVal-RightParent     U9)  T5)
(setf (DomVal-RightParentType U9)  'or)
(setf (DomVal-LeftChild       U9)  nil)
(setf (DomVal-LeftChildType   U9)  nil)
(setf (DomVal-RightChild      U9)  nil)
(setf (DomVal-RightChildType  U9)  nil)

;; U10

(setf (DomVal-Name            U10)  'U10)
(setf (DomVal-MyRoot          U10)  B3)
(setf (DomVal-LeftParent      U10)  T5)
(setf (DomVal-LeftParentType  U10)  'or)
(setf (DomVal-RightParent     U10)  nil)
(setf (DomVal-RightParentType U10)  nil)
(setf (DomVal-LeftChild       U10)  nil)
(setf (DomVal-LeftChildType   U10)  nil)
(setf (DomVal-RightChild      U10)  nil)
(setf (DomVal-RightChildType  U10)  nil)

;; T6

(setf (DomVal-Name            T6)  'T6)
(setf (DomVal-MyRoot          T6)  B3)
(setf (DomVal-LeftParent      T6)  B3)
(setf (DomVal-LeftParentType  T6)  'and)
(setf (DomVal-RightParent     T6)  nil)
(setf (DomVal-RightParentType T6)  nil)
(setf (DomVal-LeftChild       T6)  U11)
(setf (DomVal-LeftChildType   T6)  'and)
(setf (DomVal-RightChild      T6)  U12)
(setf (DomVal-RightChildType  T6)  'and)

;; U11

(setf (DomVal-Name            U11)  'U11)
(setf (DomVal-MyRoot          U11)  B3)
(setf (DomVal-LeftParent      U11)  nil)
(setf (DomVal-LeftParentType  U11)  nil)
(setf (DomVal-RightParent     U11)  T6)
(setf (DomVal-RightParentType U11)  'and)
(setf (DomVal-LeftChild       U11)  nil)
(setf (DomVal-LeftChildType   U11)  nil)
(setf (DomVal-RightChild      U11)  nil)
(setf (DomVal-RightChildType  U11)  nil)

;; U12

(setf (DomVal-Name            U12)  'U12)
(setf (DomVal-MyRoot          U12)  B3)
(setf (DomVal-LeftParent      U12)  T6)
(setf (DomVal-LeftParentType  U12)  'and)
(setf (DomVal-RightParent     U12)  nil)
(setf (DomVal-RightParentType U12)  nil)
(setf (DomVal-LeftChild       U12)  nil)
(setf (DomVal-LeftChildType   U12)  nil)
(setf (DomVal-RightChild      U12)  nil)
(setf (DomVal-RightChildType  U12)  nil)

;; ***************************************************************************
;;
;; Domain Value E1 hierarchy
;;
;; ***************************************************************************

;; E1 ok

(setf (DomVal-Name            E1)  'E1)
(setf (DomVal-MyRoot          E1)  E1)
(setf (DomVal-Root            E1)  t)
(setf (DomVal-LeftParent      E1)  J1)
(setf (DomVal-LeftParentType  E1)  'or)
(setf (DomVal-RightParent     E1)  J2)
(setf (DomVal-RightParentType E1)  'or)
(setf (DomVal-LeftChild       E1)  L1)
(setf (DomVal-LeftChildType   E1)  'and)
(setf (DomVal-RightChild      E1)  L2)
(setf (DomVal-RightChildType  E1)  'and)
(setf (DomVal-NextSibling     E1)  E2)
(setf (DomVal-PrevSibling     E1)  nil)

;; J1 ok

(setf (DomVal-Name            J1)  'J1)
(setf (DomVal-MyRoot          J1)  E1)
(setf (DomVal-LeftParent      J1)  nil)
(setf (DomVal-LeftParentType  J1)  nil)
(setf (DomVal-RightParent     J1)  nil)
(setf (DomVal-RightParentType J1)  nil)
(setf (DomVal-LeftChild       J1)  nil)
(setf (DomVal-LeftChildType   J1)  nil)
(setf (DomVal-RightChild      J1)  E1)
(setf (DomVal-RightChildType  J1)  'or)

;; J2 ok

(setf (DomVal-Name            J2)  'J2)
(setf (DomVal-MyRoot          J2)  E1)
(setf (DomVal-LeftParent      J2)  K3)
(setf (DomVal-LeftParentType  J2)  'or)
(setf (DomVal-RightParent     J2)  K4)
(setf (DomVal-RightParentType J2)  'or)
(setf (DomVal-LeftChild       J2)  E1)
(setf (DomVal-LeftChildType   J2)  'or)
(setf (DomVal-RightChild      J2)  nil)
(setf (DomVal-RightChildType  J2)  nil)

;; K3

(setf (DomVal-Name            K3)  'K3)
(setf (DomVal-MyRoot          K3)  E1)
(setf (DomVal-LeftParent      K3)  nil)
(setf (DomVal-LeftParentType  K3)  nil)
(setf (DomVal-RightParent     K3)  nil)
(setf (DomVal-RightParentType K3)  nil)
(setf (DomVal-LeftChild       K3)  nil)
(setf (DomVal-LeftChildType   K3)  nil)
(setf (DomVal-RightChild      K3)  J2)
(setf (DomVal-RightChildType  K3)  'or)

;; K4

(setf (DomVal-Name            K4)  'K4)
(setf (DomVal-MyRoot          K4)  E1)
(setf (DomVal-LeftParent      K4)  nil)
(setf (DomVal-LeftParentType  K4)  nil)
(setf (DomVal-RightParent     K4)  nil)
(setf (DomVal-RightParentType K4)  nil)
(setf (DomVal-LeftChild       K4)  J2)
(setf (DomVal-LeftChildType   K4)  'or)
(setf (DomVal-RightChild      K4)  nil)
(setf (DomVal-RightChildType  K4)  nil)

;; L1

(setf (DomVal-Name            L1)  'L1)
(setf (DomVal-MyRoot          L1)  E1)
(setf (DomVal-LeftParent      L1)  nil)
(setf (DomVal-LeftParentType  L1)  nil)
(setf (DomVal-RightParent     L1)  E1)
(setf (DomVal-RightParentType L1)  'and)
(setf (DomVal-LeftChild       L1)  M1)
(setf (DomVal-LeftChildType   L1)  'or)
(setf (DomVal-RightChild      L1)  M2)
(setf (DomVal-RightChildType  L1)  'or)

;; M1

(setf (DomVal-Name            M1)  'M1)
(setf (DomVal-MyRoot          M1)  E1)
(setf (DomVal-LeftParent      M1)  nil)
(setf (DomVal-LeftParentType  M1)  nil)
(setf (DomVal-RightParent     M1)  L1)
(setf (DomVal-RightParentType M1)  'or)
(setf (DomVal-LeftChild       M1)  nil)
(setf (DomVal-LeftChildType   M1)  nil)
(setf (DomVal-RightChild      M1)  nil)
(setf (DomVal-RightChildType  M1)  nil)

;; M2

(setf (DomVal-Name            M2)  'M2)
(setf (DomVal-MyRoot          M2)  E1)
(setf (DomVal-LeftParent      M2)  L1)
(setf (DomVal-LeftParentType  M2)  'or)
(setf (DomVal-RightParent     M2)  nil)
(setf (DomVal-RightParentType M2)  nil)
(setf (DomVal-LeftChild       M2)  nil)
(setf (DomVal-LeftChildType   M2)  nil)
(setf (DomVal-RightChild      M2)  nil)
(setf (DomVal-RightChildType  M2)  nil)

;; L2

(setf (DomVal-Name            L2)  'L2)
(setf (DomVal-MyRoot          L2)  E1)
(setf (DomVal-LeftParent      L2)  E1)
(setf (DomVal-LeftParentType  L2)  'and)
(setf (DomVal-RightParent     L2)  nil)
(setf (DomVal-RightParentType L2)  nil)
(setf (DomVal-LeftChild       L2)  M3)
(setf (DomVal-LeftChildType   L2)  'and)
(setf (DomVal-RightChild      L2)  M4)
(setf (DomVal-RightChildType  L2)  'and)

;; M3

(setf (DomVal-Name            M3)  'M3)
(setf (DomVal-MyRoot          M3)  E1)
(setf (DomVal-LeftParent      M3)  nil)
(setf (DomVal-LeftParentType  M3)  nil)
(setf (DomVal-RightParent     M3)  L2)
(setf (DomVal-RightParentType M3)  'and)
(setf (DomVal-LeftChild       M3)  nil)
(setf (DomVal-LeftChildType   M3)  nil)
(setf (DomVal-RightChild      M3)  nil)
(setf (DomVal-RightChildType  M3)  nil)

;; M4

(setf (DomVal-Name            M4)  'M4)
(setf (DomVal-MyRoot          M4)  E1)
(setf (DomVal-LeftParent      M4)  L2)
(setf (DomVal-LeftParentType  M4)  'and)
(setf (DomVal-RightParent     M4)  nil)
(setf (DomVal-RightParentType M4)  nil)
(setf (DomVal-LeftChild       M4)  nil)
(setf (DomVal-LeftChildType   M4)  nil)
(setf (DomVal-RightChild      M4)  nil)
(setf (DomVal-RightChildType  M4)  nil)

;; ***************************************************************************
;;
;; Domain Value E2 hierarchy
;;
;; ***************************************************************************

;; E2 ok

(setf (DomVal-Name            E2)  'E2)
(setf (DomVal-MyRoot          E2)  E2)
(setf (DomVal-Root            E2)  t)
(setf (DomVal-LeftParent      E2)  J3)
(setf (DomVal-LeftParentType  E2)  'or)
(setf (DomVal-RightParent     E2)  J4)
(setf (DomVal-RightParentType E2)  'or)
(setf (DomVal-LeftChild       E2)  L3)
(setf (DomVal-LeftChildType   E2)  'or)
(setf (DomVal-RightChild      E2)  L4)
(setf (DomVal-RightChildType  E2)  'or)
(setf (DomVal-NextSibling     E2)  nil)
(setf (DomVal-PrevSibling     E2)  E1)

;; J3 ok

(setf (DomVal-Name            J3)  'J3)
(setf (DomVal-MyRoot          J3)  E2)
(setf (DomVal-LeftParent      J3)  nil)
(setf (DomVal-LeftParentType  J3)  nil)
(setf (DomVal-RightParent     J3)  nil)
(setf (DomVal-RightParentType J3)  nil)
(setf (DomVal-LeftChild       J3)  nil)
(setf (DomVal-LeftChildType   J3)  nil)
(setf (DomVal-RightChild      J3)  E2)
(setf (DomVal-RightChildType  J3)  'or)

;; J4 ok

(setf (DomVal-Name            J4)  'J4)
(setf (DomVal-MyRoot          J4)  E2)
(setf (DomVal-LeftParent      J4)  nil)
(setf (DomVal-LeftParentType  J4)  nil)
(setf (DomVal-RightParent     J4)  nil)
(setf (DomVal-RightParentType J4)  nil)
(setf (DomVal-LeftChild       J4)  E2)
(setf (DomVal-LeftChildType   J4)  'or)
(setf (DomVal-RightChild      J4)  nil)
(setf (DomVal-RightChildType  J4)  nil)

;; L3

(setf (DomVal-Name            L3)  'L3)
(setf (DomVal-MyRoot          L3)  E2)
(setf (DomVal-LeftParent      L3)  nil)
(setf (DomVal-LeftParentType  L3)  nil)
(setf (DomVal-RightParent     L3)  E2)
(setf (DomVal-RightParentType L3)  'or)
(setf (DomVal-LeftChild       L3)  M5)
(setf (DomVal-LeftChildType   L3)  'and)
(setf (DomVal-RightChild      L3)  M6)
(setf (DomVal-RightChildType  L3)  'and)

;; M5

(setf (DomVal-Name            M5)  'M5)
(setf (DomVal-MyRoot          M5)  E2)
(setf (DomVal-LeftParent      M5)  nil)
(setf (DomVal-LeftParentType  M5)  nil)
(setf (DomVal-RightParent     M5)  L3)
(setf (DomVal-RightParentType M5)  'and)
(setf (DomVal-LeftChild       M5)  nil)
(setf (DomVal-LeftChildType   M5)  nil)
(setf (DomVal-RightChild      M5)  nil)
(setf (DomVal-RightChildType  M5)  nil)

;; M6

(setf (DomVal-Name            M6)  'M6)
(setf (DomVal-MyRoot          M6)  E2)
(setf (DomVal-LeftParent      M6)  L3)
(setf (DomVal-LeftParentType  M6)  'and)
(setf (DomVal-RightParent     M6)  nil)
(setf (DomVal-RightParentType M6)  nil)
(setf (DomVal-LeftChild       M6)  nil)
(setf (DomVal-LeftChildType   M6)  nil)
(setf (DomVal-RightChild      M6)  nil)
(setf (DomVal-RightChildType  M6)  nil)

;; L4

(setf (DomVal-Name            L4)  'L4)
(setf (DomVal-MyRoot          L4)  E2)
(setf (DomVal-LeftParent      L4)  E2)
(setf (DomVal-LeftParentType  L4)  'or)
(setf (DomVal-RightParent     L4)  nil)
(setf (DomVal-RightParentType L4)  nil)
(setf (DomVal-LeftChild       L4)  nil)
(setf (DomVal-LeftChildType   L4)  nil)
(setf (DomVal-RightChild      L4)  nil)
(setf (DomVal-RightChildType  L4)  nil)


;; ---------------------------------------------------------------------------
;;
;; Graph definition for AO-AC3 testing
;;
;; ---------------------------------------------------------------------------

(setq rfn #'R-relation)

(setq G1 (make-AC-Graph))

(setf (AC-Graph-Name           G1) 'G1)
(setf (AC-Graph-CVariableList  G1) 
      (list V0 V1 V2))
(setf (AC-Graph-ArcList        G1) 
      (list
       (list V0 (list V1))
       (list V1 (list V2))
       (list V2 (list V0)) ))
(setf (AC-Graph-ConstraintList G1)
      (list
       (list V0 V1 rfn)
       (list V1 V2 rfn)
       (list V2 V0 rfn) ))

(setq G2 (make-AC-Graph))

(setf (AC-Graph-Name           G2) 'G2)
(setf (AC-Graph-CVariableList  G2) 
      (list V2 V0 V1))
(setf (AC-Graph-ArcList        G2) 
      (list
       (list V0 (list V1))
       (list V1 (list V2))
       (list V2 (list V0)) ))
(setf (AC-Graph-ConstraintList G2)
      (list
       (list V0 V1 rfn)
       (list V1 V2 rfn)
       (list V2 V0 rfn) ))

(setq G3 (make-AC-Graph))

(setf (AC-Graph-Name           G3) 'G3)
(setf (AC-Graph-CVariableList  G3) 
      (list V1 V2 V0))
(setf (AC-Graph-ArcList        G3) 
      (list
       (list V0 (list V1))
       (list V1 (list V2))
       (list V2 (list V0)) ))
(setf (AC-Graph-ConstraintList G3)
      (list
       (list V0 V1 rfn)
       (list V1 V2 rfn)
       (list V2 V0 rfn) ))
