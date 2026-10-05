;;;; Separate FiveAM suite for the opt-in research harness, not a historical golden.
(require :asdf)
(load (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname)))
(ql:quickload :fiveam :silent t)
(defparameter *project-root* (truename (merge-pathnames "../" (uiop:pathname-directory-pathname *load-pathname*))))
(pushnew *project-root* asdf:*central-registry* :test #'equal)
(asdf:load-system :qcsp3)
(load (merge-pathnames "experiments/constraint-search/model.lisp" *project-root*))
(load (merge-pathnames "experiments/constraint-search/qcsp3-adapter.lisp" *project-root*))
(load (merge-pathnames "experiments/constraint-search/table-search.lisp" *project-root*))
(load (merge-pathnames "experiments/constraint-search/historical-export.lisp" *project-root*))

(in-package #:constraint-search-bench)
(5am:def-suite constraint-search-tests :description "Independent finite-model contract and QCSP3 parity")
(5am:in-suite constraint-search-tests)

(defun fixture (name)
  (read-instance (merge-pathnames (format nil "experiments/constraint-search/fixtures/~A.sexp" name)
                                 cl-user::*project-root*)))

(defun normalized (solutions)
  (sort (mapcar (lambda (assignment)
                 (sort (copy-tree assignment) #'string< :key #'first)) solutions)
        #'string< :key #'prin1-to-string))

(defun tiny-instance (seed)
  "Stable generator v1; no dependency on implementation-specific RANDOM state."
  (let ((state (+ 1 seed)) (variables nil) (constraints nil))
    (labels ((draw (limit)
               (setf state (mod (+ (* state 1664525) 1013904223) 4294967296))
               (mod (ash state -16) limit)))
      (dotimes (i (+ 2 (mod seed 3)))
        (push (list (format nil "v~D" i)
                    (loop for j below 3 unless (zerop (draw 4)) collect (format nil "o~D" j))) variables))
      (setf variables (nreverse variables))
      (loop for tail on variables do
        (dolist (right (rest tail))
          (unless (zerop (draw 3))
            (push (list :id (format nil "~A-to-~A" (caar tail) (first right))
                        :kind :table :scope (list (caar tail) (first right))
                        :tuples (loop for a in (second (first tail)) append
                                  (loop for b in (second right) unless (zerop (draw 3)) collect (list a b))))
                  constraints))))
      (when (oddp seed)
        (push (list :id "injective" :kind :all-different :scope (mapcar #'first variables)) constraints))
      (list :schema-version 1 :id (format nil "generated-v1-~D" seed)
            :provenance "new-synthetic" :variables variables :constraints constraints))))

(5am:test hand-checked-fixtures
  (5am:is (equal '((("source" "a") ("target" "b")))
                 (getf (enumerate-instance (fixture "ordered")) :solutions)))
  (5am:is (equal (getf (enumerate-instance (fixture "ambiguous")) :solutions)
                 '((("left" "a") ("right" "b")) (("left" "b") ("right" "a")))))
  (5am:is (equal (getf (enumerate-instance (fixture "hall-sat")) :solutions)
                 '((("A" "1") ("B" "2") ("C" "3"))
                   (("A" "2") ("B" "1") ("C" "3")))))
  (5am:is (eq :unsat (getf (enumerate-instance (fixture "hall-unsat")) :status)))
  (5am:is (equal (getf (enumerate-instance (fixture "unary")) :solutions) '((("slot" "b"))))))

(5am:test materialized-parity
  (dolist (name '("ordered" "ambiguous" "hall-sat" "hall-unsat" "unary"))
    (let* ((instance (fixture name)) (before (copy-tree instance))
           (oracle (enumerate-instance instance)))
      (dolist (strategy '(:bt :fc :fcdr :fcdr-as))
        (let ((result (solve-qcsp3 instance :strategy strategy)))
          (5am:is-true (getf result :complete))
          (5am:is (eq (getf result :status) (getf oracle :status)))
          (5am:is (equal (normalized (getf result :solutions)) (normalized (getf oracle :solutions))))))
      (5am:is (equal instance before)))))

(5am:test generated-parity
  (let ((sat 0) (unsat 0) (ambiguous 0))
    (dotimes (seed 100)
      (let* ((instance (tiny-instance seed)) (oracle (enumerate-instance instance)))
        (if (eq (getf oracle :status) :sat) (incf sat) (incf unsat))
        (when (> (length (getf oracle :solutions)) 1) (incf ambiguous))
        (dolist (strategy '(:bt :fc :fcdr :fcdr-as))
          (let ((result (solve-qcsp3 instance :strategy strategy)))
            (5am:is-true (getf result :complete))
            (5am:is (eq (getf result :status) (getf oracle :status)))
            (5am:is (equal (normalized (getf result :solutions)) (normalized (getf oracle :solutions)))
                    "Mismatch at seed ~D strategy ~S" seed strategy)))))
    (5am:is (plusp sat)) (5am:is (plusp unsat)) (5am:is (plusp ambiguous))))

(5am:test witness-mutations
  (let ((instance (fixture "ordered")))
    (dolist (bad '((("source" "a") ("target" "a"))
                  (("source" "b") ("target" "a"))
                  (("source" "a") ("target" "outside"))
                  (("source" "a"))
                  (("source" "a") ("source" "b"))
                  (("source" "a") ("target" "b") ("extra" "a"))))
      (5am:is-false (check-assignment instance bad)))
    ;; A solver can correctly solve an incorrectly translated model.
    (let ((reversed (copy-tree instance)))
      (setf (getf (first (getf reversed :constraints)) :scope) '("target" "source"))
      (5am:is-false (check-assignment instance (first (getf (solve-qcsp3 reversed) :solutions)))))
    (let ((omitted (copy-tree instance)))
      (setf (getf omitted :constraints) nil)
      (5am:is-true (some (lambda (assignment) (not (check-assignment instance assignment)))
                         (getf (solve-qcsp3 omitted) :solutions)))))
  (let* ((original (fixture "ambiguous")) (omitted (copy-tree original)))
    (setf (getf omitted :constraints) nil)
    (5am:is-true (some (lambda (assignment) (not (check-assignment original assignment)))
                       (getf (solve-qcsp3 omitted) :solutions)))))

(5am:test strict-model-validation
  (let ((instance (fixture "ordered")))
    (5am:signals invalid-instance (validate-instance (append instance '(:callback "ignored?"))))
    (5am:signals invalid-instance (validate-instance (append instance '(:schema-version 1))))
    (let ((bad (copy-tree instance)))
      (setf (getf bad :schema-version) 2)
      (5am:signals invalid-instance (validate-instance bad)))
    (let ((bad (copy-tree instance)))
      (setf (getf (first (getf bad :constraints)) :tuples) '(("a")))
      (5am:signals invalid-instance (validate-instance bad)))
    (let ((bad (copy-tree instance)))
      (setf (getf (first (getf bad :constraints)) :scope) '("unknown" "target"))
      (5am:signals invalid-instance (validate-instance bad))))
  (let ((ternary '(:schema-version 1 :id "ternary" :provenance "new-synthetic"
                   :variables (("x" ("a")) ("y" ("a")) ("z" ("a")))
                   :constraints ((:id "three" :kind :table :scope ("x" "y" "z")
                                   :tuples (("a" "a" "a")))))))
    (5am:is (eq :sat (getf (enumerate-instance ternary) :status)))
    (dolist (policy '(:mrv :wdeg))
      (5am:is-true (same-solutions-p (getf (enumerate-instance ternary) :solutions)
                                    (getf (solve-table-search ternary :policy policy) :solutions))))
    (5am:signals unsupported-instance (solve-qcsp3 ternary))))

(5am:test boundaries-and-isolation
  (let ((instance (fixture "ambiguous"))
        (qcsp3::*solution-set* '(("sentinel"))) (qcsp3:*constraint-cks* 12345))
    (let ((first (solve-qcsp3 instance :mode :first)))
      (5am:is (eq :sat (getf first :status)))
      (5am:is-false (getf first :complete))
      (5am:is (= 1 (length (getf first :solutions)))))
    (5am:is (equal qcsp3::*solution-set* '(("sentinel"))))
    (5am:is (= 12345 qcsp3:*constraint-cks*))
    (let ((limited (solve-qcsp3 instance :cpu-seconds 0)))
      (5am:is (eq :unknown (getf limited :status)))
      (5am:is-false (getf limited :complete)))
    (let ((limited (enumerate-instance instance :max-assignments 0)))
      (5am:is (eq :unknown (getf limited :status)))
      (5am:is-false (getf limited :complete)))
    (let ((limited (enumerate-instance instance :max-assignments 2)))
      (5am:is (eq :sat (getf limited :status)))
      (5am:is-false (getf limited :complete))))
  (let ((empty '(:schema-version 1 :id "empty" :provenance "new-synthetic"
                 :variables nil :constraints nil)))
    (5am:is (equal '(nil) (getf (enumerate-instance empty) :solutions)))
    (5am:is (equal '(nil) (getf (solve-qcsp3 empty) :solutions))))
  (let ((empty-domain '(:schema-version 1 :id "empty-domain" :provenance "new-synthetic"
                        :variables (("x" nil)) :constraints nil)))
    (5am:is (eq :unsat (getf (solve-qcsp3 empty-domain) :status)))))

(5am:test duplicate-result-detection
  (5am:is-false (same-solutions-p '((("x" "a")) (("x" "a")))
                                  '((("x" "a")) (("x" "b")))))
  (5am:is-true (same-solutions-p '((("x" "a") ("y" "b")))
                                 '((("y" "b") ("x" "a"))))))

(5am:test runner-contract
  (5am:is (string= "runner contract passed"
                    (string-trim '(#\Newline #\Return)
                                 (uiop:run-program
                                  (list "python3" (namestring (merge-pathnames "tests/constraint-runner-check.py"
                                                                                           cl-user::*project-root*)))
                                  :output :string :error-output *error-output*)))))

(5am:test table-search-parity
  (dotimes (seed 100)
    (let* ((instance (tiny-instance seed)) (expected (enumerate-instance instance)))
      (dolist (policy '(:mrv :wdeg))
        (let ((actual (solve-table-search instance :policy policy)))
          (5am:is-true (getf actual :complete))
          (5am:is (eq (getf expected :status) (getf actual :status)))
          (5am:is-true (same-solutions-p (getf expected :solutions) (getf actual :solutions)))))))
  (let* ((instance (fixture "hall-unsat"))
         (first (solve-table-search instance)) (again (solve-table-search instance)))
    (5am:is (plusp (getf first :weight-updates)))
    (5am:is (equal (getf first :weights) (getf again :weights))))
  (5am:is (eq :unknown (getf (solve-table-search (fixture "ambiguous") :cpu-seconds 0) :status)))
  (let ((result (solve-table-search (fixture "ambiguous") :mode :first)))
    (5am:is (eq :sat (getf result :status)))
    (5am:is-false (getf result :complete)))
  (let* ((domains '(("a" ("1" "2")) ("b" ("1" "2" "3")) ("c" ("1" "2" "3"))))
         (constraints '((:scope ("a" "c")) (:scope ("b" "c"))))
         (weights #(1 10)))
    (5am:is (equal "a" (first (select-table-variable domains constraints weights :mrv))))
    (5am:is (equal "c" (first (select-table-variable domains constraints weights :wdeg))))))

(5am:test historical-export-contract
  (5am:is-false (supported-historical-constraints-p "mpr" '("bad" nil ((qcsp3::medial (a b c))))))
  (5am:is-false (supported-historical-constraints-p "adt" '("bad" nil ((qcsp3::same-type-p (a b))))))
  (5am:is-false (supported-historical-constraints-p "adt" '("bad" nil ((unknown (a b))))))
  (5am:is-true (search "mpr-base: original predicates"
                       (uiop:run-program (list "python3" (namestring (merge-pathnames "experiments/constraint-search/export.py"
                                                                                   cl-user::*project-root*)))
                                         :output :string :error-output *error-output*))))

(5am:test historical-expected-mappings
  ;; Pin IDs independently of exporter output; regeneration must not redefine truth.
  (dolist (case '(("adt-base" "ADTQ1-") ("adt-index" "ADTQ1-")
                  ("adt-two" "ADTQ1-" "ADTQ2-") ("mpr-base" "SIT1-")))
    (let* ((name (first case)) (mpr (string= name "mpr-base"))
           (instance (fixture (concatenate 'string "historical/" name)))
           (expected (loop for prefix in (rest case) collect
                       (loop for suffix in (cond (mpr '("1" "2" "3" "4" "5"))
                                                   ((string= name "adt-index") '("C" "D" "G" "E"))
                                                   (t '("A" "B" "C" "D" "E" "F" "G" "H" "I")))
                             collect (list (concatenate 'string (if mpr "TS" "Q1-") suffix)
                                           (concatenate 'string prefix suffix))))))
      (5am:is-true (same-solutions-p expected (getf (enumerate-instance instance) :solutions)))
      (dolist (strategy '(:bt :fc :fcdr :fcdr-as :mrv :wdeg))
        (let ((actual (if (member strategy '(:mrv :wdeg))
                          (solve-table-search instance :policy strategy)
                          (solve-qcsp3 instance :strategy strategy))))
          (5am:is-true (getf actual :complete))
          (5am:is-true (same-solutions-p expected (getf actual :solutions))))))))

(5am:test controlled-noise-parity
  (let ((directory (merge-pathnames "experiments/constraint-search/fixtures/noise/" cl-user::*project-root*)))
    (5am:is (= 20 (length (directory (merge-pathnames "*.sexp" directory)))))
    (dolist (path (directory (merge-pathnames "*.sexp" directory)))
      (let* ((instance (read-instance path)) (name (getf instance :id))
             (negative (search "negative" name)) (ambiguous (search "ambiguous" name))
             (expected (unless negative
                         (loop for prefix in (if ambiguous '("ADTQ1-" "N0-1-") '("ADTQ1-")) collect
                           (loop for suffix in '("A" "B" "C" "D" "E" "F" "G" "H" "I") collect
                             (list (concatenate 'string "Q1-" suffix) (concatenate 'string prefix suffix))))))
             (oracle (enumerate-instance instance)))
        (5am:is-true (getf oracle :complete))
        (5am:is-true (same-solutions-p expected (getf oracle :solutions)))
        (dolist (strategy '(:bt :fc :fcdr :fcdr-as :mrv :wdeg))
          (let ((result (if (member strategy '(:mrv :wdeg))
                            (solve-table-search instance :policy strategy)
                            (solve-qcsp3 instance :strategy strategy))))
            (5am:is-true (getf result :complete))
            (5am:is-true (same-solutions-p expected (getf result :solutions))))))))
  (5am:is-true (search "noise-s0-n2-renamed"
                       (uiop:run-program (list "python3" (namestring (merge-pathnames "experiments/constraint-search/generate-noise.py"
                                                                                    cl-user::*project-root*)))
                                         :output :string :error-output *error-output*))))

(5am:test trace-contract
  (let* ((instance (fixture "noise/noise-s0-n2-negative"))
         (plain (solve-table-search instance))
         (traced (solve-table-search instance :trace-limit 1000))
         (limited (solve-table-search instance :trace-limit 2)))
    (5am:is-true (getf traced :complete))
    (5am:is (= (getf plain :nodes) (getf traced :nodes)))
    (5am:is (= (getf plain :constraint-tests) (getf traced :constraint-tests)))
    (5am:is (equal (getf plain :weights) (getf traced :weights)))
    (5am:is-true (same-solutions-p (getf plain :solutions) (getf traced :solutions)))
    (5am:is-true (some (lambda (event) (equal "failure" (gethash "event" event))) (getf traced :trace)))
    (5am:is (null (getf plain :trace)))
    (5am:is (= 2 (length (getf limited :trace))))
    (5am:is-true (getf limited :trace-truncated))
    (5am:signals invalid-instance (solve-table-search instance :trace-limit -1))))

(5am:test optional-cp-sat-contract
  (let ((python (uiop:getenv "PHD_BENCH_CP_PYTHON")))
    (if python
        (5am:is-true (search "CP-SAT contract passed"
                             (uiop:run-program (list python (namestring (merge-pathnames "tests/cp-sat-contract.py"
                                                                                                      cl-user::*project-root*)))
                                               :output :string :error-output *error-output*)))
        (5am:skip "Set PHD_BENCH_CP_PYTHON to run the optional installed CP-SAT backend."))))

(format t "~&;; Constraint search benchmark suite~%")
(uiop:quit (if (5am:run! 'constraint-search-tests) 0 1))
