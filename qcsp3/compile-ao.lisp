
(defun compile-ao (&optional (sys *unix*))

  (if sys
      (progn

	(compile-file "comment.lisp")
	(compile-file "hierarchy.lisp")
	(compile-file "ac-graph.lisp")
	(compile-file "ao-ac3.lisp")
	(compile-file "ao-ac-new.lisp")
	(compile-file "ao-revise-fns.lisp")
	(compile-file "ao-revise.lisp")
	(compile-file "ao-revise-step.lisp")
	(compile-file "ao-revise-aggressive.lisp")
	(compile-file "applyr.lisp")
	(compile-file "example-extend.lisp")
;;	(compile-file "example-simple.lisp")

	)
    (progn

  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:comment.lisp")
  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:hierarchy.lisp")
  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ac-graph.lisp")
  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-ac3.lisp")
  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-ac-new.lisp")
  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-revise-fns.lisp")
  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-revise.lisp")
  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-revise-step.lisp")
  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ao-revise-aggressive.lisp")
  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:applyr.lisp")
  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:example-extend.lisp")
  (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:example-simple.lisp")

      )))





