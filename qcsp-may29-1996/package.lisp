;;;; qcsp-may29-1996/package.lisp -- Package definition for May 1996 CSP snapshot

(defpackage #:phd-qcsp-may29
  (:use #:common-lisp)
  (:nicknames #:qcsp-may29)
  (:export #:q #:qs #:qc #:cq #:cqs #:cqc #:queens
           #:adt #:adt-gsat #:mpr #:bm #:backtracking #:ac-3
           #:memory-search #:quilici-search
           #:set-globals #:show-solution #:show-options #:comment1))

(in-package #:phd-qcsp-may29)

;;; -----------------------------------------------------------------------
;;; Global variable declarations
;;;
;;; All special variables used across the system are declared here to
;;; prevent "undefined variable" warnings during compilation.
;;; -----------------------------------------------------------------------

;; Output control
(defvar *output-stream* nil)
(defvar *file-output* nil)
(defvar *long-output* nil)
(defvar *single-line-override* nil)
(defvar *suppress-single-line* nil)
(defvar *whole-file-name* nil)

;; Error state
(defvar *error* 0)

;; Search configuration
(defvar *search-mode* nil)
(defvar *backjump* nil)
(defvar *backtrack* nil)
(defvar *backmark* nil)
(defvar *gsat* nil)
(defvar *quilici* nil)
(defvar *node-consis* nil)
(defvar *node-force-all* nil)
(defvar *arc-consis* nil)
(defvar *forward-checking* nil)
(defvar *advance-sort* nil)
(defvar *sort-const* nil)
(defvar *adv-sort-const* nil)
(defvar *dynamic-rearrangement* nil)
(defvar *one-solution-only* nil)
(defvar *cpu-sec-limit* 600)
(defvar *check-point-interval* 150)
(defvar *this-check-point* 150)
(defvar *debug* nil)
(defvar *debug-consis* nil)
(defvar *debug-ac* nil)
(defvar *debug-q* nil)
(defvar *debug-node* nil)

;; Problem variables
(defvar *raw-variables* nil)
(defvar *variables* nil)
(defvar *var-order* nil)
(defvar *var-order-note* nil)
(defvar *number-of-units* 0)
(defvar *domain-name* nil)
(defvar *domain-loaded* nil)
(defvar *constraints* nil)

;; Timing
(defvar *internal-start-time* 0)
(defvar *internal-end-time* 0)
(defvar *internal-advance-start-time* 0)
(defvar *internal-advance-end-time* 0)
(defvar *internal-sort-start-time* 0)
(defvar *internal-sort-end-time* 0)

;; Search state
(defvar *last-node* 0)
(defvar *initial-state* nil)
(defvar *solution-set* nil)
(defvar *exit-backmark-now* nil)
(defvar *val-ret* 0)

;; Recording/diagnostics
(defvar *node-consis-decision* nil)
(defvar *constraint-fail* nil)
(defvar *arc-constraint-fail* nil)
(defvar *satisfy-p-calls* 0)
(defvar *satisfy-p-cost* 0)
(defvar *constraint-cks* 0)
(defvar *consistent-p-calls* 0)
(defvar *consistent-null-arcs* 0)
(defvar *backtrack-nodes-created* 0)
(defvar *backjump-count* 0)
(defvar *ac-count-compat* 0)
(defvar *ac-count-notcompat* 0)
(defvar *nodes-visited* 0)
(defvar *for-check-calls* 0)
(defvar *for-check-cost* 0)
(defvar *dyn-rearr-calls* 0)
(defvar *dyn-rearr-cost* 0)
(defvar *type-a-savings* 0)
(defvar *type-b-savings* 0)

;; RECALL values (for memory-csp show-solution)
(defvar *RECALL-avg-var-len* 0)
(defvar *RECALL-adv-proc-time* 0)
(defvar *RECALL-search-time* 0)
(defvar *RECALL-total-time* 0)
(defvar *RECALL-adv-sort-time* 0)

;; Memory-CSP state
(defvar *value-series* nil)

;; BackMark diagnostics
(defvar *dolist-count* 0)
(defvar *greater-equal-count* 0)
(defvar *loop-count* 0)
(defvar *backmark-calls* 0)

;; Domain: situation/template
(defvar *current-situation* nil)
(defvar *current-template* nil)
(defvar *sit-object-id* nil)
(defvar *template-id* nil)
(defvar *situation-noise-added* 0)
(defvar *random-ident* nil)
(defvar *random-dist-name* nil)
(defvar *random-dist* nil)
(defvar *override-situation* nil)
(defvar *override-template* nil)

;; MPR-specific counters
(defvar *constraint-sch-on* nil)
(defvar *constraint-sep-cks* 0)
(defvar *constraint-sch-cks* 0)
(defvar *sch-save* 0)
(defvar *constraint-pos-cks* 0)
(defvar *constraint-med-cks* 0)
(defvar *constraint-ech-cks* 0)
(defvar *constraint-same-type-cks* 0)
(defvar *constraint-same-orient-cks* 0)
(defvar *constraint-same-activity-cks* 0)
(defvar *constraint-same-size-cks* 0)

;; Node consistency counters
(defvar *node-consistency-calls* 0)
(defvar *node-consistency-checks* 0)
(defvar *ts-match-activity-count* 0)
(defvar *ts-match-size-count* 0)
(defvar *ts-match-orient-count* 0)
(defvar *ts-match-type-count* 0)
(defvar *ts-match-abs-loc-count* 0)
(defvar *unique-restrict-count* 0)

;; MPR random distributions
(defvar *ran-type-lst* nil)
(defvar *ran-size-lst* nil)
(defvar *ran-activity-lst* nil)
(defvar *ran-orient-lst* nil)

;; MPR setup state
(defvar *mpr-setup-loaded* nil)
(defvar *situation-stream* nil)
(defvar *random-stream* nil)
(defvar *gnuplot-stream* nil)

;; ADT-specific
(defvar *adt-setup-loaded* nil)
(defvar *debug-local* nil)
(defvar *situations* nil)
(defvar *distributions* nil)
(defvar *template-object-list* nil)
(defvar *ran-stmt-type-lst* nil)
(defvar *ran-decl-type-lst* nil)
(defvar *ran-array-type-lst* nil)
(defvar *current-array-list* nil)
(defvar *current-int-list* nil)
(defvar *current-char-list* nil)
(defvar *current-real-list* nil)
(defvar *current-boolean-list* nil)
(defvar *current-block-list* nil)
(defvar *actual-type-lst* nil)
(defvar *max-array-size* 201)
(defvar *max-line-number* 1000)
(defvar *original-situation* nil)
(defvar *orig-nums* nil)
(defvar *line-number-set* nil)
(defvar *constraint-before-cks* 0)
(defvar *constraint-same-name-cks* 0)
(defvar *constraint-close-to-cks* 0)

;; Debug (additional)
(defvar *debug-csp* nil)

;; Bare setq locals in legacy code (bm.lisp, bt.lisp, queens.lisp, etc.)
(defvar lowunit nil)
(defvar mark nil)
(defvar cost-before 0)
(defvar cost-after 0)
(defvar merged nil)
(defvar old nil)
(defvar out-f nil)
(defvar ps-length 0)
(defvar reduced-set nil)
(defvar rfn nil)
(defvar best-value nil)
(defvar nvalues nil)
(defvar situation-setup nil)

;; Misc
(defvar *check* 0)
(defvar *test* nil)
(defvar par-out nil)
(defvar here 0)
(defvar *constraint-count* 0)

;; AO test4 support — variables set by example-extend.lisp and test4.lisp
(defvar *debug-app* nil)
(defvar g1 nil)
(defvar g2 nil)
(defvar g3 nil)
(defvar v0 nil)
(defvar v1 nil)
(defvar v2 nil)
(defvar ao1 nil)
(defvar ao2 nil)
(defvar ao3 nil)

;; Domain values (from example-extend.lisp)
(defvar a1 nil) (defvar a2 nil) (defvar a3 nil)
(defvar b1 nil) (defvar b2 nil) (defvar b3 nil)
(defvar c1 nil) (defvar c2 nil) (defvar c3 nil)
(defvar c4 nil) (defvar c5 nil) (defvar c6 nil)
(defvar e1 nil) (defvar e2 nil)
(defvar j1 nil) (defvar j2 nil) (defvar j3 nil) (defvar j4 nil)
(defvar k3 nil) (defvar k4 nil)
(defvar l1 nil) (defvar l2 nil) (defvar l3 nil) (defvar l4 nil)
(defvar m1 nil) (defvar m2 nil) (defvar m3 nil)
(defvar m4 nil) (defvar m5 nil) (defvar m6 nil)
(defvar p1 nil) (defvar p2 nil) (defvar p3 nil) (defvar p4 nil)
(defvar q1 nil) (defvar q2 nil) (defvar q3 nil) (defvar q4 nil)
(defvar r1 nil) (defvar r2 nil) (defvar r3 nil)
(defvar r4 nil) (defvar r5 nil) (defvar r6 nil)
(defvar s1 nil) (defvar s2 nil) (defvar s3 nil) (defvar s4 nil)
(defvar s5 nil) (defvar s6 nil) (defvar s7 nil) (defvar s8 nil)
(defvar t1 nil) (defvar t2 nil) (defvar t3 nil)
(defvar t4 nil) (defvar t5 nil) (defvar t6 nil)
(defvar u1 nil) (defvar u2 nil) (defvar u3 nil) (defvar u4 nil)
(defvar u5 nil) (defvar u6 nil) (defvar u7 nil) (defvar u8 nil)
(defvar u9 nil) (defvar u10 nil) (defvar u11 nil) (defvar u12 nil)
(defvar x1 nil) (defvar x2 nil) (defvar x3 nil) (defvar x4 nil)
(defvar x5 nil) (defvar x6 nil) (defvar x7 nil) (defvar x8 nil)
(defvar x9 nil) (defvar x10 nil) (defvar x11 nil) (defvar x12 nil)
