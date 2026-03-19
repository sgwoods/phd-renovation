;; mpr.lisp

;; **************************************************
;; Define the situation containers

(defstruct situation
"
An object which maintains one situational hypothesis as a list of
situational objects.  Note this structure should be indexed spatially.
"
 (situation-id nil)
 (sit-obj-list nil)
)

(defstruct (sit-object (:type vector) :named)
"
 An object identified in a situation.  May be partially defined only.  For the
purposes of solving MPR as constraint satisfaction in my original example, each
sit-object is considered a potential element of the domains of the templ-slot
variables.
"
  sit-node-id        ; unique node identifier
  x-location         ; x coordinate in world view
  y-location         ; y coordinate in world view
  type               ; current defined type
)

;; **************************************************
;; Define the template container

(defstruct (template
"
 An object which maintains one template.
"
  (template-id    nil)     ; unique template identifier
  (templ-slot-set nil)     ; the list of template slots (variables).
)

(defstruct (templ-slot (:type vector) :named)
"
 A single slot of many making up a template. For the purposes of solving MPR
 as constraint satisfaction in my original example, each templ-slot is
considered  a variable which is assigned one of its domain, which ranges over
the set of sit-objects in a particular situation.
"
  templ-slot-id         ; unique template slot identifier
  constraints           ; the list of node constraints for this templ-slot
                        ; all must be true else templ-slot assignment is 
                        ; invalid.
;; (v1 (1 2 3))


(v1 (1 2 3))

(defun mpr-variables ()
  (let* (
	 (situation (use-situation 1))   ; list of 
	 (sit-size  (length (use-situation 1))   ; instantiates situation objects
	 (template  (use-template  1))   ; instantiates a template object
	)

    (let  ( 
            (common-domain nil) 
            (var-list nil) 
          )
        (dotimes (i n) 
            (setq common-domain (cons (- n i) common-domain)))
        (dotimes (i n var-list) 
            (setq var-list 
                (cons
                    (cons 
                        (list 'row (- n i))
                        common-domain)
                    var-list)))))


(defun consistent-p (symbol1 value1 symbol2 value2)
"
Return true iff the instantiation of SYMBOL1 with VALUE1 is consistent with
the instantiation of SYMBOL2 with VALUE2.
"
(setq *constraint-checks* (+ 1 *constraint-checks*))
(and
 (/= value1 value2)
 (/=
  (abs (- value1 value2))
  (abs (- (second symbol1) (second symbol2))))))
