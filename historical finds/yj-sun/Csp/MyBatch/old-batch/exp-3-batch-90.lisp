;; Experiment 1

(load "load")
(load "yj-load")
(my-fasl)
(load "2-pre")
(load "general-exp-2")
 
 
(setq *template-list-3*	'(
	"increment-template-2-2" 		  
		))
 
(experiment  (list (nth 21 *data-file-list-d*))
	     *template-list-3*
	     "testdata/Results/exp-3-two-filter-90" nil)


:exit
