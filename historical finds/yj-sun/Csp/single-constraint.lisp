(setq
 *template-object-list* 
 (list

    '("guaranteed-data-dependency-2-1"
    (
     (e4 (Index Id4-1 Id4-2 Id4-3))       ;temp1 = a[i] 
     (e5 (PlusAssign Id5-1 Id5-2))        ;mean += temp1
     )
    (
     (guaranteed-data-dependency (e5 e4) Id5-2) 
     )
    )

  '("possible-data-dependency-2-1"
    (
     (e2 (Assign Id2-1 Id2-2))            ;i = 0 
     (e3 (Less Id3-1 Id3-2 Id3-3))        ;i<n 
     )
    (
     (possible-data-dependency (e3 e2) Id3-1)
     )
    )
  
  '("same-data-dependency-2-1"
    (
     (e3 (Less Id3-1 Id3-2 Id3-3))        ;i<n 
     (e8 (DivAssign Id8-1 Id8-2))         ;mean /= n 
     )
    (
     (same-data-dependency (e3 e8) (Id3-2 Id8-2))
     ) 
    )
  
  '("control-data-dependency-2-1"
    (
     (e1 (Assign Id1-1 Id1-2))            ;mean = 0 
     (e21 (Loop)) 
     )
    (
     (control-data-dependency (e21 e1))  
     ) 
    )
  
  '("same-variable-2-1"
    (
     (e6 (Plus Id6-1 Id6-2 Id6-3))        ;++i ==> Id6-3 = i + 1
     (e7 (Assign Id7-1 Id7-2))            ;i = Id6-3  
     )
    (
     (same-variable (e7 e6) (Id7-1 Id6-1)) 
     ) 
    )
  
))

(defun exp-8-cc-gd ()
;;exp-8 
  (pick-two-for-xvgr 0
             8 
             13  
             "testdata/Results/exp-8-original-result"
             "testdata/Results/exp-8-gd")
)
 
(defun exp-8-cc-pd ()
;;exp-8 
  (pick-two-for-xvgr 1 
             8 
             13  
             "testdata/Results/exp-8-original-result"
             "testdata/Results/exp-8-pd")
)
 
(defun exp-8-cc-sd ()
;;exp-8 
  (pick-two-for-xvgr 2
             8 
             13  
             "testdata/Results/exp-8-original-result"
             "testdata/Results/exp-8-sd")
)
 
(defun exp-8-cc-cd ()
;;exp-8 
  (pick-two-for-xvgr 3 
             8 
             13  
             "testdata/Results/exp-8-original-result"
             "testdata/Results/exp-8-cd")
)
 
(defun exp-8-cc-sv ()
;;exp-8 
  (pick-two-for-xvgr 4 
             8 
             13  
             "testdata/Results/exp-8-original-result"
             "testdata/Results/exp-8-sv")
)

(defun exp-8-result () 
	(exp-8-cc-gd)
	(exp-8-cc-pd)
	(exp-8-cc-sd)
	(exp-8-cc-cd)
	(exp-8-cc-sv)
) 
 
;;===============================================================

(defun exp-8-cc-gdav ()
;;exp-8 
  (pick-two-for-xvgr 0
             4 
             19  
             "testdata/Results/exp-8-original-result"
             "testdata/Results/exp-8-gdav")
)
 
(defun exp-8-cc-pdav ()
;;exp-8 
  (pick-two-for-xvgr 1 
             4 
             19  
             "testdata/Results/exp-8-original-result"
             "testdata/Results/exp-8-pdav")
)
 
(defun exp-8-cc-sdav ()
;;exp-8 
  (pick-two-for-xvgr 2
             4 
             19  
             "testdata/Results/exp-8-original-result"
             "testdata/Results/exp-8-sdav")
)
 
(defun exp-8-cc-cdav ()
;;exp-8 
  (pick-two-for-xvgr 3 
             4 
             19  
             "testdata/Results/exp-8-original-result"
             "testdata/Results/exp-8-cdav")
)
 
(defun exp-8-cc-svav ()
;;exp-8 
  (pick-two-for-xvgr 4 
             4 
             19  
             "testdata/Results/exp-8-original-result"
             "testdata/Results/exp-8-svav")
)

(defun exp-8-av-result () 
	(exp-8-cc-gdav)
	(exp-8-cc-pdav)
	(exp-8-cc-sdav)
	(exp-8-cc-cdav)
	(exp-8-cc-svav)
) 
 
