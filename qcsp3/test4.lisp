(in-package #:phd-qcsp3)
;; test4.lisp

(defun t4 (&optional (sys *unix*) )
  (if sys
      (progn
	(load  "test4.lisp")
	)
    (progn
      (load "HD:Languages:Allegro Common Lisp:qcsp:test4.lisp")
      )))

(defun load-t4 (&optional (sys *unix*) )
  (if (not sys)
    (progn
      (load "HD:Languages:Allegro Common Lisp:qcsp:comment")
      (load "HD:Languages:Allegro Common Lisp:qcsp:compile-ao")
      (load "HD:Languages:Allegro Common Lisp:qcsp:hierarchy")
      (load "HD:Languages:Allegro Common Lisp:qcsp:ac-graph")
      (load "HD:Languages:Allegro Common Lisp:qcsp:ao-ac3")
      (load "HD:Languages:Allegro Common Lisp:qcsp:ao-ac-new")
      (load "HD:Languages:Allegro Common Lisp:qcsp:ao-revise-fns")
      (load "HD:Languages:Allegro Common Lisp:qcsp:ao-revise")
      (load "HD:Languages:Allegro Common Lisp:qcsp:ao-revise-step")
      (load "HD:Languages:Allegro Common Lisp:qcsp:ao-revise-aggressive")
      (load "HD:Languages:Allegro Common Lisp:qcsp:applyr")
      (load "HD:Languages:Allegro Common Lisp:qcsp:example-extend")
      (load "HD:Languages:Allegro Common Lisp:qcsp:ac-graph")
      ;;(load "HD:Languages:Allegro Common Lisp:qcsp:example-simple")
      )
  (progn
      (load "comment")
      (load "compile-ao")
      (load "ac-graph")
      (load "hierarchy")
      (load "ao-ac3")
      (load "ao-ac-new")
      (load "ao-revise-fns")
      (load "ao-revise")
      (load "ao-revise-step")
      (load "ao-revise-aggressive")
      (load "applyr")
      (load "example-extend")
      ;;(load "example-simple")
    )))

;; ---------------------------------------------------------------------------


(defun testacns (&optional (cs 1))
  (load-t4)
  (let (
	(result  (if (eq cs 1) 
		     (ao-ac-new g1 2 :revise-mode 'step :debug-mode nil) 
		   (if (eq cs 2) 
		       (ao-ac-new g2 2 :revise-mode 'step :debug-mode nil)
		     (if (eq cs 3) 
			 (ao-ac-new g3 2 :revise-mode 'step :debug-mode nil) 
		       )))) )
    
    (comment1 "AO-ac-new (Step) Run Completed.  Constraint checks = " 
	      *constraint-count*)
    (comment1 "Variables and domains:" (list (graph-variable-list result)))
    
    result
  ))

(defun testacna (&optional (cs 1))
  (load-t4)
  (let (
	(result   (if (eq cs 1) 
		      (ao-ac-new g1 2 :revise-mode 'aggr :debug-mode nil)
		    (if (eq cs 2) 
			(ao-ac-new g2 2 :revise-mode 'aggr :debug-mode nil)
		      (if (eq cs 3) 
			  (ao-ac-new g3 2 :revise-mode 'aggr :debug-mode nil) 
			)))) )

    (comment1 "AO-ac-new (Aggr) Run Completed.  Constraint checks = " 
	      *constraint-count*)
    (comment1 "Variables and domains:" (list (graph-variable-list result)))

    result
  ))

;; ---------------------------------------------------------------------------

(defun testacs (&optional (cs 1))
  (load-t4)
  (let (
	(result  (if (eq cs 1) 
		     (ao-ac3 g1 2 :revise-mode 'step :debug-mode nil)
		   (if (eq cs 2) 
		       (ao-ac3 g2 2 :revise-mode 'step :debug-mode nil)
		     (if (eq cs 3) 
			 (ao-ac3 g3 2 :revise-mode 'step :debug-mode nil))))))
    
    (comment1 "AO-ac3 (Step) Run Completed.  Constraint checks = " 
	      *constraint-count*)
    (comment1 "Variables and domains:" (list (graph-variable-list result)))
    
    result
  ))

(defun testaca (&optional (cs 1))
  (load-t4)
  (let (
	(result   (if (eq cs 1) 
		      (ao-ac3 g1 2 :revise-mode 'aggr :debug-mode nil)
		    (if (eq cs 2) 
			(ao-ac3 g2 2 :revise-mode 'aggr :debug-mode nil)
		      (if (eq cs 3) 
			  (ao-ac3 g3 2 :revise-mode 'aggr :debug-mode nil))))))

    (comment1 "AO-ac3 (Aggr) Run Completed.  Constraint checks = " 
	      *constraint-count*)
    (comment1 "Variables and domains:" (list (graph-variable-list result)))

    result
  ))

;; ---------------------------------------------------------------------------

(defun testao1a () 
  (setq *constraint-count* 0)
  (setq AO1 (ao-revise v1 v2 rfn 2 :mode 'aggr)))
(defun testao2a () (setq AO2 (ao-revise v0 v1 rfn 2 :mode 'aggr)))
(defun testao3a () (setq AO3 (ao-revise v2 v0 rfn 2 :mode 'aggr)))

(defun test4a () 
  (load-t4)
  (testao1a) (testao2a)  (testao3a)   )

(defun testao1s () 
  (setq *constraint-count* 0)
  (setq AO1 (ao-revise v1 v2 rfn 2 :mode 'step )))
(defun testao2s () (setq AO2 (ao-revise v0 v1 rfn 2 :mode 'step )))
(defun testao3s () (setq AO3 (ao-revise v2 v0 rfn 2 :mode 'step )))

(defun test4s () 
  (load-t4)
  (testao1s) (testao2s)  (testao3s)   )

