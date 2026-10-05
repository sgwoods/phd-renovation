(in-package #:constraint-search-bench)

(defun compile-pairs (instance)
  "Compile unary tables into domains and binary tables/distinctness into pairs."
  (let ((variables (copy-tree (getf instance :variables))) (pairs nil))
    (dolist (constraint (getf instance :constraints))
      (let ((scope (getf constraint :scope)))
        (case (getf constraint :kind)
          (:all-different
           (loop for tail on scope do
             (dolist (other (rest tail))
               (push (list (first tail) other :different) pairs))))
          (:table
           (case (length scope)
             (1 (let ((variable (assoc (first scope) variables :test #'equal)))
                  (setf (second variable)
                        (remove-if-not (lambda (value)
                                         (member (list value) (getf constraint :tuples) :test #'equal))
                                       (second variable)))))
             (2 (push (list (first scope) (second scope) (getf constraint :tuples)) pairs))
             (otherwise
              (error 'unsupported-instance :reason "QCSP3 adapter supports unary/binary tables only.")))))))
    (values variables pairs)))

(defun pairs-allow-p (pairs x a y b)
  (every (lambda (pair)
           (destructuring-bind (left right relation) pair
             (cond ((and (equal left x) (equal right y))
                    (if (eq relation :different) (not (equal a b))
                        (member (list a b) relation :test #'equal)))
                   ((and (equal left y) (equal right x))
                    (if (eq relation :different) (not (equal a b))
                        (member (list b a) relation :test #'equal)))
                   (t t)))) pairs))

(defun solve-qcsp3 (instance &key (strategy :bt) (mode :all) (cpu-seconds 5))
  "Run unmodified QCSP3 in isolated dynamic globals; never use its status as a witness."
  (validate-instance instance)
  (require-model (member strategy '(:bt :fc :fcdr :fcdr-as)) "Unsupported strategy.")
  (require-model (member mode '(:all :first)) "Unsupported solve mode.")
  (require-model (and (integerp cpu-seconds) (>= cpu-seconds 0)) "Invalid CPU budget.")
  (multiple-value-bind (variables pairs) (compile-pairs instance)
    (when (some (lambda (v) (null (second v))) variables)
      (return-from solve-qcsp3 (list :status :unsat :complete t :termination :empty-domain
                                     :solutions nil :raw-status nil :nodes 0 :pair-checks 0)))
    (unless variables
      (return-from solve-qcsp3 (list :status :sat :complete t :termination :empty-model
                                     :solutions (list nil) :raw-status nil :nodes 0 :pair-checks 0)))
    (when (zerop cpu-seconds)
      (return-from solve-qcsp3 (list :status :unknown :complete nil :termination :cpu-limit
                                     :solutions nil :raw-status nil :nodes 0 :pair-checks 0)))
    (let ((globals nil) (fc (not (eq strategy :bt)))
          (dr (member strategy '(:fcdr :fcdr-as))) (advance (eq strategy :fcdr-as)))
      ;; Legacy domains share special variables and reporting also mutates them.
      ;; Rebinding avoids leaking this experiment's state into other callers.
      (do-symbols (symbol (find-package :qcsp3))
        (when (and (eq (symbol-package symbol) (find-package :qcsp3)) (boundp symbol)
                   (char= (char (symbol-name symbol) 0) #\*))
          (push symbol globals)))
      (progv globals (mapcar #'symbol-value globals)
        (let* ((*standard-output* (make-broadcast-stream))
               (raw (mapcar (lambda (v) (cons (first v) (copy-list (second v)))) variables)))
          (unless (qcsp3:set-globals raw "finite-benchmark" "bt" nil nil nil fc (not (null dr))
                                    advance nil nil (eq mode :first) cpu-seconds
                                    (+ cpu-seconds 1) nil nil nil nil)
            (error "QCSP3 rejected benchmark configuration."))
          (setf qcsp3::*single-line-override* nil
                qcsp3::*long-output* nil
                qcsp3:*node-consistency-checks* 0
                qcsp3::*internal-advance-start-time* (get-internal-run-time)
                qcsp3::*internal-advance-end-time* (get-internal-run-time))
          (when advance (setf raw (qcsp3::advance-sort raw)))
          (setf qcsp3::*variables* raw qcsp3::*var-order* (mapcar #'first raw))
          (let* ((raw-status
                   (qcsp3:backtracking
                    (qcsp3::make-initial-bt-state raw)
                    (lambda (x a y b partial)
                      (declare (ignore partial))
                      (incf qcsp3:*constraint-cks*)
                      (list (not (null (pairs-allow-p pairs x a y b))) 0))
                    :forward-checking fc :dynamic-rearrangement (not (null dr))
                    :one-solution-only (eq mode :first) :backjump nil :arc-c nil :sch-c nil))
                 (solutions (copy-tree qcsp3::*solution-set*))
                 (complete (eq raw-status :complete)))
            (unless (member raw-status '(t :complete :time-bound))
              (error "Unexpected legacy return: ~S" raw-status))
            (list :status (cond (solutions :sat) (complete :unsat) (t :unknown))
                  :complete complete
                  :termination (cond (complete :exhausted) ((eq raw-status :time-bound) :cpu-limit)
                                     (t :first-witness))
                  :solutions solutions :raw-status raw-status
                  :nodes qcsp3:*nodes-visited* :pair-checks qcsp3:*constraint-cks*)))))))
