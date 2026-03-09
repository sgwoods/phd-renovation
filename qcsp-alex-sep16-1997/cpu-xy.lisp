(in-package #:phd-qcsp-alex)
(setq *number-program-components-posi* 4)
(setq *cpu-time-posi* 13)
;;*************************************************************************************
(defun get-all-xcpu() 
  (exp-1-xcpu)
  (exp-2-xcpu)
  (exp-3-xcpu)
;;  (exp-4-1-xcpu)
;;  (exp-4-2-xcpu)
;;  (exp-6-xcpu)
;;  (average-array-missed-in-exp-6-xcpu)
)
;;*************************************************************************************
(defun average-array-missed-in-exp-6-xcpu ()
  (pick-two-for-xvgr 0 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/average-array-8-12-original-result" 
		     "testdata/Results/average-array-8-12-x-cpu")
)

(defun exp-1-xcpu ()
;;exp-1
  (pick-two-for-xvgr 0 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-1-original-result" 
		     "testdata/Results/exp-1-x-cpu")
)
(defun exp-2-xcpu ()
;;exp-2
  (pick-two-for-xvgr 0 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-2-original-result" 
		     "testdata/Results/exp-2-x-cpu")
)

(defun exp-3-xcpu ()
;;exp-3
  (pick-two-for-xvgr 0 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-3-original-result" 
		     "testdata/Results/exp-3-x-cpu")
)

(defun exp-6-xcpu ()
;;exp-6
  (pick-two-for-xvgr 0 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-6-original-result" 
		     "testdata/Results/reset-value-x-cpu")
  (pick-two-for-xvgr 1 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-6-original-result" 
		     "testdata/Results/copy-array-element-x-cpu")
  (pick-two-for-xvgr 2 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-6-original-result" 
		     "testdata/Results/alloc-array-x-cpu")
  (pick-two-for-xvgr 3 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-6-original-result" 
		     "testdata/Results/traverse-array-x-cpu")
  (pick-two-for-xvgr 4 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-6-original-result" 
		     "testdata/Results/addup-array-x-cpu")
  (pick-two-for-xvgr 5 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-6-original-result" 
		     "testdata/Results/copy-array-x-cpu")
  (pick-two-for-xvgr 7 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-6-original-result" 
		     "testdata/Results/sum-square-array-x-cpu")
)

(defun exp-4-1-xcpu ()
;;exp-4-1
  (pick-two-for-xvgr 0 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-4-1-original-result" 
		     "testdata/Results/aa-9-13-x-cpu")
  (pick-two-for-xvgr 1 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-4-1-original-result" 
		     "testdata/Results/aa-9-14-x-cpu")
  (pick-two-for-xvgr 2 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-4-1-original-result" 
		     "testdata/Results/aa-9-15-x-cpu")
  (pick-two-for-xvgr 3 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-4-1-original-result" 
		     "testdata/Results/aa-9-16-x-cpu")
  (pick-two-for-xvgr 4 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-4-1-original-result" 
		     "testdata/Results/aa-9-17-x-cpu")
  (pick-two-for-xvgr 5 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-4-1-original-result" 
		     "testdata/Results/aa-9-18-x-cpu")

)

(defun exp-4-2-xcpu ()
;;exp-4-2
  (pick-two-for-xvgr 0 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-4-2-original-result" 
		     "testdata/Results/aa-8-12-x-cpu")
  (pick-two-for-xvgr 1 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-4-2-original-result" 
		     "testdata/Results/aa-8-13-x-cpu")
  (pick-two-for-xvgr 2 
		     *number-program-components-posi* 
		     *cpu-time-posi* 
		     "testdata/Results/exp-4-2-original-result" 
		     "testdata/Results/aa-8-14-x-cpu")

)
