;;;; generate-experiments.lisp -- Generate all Q-Batch experiment scripts for SBCL
;;;;
;;;; Usage:
;;;;   sbcl --non-interactive --load Q-Batch-SBCL/generate-experiments.lisp
;;;;
;;;; Generates:
;;;;   - 20 ij2-*.lisp files (memory-search baseline, noise 50-1000)
;;;;   - 20 ij3-*.lisp files (memory-search + FC/DR/advance-sort)
;;;;   - 5  ij4-*.lisp files (direct adt + FC/DR/advance-sort)
;;;;   Total: 45 experiment scripts

(format t "~&; Generating Q-Batch-SBCL experiment scripts...~%")

;;; Constants -------------------------------------------------------------------

(defvar *noise-levels*
  '(50 100 150 200 250 300 350 400 450 500
    550 600 650 700 750 800 850 900 950 1000))

(defvar *seeds*
  '(("default"    . "1")
    ("1783960706" . "2")
    ("6148712495" . "3")
    ("8261581571" . "4")
    ("4705297406" . "5")
    ("6724813580" . "6")
    ("8798969000" . "7")
    ("0805098560" . "8")
    ("4767135635" . "9")
    ("7685437293" . "99")))

(defvar *ij4-groups*
  '((1 . (50 100 150 200 250))
    (2 . (300 350 400 450))
    (3 . (500 550 600 650))
    (4 . (700 750 800 850))
    (5 . (900 950 1000))))

(defun noise-label (noise)
  "Format noise level for filenames: 50 -> 050, 100 -> 100, 1000 -> 1000"
  (if (< noise 100)
      (format nil "0~A" noise)
      (format nil "~A" noise)))

;;; ij2 generator (memory-search baseline) -------------------------------------

(defun generate-ij2-file (noise)
  (let ((filename (format nil "Q-Batch-SBCL/ij2-~A.lisp" (noise-label noise))))
    (with-open-file (out filename :direction :output
                     :if-exists :supersede :if-does-not-exist :create)
      (format out "~%;; ~A~%" noise)
      (format out "~%(princ \"Journal Testing (2 Phased)\") (terpri)(terpri)~%")
      (format out "(load \"Q-Batch-SBCL/bootstrap.lisp\")~%")
      (format out "~%(princ \"**** Noise ~A ****\") (terpri)(terpri)~%" noise)
      (dolist (seed *seeds*)
        (format out "(time (memory-search \"quilici-t1-index\" \"quilici-t1\"~%")
        (format out "	   :sit-noise    ~A~%" noise)
        (format out "	   :random-ident \"~A\"~%" (car seed))
        (format out "	   :memory-output-file \"../Q-Batch-SBCL/ij2/ij2-~A.~A\"~%"
                (noise-label noise) (cdr seed))
        (format out "	   ))~%~%"))
      (format out "(sb-ext:exit)~%"))
    (format t "~&;   ~A~%" filename)))

;;; ij3 generator (memory-search + FC/DR/advance-sort) -------------------------

(defun generate-ij3-file (noise)
  (let ((filename (format nil "Q-Batch-SBCL/ij3-~A.lisp" (noise-label noise))))
    (with-open-file (out filename :direction :output
                     :if-exists :supersede :if-does-not-exist :create)
      (format out "~%;; ~A~%" noise)
      (format out "~%(princ \"Journal Testing (2 Phased)\") (terpri)(terpri)~%")
      (format out "(load \"Q-Batch-SBCL/bootstrap.lisp\")~%")
      (format out "~%(princ \"**** Noise ~A ****\") (terpri)(terpri)~%" noise)
      (dolist (seed *seeds*)
        (format out "(time (memory-search \"quilici-t1-index\" \"quilici-t1\"~%")
        (format out "	   :sit-noise    ~A~%" noise)
        (format out "	   :1-forward-checking t~%")
        (format out "	   :1-dynamic-rearrangement t~%")
        (format out "	   :1-advance-sort t~%")
        (format out "	   :random-ident \"~A\"~%" (car seed))
        (format out "	   :memory-output-file \"../Q-Batch-SBCL/ij3/ij3-~A.~A\"~%"
                (noise-label noise) (cdr seed))
        (format out "	   ))~%~%"))
      (format out "(sb-ext:exit)~%"))
    (format t "~&;   ~A~%" filename)))

;;; ij4 generator (direct adt + FC/DR/advance-sort) ----------------------------

(defun generate-ij4-file (group-num noise-list)
  (let ((filename (format nil "Q-Batch-SBCL/ij4-~A.lisp" group-num)))
    (with-open-file (out filename :direction :output
                     :if-exists :supersede :if-does-not-exist :create)
      (format out "~%;; ~{~A~^, ~}~%" noise-list)
      (format out "~%(princ \"JOURNAL Testing (FCDR, adv sort)\") (terpri)(terpri)~%")
      (format out "(load \"Q-Batch-SBCL/bootstrap.lisp\")~%")
      (dolist (noise noise-list)
        (format out "~%(princ \"**** Noise ~A ****\") (terpri)(terpri)~%" noise)
        (dolist (seed *seeds*)
          (format out "(time (adt :situation-id \"quilici-i1\"~%")
          (format out "	   :sit-noise    ~A~%" noise)
          (format out "	   :template-id  \"quilici-t1\"~%")
          (format out "	   :forward-checking t~%")
          (format out "	   :dynamic-rearrangement t~%")
          (format out "	   :advance-sort t~%")
          (format out "	   :single-line-override t~%")
          (format out "	   :random-ident \"~A\"~%" (car seed))
          (format out "	   :output-file \"ij4-~A.~A\"~%"
                  (noise-label noise) (cdr seed))
          (format out "	   ))~%~%")))
      (format out "(sb-ext:exit)~%"))
    (format t "~&;   ~A~%" filename)))

;;; Generate all files ---------------------------------------------------------

(format t "~&; --- ij2 (memory-search baseline) ---~%")
(dolist (noise *noise-levels*)
  (generate-ij2-file noise))

(format t "~&; --- ij3 (memory-search + FC/DR/advance-sort) ---~%")
(dolist (noise *noise-levels*)
  (generate-ij3-file noise))

(format t "~&; --- ij4 (direct adt + FC/DR/advance-sort) ---~%")
(dolist (group *ij4-groups*)
  (generate-ij4-file (car group) (cdr group)))

(format t "~&; Done. 45 experiment scripts generated in Q-Batch-SBCL/.~%")
