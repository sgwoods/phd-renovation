;;;; tests/run.lisp -- Run all FiveAM test suites
;;;;
;;;; Usage: sbcl --non-interactive --load "tests/run.lisp"
;;;;
;;;; Runs csp and qcsp3 test suites in separate SBCL processes
;;;; (necessary because both systems define functions with the same
;;;; names in CL-USER, so they cannot coexist in one image).
;;;;
;;;; Exits with status 0 if all suites pass, 1 otherwise.

(defvar *project-root*
  (make-pathname :directory (butlast (pathname-directory
                                       (truename *load-pathname*)))
                 :device (pathname-device (truename *load-pathname*))))

(defun run-suite (suite-file label)
  "Run a test suite in a child SBCL process. Returns T on success."
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

(format t "~&~%;; ===== Running all FiveAM test suites =====~%~%")

(let ((csp-ok (run-suite "tests/csp-suite.lisp" "CSP suite"))
      (qcsp3-ok (run-suite "tests/qcsp3-suite.lisp" "QCSP3 suite")))
  (format t "~&;; ===== Summary =====~%")
  (format t ";; CSP:   ~A~%" (if csp-ok "PASS" "FAIL"))
  (format t ";; QCSP3: ~A~%" (if qcsp3-ok "PASS" "FAIL"))
  (sb-ext:exit :code (if (and csp-ok qcsp3-ok) 0 1)))
