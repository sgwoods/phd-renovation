;; mpr-setup.lisp

;;
;; MPR situation and template information
;;
(setq *mpr-setup-loaded* 'nil)
;; **********************************************************************
;; All situation options
(defparameter *situations*
      (list
       '( "test-1"
	     ( sit1-1  (45 50)  ARI   Adv n co)
	     ( sit1-2  (50 50)  ARM   Adv n co)
	     ( sit1-3  (57 50)  ARI   Adv n co)
	     ( sit1-4  (50 48)  ART   Adv n co)
	     ( sit1-5  (50 42)  AIHQ  Adv n co)

	     ( sit2-1  (30 30)  ARI   Adv nw co)
	     ( sit2-2  (38 38)  ARI   Adv nw co)

	     ( sit3-1  (70 30)  ARI   Adv ne co)
	     ( sit3-2  (74 26)  ARM   Adv ne co)
	     ( sit3-3  (79 21)  ARI   Adv ne co)
	     ( sit3-4  (69 21)  ART   Adv ne co)
	     ( sit3-5  (67 19)  AIHQ  Adv ne co)
	     )

       '( "d1"
	     ( sit1  (27 17)  AIHQ    Adv ne co)
	     ( sit7  (22 21)  ARM  Adv ne co)
	     ( sit5  (32 14)  ARM  Adv ne co)
	     ( sit10 (24 16)  ARI Adv ne co)
	     ( sit14 (23 12)  ART Adv ne co)
	     )

       '( "d2"
	     ( sit6  (6 19)   AIHQ    Adv w co)
	     ( sit2  (6 12)   ARM  Adv w co)
	     ( sit8  (6 26)   ARM  Adv w co)
	     ( sit4  (10 19)  ARI Adv w co)
	     ( sit3  (16 19)  ART Adv w co)

	     )

       '( "d3"
	     ( sit1  (27 17)  AIHQ    Adv ne co)
	     ( sit7  (22 21)  ARM  Adv ne co)
	     ( sit5  (32 14)  ARM  Adv ne co)
	     ( sit10 (24 16)  ARI Adv ne co)
	     ( sit14 (23 12)  ART Adv ne co)
	     ( sit6  (6 19)   AIHQ    Adv w co)
	     ( sit2  (6 12)   ARM  Adv w co)
	     ( sit8  (6 26)   ARM  Adv w co)
	     ( sit4  (10 19)  ARI Adv w co)
	     ( sit3  (16 19)  ART Adv w co)
	     )

       '( "sit-bj"
	     ( sit-b1  (3 8)      ARM  Adv ne co)
	     ( sit-b2  (3 7)      ARM  Adv ne co)
	     ( sit-b3  (2 5.5)    ART Adv ne co)
	     ( sit-b4  (1.9 9.1)  ART Adv ne co)
	     ( sit-b6  (6 7)      ARI Adv ne co)
	     ( sit-b7  (6 8)      ARI Adv ne co)
	     ( sit-b8  (5 5)      AIHQ    Adv ne co)
	     ( sit-b9  (4 6)      AIHQ    Adv ne co)
	     )
       ))

;;  **********************************************************************
;; Situation distribution options predefined
;;
;; note that undefined orientation not supported at this time.
;;   

(defparameter *distributions*
      '(
	( "ddist" 
	  ( (ARM 1) (AIHQ 1) (ARI 1) (ART 1) (* 1) )
	  ( (Grp 1) (Co 1) (Bn 1) (Pl 1) (* 1) )
	  ( (Adv 1) (Rec 1) (Dep 1) (Ret 1) (* 1) )
	  ( (n 1) (ne 1) (e 1) (se 1) (s 1) (sw 1) (w 1) (nw 1) (* 0) )
	  )
	( "dist1"
	  ( (ARM 1) (AIHQ 1) (ARI 1) (ART 3) (* 1) )
	  ( (Grp 1) (Co 1) (Bn 1) (Pl 2) (* 1) )
	  ( (Adv 1) (Rec 1) (Dep 2) (Ret 1) (* 1) )
	  ( (n 1) (ne 1) (e 1) (se 1) (s 1) (sw 1) (w 1) (nw 1) (* 0) )
	  )
	( "dist2"
	  ( (ARM 1) (AIHQ 1) (ARI 1) (ART 1) (* 1) )
	  ( (Grp 1) (Co 1) (Bn 1) (Pl 1) (* 1) )
	  ( (Adv 1) (Rec 1) (Dep 1) (Ret 1) (* 1) )
	  ( (n 1) (ne 1) (e 1) (se 1) (s 1) (sw 1) (w 1) (nw 1) (* 0) )
	  ) ))

;; **********************************************************************
;; All template options
;;
;;  note that the order in which constraints are listed here will determine
;;   the order in which they are checked in absence of a request to sort
;;   them before application time.

;; Note 3-ary constraint removed temporarily for testing in demo1b, not demo1a

;; (slot type activity orientation abs-loc size)

(defparameter *template-object-list* 
      (list 
       '( "test1-w"
	  (
	   (ts1 ARI  (Adv Rec) * * Co)
	   (ts2 ARM  (Adv Rec) * * Co)
	   (ts3 ARI  (Adv Rec) * * Co)
	   (ts4 ART  *         * * Co)
	   (ts5 AIHQ *         * * Co)
	   )
	  (
	   (sep (ts1 ts2) (5 7))               
	   (left-of   (ts1 ts2))
	   (sep (ts2 ts3) (5 7))
	   (right-of  (ts3 ts2))
	   (sep (ts2 ts4) (2 4))
	   (behind-of  (ts4 ts2))
	   (sep (ts4 ts5) (4 6))
	   (behind-of (ts5 ts4))
 	   (echelon   (ts2 ts4) (2))
	   (echelon   (ts2 ts5) (2))
	   (same-attr-orient (ts1 ts3))
	   )
	  ( (ts1 20) (ts2 20) (ts3 20) (ts4 20) (ts5 20) )
	  )
       '( "test1-wb"
	  (
	   (ts1 ARI  (Adv Rec) * * Co)
	   (ts2 ARM  (Adv Rec) * * Co)
	   (ts3 ARI  (Adv Rec) * * Co)
	   (ts4 ART  *         * * Co)
	   (ts5 AIHQ *         * * Co)
	   )
	  (
	   (sep (ts1 ts2) (5 7))               
	   (left-of   (ts1 ts2))
	   (sep (ts2 ts3) (5 7))
	   (right-of  (ts3 ts2))
	   (sep (ts2 ts4) (2 4))
	   (behind-of  (ts4 ts2))
	   (sep (ts4 ts5) (4 6))
	   (behind-of (ts5 ts4))
 	   (echelon   (ts2 ts4) (2))
	   (echelon   (ts2 ts5) (2))
	   (same-attr-orient (ts1 ts3))
	   )
	  ( (ts1 20) )
	  )

       '( "test1-m"
	  (
	   (ts1 ARI  * * * Co)
	   (ts2 ARM  * * * Co)
	   (ts3 ARI  * * * Co)
	   (ts5 (ARI AIHQ) * * * Co)
	   )
	  (
	   (sep (ts1 ts2) (4 8))               
	   (left-of   (ts1 ts2))
	   (sep (ts2 ts3) (4 8))
	   (right-of  (ts3 ts2))
	   (sep (ts2 ts5) (6 10))
	   (behind-of  (ts5 ts2))
	   (echelon   (ts2 ts5) (4))
	   (same-attr-orient (ts1 ts3))
	   )
	  ( (ts1 20) (ts2 20) (ts3 20) (ts5 20) )
	  )

       '( "test1-s"
	  (
	   (ts1 (ARI ARM) * * * (Co Grp))
	   (ts3 (ARI ARM) * * * (Co Grp))
	   )
	  (
	   (sep (ts1 ts3) (8 16))
	   (right-of  (ts3 ts1))
	   )
	   ( (ts1 20) (ts3 20) )
	  )

       '( "test1-w-restrict0"
	  (
	   (ts1 ARI  (Adv Rec) * * Co)
	   (ts2 ARM  (Adv Rec) * * Co)
	   (ts3 ARI  (Adv Rec) * * Co)
	   )
	  (
	   (sep (ts1 ts2) (5 7))               
	   (left-of   (ts1 ts2))
	   (sep (ts2 ts3) (5 7))
	   (right-of  (ts3 ts2))
	   (same-attr-orient (ts1 ts3))
	   )
	   ( (ts1 20) (ts2 20) (ts3 20) )
	  )

       '( "test1-w-restrict1"
	  (
	   (ts1 ARI  (Adv Rec) * * Co)
	   (ts2 ARM  (Adv Rec) * * Co)
	   (ts3 ARI  (Adv Rec) * * Co)
	   )
	  (
	   (sep (ts1 ts2) (3 9))               
	   (left-of   (ts1 ts2))
	   (sep (ts2 ts3) (3 9))
	   (right-of  (ts3 ts2))
	   )
	   ( (ts1 20) (ts2 20) (ts3 20) )
	  )

       '( "test1-w-restrict2"
	  (
	   (ts1 ARI  * * * Co)
	   (ts2 ARM  * * * Co)
	   (ts3 ARI  * * * Co)
	   )
	  (
	   (sep (ts1 ts2) (3 9))               
	   (left-of   (ts1 ts2))
	   (sep (ts2 ts3) (3 9))
	   (right-of  (ts3 ts2))
	   )
	   ( (ts1 20) (ts2 20) (ts3 20) )
	  )

       '( "demo1a"
	  (
	   (ts1 ARM   Adv * * * *)
	   (ts2 AIHQ  Adv * * * *)
	   (ts3 ARM   Adv * * * *)
	   (ts4 ARI   Adv * * * *)
	   (ts5 ART   Adv * * * *)
	   )
	  (
	   (sep (ts1 ts2) (5 7))               
	   (left-of   (ts1 ts2))
	   (sep (ts2 ts3) (5 7))
	   (right-of  (ts3 ts2))
	   (sep (ts2 ts4) (2 4))
	   (ahead-of  (ts2 ts4))
	   (sep (ts4 ts5) (4 6))
	   (behind-of (ts5 ts4))
 	   (echelon   (ts2 ts4) (2))
	   (echelon   (ts2 ts5) (2))
	   (same-attr-orient (ts1 ts3))
	   ))

       '( "demo1a-II"
	  (
	   (ts1 ARM  Adv * * *)
	   (ts2 AIHQ    Adv * * *)
	   (ts3 ARM  Adv * **)
	   )
	  (
	   (same-attr-orient (ts1 ts3))
	   (sep (ts1 ts2) (5 7))               
	   (left-of   (ts1 ts2))
	   (sep (ts2 ts3) (5 7))
	   (right-of  (ts3 ts2))
	   ))


       '( "demo1a-I"
	  (
	   (ts1 ARM  Adv * * *)
	   (ts3 ARM  Adv * * *)
	   )
	  (
	   (same-attr-orient (ts1 ts3))
	   (right-of  (ts3 ts1))
	   (sep (ts2 ts4) (10 14))
	   ))

       '( "demo1b"
	  (
	   (ts1 ARM  Adv * * *)
	   (ts2 AIHQ    Adv * * *)
	   (ts3 ARM  Adv * * *)
	   (ts4 ARI Adv * * *)
	   (ts5 ART Adv * * *)
	   )
	  (
	   (sep (ts1 ts2) (5 7))               
	   (left-of   (ts1 ts2))
	   (sep (ts2 ts3) (5 7))
	   (right-of  (ts3 ts2))
	   (sep (ts2 ts4) (2 4))
	   (ahead-of  (ts2 ts4))
	   (med-dist  (ts1 ts2 ts3) (2))
	   (sep (ts4 ts5) (4 6))
	   (behind-of (ts5 ts4))
 	   (echelon   (ts2 ts4) (2))
	   (echelon   (ts2 ts5) (2))
	   (same-attr-orient (ts1 ts3))
	   ))

       '( "demo-bj"
	  (
	   (ts1 ARM  Adv * * *)
	   (ts2 AIHQ    Adv * * *)
	   (ts3 ARI Adv * * *)
	   (ts4 ART Adv * * *)
	   )
	  (
	   (sep (ts1 ts4) (0 2))
	   (sep (ts2 ts4) (0 5))
	   ))

       '( "demo-simple"
	  (
	   (ts1 ARM  Adv * * *)
	   (ts3 ARM  Adv * * *)
	   )
	  (
	   (sep (ts1 ts3) (2 20))
	   (right-of  (ts3 ts1))
	   (same-attr-orient (ts1 ts3))
	   ))
       ))

;; limit abs-loc to one template
;;	   (ts1 ARM  Adv * (20 20 25 25) )

;; ***************************************************************************
;; Functions to create random situation objects for noise 
;; ***************************************************************************

(defun create-ran-situation (size-sit type size activity orient)
  (let (
	(newlist  nil)
	)

    (setup-proportion 
     (reverse type) (reverse size) (reverse activity) (reverse orient))
     
    (dotimes (n size-sit newlist)
      (setq newlist
	    (append (list (ran-sit-object))
		    newlist))) ))

(defun setup-proportion (type size activity orient)
  (setq *ran-type-lst* (create-random-lst type))
  (setq *ran-size-lst* (create-random-lst size))
  (setq *ran-activity-lst* (create-random-lst activity))
  (setq *ran-orient-lst* (create-random-lst orient)) )

(defun create-random-lst (prop-lst)
  (let ( (in-prog nil )	)
    (dolist (this prop-lst in-prog)
      (setq in-prog (append (n-vals (first this) (second this)) in-prog)) )))

(defun n-vals (what many)
  (let ( (newlist nil) )
    (dotimes (n many newlist)
      (setq newlist (cons what newlist)))))

(defun ran-sit-object ()
"Create a random situation object as *noise* for the MPR."
(list (create-sit-id) 
      (random-position)
      (ran-type) 
      (ran-activity) 
      (ran-orient) 
      (ran-size) ))
  
(defun create-sit-id ()
"Create unique situation identifier."
  (gentemp "sit-gen"))

(defun ran-type ()
"Randomly select a type value."
  (random-element *ran-type-lst*))

(defun ran-activity ()
"Randomly select an activity value."
  (random-element *ran-activity-lst*))

(defun ran-size ()
"Randomly select a size value."
  (random-element *ran-size-lst*))

(defun ran-orient ()
"Randomly select an orientation value."
  (random-element *ran-orient-lst*))

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

(defun random-position (&optional (boundx 100) (boundy 100))
"Generate a random x y position (x y) between boundx and boundy."
  (let (
	(ranx (random boundx))
	(rany (random boundy))
	)
    (list ranx rany)))

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
		    "~2&***** ~A Template Description ***** ~2&" template-id)
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
	    (format *output-stream*
		    "~&~& SCHs: ~A ~&" (length 
					     (get-templ-cohesion-constr template)))
	    (dolist (c (get-cohesion-constr template))
	      (format *output-stream* "~&~& SCH Constr: ~A ~&" c))
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
	  
	    ))))
  t)

(defun mpr-set-global-values (sit-id sit-noise random-ident temp-id sch-call 
				     rand-dist-id
				     rand-dist-struct
				     long-output
				     single-line-override)
"
MPR structure set up.
"
(let (
      (mpr-err nil)
      )

  ;; Situation setup 
  (setq *current-situation* 
	(get-situation sit-id *situations* ))

  (if (eq *current-situation* nil)
      (progn 
	(setq mpr-err t)
	(comment1 "Situation not found" sit-id)
	))
  (setq *sit-object-id* sit-id)

  ;; Distribution of situation attributes
  (setq *random-dist-name* rand-dist-id)
  (setq *random-dist* rand-dist-struct)

  ;; Output long option
  (setq *long-output* long-output)

  ;; Override output option
  (setq *single-line-override* single-line-override)

  ;; Noise addition to situation
  ;;  Note anomaly that PREPARED elements are at the front of the
  ;;  siutation list and consequently will be at the front of the
  ;;  variable domain lists and be selected first.  There should either
  ;;  be the option to randomize HERE or at selection time in the various
  ;;  search algorithm.  BEST here since then there is only one location for
  ;;  this, HOWEVER  doing it here will result in the same order of initial
  ;;  domain values for EVERY VARIABLE, while in the search routine if a 
  ;;  random position were selected, the order would vary...
  (setq *situation-noise-added* sit-noise)
  (if (not (numberp sit-noise))
      (progn
	(setq mpr-err t)
	(comment1 "Sit noise must be a number" sit-noise))
    (if (> sit-noise 0)
	(let (
	      (noise (create-ran-situation sit-noise
					   (first  rand-dist-struct) ;; type
					   (second rand-dist-struct) ;; size
					   (third  rand-dist-struct) ;; activ
					   (fourth rand-dist-struct) ;; orient
					   ))
	      )
	  (setq *current-situation* (append *current-situation*
					    noise)) )))

  ;; random-ident
  (setq *random-ident* random-ident)

  ;; Template setup
  (setq *current-template* 
	(get-templ-object temp-id))
  (if (eq *current-template* nil)
      (progn
	(setq mpr-err t)
	(comment1 "Template not found" temp-id)
	))
  (setq *template-id* temp-id)

  (setq *constraint-sch-on* sch-call)    ;; separation constraints

  ;; specific counters for mpr only
  (setq *constraint-sep-cks* 0)    ;; separation constraints
  (setq *constraint-sch-cks* 0)    ;; spatial cohes constraints
  (setq *sch-save* 0)              ;; spatial cohes savings - dom vals remv
  (setq *constraint-pos-cks* 0)    ;; right/left/ahead/behind constraints
  (setq *constraint-med-cks* 0)    ;; medial  constraints
  (setq *constraint-ech-cks* 0)    ;; echelon constraints
  (setq *constraint-same-type-cks* 0)
  (setq *constraint-same-orient-cks* 0)
  (setq *constraint-same-activity-cks* 0)
  (setq *constraint-same-size-cks* 0)

  (setq *node-consistency-calls*  0)  ;; cost of initial filtering
  (setq *node-consistency-checks* 0)
  (setq *ts-match-activity-count* 0)
  (setq *ts-match-size-count*     0)
  (setq *ts-match-orient-count*   0)
  (setq *ts-match-type-count*     0)
  (setq *ts-match-abs-loc-count*     0)

  (setq *unique-restrict-count* 0) ;; uniqueness rejections

 (if mpr-err
     nil
   t)
))

;; save versions for MPR
 
(defun save-situation ( name size )
"
(MPR version)
Save current situation for later display or review.
We *could* re-use these instead of recreating ... save a little time.
"
(let (
      (situation-file  (concatenate 'string "MPR-Situation/Sit" 
		    "-" (string-downcase (string *sit-object-id*)) 
		    "-" (string-downcase (string *random-dist-name*)) 
		    "-" (string-downcase (string name))
		    "-" (num-to-string size) ))
      )
  (if (not (probe-file situation-file))
      (progn
	(setq *situation-stream*
	      (open situation-file 
		    :direction :output 
		    :if-exists :overwrite
		    :if-does-not-exist :create))
	(write *current-situation* :stream *situation-stream*)
	(close *situation-stream*)
	t)
    nil)
  ))

(defun save-rand ( name )
"
Save current random-state object for later recreation of this run.
"
(let (
      (random-file  (concatenate 'string "MPR-Random/Rnd" (string-downcase (string name))))
      )
;  (break "in save-rand")
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
(let (
      (random-file (concatenate 'string "MPR-Random/Rnd" 
				(string-downcase (string name))))
      )
;  (break "in load-rand")
  (setq *random-state* (read (open random-file :direction :input)))
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
  (loop while (not unique) do
	(setq newstr nil)
	(dotimes (i 10)
	  (let (
		(this (random 10))
		)
	    (setq newstr (concatenate 'string newstr (num-to-letter this)))))
	(if (not (probe-file (concatenate 'string "MPR-Random/Rnd" 
				 (string-downcase (string newstr)))))
	    (setq unique t)))
  newstr))

;; gnuplot output specific to MPR

;; **************************************************
;;
(defun save-gnuplot ( name size )
"
MPR  Version
Output gnuplot suitable files for later display
of individual situations.
"
(let* (
       (type-red       (select-type 'AIHQ    *current-situation*))
       (type-green     (select-type 'ARM     *current-situation*))
       (type-purple    (select-type 'ARI     *current-situation*))
       (type-yellow    (select-type 'ART     *current-situation*))
       (red-file       (concatenate 'string "MPR-Situation/.Sit" 
			    "-" (string-downcase (string *sit-object-id*)) 
			    "-" (string-downcase (string *random-dist-name*)) 
			    "-" (string-downcase (string name)) 
			    "-" (num-to-string size) "." "r"))
       (green-file     (concatenate 'string "MPR-Situation/.Sit" 
			    "-" (string-downcase (string *sit-object-id*)) 
			    "-" (string-downcase (string *random-dist-name*)) 
			    "-" (string-downcase (string name)) 
			    "-" (num-to-string size) "." "g"))
       (yellow-file    (concatenate 'string "MPR-Situation/.Sit" 
			    "-" (string-downcase (string *sit-object-id*)) 
			    "-" (string-downcase (string *random-dist-name*)) 
			    "-" (string-downcase (string name)) 
			    "-" (num-to-string size) "." "y"))
       (purple-file    (concatenate 'string "MPR-Situation/.Sit" 
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


(setq *mpr-setup-loaded* 't)


