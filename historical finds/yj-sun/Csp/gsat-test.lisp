
;; sit obj components  (domain values)

(setq s *current-situation*)

(setq adt1-1a (get-sit-object 'adt1-1a)) ;; decl array int
(setq adt1-1b (get-sit-object 'adt1-1b)) ;; decl int
(setq adt1-1c (get-sit-object 'adt1-1c)) ;; decl int
(setq adt1-1d (get-sit-object 'adt1-1d)) ;; zero array at position
(setq adt1-1e (get-sit-object 'adt1-1e)) ;; assign array at position a value

;; template components (variable slots)

(setq ct *current-template*)
(setq slots  (get-templ-slots       *current-template*))
(setq t1-a (nth 0 slots)) ;; decl array int or char
(setq t1-b (nth 1 slots)) ;; decl int
(setq t1-c (nth 2 slots)) ;; decl int or char
(setq t1-d (nth 3 slots)) ;; zero array int or char
(setq t1-e (nth 4 slots)) ;; assign to array int or char and int or char

(setq cl (get-templ-constraints *current-template*))
(setq c1 (nth 0 cl))
(setq c2 (nth 1 cl))
(setq c3 (nth 2 cl))
(setq c4 (nth 3 cl))
(setq c5 (nth 4 cl))
(setq c6 (nth 5 cl))
(setq c7 (nth 6 cl))
(setq c8 (nth 7 cl))
(setq c9 (nth 8 cl))
(setq c10 (nth 9 cl))

(setq v (adt-variables))

(setq nv (node-consistent-variables v))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

