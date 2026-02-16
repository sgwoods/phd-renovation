;;*************************************************************************************
;;
;;For experiment 6, a set of templates with increasing number of components,
;;use PreInc

(load "load")
(load "yj-load")
(my-fasl)
  
(setq *template-list-6* '(
			  "reset-value-template-2-1"
;;			  "increment-template-2-2"
			  "copy-array-element-template-3-2"
			  "alloc-array-error-check-template-4-3"
			  "traverse-array-template-5-7"
			  "addup-array-template-6-9"
			  "copy-array-template-7-11"
			  "average-array-template-8-12"
			  "sum-square-array-9-16"
			  ))  
(experiment  (list (nth 0 *data-file-list-c*))
	     (list (nth 6 *template-list-6*))
	     "testdata/Results/exp-6-new-6-0" nil)


:exit
