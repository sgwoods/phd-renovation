(in-package #:phd-qcsp-alex)
(defun start-test ()
(setq *final-templ* 
         '("traverse-array-5-7-best" 
           (                                       ;# of instances
           (e3 (Less Id3-1 Id3-2 Id3-3))   ; i < n ;    18
           (e1 (Assign Id1-1 Id1-2))       ; i = 0 ;   171
           (e2 (Loop))                     ;       ;    18
           (e5 (PreInc Id5-1))             ; ++i   ;    18
           (e4 (Index Id4-1 Id4-2 Id4-3))  ; x[i]  ;    99
           )
          (
           (possible-data-dependency (e3 e1) Id3-1);   con1
           (control-data-dependency (e2 e1))       ;   con2
           (possible-data-dependency (e3 e5) Id3-1);   con3
           (possible-data-dependency (e5 e1) Id5-1);   con4
           (possible-data-dependency (e5 e5) Id5-1);   con5
           (possible-data-dependency (e4 e1) Id4-2);   con6
           (possible-data-dependency (e4 e5) Id4-2);   con7
           )
         ))

		(test-main "testdata/data-c/dmaxc.component" 
					"testdata/data-c/dmaxc.control" 
					"xxx")
          (adt :template-id "special"
               :search-mode "qu"
;;             :forward-checking t
               :advance-sort 'quilici
               :adv-sort-const nil
               :debug-csp t
               ;;:debug-node t
               :override-template *final-templ*)
) 
(defun start-test-d ()

(setq *final-templ* 
  '("traverse-array-template-5-7"
    (
     (e1 (Assign Id1-1 Id1-2))           ;i = 0
     (e2 (Loop))
     (e3 (Less Id3-1 Id3-2 Id3-3))       ;i<n
     (e4 (Index Id4-1 Id4-2 Id4-3))      ;
     (e5 (PreInc Id5-1))                 ;++i
     )
    (
     (control-data-dependency (e2 e1))
     (possible-data-dependency (e3 e1) Id3-1)
     (possible-data-dependency (e3 e5) Id3-1)
     (possible-data-dependency (e4 e1) Id4-2)
     (possible-data-dependency (e4 e5) Id4-2)
 
     (possible-data-dependency (e5 e1) Id5-1)
     (possible-data-dependency (e5 e5) Id5-1)
     )
    )
         
)
		(test-main "testdata/data-c/dmaxc.component" 
					"testdata/data-c/dmaxc.control" 
					"xxx")
              (adt :template-id "special" 
               :forward-checking t
               :dynamic-rearrangement t
               :debug 't  
               :debug-csp 't
               :override-template *final-templ*)

)
;;             :output-file "test-output-file")
) 
