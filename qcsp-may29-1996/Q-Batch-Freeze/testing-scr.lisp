


(setq len (length *raw-variables*))
(setq c (first *raw-variables*))
(setq d (second *raw-variables*))
(setq g (third *raw-variables*))
(setq e (fourth *raw-variables*))
(setq i (fifth *raw-variables*))
(setq a (sixth *raw-variables*))
(setq b (seventh *raw-variables*))
(setq f (eighth *raw-variables*))
(setq h (ninth *raw-variables*))


(setq v1 (if (member 'adtq1-a a) t nil))
(setq v2 (if (member 'adtq1-b b) t nil))
(setq v3 (if (member 'adtq1-c c) t nil))
(setq v4 (if (member 'adtq1-d d) t nil))
(setq v5 (if (member 'adtq1-e e) t nil))
(setq v6 (if (member 'adtq1-f f) t nil))
(setq v7 (if (member 'adtq1-g g) t nil))
(setq v8 (if (member 'adtq1-h h) t nil))
(setq v9 (if (member 'adtq1-i i) t nil))
(setq vall (list v1 v2 v3 v4 v5 v6 v7 v8 v9))

;;;
;;; NODE CONSISTENT TESTING ....
;;;
(setq ivs (node-consistent-variables *raw-variables* :force nil))


(setq iv-len (length ivs))
(setq iv-c (first ivs))
(setq iv-d (second ivs))
(setq iv-g (third ivs))
(setq iv-e (fourth ivs))
(setq iv-i (fifth ivs))
(setq iv-a (sixth ivs))
(setq iv-b (seventh ivs))
(setq iv-f (eighth ivs))
(setq iv-h (ninth ivs))

(setq iv-v1 (if (member 'adtq1-a iv-a) t nil))
(setq iv-v2 (if (member 'adtq1-b iv-b) t nil))
(setq iv-v3 (if (member 'adtq1-c iv-c) t nil))
(setq iv-v4 (if (member 'adtq1-d iv-d) t nil))
(setq iv-v5 (if (member 'adtq1-e iv-e) t nil))
(setq iv-v6 (if (member 'adtq1-f iv-f) t nil))
(setq iv-v7 (if (member 'adtq1-g iv-g) t nil))
(setq iv-v8 (if (member 'adtq1-h iv-h) t nil))
(setq iv-v9 (if (member 'adtq1-i iv-i) t nil))
(setq iv-vall (list iv-v1 iv-v2 iv-v3 iv-v4 iv-v5 iv-v6 iv-v7 
			iv-v8 iv-v9))


