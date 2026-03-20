(defun my-load ()
  (load "adt-template.lisp")
  (load "new-setup.lisp")
;  (load "new-dep.lisp")          ; y2k etc use "2-pre.lisp" instead
  (load "2-pre.lisp")           ; 2-pre used for improved data structure (new alg)
  (load "general-exp.lisp")
  (load "random-templ-exp.lisp")
  (load "static-order-exp.lisp")
  (load "cpu-xy.lisp") 
)

(defun my-load-fasl ()
  (load "adt-template.sbin")
  (load "new-setup.sbin")
;  (load "new-dep.sbin")           ; y2k etc use "2-pre.lisp" instead
  (load "2-pre.sbin")       
  (load "general-exp.sbin")       ;  (load "general-exp-2.sbin") 
  (load "random-templ-exp.sbin")
  (load "static-order-exp.sbin")
  (load "cpu-xy.sbin")   
)

(defun my-compile ()
  (compile-file "adt-template.lisp")
  (compile-file "new-setup.lisp")
  (compile-file "new-dep.lisp")    ; y2k etc use "2-pre.lisp" instead
  (compile-file "2-pre.lisp")
  (compile-file "general-exp.lisp")
  (compile-file "random-templ-exp.lisp")
  (compile-file "static-order-exp.lisp")
  (compile-file "cpu-xy.lisp") 
)

(my-load-fasl)
