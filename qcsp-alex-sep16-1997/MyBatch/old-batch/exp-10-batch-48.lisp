;; Experiment 10

(load "load")
(load "yj-load")
(my-fasl)
 
  
(experiment  (list (nth 16 *data-file-list-c*))
	     *template-list-10*
	     "testdata/Results/exp-10-two-filter-48" nil)

:exit
