;; Experiment 1

(load "load")
(load "yj-load")
(my-fasl)
(load "2-pre")
(load "general-exp-2")
 
(setq *template-list-1*	'(
				"average-array-template-9-18" 
			  ))
 
(experiment  (list (nth 19 *data-file-list-d*))
	     *template-list-1*
	     "testdata/Results/exp-1-two-filter-66" nil)


:exit
