(in-package #:phd-qcsp-may29)
;; ao-revise.lisp  
;;

(defun ao-revise ( srcVar thisTarget constraint-fn maxDepth &key (mode 'step))

  (cond 
   ((eq mode 'aggr)
    (progn
      (ao-revise-aggr srcVar thisTarget constraint-fn maxDepth)
      ))
   ((eq mode 'step)
    (progn
      (ao-revise-step srcVar thisTarget constraint-fn maxDepth)
      ))
   (t
    (comment1 "Error in ao-revise option: " mode)
    nil)
   ))
