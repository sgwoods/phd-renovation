(in-package #:phd-qcsp-alex)
  (setq partial-solution-set 

	 (adt :situation-id "quilici-i1"
	      :sit-noise    100
	      :rand-dist    "dist1"
	      :random-ident "4705297406"
	      :long-output   nil
	      :single-line-override    t
	      :suppress-single-line    t

	      :template-id  "quilici-t1-index"

	      :search-mode            "bt"
	      :node-consis            t
	      :arc-consis             nil
	      :forward-checking       nil
	      :dynamic-rearrangement  nil
	      :advance-sort           nil
	      :sort-const             nil
	      :adv-sort-const         nil
	      :one-solution-only      nil

	      :debug      t
	      :debug-node t
	      :output-file     "test2-phase1.out"
	      ))

(setq p1 (nth 0 partial-solution-set))
(setq p2 (nth 1 partial-solution-set))
(setq p3 (nth 2 partial-solution-set))
(setq p4 (nth 3 partial-solution-set))
(setq p5 (nth 4 partial-solution-set))
(setq p6 (nth 5 partial-solution-set))
(setq p7 (nth 6 partial-solution-set))
(setq p8 (nth 7 partial-solution-set))
(setq p9 (nth 8 partial-solution-set))
(setq p10 (nth 9 partial-solution-set))

 (setq r1
       (adt :situation-id  "quilici-i1"
	    :sit-noise     100
	    :rand-dist     "dist1"
	    :random-ident  "4705297406"
	    :long-output   nil
	    :single-line-override    t
	    :suppress-single-line    t

	    :template-id  "quilici-t1"
	    
	    :search-mode            "bt"
	    :node-consis            t
	    :arc-consis             nil
	    :forward-checking       t
	    :dynamic-rearrangement  t
	    :advance-sort           t
	    :sort-const             'random
	    :adv-sort-const         'random
	    :one-solution-only      nil
			  
	    :part-soln    p1

	    :debug t
	    :debug-node t

	    :output-file     "test2-phase2-r1.out"
	    ))

 (setq r4
       (adt :situation-id  "quilici-i1"
	    :sit-noise     100
	    :rand-dist     "dist1"
	    :random-ident  "4705297406"
	    :long-output   nil
	    :single-line-override    t
	    :suppress-single-line    t

	    :template-id  "quilici-t1"
	    
	    :search-mode            "bt"
	    :node-consis            t
	    :arc-consis             nil
	    :forward-checking       t
	    :dynamic-rearrangement  t
	    :advance-sort           t
	    :sort-const             'random
	    :adv-sort-const         'random
	    :one-solution-only      nil
			  
	    :part-soln    p4

	    :debug t
	    :debug-node t

	    :output-file     "test2-phase2-r4.out"
	    ))



(time (memory-search "quilici-t1-index" "quilici-t1"
	   :sit-noise    100
	   :random-ident "4705297406"
	   :memory-output-file "test4705.out"
	   ))
