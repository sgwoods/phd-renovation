;; compile.lsp

(defun compile-all (&optional (speed 'fast))
"
Compile CSP application
"
  (if *unix*    
      (progn
	(load "compile-set")
	(compile-set)

	(compile-file "bt.lisp")
	(compile-file "bm.lisp")
	(compile-file "ct.lisp")
	(compile-file "gsat.lisp")

	(compile-file "utility.lisp")

	(compile-file "mpr-simple.lisp")
	(compile-file "mpr-setup.lisp")
	(compile-file "queens.lisp")

	(compile-file "quilici-search.lisp")
	(compile-file "memory-csp.lisp")

	(compile-file "adt-simple.lisp")
	(compile-file "adt-setup.lisp")

	(load "load"))

    (progn
 
 (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:compile-set.lisp")
 (compile-set)

 (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:bt.lisp")
 (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:bm.lisp")
 (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:ct.lisp")
 (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:gsat.lisp")

 (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:utility.lisp")

 (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:mpr-simple.lisp")
 (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:mpr-setup.lisp")
 (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:queens.lisp")

 (compile-file 
  "Macintosh HD:Languages:Allegro Common Lisp:qcsp:quilici-search.lisp")
 (compile-file 
  "Macintosh HD:Languages:Allegro Common Lisp:qcsp:memory-csp.lisp")

 (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:adt-simple.lisp")
 (compile-file "Macintosh HD:Languages:Allegro Common Lisp:qcsp:adt-setup.lisp")

 (load "Macintosh HD:Languages:Allegro Common Lisp:qcsp:load")

      )))


