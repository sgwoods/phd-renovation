
(defun tt (ns)
  (adt :sit-noise ns
       :situation-id "quilici-i1"
       :template-id  "quilici-t1"
))

(setq situation-id "quilici-i1")
(setq sit-noise                 0)
(setq template-id        "quilici-t1")  
(setq dom (list 'adt situation-id template-id))
(setq search-mode            "bt")  
(setq node-consis               t)  
(setq node-force-all          nil)  
(setq arc-consis              nil)  
(setq rand-dist           "dist1")  
(setq forward-checking        nil)  
(setq dynamic-rearrangement   nil)  
(setq advance-sort        'random)  
(setq sort-const          'random)  
(setq adv-sort-const          nil)  
(setq one-solution-only       nil)  
(setq cpu-sec-limit           600)  
(setq ck-pt-interval          150)  
(setq debug                   nil)  
(setq debug-csp               nil)  
(setq random-ident       'default)  
(setq output-file             nil)  
(setq long-output             nil)  
(setq single-line-override    nil)  

(setq *test* situation-id)

(if (eq random-ident 'unique)
    (progn
      (setq random-ident (unique-string))
      (setq *random-state* (make-random-state t))
      (save-rand random-ident))
  (if (eq random-ident 'default)
      (progn
	(load-rand 'default))
    (load-rand random-ident)))

(if (not (adt-set-global-values situation-id sit-noise 
				random-ident template-id 
 				rand-dist(get-dist rand-dist)
				long-output single-line-override
				))

    (progn
      (comment "Exiting with a ADT setup error.")
      (return-from adt nil))
  (progn
;;  not appropriate at moment for ADT
;;    (save-situation random-ident sit-noise)
;;    (save-gnuplot   random-ident sit-noise)
    ))

(setq *check* 3)
;; set up global variables
(if (not (set-globals (adt-variables)
		      dom 
		      search-mode 
		      node-consis 
		      node-force-all 
		      arc-consis
		      forward-checking 
		      dynamic-rearrangement 
		      advance-sort
		      sort-const
		      adv-sort-const
		      one-solution-only 
		      cpu-sec-limit 
		      ck-pt-interval
		      debug 
		      debug-csp 
		      output-file))
    (progn
      (comment "Exiting with a general setup error.")
      (return-from adt nil)))

;; Show set up options
(show-options)

(setq v1 (first *raw-variables*))
(setq v2 (second *raw-variables*))
(setq v3 (third *raw-variables*))
(setq v4 (fourth *raw-variables*))
(setq v5 (fifth *raw-variables*))
(setq v6 (sixth *raw-variables*))
(setq v7 (nth 6 *raw-variables*))
(setq v8 (nth 7 *raw-variables*))
(setq v9 (nth 8 *raw-variables*))

(setq r1 (node-consistent-one-node v1))
(setq r2 (node-consistent-one-node v2))
(setq r3 (node-consistent-one-node v3))  ;; <<< while
(setq r4 (node-consistent-one-node v4))
(setq r5 (node-consistent-one-node v5))
(setq r6 (node-consistent-one-node v6))
(setq r7 (node-consistent-one-node v7))
(setq r8 (node-consistent-one-node v8))  ;; <<<  not-equals
(setq r9 (node-consistent-one-node v9))  ;; <<<  increment

(setq rall (list r1 r2 r3 r4 r5 r6 r7 r8 r9)) 

;; while failures
(setq tslot-id 'Q1-C)
(setq sit-obj-id 'adtq1-c)
(setq r3a (node-consistent-p tslot-id sit-obj-id))
(setq sit-obj (get-sit-object sit-obj-id))
(setq tslot  (get-templ-slot-object *current-template* tslot-id))
(setq tmatch  (ts-matches-type        tslot sit-obj))

;;;;

(setq constraint '(same-name-p (q1-d q1-e) (Block1 Block2)))
(setq t1 'Q1-D)
(setq s1 'end-sid1628)
(setq t2 'Q1-E)
(setq s2 'begin-sid1594)

(setq aflist   (get-affected-list constraint))
(setq plist    (get-parameter-list constraint))
(setq order    (if (eq t1 (first aflist)) 't1 't2))
(setq t1-templNameVar (if (eq order 't1) (first  plist) (second plist)))
(setq t2-templNameVar (if (eq order 't2) (first  plist) (second plist)))
(setq t1-var-pos  (get-ts-obj-namePos t1 t1-templNameVar))
(setq t2-var-pos  (get-ts-obj-namePos t2 t2-templNameVar))
(setq s1-obj (get-sit-object s1))
(setq s2-obj (get-sit-object s2))
(setq s1-name (if (> t1-var-pos 0)
		  (get-sit-param-clean s1-obj t1-var-pos) nil))
(setq s2-name (if (> t2-var-pos 0)
		  (get-sit-param-clean s2-obj t2-var-pos) nil))
