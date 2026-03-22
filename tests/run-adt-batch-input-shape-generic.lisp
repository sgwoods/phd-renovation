;;;; run-adt-batch-input-shape-generic.lisp -- Inspect ADT input state for one system/dist pair
;;;;
;;;; Usage:
;;;;   PHD_ADT_SYSTEM=qcsp3
;;;;   PHD_ADT_PACKAGE=PHD-QCSP3
;;;;   PHD_ADT_DIST_ID=dist1
;;;;   PHD_ADT_RANDOM_IDENT=default
;;;;   PHD_ADT_WORKDIR=/tmp/.../adt-work/
;;;;   sbcl --non-interactive --load "tests/run-adt-batch-input-shape-generic.lisp"

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

(defun situation-stmt-type (entry)
  (first (third entry)))

(defun entry-id (entry)
  (first entry))

(defun stringify (value)
  (string-downcase (string value)))

(defun alist-incf (key alist)
  (let ((cell (assoc key alist)))
    (if cell
        (progn
          (incf (cdr cell))
          alist)
        (acons key 1 alist))))

(defun stmt-counts (situation)
  (let ((counts nil))
    (dolist (entry situation counts)
      (setq counts (alist-incf (situation-stmt-type entry) counts)))))

(defun sort-counts (counts)
  (sort (copy-list counts)
        #'string<
        :key (lambda (cell) (stringify (car cell)))))

(defun domain-sizes (var-set)
  (mapcar (lambda (node)
            (list (stringify (first node)) (length (rest node))))
          var-set))

(defun domain-heads (var-set &optional (limit 5))
  (mapcar (lambda (node)
            (list (stringify (first node))
                  (mapcar #'stringify
                          (subseq (rest node) 0 (min limit (length (rest node)))))))
          var-set))

(let* ((project-root (make-pathname :directory (butlast (pathname-directory
                                                         (truename *load-pathname*)))
                                    :device (pathname-device (truename *load-pathname*))))
       (system-name (string-downcase (required-env "PHD_ADT_SYSTEM")))
       (package-name (string-upcase (required-env "PHD_ADT_PACKAGE")))
       (dist-id (required-env "PHD_ADT_DIST_ID"))
       (random-ident (required-env "PHD_ADT_RANDOM_IDENT"))
       (adt-workdir (truename (required-env "PHD_ADT_WORKDIR"))))
  (pushnew project-root asdf:*central-registry* :test #'equal)
  (asdf:load-system (intern (string-upcase system-name) "KEYWORD"))

  (let ((*default-pathname-defaults* adt-workdir)
        (package package-name))
    (ensure-directories-exist (merge-pathnames "ADT-Random/dummy"
                                               *default-pathname-defaults*))
    (ensure-directories-exist (merge-pathnames "ADT-Situation/dummy"
                                               *default-pathname-defaults*))
    (funcall (intern "LOAD-RAND" package) random-ident)

    (if (string= system-name "qcsp3")
        (unless (funcall (intern "ADT-SET-GLOBAL-VALUES" package)
                         "adt-t2-1" 50 random-ident "adt-t2"
                         dist-id (funcall (intern "GET-DIST" package) dist-id)
                         nil t nil)
          (error "ADT setup failed for qcsp3"))
        (unless (funcall (intern "ADT-SET-GLOBAL-VALUES" package)
                         "adt-t2-1" 50 random-ident "adt-t2"
                         dist-id (funcall (intern "GET-DIST" package) dist-id)
                         nil t)
          (error "ADT setup failed for csp")))

    (let* ((raw (funcall (intern "ADT-VARIABLES" package)))
           (node-only (funcall (intern "NODE-CONSISTENT-VARIABLES" package) raw))
           (situation (symbol-value (intern "*CURRENT-SITUATION*" package)))
           (dist-name (symbol-value (intern "*RANDOM-DIST-NAME*" package)))
           (base-situation
             (funcall (intern "GET-SITUATION" package)
                      "adt-t2-1"
                      (symbol-value (intern "*SITUATIONS*" package))))
           (base-ids (mapcar #'entry-id base-situation))
           (noise-situation
             (remove-if (lambda (entry)
                          (member (entry-id entry) base-ids))
                        situation)))
      (format t "system=~A~%" system-name)
      (format t "package=~A~%" package-name)
      (format t "dist_id=~A~%" dist-name)
      (format t "base_situation_size=~A~%" (length base-situation))
      (format t "situation_size=~A~%" (length situation))
      (format t "noise_size=~A~%" (length noise-situation))
      (format t "raw_var_count=~A~%" (length raw))
      (format t "raw_avg_domain=~,1F~%" (avg-domain-size raw))
      (format t "node_avg_domain=~,1F~%" (avg-domain-size node-only))
      (format t "node_checks=~A~%" (symbol-value (intern "*NODE-CONSISTENCY-CHECKS*" package)))
      (format t "stmt_counts=~S~%"
              (mapcar (lambda (cell) (list (stringify (car cell)) (cdr cell)))
                      (sort-counts (stmt-counts situation))))
      (format t "noise_stmt_counts=~S~%"
              (mapcar (lambda (cell) (list (stringify (car cell)) (cdr cell)))
                      (sort-counts (stmt-counts noise-situation))))
      (format t "raw_domain_sizes=~S~%" (domain-sizes raw))
      (format t "node_domain_sizes=~S~%" (domain-sizes node-only))
      (format t "node_domain_heads=~S~%" (domain-heads node-only))
      (format t "first_three_lines=~S~%" (subseq situation 0 (min 3 (length situation))))
      (format t "first_var_shape=~S~%" (first node-only)))))
