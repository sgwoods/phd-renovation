;;;; run-adt-batch-input-shape-ij2.lisp -- Inspect one preserved ADT batch ij2 input state
;;;;
;;;; Usage:
;;;;   PHD_ADT_BRIDGE_WORKDIR=/tmp/.../bridge/
;;;;   sbcl --non-interactive --load "tests/run-adt-batch-input-shape-ij2.lisp"

(require :asdf)

(defun required-env (name)
  (or (uiop:getenv name)
      (error "Missing required environment variable: ~A" name)))

(defun avg-domain-size (var-set)
  (if (null var-set)
      0.0
      (let ((total 0)
            (count 0))
        (dolist (node var-set (/ (* total 1.0) count))
          (incf total (length (rest node)))
          (incf count)))))

(let* ((project-root (make-pathname :directory (butlast (pathname-directory
                                                         (truename *load-pathname*)))
                                    :device (pathname-device (truename *load-pathname*))))
       (bridge-workdir (truename (required-env "PHD_ADT_BRIDGE_WORKDIR"))))
  (pushnew project-root asdf:*central-registry* :test #'equal)
  (asdf:load-system :phd-research)

  (let ((*default-pathname-defaults* bridge-workdir))
    (ensure-directories-exist (merge-pathnames "ADT-Random/dummy"
                                               *default-pathname-defaults*))

    ;; Reproduce the setup path used by the narrow ij2 bridge, but stop before search.
    (funcall (intern "LOAD-RAND" "PHD-CSP") "default")
    (unless (funcall (intern "ADT-SET-GLOBAL-VALUES" "PHD-CSP")
                     "adt-t2-1" 50 "default" "adt-t2"
                     "dist1" (funcall (intern "GET-DIST" "PHD-CSP") "dist1")
                     nil t)
      (error "ADT setup failed"))

    (let* ((raw (funcall (intern "ADT-VARIABLES" "PHD-CSP")))
           (node-only (funcall (intern "NODE-CONSISTENT-VARIABLES" "PHD-CSP") raw))
           (situation (symbol-value (intern "*CURRENT-SITUATION*" "PHD-CSP"))))
      (format t "situation_size=~A~%" (length situation))
      (format t "raw_var_count=~A~%" (length raw))
      (format t "raw_avg_domain=~,1F~%" (avg-domain-size raw))
      (format t "node_avg_domain=~,1F~%" (avg-domain-size node-only))
      (format t "node_checks=~A~%" (symbol-value (intern "*NODE-CONSISTENCY-CHECKS*" "PHD-CSP")))
      (format t "first_three_lines=~S~%" (subseq situation 0 (min 3 (length situation))))
      (format t "first_var_shape=~S~%" (first node-only)))))
