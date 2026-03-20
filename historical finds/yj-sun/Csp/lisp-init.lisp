;;; -*- Mode: LISP; Syntax: Common-Lisp; Package: LUCID; Base: 10 -*-
;;;
;;;; File: lisp-init.lisp
;;;
;;; This file is a prototypical initialization file for Sun Common Lisp
;;; version 3.0.  Copy this file to your home directory, and then edit
;;; the copy to suit your personal tastes.  The file will be loaded
;;; whenever you start up Sun Common Lisp unless you've specified
;;; the -n flag on the command line.
;;;
;;; Edit-History:
;;;
;;; Created: 9-Apr-89 by R. Dunbar Poor
;;; 26-Apr-89 r: Added augment-archive-search-path (H. Muller's suggestion)
;;;
;;; End-of-Edit-History

(in-package "USER")
 
;;; Tell me what features are present in this image

(format t ";;; This image features~{~<~%;;;~:; ~A~>~^,~}.~%" 
	(sort (copy-list *features*) #'string< :key #'symbol-name))

;;; Setting the compiler options

(defun pqc ()
  "Specify optimizations to select the Production Quality Compiler"
  (proclaim '(optimize (speed 3) (safety 1) (space 0) (compilation-speed 0))))

(defun sfc ()
  "Specify optimizations to select the Development Compiler"
  (proclaim '(optimize (speed 0) (safety 3) (space 3) (compilation-speed 3))))

;;; Give short names to some commonly typed functions

(defun cf (file &rest options)
  "Compile a file."
  (apply #'compile-file file options))

(defun cl (file &rest options)
  "Compile and load a file."
  (load (apply #'compile-file file options)))

(defun recompile (function)
  "Compile a function, uncompiling it if required"
  (check-type function symbol)
  (if (compiled-function-p (symbol-function function))
      (compile (uncompile function))
      (compile function)))

;;; Functions for printing objects in hexadeximal, decimal, octal, and binary.

(defun hex (&optional (arg *))
  "Print argument in hex.  If argument is omitted, use value of *"
  (format t "~&~X" arg)
  arg)

(defun decimal (&optional (arg *))
  "Print argument in decimal.  If argument is omitted, use value of *"
  (format t "~&~D" arg)
  arg)

(defun octal (&optional (arg *))
  "Print argument in octal.  If argument is omitted, use value of *"
  (format t "~&~O" arg)
  arg)

(defun binary (&optional (arg *))
  "Print argument in binary.  If argument is omitted, use value of *"
  (format t "~&~B" arg)
  arg)

(defun all-bases (&optional (arg *))
  "Print argument in hex, decimal, and octal.  If argument is ommited, use
   value of *"
  (format t "~&#x~X = ~D. = #o~O" arg arg arg)
  arg)

;;; List the contents of a hash table.

(defun printhash (hash-table)
  "Print out the contents of a hash table"
  (maphash #'(lambda (key value) (format t "~S:~14,8T~S~%" key value))
	   hash-table))

;;; Enable or disable multitasking

(defun disable-multitasking ()
  (when lucid::*io-waits-with-process-wait*
    (warn "Turning off the multitasking scheduler")
    (setf lucid::*io-waits-with-process-wait* nil)
    ;; A billion milliseconds = 11 days, 13 hours, 46 minutes, 40 seconds
    (setf *scheduling-quantum* 1000000000)
    ))

(defun enable-multitasking ()
  (unless lucid::*io-waits-with-process-wait*
    (warn "Turning on the multitasking scheduler")
    (setf lucid::*io-waits-with-process-wait* t)
    (setf *scheduling-quantum* 333)	; milliseconds
    ))

;;; A common error is for a developer to disksave an image with his or her
;;; own customizations loaded.  This defadvice will warn if the developer
;;; attempts a disksave after loading this lisp-init file.

(defadvice (disksave :init-file-loaded) (filename &rest args)
  "Remind me not to disksave an image with my lisp-init file loaded."
  (cerror "Proceed with the disksave anyway"
	  "Your lisp-init file has been loaded into this image.~%~
	   You might not wish to disksave it.")
  ;; Remove the advice so it won't be propagated in the disksaved image
  (remove-advice 'disksave :init-file-loaded :verbose nil)
  ;; And go ahead with the disksave.
  (apply-advice-continue filename args))


;;; Extend the default search path for foreign libraries based on 
;;; the unix environment variable LD_LIBRARY_PATH

(defun augment-archive-search-path ()
  (let ((ld-search-path (environment-variable "LD_LIBRARY_PATH")))
    (when ld-search-path
      (let ((new-path
	     (loop for start = 0 then (1+ end)
		   for end = (position #\: ld-search-path :start start)
		   collect 
		   (format nil "~A/lib/" (subseq ld-search-path start end))
		   until (null end))))
	(setq lucid::*default-archive-directories*
	      (nconc new-path lucid::*default-archive-directories*)))))
  )

(augment-archive-search-path)

;;; Just for fun...

(defun clock (&optional (universal-time (get-universal-time)))
  "Return a string that tells the current time."
  (multiple-value-bind (sec min hrs)
    (decode-universal-time universal-time)
    (format nil "~2D:~2,'0D:~2,'0D ~:[AM~;PM~]"
	    (if (> hrs 12) (- hrs 12) hrs) 
	    min
	    sec
	    (>= hrs 12))))

(defun date (&optional (universal-time (get-universal-time)))
  "Return a string that tells the current date."
  (multiple-value-bind (sec min hrs date month year day)
    (decode-universal-time universal-time)
    (declare (ignore sec min hrs))
    (format nil "~A ~2D-~A-~2,'0D"
	    (svref #("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun") day)
	    date
	    (svref #("???" "Jan" "Feb" "Mar" "Apr" "May" "Jun"
			   "Jul" "Aug" "Sep" "Oct" "Nov" "Dec") month)
	    (mod year 100)
	    )))

;;; The following function is biased for U.S.A. holidays, but can be
;;; edited to reflect any calendar.

(defun red-letter-day (&optional (universal-time (get-universal-time)))
  "Return a string that describes the current holiday, or NIL if none known"
  (multiple-value-bind (sec min hrs date month year day)
    (decode-universal-time universal-time)
    (declare (ignore sec min hrs year))
    (cond ((and (= month 1) (= date 1)) "New Year's Day")
	  ((and (= month 11) (<= 22 date 28) (= day 3)) "Thanksgiving")
	  ((and (= month 7) (= date 4)) "Independence Day")
	  ((and (= month 5) (= date 30)) "Memorial Day")
	  ((and (= month 4) (= date 1)) "April Fool's Day")
	  ((and (= month 10) (= date 31)) "Halloween")
	  ;; Add your favorite holidays here...
	  (t nil))))

;;; Announce the current date, time and holiday.

(format t "~A ~A~%~@[Today is ~A!~%~]" (date) (clock) (red-letter-day))

