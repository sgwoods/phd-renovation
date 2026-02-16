


(defun t4 (&optional (sys *unix*) )
  (if sys
      (progn
	(load  "test4.lisp")
	)
    (progn
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:test4.lisp")
      )))

(defun load-t4 (&optional (sys *unix*) )
  (if (not sys)
    (progn
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:comment")
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:compile-ao")
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:hierarchy")
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-revise-fns")
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-revise-aggressive")
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:applyr")
      (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:example-extend")
      ;;(load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:example-simple")
      )
  (progn
      (load "comment")
      (load "compile-ao")
      (load "hierarchy")
      (load "ao-revise-fns")
      (load "ao-revise-aggressive")
      (load "applyr")
      (load "example-extend")
      ;;(load "example-simple")
    )))

(defun testao1 ()
  (setq AO1 (ao-revise v1 v2 rfn 2)))

(defun testao2 ()
  (setq AO2 (ao-revise v0 v1 rfn 2)))

(defun testao3 ()
  (setq AO3 (ao-revise v2 v0 rfn 2)))



   