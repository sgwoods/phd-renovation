(load "load")
(load "yj-load")
(my-fasl)

(load "this-exp-data.lisp")

(experiment  (list (nth 11 *this-data-file*))
	     *this-template-list*
	     "testdata/Results/Inter/this-result-11" nil)

:exit
