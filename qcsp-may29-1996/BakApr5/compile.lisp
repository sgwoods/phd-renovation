;; compile.lsp

(defun compile-all (&optional (speed 'fast))
"
Compile CSP application
"
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

  (load "load")
)


