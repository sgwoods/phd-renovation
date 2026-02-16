;; utility.lisp
(defun cu () (compile-file "utility")  (load "utility"))

(setq *output-stream* *standard-output*)

;; **********************************************************************
;; Global var initialization

(defun set-globals ( raw-variables 
		     dom 
		     search-mode 
		     node-consis 
		     node-type-consis 
		     node-force-all 
		     arc-consis
		     fc 
		     dr 
		     dfa-r
		     adv 
		     sortc 
		     adv-sortc
		     os 
		     cpu 
		     ckpt
		     debug 
		     debug-csp 
		     debug-node
		     output-file )

  ;; **********************************************************************
  ;; Parameter globals

  (setq *error* 0)

  (if (null raw-variables)
      (progn
	(setq *error* 1)
	(comment1 "Initial raw variables in error") )
    (progn
      (setq *raw-variables* raw-variables)
      (setq *variables* 'not-yet-assigned)
      (setq *var-order* (mapcar #'(lambda (x) (first x)) raw-variables))
      (setq *var-order-note* 'initial)
      (setq *number-of-units* (length *raw-variables*)) ))

  ;; domain name
  (setq *domain-name* dom)    

  ;; search mode
  (setq *backjump* nil)
  (setq *backtrack* nil)
  (setq *backmark* nil)

  (setq *search-mode* search-mode)   

  (if (member-string *search-mode* '("bt" "bm" "bj" "qu" "gsat"))
      (if (equal search-mode "bj")
	  (setq *backjump* t)
	(if (equal search-mode "bm")
	    (setq *backmark* t) 
	  (if (equal search-mode "bm")
	      (setq *backtrack* t)
	    (if (equal search-mode "gsat")
		(setq *gsat* t)
	      (if (equal search-mode "qu")
		  (setq *quilici* t))))))
    (progn
      (setq *error* 2)
      (comment1 "Search mode in error" search-mode)))

  ;; node consistency
  (if (member node-consis '(t nil))
      (setq *node-consis* node-consis)
    (progn
      (setq *error* 3)
      (comment1 "Node consis in error" node-consis)))

  ;; node type consistency
  (if (member node-type-consis '(t nil))
      (setq *node-type-consis* node-type-consis)
    (progn
      (setq *error* 3b)
      (comment1 "Node Type consis in error" node-type-consis)))

  ;; node force all
  (if (member node-force-all '(t nil))
      (setq *node-force-all* node-force-all)
    (progn
      (setq *error* 4)
      (comment1 "Node force-all in error" node-force-all)))

  ;; arc consistency
  (if (member arc-consis '(nil before during both))
      (if (and (equal *search-mode* "qu")
	       (or (eq arc-consis 'during) (eq arc-consis 'both)))
	  (progn
	    (comment1 "Inconsistent arc-consis value with Quilici." arc-consis)
	    (setq *error* 4.5)
	  )
	(setq *arc-consis* arc-consis))
    (progn
      (setq *error* 5)
      (comment1 "Arc consis in error" arc-consis)))

  ;; forward checking
  (if (member fc '(t nil))
      (setq *forward-checking* fc)
    (progn
      (setq *error* 6)
      (comment1 "Forward checking in error" fc)))

  ;; advance-sort (variables !!)
  (if (member adv '(t nil random quilici))
      (setq *advance-sort* adv)
    (progn
      (setq *error* 7)
      (comment1 "Advance sort in error" adv)))

  ;; sort-const (inline)
  (if (member sortc '(t nil random))
      (setq *sort-const* sortc)
    (progn
      (setq *error* 7.5)
      (comment1 "Sort Const in error" sortc)))

  ;; sort-const (in advance !!)
  (if (member adv-sortc '(nil random quilici))
      (setq *adv-sort-const* adv-sortc)
    (progn
      (setq *error* 7.7)
      (comment1 "Advance Sort Const in error" adv-sortc)))

  ;; dynamic rearrangement
  (if (member dr '(t nil))
      (setq *dynamic-rearrangement* dr)
    (progn
      (setq *error* 8)
      (comment1 "Dynamic rearrangement checking in error" dr)))

  ;; dfa rearrangement
  (if (member dfa-r '(t nil))
      (setq *dfa-rearrangement* dfa-r)
    (progn
      (setq *error* 8b)
      (comment1 "Data Flow Analysis rearrangement checking in error" dfa-r)))

  ;; one solution only
  (if (member os '(t nil))
      (setq *one-solution-only* os)
    (progn
      (setq *error* 9)
      (comment1 "One solution only in error" os)))

  ;; cpu limit
  (if (numberp cpu)
      (setq *cpu-sec-limit* cpu)
    (progn
      (setq *error* 10)
      (comment1 "Not numberp cpu limit" cpu)))

  ;; ckpt limit
  (if (numberp ckpt)
      (progn
	(setq *check-point-interval* ckpt)
	(setq *this-check-point* ckpt)
	)
    (progn
      (setq *error* 11)
      (comment1 "Not numberp ckpt intercal" ckpt)))

  ;; debug
  (if (member debug '(t nil))
      (setq *debug* debug)
    (progn
      (setq *error* 12)
      (comment1 "Debug in error" debug)))

  ;; debug csp
  (if (member debug-csp '(t nil))
      (progn
	(setq *debug-consis* debug-csp)
	(setq *debug-ac* debug-csp) 
	(setq *debug-q* debug-csp))
    (progn
      (setq *error* 13)
      (comment1 "Debug-csp in error" debug-csp)))


  ;; debug node
  (if (member debug-node '(t nil))
      (progn
	(setq *debug-node* debug-node))
    (progn
      (setq *error* 13b)
      (comment1 "Debug-node in error" debug-node)))

  ;; file output
  (setq *file-output* nil)
  (setq *whole-file-name* 
	(if *unix* 
	    (concatenate 'string ""
			 output-file)
	  (concatenate 'string  
		       "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ADT-Batch:Test-"
		       output-file))) 
  (setq *output-stream* 
	(cond ((or (eq output-file t) (null output-file)) 
	       *standard-output*)
	      ((eq output-file 'no-output) nil)
	      (t 
	       (setq *file-output* t)
	       (comment1 "Opening output file/stream for :" *whole-file-name*)
	       (open *whole-file-name*
		     :direction :output 
		     :if-exists :append 
		     :if-does-not-exist :create)
	      )))

  ;; **********************************************************************
  ;; State globals

  (reset-node-id)  ;; reset search node counter

  ;; **********************************************************************
  ;; Result globals

  (setq *internal-end-time*   0) 
  (setq *internal-start-time* 0)

  (setq *internal-advance-end-time*   0) 
  (setq *internal-advance-start-time* 0)

  (setq *internal-sort-start-time*   0) 
  (setq *internal-sort-end-time*   0) 

  (setq *node-consis-decision* nil)
  (setq *constraint-fail* nil)
  (setq *arc-constraint-fail* nil)

  (setq *satisfy-p-calls* 0)
  (setq *satisfy-p-cost* 0)

  (setq *constraint-cks* 0)
  (setq *consistent-p-calls* 0)
  (setq *consistent-null-arcs* 0)

  (setq *backtrack-nodes-created* 0)
  (setq *backjump-count* 0)

  (setq *ac-count-compat* 0)
  (setq *ac-count-notcompat* 0)

  (setq *nodes-visited* 0)

  (setq *for-check-calls* 0)
  (setq *for-check-cost* 0)

  (setq *dyn-rearr-calls* 0)
  (setq *dyn-rearr-cost*  0)

  (setq *dfa-rearr-calls* 0)
  (setq *dfa-rearr-cost*  0)

  (setq *type-a-savings* 0)
  (setq *type-b-savings* 0)

  (setq *solution-set* nil)

  (if (> *error* 0)
      nil
    t)
)

;; ---------------------------------------------------------------------------

;; **********************************************************************
;; Recording functions
;;
;; *constraint-fail*  
;;     all cases where a constraint failed in consistent-p
;; *node-consis-decision*
;;     at assignment time, why a sit was rejected for a slot (all)

(defun explain ()
  (show-node-fail)
  (show-cons-fail) )

(defun record-fail (ts1 s1 ts2 s2 constraint)
"
Keep track of failed constraint justifications.
"
(setq *constraint-fail* 
      (append *constraint-fail*
	      (list (list ts1 s1 ts2 s2 constraint)))))

(defun show-cons-fail ()
"
"
(format *output-stream* "~% Failed Constraint checks (ARC-pre) ... ~2%")
(dolist (element *arc-constraint-fail*)
  (format *output-stream* "~A ~%" element))

(format *output-stream* "~% Failed Constraint checks (Search) ... ~2%")
(dolist (element *constraint-fail*)
  (format *output-stream* "~A ~%" element)) )

(defun record-node-fail (tslot-id sit-obj-id match-type match-orient
				  match-activity match-abs-loc match-size)
"
Keep track of failed node domain assignments.
"
(setq *node-consis-decision*
      (append *node-consis-decision*
	      (list
	       (list (list tslot-id sit-obj-id) (list match-type match-orient 
					    match-activity match-abs-loc
					    match-size ))))))

(defun explain-node-fail (ts1 s1)
"
Return node consistent rejection if it exists for ts1 assigned s1.
"
 (find-node-consis *node-consis-decision* (list ts1 s1)) )

(defun find-node-consis ( objlist ident )
(if (equal objlist nil)
    nil
  (if (equal ident (first (car objlist)))
      (car objlist)
    (find-node-consis (cdr objlist) ident))) )


(defun abort-fail (commentIn)
(format *output-stream* 
	"~&~& ABORT :: ~A ~&" commentIn) )


(defun show-node-fail ()
  (format *output-stream* "~% Node consistency checks ... ~%")
  (format *output-stream* 
	  "~%      Slot Value         Type  Size   Act  Or   Loc~2%")
  (dolist (element *node-consis-decision*)
    (format *output-stream* "~5T<~A~11T~A>~25T~A~31T~A~37T~A~43T~A~49T~A~%"
	    (first  (first element))
	    (second (first element))
	    (first (second element))
	    (second (second element))
	    (third (second element))
	    (fourth (second element)) 
	    (fifth (second element))
	    )))

(defun var-set-characterize (var-set &optional (where 'default) )
"
"
(let* (
       (var-lengths (get-var-lengths var-set))   ;; ((var length) ... )
       (max    (get-max-var-len var-lengths 0 nil  ))  ;;(var size)
       (min    (get-min-var-len var-lengths 99999 nil))  ;;(var size)
       (avg    (get-avg-var-len var-lengths))  ;;size
       )
  (if (not *single-line-override*)
      (progn
	(format *output-stream*  "Domain size ( ~A ) statistics ... ~%" where)
	(format *output-stream*  
		"Max[~A]  Min[~A]  Avg[~A] ~2%" max min avg)))) )

(defun get-var-lengths (var-set)
(if (null var-set)
    nil
  (append 
   (list (list (first (car var-set)) (length (rest (car var-set)))))
   (get-var-lengths (cdr var-set)) )))

(defun get-max-var-len (var-len prev-max prev-var)
  (if (null var-len)
      (list prev-var prev-max)
    (let* (
	   (this     (car var-len))
	   (this-var (first  this))
	   (this-len (second this))
	   )
      (if (> this-len prev-max)
	  (get-max-var-len (cdr var-len) this-len this-var)
	(get-max-var-len (cdr var-len) prev-max prev-var) ))) )

(defun get-min-var-len (var-len prev-min prev-var)
  (if (null var-len)
      (list prev-var prev-min)
    (let* (
	   (this     (car var-len))
	   (this-var (first  this))
	   (this-len (second this))
	   )
      (if (< this-len prev-min)
	  (get-min-var-len (cdr var-len) this-len this-var)
	(get-min-var-len (cdr var-len) prev-min prev-var) ))) )

(defun get-avg-var-len (var-len)
  (let (
	(total   0)
	(count   (length var-len))
	)
    (if (eq count 0)
	0
      (progn
	(dolist (element var-len)
	  (setq total (+ total (second element))) )
	(/ (* total 1.0) count) ))))
  
;; **********************************************************************
;; Utility functions

(defun l () (load "load"))
(defun c () (compile-all))
(defun lm () (load "mpr-simple"))
(defun la () (load "adt-simple") (load "adt-setup"))
(defun lqueens   () (load "queens"))
(defun lmpr () (load "mpr-simple") (load "mpr-setup"))

(defun create-node-id ()
  "create new node identifier"
  (setq *last-node* (+ 1 *last-node*)) )

(defun reset-node-id (&optional (val 0))
  "reset to zero node identifier"
  (setq *last-node* val) )

(defun show-options ()

  (if (not (or (eq *output-stream* nil) *single-line-override*))
      (let ()

	(format *output-stream*
		"~&~&***** OPTIONS for CSP ( ~A ) ***** ~2&" *domain-name*)

	(if (eq *domain-loaded* 'mpr)
	    (progn
	      	(format *output-stream*
		"~&~& Situation id         :   ~A ~&" *sit-object-id*)
		(format *output-stream*
		"~&~& Situation noise add  :   ~A ~&" *situation-noise-added*)
	      	(format *output-stream*
		"~&~& Situation Size       :   ~A ~&" (length
						       *current-situation*))
		(format *output-stream*
		"~&~& Template id          :   ~A ~&" *template-id*)
	      	(format *output-stream*
		"~&~& Template Size        :   ~A ~&" (length
					       (second *current-template*)))

		(format *output-stream*
		"~&~& Distribution id      :   ~A ~&" *random-dist-name*)
		(show-dist)

	      	(format *output-stream*
		"~&~& Num of constraints   :   ~A ~2&" 
		(length (get-templ-constraints *current-template*)))

		))

	(if (eq *domain-loaded* 'adt)
	    (progn
	      	(format *output-stream*
		"~&~& Situation id         :   ~A ~&" *sit-object-id*)
		(format *output-stream*
		"~&~& Situation noise add  :   ~A ~&" *situation-noise-added*)
	      	(format *output-stream*
		"~&~& Situation Size       :   ~A ~&" (length
						       *current-situation*))
		(format *output-stream*
		"~&~& Template id          :   ~A ~&" *template-id*)
	      	(format *output-stream*
		"~&~& Template Size        :   ~A ~&" (length
					       (second *current-template*)))

		(format *output-stream*
		"~&~& Distribution id      :   ~A ~&" *random-dist-name*)
		(show-dist)

	      	(format *output-stream*
		"~&~& Num of constraints   :   ~A ~2&" 
		(length (get-templ-constraints *current-template*)))

		))

	(format *output-stream*
		"~&~& Search Mode          : ~A ~&" *search-mode*)
	(format *output-stream*
		"~&~& Node Consis Mode     : ~A ~&" *node-consis*)
	(format *output-stream*
		"~&~& Node Type Cons Mode  : ~A ~&" *node-type-consis*)
	(format *output-stream*
		"~&~& Node Force all       : ~A ~&" *node-force-all*)
	(format *output-stream*
		"~&~& Arc  Consis Mode     : ~A ~&" *arc-consis*)

	(format *output-stream*
		"~&~& Forward Checking     : ~A ~&" *forward-checking*)
	(format *output-stream*
		"~&~& Dynamic Rearrangement: ~A ~&" *dynamic-rearrangement*)
	(format *output-stream*
		"~&~& DFA     Rearrangement: ~A ~&" *dfa-rearrangement*)
	(format *output-stream*
		"~&~& Advance sort option  : ~A ~&" *advance-sort*)
	(format *output-stream*
		"~&~& Inline  sort cstr opt: ~A ~&" *sort-const*)
	(format *output-stream*
		"~&~& Advance sort cstr opt: ~A ~&" *adv-sort-const*)
	(format *output-stream*
		"~&~& Backjump option      : ~A ~&" *backjump*)
	(format *output-stream*
		"~&~& One Solution Only    : ~A ~&" *one-solution-only*)
	(format *output-stream*
		"~&~& CPU Seconds limit    : ~A ~&" *cpu-sec-limit*)
	(format *output-stream*
		"~&~& CK Point interval    : ~A ~&" *check-point-interval*)
	(format *output-stream*
		"~&~& Debug                : ~A ~&" *debug*)
	(format *output-stream*
		"~&~& Debug CSP            : ~A ~2&" *debug-consis*)

	(if (eq *domain-loaded* 'mpr)
	    (progn
	      (format *output-stream*
		"~&~& Random Ident         : ~A ~&" *random-ident*)
	      (format *output-stream*
		"~&~& Spatial Cohes Prune  : ~A ~2&" *constraint-sch-on*) ))

	(if (eq *domain-loaded* 'adt)
	    (progn
	      (format *output-stream*
		"~&~& Random Ident         : ~A ~&" *random-ident*) ))

;;	(format *output-stream*
;;		"~&~& Output Stream        : ~A ~2&" *output-stream*)
	)) )

(defun rl () (load "load"))
(defun doc (f) (documentation f 'function))

;; **********************************************************************
;;

(defun show-bt-state (bt-state)
  (show-state        
   :node-id           (bt-state-node-id bt-state)
   :prev-node-id      (bt-state-prev-node-id bt-state)
   :partial-solution  (bt-state-partial-solution bt-state)
   :symbol            (bt-state-symbol bt-state)
   :value             (bt-state-value bt-state)
   :domain            (bt-state-domain bt-state)
   :variables-left    (bt-state-variables-left bt-state)
   :arc-cost          (bt-state-arc-cost bt-state)
   :depth             (bt-state-depth bt-state)
   :max-fail-level    (bt-state-max-fail-level bt-state)
   :parent-state      (bt-state-parent-state bt-state)
   :where             'show-bt-state) )

(defun show-state (&key (node-id  nil)
			(prev-node-id  nil)
			(partial-solution nil)
			(symbol nil)
			(value nil)
			(domain nil)
			(variables-left nil)
			(arc-cost nil)
			(depth nil)
			(max-fail-level nil)
			(parent-state nil)
			(where 'nowhere))

  (if (not (eq *output-stream* nil))
      (let ()
	(format *output-stream*
		"~&~&***** ~A State Description ***** ~2&" where)
	(format *output-stream*
		"~&~& Node id: ~A ~&" node-id)
	(format *output-stream*
		"~&~& Partial solution: ~A ~&" partial-solution)
	(format *output-stream*
		"~&~& Symbol: ~A ~&" symbol)
	(format *output-stream*
		"~&~& Symbol value: ~A ~&" value)
	(format *output-stream*
		"~&~& Domain: ~A ~&" domain)
	(format *output-stream*
		"~&~& Variables left: ~A ~&" variables-left)
	(format *output-stream*
		"~&~& Arc Cost: ~A ~&" arc-cost)
	(format *output-stream*
		"~&~& Depth: ~A ~&" depth)
	(format *output-stream*
		"~&~& Max fail level: ~A ~&" max-fail-level)
	(if (not (null prev-node-id))
	    (setq par-out prev-node-id)
	    (setq par-out 'None))
	(format *output-stream*
		"~&~& Prev Node id: ~A ~&" par-out)
	(format *output-stream*
		"~&~& Parent id: ~A ~2&" parent-state)
	)) )

(defun comment (com )
  (if (not (eq *output-stream* nil))
      (let ()
	(format *output-stream*	"~&> ~A ~& " com)
	))  )

(defun comment1 (com &optional (var nil))
  (if (not (eq *output-stream* nil))
      (let ()
	(format *output-stream*	"~&> ~A " com)
	(format *output-stream* " < ~A > ~&" var)
	)) )

(defun comment1s (com &optional (var nil))
  (if (not (eq *output-stream* nil))
      (let ()
	(format *output-stream*	"~2&> ~A " com)
	(format *output-stream* " < ~A > ~&" var)
	)) )

(defun comment2 (com &optional (var nil) (var2 nil))
  (if (not (eq *output-stream* nil))
      (let ()
	(format *output-stream*	"~&> ~A " com)
	(format *output-stream* " < ~A," var)
	(format *output-stream* " ~A > ~&" var2)
	)) )


(defun comment3 (com &optional (var nil) (var2 nil) (var3 nil) )
  (if (not (eq *output-stream* nil))
      (let ()
	(format *output-stream*	"~&> ~A " com)
	(format *output-stream* " < ~A," var)
	(format *output-stream* " ~A," var2)
	(format *output-stream* " ~A > ~&" var3)
	)) )

(defun comment4 (com &optional (var nil) (var2 nil) (var3 nil) (var4 nil))
  (if (not (eq *output-stream* nil))
      (let ()
	(format *output-stream*	"~2&> ~A " com)
	(format *output-stream* " < ~A," var)
	(format *output-stream* " ~A," var2)
	(format *output-stream* " ~A," var3)
	(format *output-stream* " ~A > ~&" var4)
	)) )

(defun comment5 (com &optional (var nil) (var2 nil) (var3 nil) (var4 nil)
		    (var5 nil) )
  (if (not (eq *output-stream* nil))
      (let ()
	(format *output-stream*	"~2&> ~A " com)
	(format *output-stream* " < ~A," var)
	(format *output-stream* " ~A," var2)
	(format *output-stream* " ~A," var3)
	(format *output-stream* " ~A," var4)
	(format *output-stream* " ~A > ~&" var5)
	)) )

(defun comment6 (com &optional (var nil) (var2 nil) (var3 nil) (var4 nil)
		    (var5 nil) (var6 nil) )
  (if (not (eq *output-stream* nil))
      (let ()
	(format *output-stream*	"~2&> ~A " com)
	(format *output-stream* " < ~A," var)
	(format *output-stream* " ~A," var2)
	(format *output-stream* " ~A," var3)
	(format *output-stream* " ~A," var4)
	(format *output-stream* " ~A," var5)
	(format *output-stream* " ~A > ~&" var6)
	)) )

(defun show-dist ()
	(format *output-stream*	"~&~& Distributions    : ~&" )
	(dolist (this *random-dist*) 
	  (format *output-stream* "~A ~&" this))  )

;         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6

;123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-

;Size	Mo/NC /AC /FC /DR   Ident	Dsize	NCC	TCC	BT/V	    AP      S	     Total    NumS    BJ   TypA/B    FCcost    DRcost    ASort/AStime ConsSort



(defun write-single-header ()
  (format *output-stream* 
	  "~A~9T~A/~12T~A/~16T~A/~20T~A/~24T~A~29T~A~41T~A~49T~A~57T~A~65T~A/~A~76T~A~84T~A~92T~A~101T~A~109T~A~114T~A/~A~124T~A~135T~A~144T~A/~A~156T~A~165T~A~174T~A~183T~A~192T~A~&" 
	  "Size" "Mo" "NC" "AC" "FC" "DR" "Ident" "Dsize" "NCC" "TCC" "BT" "V" "AP" "S" "Total" "NumS" "BJ" "TypA" "B" "FCcost" "DRcost"  "AS" "AStime" "ConsSort" "AdvSrtC" "ReprKey" "NdTypCs" "DFAcst") )



(defun show-solution (&key      (solution-set *solution-set*) 
				(exit-location 'repeat)
				(replace-values  nil)
				(memory-key      nil)
				)
  
  (let (
	(override-output (or *single-line-override* memory-key))
	)

    ;; This option resets the global variables for printing
    ;; primarily called from memory-csp.lisp with this option
    (if (not (null replace-values))
	(reload-values replace-values)
      ;;
      ;; standard case - compute these values right now rather than from saved
      ;;
      (progn
	(setq *RECALL-avg-var-len*    
	      (get-avg-var-len (get-var-lengths *variables*)))
	(setq *RECALL-adv-proc-time*  
	      (/ (- *internal-advance-end-time* 
		    *internal-advance-start-time*)
		 (* 1.0 internal-time-units-per-second))) 
	(setq *RECALL-search-time* 			
	      (/ (- *internal-end-time* *internal-start-time*)
		 (* 1.0 internal-time-units-per-second)))
	(setq *RECALL-total-time* 			
	      (/ (- *internal-end-time* *internal-advance-start-time*)
		 (* 1.0 internal-time-units-per-second)))
	(setq *RECALL-adv-sort-time* 
	      (/ (- *internal-sort-end-time* *internal-sort-start-time*)
		 (* 1.0 internal-time-units-per-second)))
	))

    (if override-output
	(progn
	  ;; Output single line for compilation of test results only
	  ;;  if single line suppressed, output only the solution
	  (if (not (eq *output-stream* nil)) 
	      (let (
		    (num-sols (length solution-set))
		    )
		(setq *solution-set* solution-set)

		(if (or (not *suppress-single-line*) memory-key)
		    (progn
		      (if *long-output*
			  (write-single-header))

		      (format *output-stream* 
			      "~A~9T~A/~12T~A/~16T~A/~20T~A/~24T~A~29T~A~41T~A~49T~A~57T~A~65T~A / ~A~76T~A~84T~A~92T~A~101T~A~109T~A~114T~A/~A~124T~A~135T~A~144T~A/~A~156T~A~165T~A~174T~A~183T~A~192T~A~&" 
			      *Situation-noise-added*
			      *search-mode*
			      *node-consis*
			      *arc-consis*
			      *forward-checking*
			      *dynamic-rearrangement* 
			      *random-ident*
			      *RECALL-avg-var-len*
			      *node-consistency-checks*
			      *constraint-cks*
			      *backtrack-nodes-created*
			      *nodes-visited*
			      *RECALL-adv-proc-time* 
			      *RECALL-search-time* 
			      *RECALL-total-time*
			      num-sols
			      *backjump-count*
			      *type-a-savings*
			      *type-b-savings*
			      *for-check-cost*
			      *dyn-rearr-cost*
			      *advance-sort*
			      *RECALL-adv-sort-time* 
			      *sort-const* 
			      *adv-sort-const*
			      nil ;; ReprKey -- placeholder for missing arg
			      (if *node-type-consis*
				  *node-type-consistency-checks* nil)
			      *dfa-rearr-cost*
			      )
		      ))

		(if (and *file-output* 
			 (not (eq exit-location 'CHECKPOINT))
			 (not memory-key))
		    (progn
		      (close *output-stream*)
		      (setq *output-stream* *standard-output*)
		      (setq *file-output* nil)
		      (format *output-stream*
			      "~&~& File Closed (at 1). ~2&"))) 
		) ;; let
	    ;; else case ... return solution set only
	    ) ;; if
	  )  ;; progn

      ;; resume normal programming in this case !
      (show-solution1 solution-set exit-location) )) )

(defun show-solution1 (solution-set exit-location)
"
Show output values at end. ALL DOMAIN VERSIONS.
"
(let (
      (print-long (or (eq exit-location 'repeat) 
		      *file-output*
		      *long-output*
		      ))
      )
  (if (not (eq *output-stream* nil))
      (let (
	    (num (length solution-set))
	    (desc-string (if (equal *search-mode* "bt")
			     'Backtrack
			   (if (equal *search-mode* "bj")
			       'BackJump
			     (if (equal *search-mode* "bm")
				 'BackMark
			       (if (equal *search-mode* "qu")
				   'quilici
			       'Error)))))
	    )
	(setq *solution-set* solution-set)

	(format *output-stream*
		"~&~&***** ~A Information ***** ~2&" desc-string )
	(format *output-stream*
		"~&~& Exit Location    : ~A ~&" exit-location)
	(format *output-stream*
		"~&~& No. Solutions    : ~A ~&" (length solution-set))

	(if (and (> num 0) print-long)
	    (progn
	      (format *output-stream* "~&~& Solutions... ~&")
	      (dolist (sol solution-set)
		(format *output-stream* "~A ~&" sol)) ))

	(if *node-consis*
	    (progn
;;	      (format *output-stream*
;;	      "~&~& Node Consis. calls : ~A ~&" *node-consistency-calls*)
	      (format *output-stream*
	      "~&~& Node Consis. cks   : ~A ~&" *node-consistency-checks*)
	      (format *output-stream*
	      "~&~& Node Type Cons cks : ~A ~&" *node-type-consistency-checks*)
	      (format *output-stream*
	      "~&~& Node Type Cons ok  : ~A ~&"  *node-type-consistency-ck-ok*)
	      (format *output-stream*
	     "~&~& Node Type Cons fail: ~A ~&" *node-type-consistency-ck-fail*)
	      
	      (if (and print-long (eq *domain-loaded* 'mpr))
		  (progn
		    (format *output-stream*
	    "~&~&   >Matches-type       : ~A ~&" *ts-match-type-count*)
		    (format *output-stream*
	    "~&~&   >Matches-orient     : ~A ~&" *ts-match-orient-count*)
		    (format *output-stream*
	   "~&~&   >Matches-activity   : ~A ~&" *ts-match-activity-count*)
		    (format *output-stream*
	   "~&~&   >Matches-abs-loc    : ~A ~&" *ts-match-abs-loc-count*)
		    (format *output-stream*
	   "~&~&   >Matches-size       : ~A ~&" *ts-match-size-count*)
		    )) ))

	(if print-long 
	    (progn
	      (format *output-stream*
		      "~&~& Satisfy-p calls  : ~A ~&" *satisfy-p-calls*)
	      (format *output-stream*
		      "~&~& Satisfy-p cost   : ~A ~&" *satisfy-p-cost*)
	      (format *output-stream*
		      "~&~& Consistent calls : ~A ~&" *consistent-p-calls*)
	      (if (eq *domain-loaded* 'mpr)
		  (progn
		    (format *output-stream*
		  "~&~&     >Consistent nulls : ~A ~&" *consistent-null-arcs*)
		    (format *output-stream*
		  "~&~&     >Unique restricts : ~A ~&" *unique-restrict-count*)
		    )) ))

	(format *output-stream*
		"~&~& Ttl constr chks  : ~A ~&" *constraint-cks*)

	(if (and (eq *domain-loaded* 'mpr) print-long)
	    (progn
	      (format *output-stream*
	    "~&~&    >AC     compat results: ~A ~&" *ac-count-compat*)
	      (format *output-stream*
	    "~&~&    >AC not compat results: ~A ~&" *ac-count-notcompat*)
	      (format *output-stream*
	    "~&~&    >Spatial Cohes cks: ~A ~&" *constraint-sch-cks*)
	      (format *output-stream*
	    "~&~&    >Spatial Cohes savings : ~A ~&" *sch-save*)
	      (format *output-stream*
	    "~&~&    >Separation cks   : ~A ~&" *constraint-sep-cks*)
	      (format *output-stream*
	    "~&~&    >Positional cks   : ~A ~&" *constraint-pos-cks*)
	      (format *output-stream*
	    "~&~&    >Medial cks       : ~A ~&" *constraint-med-cks*)
	      (format *output-stream*
	    "~&~&    >Echelon cks      : ~A ~&" *constraint-ech-cks*)
	      (format *output-stream*
   	    "~&~&    >Same type cks    : ~A ~&" *constraint-same-type-cks*)
	      (format *output-stream*
   	    "~&~&    >Same orient cks  : ~A ~&" *constraint-same-orient-cks*)
	      (format *output-stream*
 	    "~&~&    >Same activity cks: ~A ~&" *constraint-same-activity-cks*)
	      (format *output-stream*
 	    "~&~&    >Same size cks    : ~A ~&" *constraint-same-size-cks*)
	      ))

	(if (and (eq *domain-loaded* 'adt) print-long)
	    (progn
	      (format *output-stream*
	    "~&~&    >AC     compat results: ~A ~&" *ac-count-compat*)
	      (format *output-stream*
	    "~&~&    >AC not compat results: ~A ~&" *ac-count-notcompat*)
	      (format *output-stream*
	    "~&~&    >Before-p cks         : ~A ~&" *constraint-before-cks*)
	      (format *output-stream*
	    "~&~&    >Same-name-p cks      : ~A ~&" *constraint-same-name-cks*)
	      (format *output-stream*
	    "~&~&    >Close-to-p cks      : ~A ~&" *constraint-close-to-cks*)
	      (format *output-stream*
   	    "~&~&    >Same type cks        : ~A ~&" *constraint-same-type-cks*)
	      ))


	(if (equal *search-mode* "qu")
	    (format *output-stream*
	    "~&~& Quilici open states created : ~A ~&" *backtrack-nodes-created*)
	  (progn
	      (format *output-stream*
	      "~&~& BT nodes created : ~A ~&" *backtrack-nodes-created*)
	      (format *output-stream*
	      "~&~& Nodes visited    : ~A ~&" *nodes-visited*)))

	(if *backjump*
	    (format *output-stream*
		    "~&~& Backjumps        : ~A ~&" *backjump-count*))

	(if *backmark*
	    (progn
	      (format *output-stream*
		      "~&~& BM Type-A Savings : ~A ~&" *type-a-savings*)
	      (format *output-stream*
		      "~&~& BM Type-B Savings : ~A ~&" *type-b-savings*)))

	(if *forward-checking*
	    (progn
;;	      (format *output-stream*
;;		      "~&~& Forward ck calls : ~A ~&" *for-check-calls*)
	      (format *output-stream*
		      "~&~& Forward ck cost  : ~A ~&" *for-check-cost*)))

	(if *dynamic-rearrangement* 
	    (progn
;;	      (format *output-stream*
;;		      "~&~& Dyn Rearr calls  : ~A ~&" *dyn-rearr-calls*)
	      (format *output-stream*
		      "~&~& Dyn Rearr cost   : ~A ~2&" *dyn-rearr-cost*)))

	(if *dfa-rearrangement* 
	    (progn
;;	      (format *output-stream*
;;		      "~&~& DFA Rearr calls  : ~A ~&" *dfa-rearr-calls*)
	      (format *output-stream*
		      "~&~& DFA Rearr cost   : ~A ~2&" *dfa-rearr-cost*)))

	(format *output-stream* 
                "~2&Advance Processing CPU Seconds: ~D ~&" 
	    (/ (- *internal-advance-end-time* *internal-advance-start-time*)
	       (* 1.0 internal-time-units-per-second)))
  
	(if *advance-sort*
	    (progn
	      (format *output-stream* 
		 "Advance Sort       CPU Seconds: ~D ~&" 
		 (/ (- *internal-sort-end-time* *internal-sort-start-time*)
		    (* 1.0 internal-time-units-per-second)))))

	 (format *output-stream* 
		 "Search             CPU Seconds: ~D ~&" 
		 (/ (- *internal-end-time* *internal-start-time*)
		    (* 1.0 internal-time-units-per-second)))

	 (format *output-stream* 
		 "Total              CPU Seconds: ~D ~2&" 
		 (/ (- *internal-end-time* *internal-advance-start-time*)
		    (* 1.0 internal-time-units-per-second)))

	(if (and *file-output* (not (eq exit-location 'CHECKPOINT)))
	    (progn
     	      (close *output-stream*)
	      (setq *output-stream* *standard-output*)
	      (setq *file-output* nil)
	      (format *output-stream*
		      "~&~& File Closed (at 2). ~2&")))
	)) ))

(defun show-backmark ()
  (format *output-stream*
	  "~&~& DoList Count       : ~A ~&" *dolist-count*)
  (format *output-stream*
	  "~&~& GreaterEqual Count : ~A ~&" *greater-equal-count*)
  (format *output-stream*
	  "~&~& Loop Count         : ~A ~&" *loop-count*)
  (format *output-stream*
	  "~&~& BackMark Calls     : ~A ~2&" *backmark-calls*) )

(defun show-bm-bt-state ( U F &optional (where 'default) )
  (if (not (eq *output-stream* nil))
      (let ()
	(format *output-stream*
		"~&~&***** ~A BackMark BT State ***** ~2&" where)
	(format *output-stream* "~&~& U       : ~A ~&" (get_U U))
	(format *output-stream*	"~&~& F       : ~A ~&" F)
	(format *output-stream* " -------------- ~2&") )))

(defun show-bm-visit-state ( U F_U F Mark LowUnit &optional (where 'default) )
  (if (not (eq *output-stream* nil))
      (let ()
	(format *output-stream*
		"~&~&***** ~A BackMark Visit State ***** ~2&" where)
	(format *output-stream* "~&~& U       : ~A ~&" (get_U U))
	(format *output-stream*	"~&~& F_U     : ~A ~&" F_U)
	(format *output-stream*	"~&~& F       : ~A ~&" F)
	(format *output-stream* "~&~& LowUnit : ~A ~&" LowUnit )
	(format *output-stream* "~&~& Mark ... ~&")
	(dolist (mark1 mark) (format *output-stream* "~A ~&" mark1))
	(format *output-stream*  " +++++++++++++++ ~2&") )))

;; **************************************************
;; Random accessor functions

(defun num-to-string ( num )
"
Positive numbers only.
"
(if (< num 10)
    (num-to-letter num)
  (let* (
	 (rest-digits (truncate (/ num 10.0)))
	 (last-digit  (- num (* 10 rest-digits)))
	 )
    
    (concatenate 'string (num-to-string rest-digits) (num-to-letter last-digit) )
    )))

(defun num-to-letter ( num )
  (cond
   ((eq num 0) "0")
   ((eq num 1) "1")
   ((eq num 2) "2")
   ((eq num 3) "3")
   ((eq num 4) "4")
   ((eq num 5) "5")
   ((eq num 6) "6")
   ((eq num 7) "7")
   ((eq num 8) "8")
   ((eq num 9) "9")))

; 	

(defun select-type (type sit)
"
Return locational information only as tuples for a given type.
"
  (if (null sit)
      nil
    (let* (
	   (this-item (car sit))
	   (this-type (third this-item))
	   )
    (if (eq type this-type)
	(append 
	 (list (list (first (second this-item)) (second (second this-item))))
	 (select-type type (cdr sit)))
      (select-type type (cdr sit))))))


;; **************************************************
;; Additional utility selection functions 

(defun select-all-type (type &optional (sit *current-situation) )
"
Return situational object set with this type.
"
  (if (null sit)
      nil
    (let* (
	   (this-item (car sit))
	   (this-type (third this-item))
	   )
    (if (eq type this-type)
	(append 
	 (list this-item)
	 (select-all-type type (cdr sit)))
      (select-all-type type (cdr sit))))))


(defun select-all-loc (&optional (xmin 0) (xmax 0) (ymin 0) (ymax 0)
				 (sit *current-situation*) )
"
Return situational object set satisfying this x y location range.
 ...  SPATIAL DOMAIN  x, y ....
"
  (if (null sit)
      nil
    (let* (
	   (this-item (car sit))
	   (this-loc (second this-item))
	   (this-x   (first this-loc))
	   (this-y   (second this-loc))
	   )
    (if (and (<= xmin this-x) (>= xmax this-x) (<= ymin this-y) (>= ymax this-y))
	(append 
	 (list this-item)
	 (select-all-loc xmin xmax ymin ymax (cdr sit)))
      (select-all-loc xmin xmax ymin ymax (cdr sit))))))
 

(defun list-element-pos (list element)
  (let* (
	 (listlen (length list))
	 (mem     (member element list))
	 (memlen  (length mem))
	 )
    (1+ (- listlen memlen)) ))


(defun constraint-exists-p (c-type  &optional (c *constraints*))
  (if (member c-type (mapcar #'(lambda (x) (first x)) c))
      t nil))

(defun member-string (element list)
  (member element list :test #'equal))

(defun assoc1 (element list)
  (assoc element list :test #'equal))

(defun or-equal (element list)
" True if element equals any element in list "
  (if (null list)
      nil
    (or (equal element (car list))
	(or-equal element (cdr list))) ))

(defun in-range (number number-range-list)
" True if element number is in number-range-list '(x y)"
(let (
      (min (first  number-range-list))
      (max (second number-range-list))
      )
  (and (>= number min) (<= number max))))


(defun member-count (element list)
  (member-count-fn element list 1))
(defun member-count-fn (element list n)
  (if (null list)
      -1
    (if (eq element (caar list))
	n
      (member-count-fn element (cdr list) (1+ n)) )))



;; line number maintenance routines

(defun gen-nums-to ( min max )
  (if (= min max)
      (list min)
    (cons min (gen-nums-to (1+ min) max)) ))

(defun remove-nums ( nums lst )
  (if (null nums)
      lst
    (remove-if #'(lambda (x) (equal x (car nums)))
	       (remove-nums (cdr nums) lst))))

(defun get-orig-nums ( orig-sit )
  (mapcar #'(lambda (x) (second x)) orig-sit))

(defun get-orig-nums2 ( orig-sit )
  (mapcar #'(lambda (x) (second (second x))) orig-sit))

; ---------------------------------------------------------------------------

(defun remove-dest-num ( num )
  (setq *line-number-set*
	(remove-if #'(lambda (x) (equal x num)) 
		   *line-number-set*)))

(defun get-line-number ()
  (let* (
	 (sz  (length *line-number-set*))
	 (ps  (random-position sz))
	 (val (nth ps *line-number-set*))
	)
    (remove-dest-num val)
    val
    ))

(defun get-specific-line ( num )
"
 Get the desired line or the nearest one available (increasing).
"
  ;; extend number set if requesting a number outside the range
  (if (> num *max-line-number*)
      (let* (
	     (new-nums (gen-nums-to (1+ *max-line-number*) (+ 100
							      *max-line-number*)))
	     )
	
	(setq *max-line-number* (+ 100 *max-line-number*))
	(setq *line-number-set* (append *line-number-set* new-nums))
	))

  (if (member num *line-number-set*)
      (progn
	(remove-dest-num num)
	num
	)
    (get-specific-line (1+ num)) ))

(defun get-max ( nums n )
  (if (null nums)
      n
    (if (> (car nums) n)
	(get-max (cdr nums) (car nums))
      (get-max (cdr nums) n))))

(defun remove-var (var varset)
" DFA Update April 28/97
  return varset with var entry removed "
  (remove-if #'(lambda (x) (equal var (car x))) varset))