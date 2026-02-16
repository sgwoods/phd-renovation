;; queens.lisp
;;
;; Queens backtracking solution with, without arc consistency checking
;;
;;           Original source 
;;           c/o Qiang Yang, Philip Wong
;;           University of Waterloo, January 1993
;;       
;;           Modifications and additions
;;           Steven Woods
;;           Defense Research Establishement Valcartier, March 1993


(defun queens (n &key 
		 (dom               "confused")  ;; 'queens
		 (search-mode           "bt")  ;; 'bm  'bj
		 (node-consis           nil)  ;; N/A
		 (node-force-all        nil)
		 (arc-consis            nil)  ;; nil/before/during/both
		 (forward-checking      nil)       
		 (dynamic-rearrangement nil)
		 (advance-sort          nil)     
		 (one-solution-only     nil)	
		 (cpu-sec-limit         300)  ;; 5 minutes cpu
		 (ck-pt-interval        150)  ;;  2 minutes cpu
		 (debug                 nil)	
		 (debug-csp             nil)	
		 (output-file           nil)	
)
"
Example program to solve the n-queens problem.  Takes one argument, the
size of the problem and has the same keywords as in BACKTRACKING.
"
;; insure Queens functions are loaded
;; arc-p consistent-p
(if (not (eq *domain-loaded* 'queens))
    (progn
      (load "queens")))

;; set up global variables
(if (not (set-globals (queens-variables n)
		      (list dom n) search-mode 
		      node-consis node-force-all arc-consis
		      forward-checking dynamic-rearrangement advance-sort
		      nil one-solution-only cpu-sec-limit ck-pt-interval
		      debug  debug-csp  output-file))
    (progn
      (comment "Exiting with a general setup error.")
      (return-from queens nil)))

;; Show set up options
(show-options)
  
(let
    (
     (init-var-set   *raw-variables*)               ;; raw backtrack values
     (arc-call       (if (or (eq arc-consis 'during)
			     (eq arc-consis 'both))
			 t nil))
     (arc-pre        (if (or (eq arc-consis 'before)
			     (eq arc-consis 'both))
			 t nil))
     )

  ;; Time advance constraint processing time
  (setq *internal-advance-start-time* (get-internal-run-time))

  ;; Setup initial variable set for backtracking ...
  (cond

   ((and node-consis arc-pre)
    (setq init-var-set 
	  (ac-3 (node-consistent-variables init-var-set
					   :force node-force-all) 
		#'arc-p #'consistent-p nil)) )
   (node-consis
    (setq init-var-set (node-consistent-variables init-var-set
						  :force node-force-all)) )

   (arc-pre
    (setq init-var-set (ac-3 init-var-set
			     #'arc-p #'consistent-p nil)) )
   ) ;; cond

  ;; Advance constraint processing completed.
  (setq *internal-advance-end-time*   (get-internal-run-time))

  ;; If advance sort requested of variable list, do so here
  (if advance-sort
      (progn
	(setq *internal-sort-start-time* (get-internal-run-time))
	(setq init-var-set (advance-sort init-var-set))
	(setq *internal-sort-end-time* (get-internal-run-time))
	))

  ;; record problem for later use in global lookups, etc
  (setq *variables* init-var-set)
  (setq *var-order* (mapcar #'(lambda (x) (first x)) init-var-set))

  ;; Invoke search, call backtracking for BT/BJ  or backmark for BM
  (cond
   ((or (equal search-mode "bt") (equal search-mode "bj"))
    ;; Invoke backtracking ...
    (backtracking 
     (make-initial-bt-state init-var-set)
     #'consistent-p
     :forward-checking      forward-checking
     :dynamic-rearrangement dynamic-rearrangement
     :one-solution-only     one-solution-only
     :backjump              (if (equal search-mode "bj") t nil)
     :arc-c                 arc-call
     ))
   ((equal search-mode "bm")
    ;; 
    ;; Note need to add flags such as one-solution-only yet.
    ;;
    (bm init-var-set 
	#'consistent-p))
   (t
    (comment1 "Error in search-mode value" search-mode))
   )))

;; **********************************************************************
;; queens variables
;; for create initial state from defined objects
  
(defun queens-variables (n)
    (let  ( 
            (common-domain nil) 
            (var-list nil) 
          )
        (dotimes (i n) 
            (setq common-domain (cons (- n i) common-domain)))
        (dotimes (i n var-list) 
            (setq var-list 
                (cons
                    (cons 
                        (list 'row (- n i))
                        common-domain)
                    var-list)))))

;; **************************************************
;; Node consistency
;;
(defun node-consistent-variables (variable-list &key (force nil))
"
Queens problem, not applicable.
"
variable-list)

;; **************************************************
;; Arc presence
;;
(defun arc-p (symbol1 symbol2)
"
Return true if there is an arc between symbol1 and symbol2.
This is the n-Queens version.
"
    (not (equal symbol1 symbol2))
)

;; **************************************************
;; Consistency
;;
(defun consistent-p (symbol1 value1 symbol2 value2 blist)
"
Optionally use q-queens or confused q-queens depending on dom.
 note that blist is not used in queens/confused.
"

(if *debug-consis* 
    (comment4 "Consistent-p <sym1 v1 sym2 v2 > ?"
	      symbol1 value1 symbol2 value2 ))

(setq *consistent-p-calls* (+ 1 *consistent-p-calls*))
(if (equal (car *domain-name*) "confused")
    (confused-consistent-p symbol1 value1 symbol2 value2)
    (queens-consistent-p symbol1 value1 symbol2 value2)))

;; **************************************************
;;
(defun queens-consistent-p (symbol1 value1 symbol2 value2)
"
Traditional q-queens, see Nadel in Nad89
Return true iff the instantiation of SYMBOL1 with VALUE1 is consistent with
the instantiation of SYMBOL2 with VALUE2.
"
(setq *constraint-cks* (+ 1 *constraint-cks*))
(if  *debug-consis* (comment1 " " *constraint-cks*))
(if 
    (and
     (/= value1 value2)
     (/=
      (abs (- value1 value2))
      (abs (- (second symbol1) (second symbol2))) ))
    (progn
      (if  *debug-consis* (comment1 "  Consistent succeed." nil))
      (list 't 0) )
  (progn
    (if  *debug-consis* (comment1 "  Consistent fail." nil))
    (list nil (get-constraint-max-level symbol2))
    )))

;; **************************************************
;;
(defun get-constraint-max-level ( ck-var )
"
Queens version.
"
(list-element-pos *var-order* ck-var) )

;; **************************************************
;;
(defun confused-consistent-p (symbol1 value1 symbol2 value2)
"
Confused q-queens, see Nadel in Nad89
Return true iff the instantiation of SYMBOL1 with VALUE1 is consistent with
the instantiation of SYMBOL2 with VALUE2.
"
(setq *constraint-cks* (+ 1 *constraint-cks*))
(if  *debug-consis* (comment1 " " *constraint-cks*))
(if 
    (or
     (= value1 value2)
     (=
      (abs (- value1 value2))
      (abs (- (second symbol1) (second symbol2)))) )
    (progn
      (if  *debug-consis* (comment1 "  Consistent succeed." nil))
      (list 't 0) )     
  (progn
    (if  *debug-consis* (comment1 "  Consistent fail." nil))
    (list nil (get-constraint-max-level symbol2))
    )))



;; **********************************************************************
;; queens test calls 

;; Default Queens
(defun q (n &optional (flag nil) (debug nil))
  (if (eq flag t)
      (setq out-f "test-output.q")
      (setq out-f t))
  (queens n 
	  :debug debug
	  :output-file out-f))

;; Simplified Queens
(defun qs (n &optional (flag nil) (debug nil))
  (if (eq flag t)
      (setq out-f "test-output.qs")
      (setq out-f t))
  (queens n 
	  :forward-checking nil
	  :dynamic-rearrangement nil
	  :debug debug
	  :output-file out-f))

;; CSP First Queens
(defun qc (n &optional (flag nil) (debug nil))
  (if (eq flag t)
      (setq out-f "test-output.qc")
      (setq out-f t))
  (queens n 
	  :mode 'ac-3
	  :debug debug
	  :output-file out-f ))

;; **********************************************************************
;; confused queens test calls 

;; Default C Queens
(defun cq (n &optional (flag nil) (debug nil))
  (if (eq flag t)
      (setq out-f "test-confused.q")
      (setq out-f t))
  (queens n 
	  :dom 'confused
	  :debug debug
	  :output-file out-f))

;; Simplified C Queens
(defun cqs (n &optional (flag nil) (debug nil))
  (if (eq flag t)
      (setq out-f "test-confused.qs")
      (setq out-f t))
  (queens n 
	  :dom 'confused
	  :forward-checking nil
	  :dynamic-rearrangement nil
	  :debug debug
	  :output-file out-f))

;; CSP First C Queens
(defun cqc (n &optional (flag nil) (debug nil))
  (if (eq flag t)
      (setq out-f "test-confused.qc")
      (setq out-f t))
  (queens n 
	  :dom 'confused
	  :mode 'ac-3
	  :debug debug
	  :output-file out-f ))

;; **********************************************************************
;; SET LOADED FLAG 
;; **********************************************************************
(setq *domain-loaded* 'queens)

