;;;; tests/ao-run.lisp -- Run all AO regression suites
;;;;
;;;; Usage: sbcl --non-interactive --load "tests/ao-run.lisp"

(defvar *project-root*
  (make-pathname :directory (butlast (pathname-directory
                                       (truename *load-pathname*)))
                 :device (pathname-device (truename *load-pathname*))))

(defun run-suite (suite-file label)
  "Run an AO suite in a child SBCL process. Returns T on success."
  (let* ((path (namestring (merge-pathnames suite-file *project-root*)))
         (process (sb-ext:run-program "sbcl"
                                      (list "--non-interactive" "--load" path)
                                      :output *standard-output*
                                      :error *error-output*
                                      :search t
                                      :wait t)))
    (let ((code (sb-ext:process-exit-code process)))
      (if (zerop code)
          (progn (format t "~&;; ~A: PASSED~%~%" label) t)
          (progn (format t "~&;; ~A: FAILED (exit ~A)~%~%" label code) nil)))))

(format t "~&~%;; ===== Running AO regression suites =====~%~%")

(let ((qcsp3-ok (run-suite "tests/ao-qcsp3-suite.lisp" "AO QCSP3 suite"))
      (may29-ok (run-suite "tests/ao-may29-suite.lisp" "AO May29 suite"))
      (alex-ok (run-suite "tests/ao-alex-suite.lisp" "AO Alex suite")))
  (format t "~&;; ===== AO Summary =====~%")
  (format t ";; AO QCSP3: ~A~%" (if qcsp3-ok "PASS" "FAIL"))
  (format t ";; AO May29: ~A~%" (if may29-ok "PASS" "FAIL"))
  (format t ";; AO Alex:  ~A~%" (if alex-ok "PASS" "FAIL"))
  (sb-ext:exit :code (if (and qcsp3-ok may29-ok alex-ok) 0 1)))
