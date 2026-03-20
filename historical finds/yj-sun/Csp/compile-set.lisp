;; compile-set.lsp

(defun compile-set ()
"
Set Compile Options
"
;;  speed 'fast
(proclaim '(optimize (speed 3) (safety 0) (space 0) (debug 0)))

;; speed 'medium
;(proclaim '(optimize (speed 2) (safety 1) (space 1) (debug 3)))

;; speed slow
; (proclaim '(optimize (speed 1) (safety 2) (space 1) (debug 3)))
)