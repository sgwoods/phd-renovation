(in-package #:phd-qcsp-may29)
;; test4.lisp

(defun t4 ()
  (load "test4.lisp"))

(defun load-t4 ()
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
  (load "example-extend"))

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

