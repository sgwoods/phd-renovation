(defun testit () (load "testit") output-)

(setq open-        '(((T2-A ADT2-1A)) ((T2-A ADT2-1B)) ((T2-A ADT2-1C))) )
(setq curc-        '(BEFORE-P (T2-A T2-B)) )
(setq unboundv2-   '(ADT2-1D ADT2-1E ADT2-1F))
(setq curv1-       'T2-A)
(setq output-      (isrtReviseOpen-1 open- curc- unboundv2- curv1-))
