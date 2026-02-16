; unify.lsp
;
; Routines to do substitution/unification 
;
; Conventions and Data Structures.
;
; Atomic formulas are represented using nested lists.
; e.g., P(f(?x,g(?y)), h(?y))
;       (P (f ?x (g ?y)) (h ?y))
; 
; Variables are symbols that start with `?'
;
; Substitutions are represented as lists of pairs.
; e.g. 
; ((?x a) (?y ?x))
; Each pair is a list and its first element is the variable.
;
;----------------------------------------------------------------
; Utility functions:
; varp          test is symbol is variable.
; rename        rename all variables in clause to unique variables
; variables-in  return list of all variables in clause.
; not-occurs-p  true if var does not occur in exp.

(defun varp (x)
  "Is x a variable (a symbol beginning with `?') ?"
  (and (symbolp x) (equal (char (symbol-name x) 0) #\?)))


(defun rename-variables (exp)
  "Rename all of the variables in exp"
  (sublis (mapcar #'(lambda (var) (cons var (gensym (string var))))
                  (variables-in exp))
          exp))

; "sublis" see tutorial.2
; "gensym" generates new symbols prefixed by string argument.
; "string" convert symbol name to string.
  

(defun variables-in (x &optional found-so-far)
  "Return list of all variables in x"
  (cond ((varp x) (list x))
        ((atom x) nil)
        (t (union (variables-in (first x))
                  (variables-in (rest x))))))

; "atom" true of non-lists and NIL, false of lists
;

(defun not-occurs-p (var exp)
  "Return T if var does not appear in exp"
  (cond ((eq var exp) nil)
        ((consp exp)
         (and (not-occurs-p var (first exp))
              (not-occurs-p var (rest exp))))
        (t t)))

;-----------------------------------------------------------------
; Primatives for dealing with substitution pairs
;

(defun get-var (var-term)
  "Return the variable in a variable = term pair"
  (first var-term))

(defun get-term (var-term)
  "Return the term in a variable = term pair"
  (second var-term))
   
(defun make-var-term (var term)
  "Return a variable = term pair"
  (list var term))

;-----------------------------------------------------------------
; Primatives for accessing substitutions, i.e., lists of pairs
; Define special empty-subsitution distinct from empty list
;        want to preserve empty list as denoting failure.
;

(defun make-sub (var term)
  "Return a new substitution with one variable = term pair"
  (list (make-var-term var term)))

(defun get-binding (var sub)
  "Return the binding for var in the substitution sub or nil if none"
  (get-term (first (member var sub :key #'get-var))))

(defconstant *empty-sub* '(()) "The empty substitution")


;-----------------------------------------------------------------
; Compose two substitutions
; Apply as substitution to a term
;       Treat empty substitution specially.
;

(defun compose (sub1 sub2)
  "Compute the composition of sub1*sub2 note order!"
  (if (equal *empty-sub* sub1)
      sub2
  (if (equal *empty-sub* sub2)
      sub1
      (let ((s1 
             (mapcar 
              #'(lambda (var-term)
                  (make-var-term
                   (get-var var-term) 
                   (apply-sub sub2 (get-term var-term))))
              sub1)))
        (append (remove-if
                 #'(lambda (var-term) 
                     (eq (get-var var-term) (get-term var-term)))
                 s1)
                (remove-if 
                 #'(lambda (var-term) 
                     (member (get-var var-term) sub1 :key #'get-var))
                 sub2))))))

(defun apply-sub (sub exp)
  "Apply a substitution to an expression"
  (cond ((equal *empty-sub* sub) exp)
        ((varp exp)
         (or (get-binding exp sub) exp))
        ((consp exp)
         (cons (apply-sub sub (first exp))
               (apply-sub sub (rest exp))))
        (t exp)))

;-----------------------------------------------------------------
; Compute Disagreement set
; Unify two substitutions returning
;       nil       --- fail
;       empty-sub --- already match without substitution.
;       m.g.u.    --- if they can be unified
; 
;

(defun dis-set (x y)
  "Return the disagreement set of x and y"
  (cond ((eq x y) nil)
        ((and (consp x) (consp y))
         (or (dis-set (first x) (first y))
             (dis-set (rest  x) (rest  y))))
        (t (list x y))))


(defun unify (x y &optional (subs *empty-sub*))
  "Return the m.g.u. of x and y or nil if it does not exist"
  (let* ((dis (dis-set x y))
         (t1 (first dis))
         (t2 (second dis)))
    (cond ((and (varp t1) (not-occurs-p t1 t2))
           (unify (apply-sub (make-sub t1 t2) x)
                  (apply-sub (make-sub t1 t2) y)
                  (compose subs (make-sub t1 t2))))
          ((and (varp t2) (not-occurs-p t2 t1))
           (unify (apply-sub (make-sub t2 t1) x)
                  (apply-sub (make-sub t2 t1) y)
                  (compose subs (make-sub t2 t1))))
          ((null dis) subs)
          (t nil))))

                         

;=================================================================
; Some test examples to check if the functions work
;

;; substition lists for composition

(setq s1 '((?x (f ?y)) (?y ?z)))
(setq s2 '((?x a) (?y b) (?z c)))

(setq s3 '((?x (f ?u ?y)) (?y ?z)))
(setq s4 '((?u (g ?z)) (?y (f ?z)) (?z (h ?x))))

(setq s5 '((?x ?y) (?z ?y) (?u ?y) (?v ?y)))
(setq s6 '((?y horse) (?x cow) (?s chicken)))

;; substition lists and listerals for substition function

(setq ss1 '((?x (f ?y))))
(setq pp1 '(p (f ?y) ?y))

(setq ss2 '((?x (f ?y))))
(setq pp2 '(p ?x ?y))

(setq ss3 '((?x horse) (?y (f ?x))))
(setq pp3 '(rides ?x ?y))

;; literals for testing the unification function.

(setq p1 '(p a ?x (h (g ?z))))
(setq p2 '(p ?z (h ?y) (h ?y)))

(setq p3 '(p a ?x))
(setq p4 '(p ?y (f ?x)))

(setq p5 '(p a w))
(setq p6 '(p ?x ?x))

(setq p7 '(p (f ?x (g a ?y)) ?z))
(setq p8 '(p ?z ?u))


