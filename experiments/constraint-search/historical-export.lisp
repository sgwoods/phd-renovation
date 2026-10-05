(in-package #:constraint-search-bench)

(defparameter *historical-cases*
  '(("adt-base" "adt" "quilici-i1" "quilici-t1")
    ("adt-index" "adt" "quilici-i1" "quilici-t1-index")
    ("adt-two" "adt" "q-i2" "quilici-t1")
    ("mpr-base" "mpr" "test-1" "test1-w")))

(defun supported-historical-constraints-p (domain template)
  (let ((allowed (if (equal domain "adt") '(qcsp3::before-p qcsp3::close-to-p qcsp3::same-name-p)
                     '(qcsp3::sep qcsp3::left-of qcsp3::right-of qcsp3::behind-of
                       qcsp3::ahead-of qcsp3::echelon qcsp3::same-attr-orient))))
    (every (lambda (c) (and (member (first c) allowed) (= (length (second c)) 2)))
           (third template))))

(defun historical-id (symbol)
  (require-model (symbolp symbol) "Historical IDs must be symbols.")
  (symbol-name symbol))

(defun string-mappings (solutions)
  (mapcar (lambda (solution)
            (mapcar (lambda (binding) (mapcar #'historical-id binding)) solution)) solutions))

(defun prepare-historical-case (name root)
  "Run in a dedicated process: loading domains replaces shared legacy functions."
  (let ((case (assoc name *historical-cases* :test #'equal)))
    (unless case (error 'unsupported-instance :reason "Unknown historical case; no arbitrary callback export."))
    (destructuring-bind (id domain situation template) case
      (declare (ignore id))
      (let ((*standard-output* (make-broadcast-stream))
            (*default-pathname-defaults* (merge-pathnames "qcsp3/" root)))
        (load (format nil "~A-simple.lisp" domain))
        (load (format nil "~A-setup.lisp" domain))
        (when (equal domain "adt")
          (setf qcsp3::*actual-type-lst* (qcsp3::simplify-types (second (qcsp3::get-dist "dist1")))))
        (setf qcsp3::*current-template* (copy-tree (qcsp3::get-templ-object template)))
        (unless (supported-historical-constraints-p domain qcsp3::*current-template*)
          (error 'unsupported-instance :reason "Unreviewed predicate or higher-arity historical constraint."))
        (let* ((original (copy-tree (qcsp3::get-situation situation qcsp3::*situations*)))
               (prepared (if (equal domain "adt") (qcsp3::restructure-line-numbers original) original)))
          (require-model (and original qcsp3::*current-template*) "Historical inputs missing.")
          (setf qcsp3::*current-situation* prepared
                qcsp3::*sit-object-id* situation qcsp3::*template-id* template
                qcsp3::*situation-noise-added* 0 qcsp3::*single-line-override* nil)
          (let ((raw (if (equal domain "adt") (qcsp3::adt-variables) (qcsp3::mpr-variables))))
            (qcsp3:set-globals raw "historical-export" "bt" t nil nil nil nil nil nil nil
                               nil 10 11 nil nil nil nil)
            (setf qcsp3::*var-order* (mapcar #'first raw))
            (values case original prepared raw
                    (qcsp3::node-consistent-variables raw :force nil))))))))

(defun export-prepared-model (id variables)
  (let ((constraints (list (list :id "implicit-injectivity" :kind :all-different
                                 :scope (mapcar (lambda (v) (historical-id (first v))) variables)))))
    (loop for constraint in (third qcsp3::*current-template*) for index from 0 do
      (destructuring-bind (left right) (second constraint)
        (let ((tuples nil))
          (dolist (a (cdr (assoc left variables)))
            (dolist (b (cdr (assoc right variables)))
              (when (qcsp3::test-constraint-2 left a right b nil constraint)
                (push (list (historical-id a) (historical-id b)) tuples))))
          (push (list :id (format nil "~D-~A" index (first constraint)) :kind :table
                      :scope (list (historical-id left) (historical-id right))
                      :tuples (nreverse tuples)) constraints))))
    (validate-instance
     (list :schema-version 1 :id id :provenance "historical-derived"
           :variables (mapcar (lambda (v) (list (historical-id (first v))
                                               (mapcar #'historical-id (rest v)))) variables)
           :constraints (nreverse constraints)))))

(defun check-historical-assignment (variables assignment)
  "Check with the original node and pair callbacks, not exported tuple membership."
  (and (every (lambda (binding) (qcsp3::node-consistent-p (first binding) (second binding))) assignment)
       (loop for tail on assignment always
         (loop for other in (rest tail) always
           (first (qcsp3::consistent-p (caar tail) (second (first tail))
                                       (first other) (second other) assignment :sort-const nil))))
       (= (length variables) (length assignment))))

(defun audit-export (model variables)
  ;; Compare every assignment in the unary-filtered product in both directions.
  ;; Bounded reviewed cases only; a larger product must not silently weaken this gate.
  (let ((product (reduce #'* variables :key (lambda (v) (length (cdr v))) :initial-value 1))
        (checked 0))
    (require-model (<= product 100000) "Historical audit exceeds exhaustive budget.")
    (labels ((visit (remaining bindings)
               (if remaining
                   (dolist (value (cdar remaining))
                     (visit (rest remaining) (cons (list (caar remaining) value) bindings)))
                   (progn
                     (incf checked)
                     (require-model
                      (eq (not (null (check-historical-assignment variables bindings)))
                          (not (null (check-assignment model (first (string-mappings (list bindings)))))))
                      "Historical predicate/model disagreement.")))))
      (visit variables nil))
    checked))

(defun solve-historical (variables)
  (let ((*standard-output* (make-broadcast-stream)))
    (qcsp3:set-globals (copy-tree variables) "historical-export" "bt" t nil nil nil nil nil nil nil
                       nil 10 11 nil nil nil nil)
    (setf qcsp3::*variables* variables qcsp3::*var-order* (mapcar #'first variables)
          qcsp3::*single-line-override* nil
          qcsp3::*internal-advance-start-time* (get-internal-run-time)
          qcsp3::*internal-advance-end-time* (get-internal-run-time))
    (let ((status (qcsp3:backtracking (qcsp3::make-initial-bt-state (copy-tree variables))
                                    #'qcsp3::consistent-p :forward-checking nil
                                    :dynamic-rearrangement nil :one-solution-only nil
                                    :backjump nil :arc-c nil :sch-c nil)))
      (require-model (eq status :complete) "Historical search did not exhaust.")
      (string-mappings qcsp3::*solution-set*))))

(defun solve-original-entrypoint (case root)
  "Cross-check the original domain setup, including its hidden semantic globals."
  (let ((*standard-output* (make-broadcast-stream))
        (*default-pathname-defaults* (merge-pathnames "qcsp3/" root)))
    (dolist (directory '("ADT-Random/" "ADT-Situation/" "MPR-Random/" "MPR-Situation/"))
      (ensure-directories-exist (merge-pathnames "placeholder" directory)))
    (apply (if (equal (second case) "adt") #'qcsp3:adt #'qcsp3:mpr)
           (list :situation-id (third case) :template-id (fourth case) :sit-noise 0
                 :random-ident "unique" :one-solution-only nil :cpu-sec-limit 10
                 :forward-checking nil :dynamic-rearrangement nil :advance-sort nil
                 :sort-const nil :adv-sort-const nil))
    (string-mappings qcsp3::*solution-set*)))
