;; Experiment 10

(load "load")
(load "yj-load")
(my-fasl)
 
  
(experiment  (list (nth 5 *data-file-list-c*))
	     *template-list-10*
	     "testdata/Results/exp-10-two-filter-5" nil)

:exit
