(load "load")
(load "yj-load")
(my-fasl)

(load "this-exp-data.lisp")

(experiment  (list (nth 5 *this-data-file*))
	     *this-template-list*
	     "testdata/Results/Inter/this-result-5" nil)

:exit
