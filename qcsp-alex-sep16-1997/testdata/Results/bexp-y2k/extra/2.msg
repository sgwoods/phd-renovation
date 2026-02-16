Note: the Allegro CL shared library moved to 0xef231000 because the previous
      address of 0xf2222000 was not available.  Will perform relocation.
      See the Allegro CL Release Notes for details.
Allegro CL 4.2 [SPARC; R1] (9/6/94 11:02)
Copyright (C) 1985-1993, Franz Inc., Berkeley, CA, USA.  All Rights Reserved.
;; Optimization settings: safety 1, space 1, speed 1, debug 2
;; For a complete description of all compiler switches given the current
;; optimization settings evaluate (EXPLAIN-COMPILER-SETTINGS).
USER(1): ; Loading /users/yjzhang/thesis/CSP/qcsp-alex/load.lisp.
;   Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/bm.fasl.
;   Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/bt.fasl.
;   Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/ct.fasl.
;   Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/gsat.fasl.
;   Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/utility.fasl.
;   Loading /users/yjzhang/thesis/CSP/qcsp-alex/compile.lisp.
;   Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/quilici-search.fasl.
Warning: REMOVE-VAR, :OPERATOR was defined in
         /users/yjzhang/thesis/CSP/qcsp-alex/utility.lisp and is now being
         defined in /users/yjzhang/thesis/CSP/qcsp-alex/quilici-search.lisp
Warning: GETVAL, :OPERATOR was defined in
         /users/yjzhang/thesis/CSP/qcsp-alex/gsat.lisp and is now being
         defined in /users/yjzhang/thesis/CSP/qcsp-alex/quilici-search.lisp
;   Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/adt-simple.fasl.
;   Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/adt-setup.fasl.
;   Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/memory-csp.fasl.
T
USER(2): ; Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/yj-load.fasl.
T
USER(3): ; Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/adt-template.fasl.
; Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/new-setup.fasl.
; Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/2-pre.fasl.
; Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/general-exp-2.fasl.
; Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/random-templ-exp.fasl.
;   Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/static-order-exp.fasl.
; Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/static-order-exp.fasl.
; Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/cpu-xy.fasl.
T
USER(4): USER(4): ; Loading /users/yjzhang/thesis/CSP/qcsp-alex/this-exp-data.lisp.
T
USER(5): USER(5): 
Do files: (testdata/data-y/dytk6c.component testdata/data-y/dytk6c.control
           testdata/data-y/dytk6c.stats)!
Processing MAIN now!
Computing dependency in  MAIN now!
component DYTK6C_37 has more than 2 parents!
component DYTK6C_37 has more than 2 parents!
component DYTK6C_37 has more than 2 parents!
component DYTK6C_37 has more than 2 parents!
component DYTK6C_37 has more than 2 parents!
component DYTK6C_70 has more than 2 parents!
component DYTK6C_70 has more than 2 parents!
component DYTK6C_70 has more than 2 parents!
component DYTK6C_70 has more than 2 parents!
component DYTK6C_70 has more than 2 parents!
component DYTK6C_103 has more than 2 parents!
component DYTK6C_103 has more than 2 parents!
component DYTK6C_103 has more than 2 parents!
component DYTK6C_103 has more than 2 parents!
component DYTK6C_103 has more than 2 parents!
component DYTK6C_136 has more than 2 parents!
component DYTK6C_136 has more than 2 parents!
component DYTK6C_136 has more than 2 parents!
component DYTK6C_136 has more than 2 parents!
component DYTK6C_136 has more than 2 parents!
component DYTK6C_169 has more than 2 parents!
component DYTK6C_169 has more than 2 parents!
component DYTK6C_169 has more than 2 parents!
component DYTK6C_169 has more than 2 parents!
component DYTK6C_169 has more than 2 parents!
component DYTK6C_202 has more than 2 parents!
component DYTK6C_202 has more than 2 parents!
component DYTK6C_202 has more than 2 parents!
component DYTK6C_202 has more than 2 parents!
component DYTK6C_202 has more than 2 parents!
Modifying dependency in  MAIN now!
> Initializing a new case 
 
***** OPTIONS for CSP ( (ADT my-sit hack-leap-year-21-28) ) ***** 

 Situation id         :   my-sit 
 Situation noise add  :   0 
 Situation Size       :   202 
 Template id          :   hack-leap-year-21-28 
 Template Size        :   21 
 Distribution id      :   dist1 
 Distributions    : 
((WHILE 1) (ZERO 1) (BLOCK 2) (INCREMENT 2) (NOT-EQUALS 2) (ASSIGN 3) (DECL 4)
 (FOR 1) (PRINT 2) (CHECK 4)) 
((ARRAY 1) (INT 2) (CHAR 2) (REAL 1) (BOOLEAN 1)) 
((INT 2) (CHAR 2) (REAL 1) (BOOLEAN 1)) 
 Num of constraints   :   28 

 Search Mode          : bt 
 Node Consis Mode     : T 
 Node Type Cons Mode  : T 
 Node Force all       : NIL 
 Arc  Consis Mode     : NIL 
 Forward Checking     : NIL 
 Dynamic Rearrangement: NIL 
 DFA     Rearrangement: T 
 Advance sort option  : T 
 Inline  sort cstr opt: RANDOM 
 Advance sort cstr opt: RANDOM 
 Backjump option      : NIL 
 One Solution Only    : NIL 
 CPU Seconds limit    : 1800 
 CK Point interval    : 900 
 Debug                : NIL 
 Debug CSP            : NIL 

 Random Ident         : DEFAULT 
Domain size ( INITIAL ) statistics ... 
Max[(E1 202)]  Min[(E1 202)]  Avg[202.0] 

Domain size ( NODE ) statistics ... 
Max[(E1 18)]  Min[(E1 18)]  Avg[18.0] 

***** BACKTRACK Information ***** 

 Exit Location    : NULL-PARENT-STATE 
 No. Solutions    : 6 
 Node Consis. cks   : 4242 
 Node Type Cons cks : 492 
 Node Type Cons ok  : 378 
 Node Type Cons fail: 114 
 Ttl constr chks  : 330 
 BT nodes created : 246 
 Nodes visited    : 258 
 DFA Rearr cost   : 0 


Advance Processing CPU Seconds: 0.817 
Advance Sort       CPU Seconds: 0.0 
Search             CPU Seconds: 0.583 
Total              CPU Seconds: 1.417 


Successful constraint checks: 324  Unsuccessful constraint checks 6 

Template hack-leap-year-21-28,
Result length is 6!
T
USER(6): USER(6): ; Exiting Lisp
