USER(5): (all-exp-2)

Total generated templates: 76
; Fast loading /users/yjzhang/thesis/CSP/qcsp-alex/new-setup.fasl.

Do files: (testdata/dmax3c.component testdata/dmax3c.control
           testdata/dmax3c.stats)!
Processing DMAX now!
Computing dependency in  DMAX now!
Modifying dependency in  DMAX now!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3446    78 / 81    0.617   1.616   2.233    3       0    0/0       6830       362      T/0.0       RANDOM   RANDOM

Successful constraint checks: 552  Unsuccessful constraint checks 2894 
Level 0 Number 0 Template (sum-square-array-9-16
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2))),
Result length is 3!
Level 0, average constraint checks is 3446.0!

> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3316    78 / 81    0.667   1.433   2.1      3       0    0/0       6851       362      T/0.0       RANDOM   RANDOM

Successful constraint checks: 522  Unsuccessful constraint checks 2794 
Level 1 Number 0 Template (test-9-15
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1)))),
Result length is 3!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  8132    186 / 222  0.633   3.0     3.633    36      0    0/0       13024      734      T/0.0       RANDOM   RANDOM

Successful constraint checks: 1005  Unsuccessful constraint checks 7127 
Level 1 Number 1 Template (test-9-15
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2))),
Result length is 36!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3412    78 / 81    0.616   1.417   2.033    3       0    0/0       6834       362      T/0.0       RANDOM   RANDOM

Successful constraint checks: 518  Unsuccessful constraint checks 2894 
Level 1 Number 2 Template (test-9-15
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1)))),
Result length is 3!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3966    120 / 129  0.617   1.717   2.334    9       0    0/0       8325       434      T/0.0       RANDOM   RANDOM

Successful constraint checks: 705  Unsuccessful constraint checks 3261 
Level 1 Number 3 Template (test-9-15
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  2766    78 / 81    0.65    1.183   1.833    3       0    0/0       7062       362      T/0.0       RANDOM   RANDOM

Successful constraint checks: 452  Unsuccessful constraint checks 2314 
Level 1 Number 4 Template (test-9-15
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1)))),
Result length is 3!
Level 1, average constraint checks is 4318.4!

> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  2776    98 / 101   0.65    1.25    1.9      3       0    0/0       8922       462      T/0.0       RANDOM   RANDOM

Successful constraint checks: 462  Unsuccessful constraint checks 2314 
Level 2 Number 0 Template (test-9-14
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1))),
Result length is 3!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3937    86 / 89    0.65    1.7     2.35     3       0    0/0       10358      387      T/0.0       RANDOM   RANDOM

Successful constraint checks: 548  Unsuccessful constraint checks 3389 
Level 2 Number 1 Template (test-9-14
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1))),
Result length is 3!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3316    78 / 81    0.617   1.3     1.917    3       0    0/0       6851       362      T/0.0       RANDOM   RANDOM

Successful constraint checks: 522  Unsuccessful constraint checks 2794 
Level 2 Number 2 Template (test-9-14
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1))),
Result length is 3!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  4373    109 / 115  0.634   1.683   2.317    6       0    0/0       8166       412      T/0.0       RANDOM   RANDOM

Successful constraint checks: 619  Unsuccessful constraint checks 3754 
Level 2 Number 3 Template (test-9-14
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1))),
Result length is 6!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  2072    78 / 81    0.633   0.984   1.617    3       0    0/0       7317       362      T/0.0       RANDOM   RANDOM

Successful constraint checks: 338  Unsuccessful constraint checks 1734 
Level 2 Number 4 Template (test-9-14
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1))),
Result length is 3!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  2786    78 / 87    0.634   1.216   1.85     9       0    0/0       7142       362      T/0.0       RANDOM   RANDOM

Successful constraint checks: 479  Unsuccessful constraint checks 2307 
Level 2 Number 5 Template (test-9-14
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  4102    86 / 95    0.633   1.7     2.333    9       0    0/0       10340      387      T/0.0       RANDOM   RANDOM

Successful constraint checks: 587  Unsuccessful constraint checks 3515 
Level 2 Number 6 Template (test-9-14
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3966    120 / 129  0.617   1.483   2.1      9       0    0/0       8325       434      T/0.0       RANDOM   RANDOM

Successful constraint checks: 705  Unsuccessful constraint checks 3261 
Level 2 Number 7 Template (test-9-14
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3836    120 / 129  0.617   1.433   2.05     9       0    0/0       8346       434      T/0.0       RANDOM   RANDOM

Successful constraint checks: 675  Unsuccessful constraint checks 3161 
Level 2 Number 8 Template (test-9-14
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  6687    186 / 222  0.617   2.483   3.1      36      0    0/0       13284      734      T/0.0       RANDOM   RANDOM

Successful constraint checks: 913  Unsuccessful constraint checks 5774 
Level 2 Number 9 Template (test-9-14
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1))),
Result length is 36!
Level 2, average constraint checks is 3785.1!

> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3937    86 / 95    0.616   1.567   2.183    9       0    0/0       10370      387      T/0.0       RANDOM   RANDOM

Successful constraint checks: 554  Unsuccessful constraint checks 3383 
Level 3 Number 0 Template (test-9-13
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     20.25   2248    3752    83 / 86    0.533   1.25    1.783    3       0    0/0       5661       304      T/0.0       RANDOM   RANDOM

Successful constraint checks: 528  Unsuccessful constraint checks 3224 
Level 3 Number 1 Template (test-8-13
                           ((E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 3!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  6988    143 / 197  0.6     2.584   3.184    54      0    0/0       13736      393      T/0.0       RANDOM   RANDOM

Successful constraint checks: 683  Unsuccessful constraint checks 6305 
Level 3 Number 2 Template (test-9-13
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  6687    186 / 222  0.617   2.467   3.084    36      0    0/0       13284      734      T/0.0       RANDOM   RANDOM

Successful constraint checks: 913  Unsuccessful constraint checks 5774 
Level 3 Number 3 Template (test-9-13
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 36!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  5984    223 / 226  0.6     2.5     3.117    3       0    0/0       17034      812      T/0.017     RANDOM   RANDOM

Successful constraint checks: 843  Unsuccessful constraint checks 5141 
Level 3 Number 4 Template (test-9-13
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 3!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  2786    78 / 87    0.616   1.084   1.7      9       0    0/0       7142       362      T/0.0       RANDOM   RANDOM

Successful constraint checks: 479  Unsuccessful constraint checks 2307 
Level 3 Number 5 Template (test-9-13
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3836    120 / 129  0.6     1.416   2.016    9       0    0/0       8346       434      T/0.0       RANDOM   RANDOM

Successful constraint checks: 675  Unsuccessful constraint checks 3161 
Level 3 Number 6 Template (test-9-13
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3652    86 / 89    0.6     1.6     2.2      3       0    0/0       11582      387      T/0.0       RANDOM   RANDOM

Successful constraint checks: 740  Unsuccessful constraint checks 2912 
Level 3 Number 7 Template (test-9-13
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 3!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3956    120 / 129  0.6     1.45    2.05     9       0    0/0       8325       434      T/0.0       RANDOM   RANDOM

Successful constraint checks: 695  Unsuccessful constraint checks 3261 
Level 3 Number 8 Template (test-9-13
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3103    109 / 115  0.6     1.25    1.85     6       0    0/0       8614       412      T/0.0       RANDOM   RANDOM

Successful constraint checks: 409  Unsuccessful constraint checks 2694 
Level 3 Number 9 Template (test-9-13
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 6!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3215    111 / 114  0.6     1.616   2.216    3       0    0/0       13915      512      T/0.0       RANDOM   RANDOM

Successful constraint checks: 444  Unsuccessful constraint checks 2771 
Level 3 Number 10 Template (test-9-13
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 3!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  10213   356 / 392  0.6     3.517   4.117    36      0    0/0       14995      656      T/0.0       RANDOM   RANDOM

Successful constraint checks: 932  Unsuccessful constraint checks 9281 
Level 3 Number 11 Template (test-9-13
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 36!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  5974    154 / 163  0.617   2.183   2.8      9       0    0/0       12039      772      T/0.0       RANDOM   RANDOM

Successful constraint checks: 787  Unsuccessful constraint checks 5187 
Level 3 Number 12 Template (test-9-13
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  4102    86 / 95    0.65    1.8     2.45     9       0    0/0       10340      387      T/0.0       RANDOM   RANDOM

Successful constraint checks: 587  Unsuccessful constraint checks 3515 
Level 3 Number 13 Template (test-9-13
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  7474    190 / 298  0.65    2.834   3.484    108     0    0/0       13332      734      T/0.0       RANDOM   RANDOM

Successful constraint checks: 941  Unsuccessful constraint checks 6533 
Level 3 Number 14 Template (test-9-13
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 108!
Level 3, average constraint checks is 5043.933!

> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  4203    137 / 155  0.65    1.633   2.283    18      0    0/0       8840       416      T/0.0       RANDOM   RANDOM

Successful constraint checks: 573  Unsuccessful constraint checks 3630 
Level 4 Number 0 Template (test-9-12
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 18!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3278    117 / 126  0.617   1.634   2.267    9       0    0/0       14389      524      T/0.016     RANDOM   RANDOM

Successful constraint checks: 468  Unsuccessful constraint checks 2810 
Level 4 Number 1 Template (test-9-12
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     20.25   2248    3731    83 / 101   0.55    1.3     1.85     18      0    0/0       5676       304      T/0.0       RANDOM   RANDOM

Successful constraint checks: 522  Unsuccessful constraint checks 3209 
Level 4 Number 2 Template (test-8-12
                           ((E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 18!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  7964    154 / 163  0.65    3.083   3.733    9       0    0/0       14884      772      T/0.0       RANDOM   RANDOM

Successful constraint checks: 1951  Unsuccessful constraint checks 6013 
Level 4 Number 3 Template (test-9-12
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     20.25   2248    4107    106 / 160  0.533   1.384   1.917    54      0    0/0       6051       321      T/0.0       RANDOM   RANDOM

Successful constraint checks: 624  Unsuccessful constraint checks 3483 
Level 4 Number 4 Template (test-8-12
                           ((E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  9955    184 / 193  0.6     3.533   4.133    9       0    0/0       18506      862      T/0.0       RANDOM   RANDOM

Successful constraint checks: 869  Unsuccessful constraint checks 9086 
Level 4 Number 5 Template (test-9-12
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  9221    480 / 489  0.617   3.783   4.4      9       0    0/0       23106      1244     T/0.0       RANDOM   RANDOM

Successful constraint checks: 1835  Unsuccessful constraint checks 7386 
Level 4 Number 6 Template (test-9-12
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  2752    78 / 87    0.617   1.183   1.8      9       0    0/0       7146       362      T/0.0       RANDOM   RANDOM

Successful constraint checks: 445  Unsuccessful constraint checks 2307 
Level 4 Number 7 Template (test-9-12
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  46400   1850 / 2012 0.667  17.167  17.834   162     0    0/0       62534      2534     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3260  Unsuccessful constraint checks 43140 
Level 4 Number 8 Template (test-9-12
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 162!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  14542   326 / 359  0.6     5.317   5.917    33      0    0/0       24674      738      T/0.0       RANDOM   RANDOM

Successful constraint checks: 1133  Unsuccessful constraint checks 13409 
Level 4 Number 9 Template (test-9-12
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 33!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  6826    143 / 197  0.633   2.634   3.267    54      0    0/0       13761      393      T/0.0       RANDOM   RANDOM

Successful constraint checks: 646  Unsuccessful constraint checks 6180 
Level 4 Number 10 Template (test-9-12
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  26800   617 / 779  0.634   9.533   10.167   162     0    0/0       37313      810      T/0.0       RANDOM   RANDOM

Successful constraint checks: 1436  Unsuccessful constraint checks 25364 
Level 4 Number 11 Template (test-9-12
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 162!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     26.625  2248    5031    159 / 213  0.567   2.016   2.583    54      0    0/0       12318      279      T/0.0       RANDOM   RANDOM

Successful constraint checks: 522  Unsuccessful constraint checks 4509 
Level 4 Number 12 Template (test-8-12
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  7568    219 / 273  0.616   3.067   3.683    54      0    0/0       20272      620      T/0.0       RANDOM   RANDOM

Successful constraint checks: 843  Unsuccessful constraint checks 6725 
Level 4 Number 13 Template (test-9-12
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     26.625  2248    2529    114 / 123  0.55    1.184   1.734    9       0    0/0       9798       279      T/0.0       RANDOM   RANDOM

Successful constraint checks: 450  Unsuccessful constraint checks 2079 
Level 4 Number 14 Template (test-8-12
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  5642    154 / 166  0.65    2.067   2.717    12      0    0/0       12063      772      T/0.0       RANDOM   RANDOM

Successful constraint checks: 552  Unsuccessful constraint checks 5090 
Level 4 Number 15 Template (test-9-12
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 12!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3741    159 / 177  0.617   1.5     2.117    18      0    0/0       9426       416      T/0.0       RANDOM   RANDOM

Successful constraint checks: 485  Unsuccessful constraint checks 3256 
Level 4 Number 16 Template (test-9-12
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 18!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  2796    98 / 107   0.634   1.233   1.867    9       0    0/0       9002       462      T/0.0       RANDOM   RANDOM

Successful constraint checks: 489  Unsuccessful constraint checks 2307 
Level 4 Number 17 Template (test-9-12
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3043    109 / 115  0.617   1.283   1.9      6       0    0/0       8624       412      T/0.0       RANDOM   RANDOM

Successful constraint checks: 397  Unsuccessful constraint checks 2646 
Level 4 Number 18 Template (test-9-12
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 6!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  7202    190 / 298  0.617   2.717   3.334    108     0    0/0       13377      734      T/0.0       RANDOM   RANDOM

Successful constraint checks: 915  Unsuccessful constraint checks 6287 
Level 4 Number 19 Template (test-9-12
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1))),
Result length is 108!
Level 4, average constraint checks is 8866.55!

> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  101093  6827 / 18815 0.633 45.4    46.033   11988   0    0/0       155292     4350     T/0.0       RANDOM   RANDOM

Successful constraint checks: 20924  Unsuccessful constraint checks 80169 
Level 5 Number 0 Template (test-9-11
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 11988!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     26.625  2248    5031    159 / 213  0.567   2.1     2.667    54      0    0/0       12318      279      T/0.0       RANDOM   RANDOM

Successful constraint checks: 522  Unsuccessful constraint checks 4509 
Level 5 Number 1 Template (test-8-11
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  9955    184 / 193  0.617   3.517   4.134    9       0    0/0       18506      862      T/0.0       RANDOM   RANDOM

Successful constraint checks: 869  Unsuccessful constraint checks 9086 
Level 5 Number 2 Template (test-9-11
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     22.285715 1967  1329    48 / 66    0.483   0.467   0.95     18      0    0/0       2253       123      T/0.0       RANDOM   RANDOM

Successful constraint checks: 228  Unsuccessful constraint checks 1101 
Level 5 Number 3 Template (test-7-11
                           ((E2 (ASSIGN ID2-1 ID2-2))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 18!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  5803    194 / 248  0.634   2.583   3.217    54      0    0/0       17987      495      T/0.0       RANDOM   RANDOM

Successful constraint checks: 506  Unsuccessful constraint checks 5297 
Level 5 Number 4 Template (test-9-11
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  14531   351 / 384  0.65    5.35    6.0      33      0    0/0       27973      863      T/0.0       RANDOM   RANDOM

Successful constraint checks: 1146  Unsuccessful constraint checks 13385 
Level 5 Number 5 Template (test-9-11
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2))),
Result length is 33!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3169    101 / 119  0.6     1.467   2.067    18      0    0/0       11641      387      T/0.0       RANDOM   RANDOM

Successful constraint checks: 314  Unsuccessful constraint checks 2855 
Level 5 Number 6 Template (test-9-11
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E2))
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 18!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3681    159 / 177  0.633   1.45    2.083    18      0    0/0       9436       416      T/0.0       RANDOM   RANDOM

Successful constraint checks: 473  Unsuccessful constraint checks 3208 
Level 5 Number 7 Template (test-9-11
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 18!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  4543    192 / 204  0.6     1.817   2.417    12      0    0/0       13293      851      T/0.0       RANDOM   RANDOM

Successful constraint checks: 589  Unsuccessful constraint checks 3954 
Level 5 Number 8 Template (test-9-11
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E4 (LESS ID4-1 ID4-2 ID4-3))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2))),
Result length is 12!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     26.625  2248    8373    304 / 412  0.55    3.05    3.6      108     0    0/0       15353      738      T/0.0       RANDOM   RANDOM

Successful constraint checks: 1190  Unsuccessful constraint checks 7183 
Level 5 Number 9 Template (test-8-11
                           ((E1 (ASSIGN ID1-1 ID1-2))
                            (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                            (E5 (INDEX ID5-1 ID5-2 ID5-3))
                            (E6 (INDEX ID6-1 ID6-2 ID6-3))
                            (E7 (MULT ID7-1 ID7-2 ID7-3))
                            (E8 (PLUSASSIGN ID8-1 ID8-2)) (E9 (PREINC ID9-1)))
                           ((CONTROL-DATA-DEPENDENCY (E3 E2))
                            (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                            (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                            (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                            (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                            (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                            (CONTROL-DATA-DEPENDENCY (E3 E1))
                            (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                            (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                            (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 108!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  9633    184 / 196  0.6     3.45    4.05     12      0    0/0       18560      862      T/0.0       RANDOM   RANDOM

Successful constraint checks: 644  Unsuccessful constraint checks 8989 
Level 5 Number 10 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2))),
Result length is 12!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  4890    154 / 166  0.634   2.016   2.65     12      0    0/0       14963      772      T/0.0       RANDOM   RANDOM

Successful constraint checks: 440  Unsuccessful constraint checks 4450 
Level 5 Number 11 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2))),
Result length is 12!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  9477    376 / 412  0.6     3.45    4.05     36      0    0/0       17092      756      T/0.0       RANDOM   RANDOM

Successful constraint checks: 800  Unsuccessful constraint checks 8677 
Level 5 Number 12 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2))),
Result length is 36!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  4189    111 / 231  0.617   1.667   2.284    120     0    0/0       9579       422      T/0.0       RANDOM   RANDOM

Successful constraint checks: 989  Unsuccessful constraint checks 3200 
Level 5 Number 13 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 120!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3701    179 / 197  0.616   1.6     2.216    18      0    0/0       11876      516      T/0.0       RANDOM   RANDOM

Successful constraint checks: 493  Unsuccessful constraint checks 3208 
Level 5 Number 14 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1))),
Result length is 18!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  7202    190 / 298  0.633   2.717   3.35     108     0    0/0       13377      734      T/0.0       RANDOM   RANDOM

Successful constraint checks: 915  Unsuccessful constraint checks 6287 
Level 5 Number 15 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2))),
Result length is 108!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  7618    234 / 882  0.617   3.05    3.667    648     0    0/0       14009      738      T/0.0       RANDOM   RANDOM

Successful constraint checks: 1366  Unsuccessful constraint checks 6252 
Level 5 Number 16 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 648!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  4073    189 / 213  0.667   1.683   2.35     24      0    0/0       9897       418      T/0.0       RANDOM   RANDOM

Successful constraint checks: 429  Unsuccessful constraint checks 3644 
Level 5 Number 17 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E5) ID7-2)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 24!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  7964    154 / 163  0.633   2.9     3.533    9       0    0/0       14884      772      T/0.0       RANDOM   RANDOM

Successful constraint checks: 1951  Unsuccessful constraint checks 6013 
Level 5 Number 18 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  8907    480 / 489  0.6     3.634   4.234    9       0    0/0       23802      1244     T/0.0       RANDOM   RANDOM

Successful constraint checks: 1521  Unsuccessful constraint checks 7386 
Level 5 Number 19 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     20.25   2248    3917    106 / 160  0.55    1.317   1.867    54      0    0/0       6081       321      T/0.0       RANDOM   RANDOM

Successful constraint checks: 566  Unsuccessful constraint checks 3351 
Level 5 Number 20 Template (test-8-11
                            ((E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  26800   617 / 779  0.617   9.417   10.034   162     0    0/0       37313      810      T/0.0       RANDOM   RANDOM

Successful constraint checks: 1436  Unsuccessful constraint checks 25364 
Level 5 Number 21 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 162!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  12115   184 / 193  0.6     4.283   4.883    9       0    0/0       21691      862      T/0.0       RANDOM   RANDOM

Successful constraint checks: 2033  Unsuccessful constraint checks 10082 
Level 5 Number 22 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2))),
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  46340   1850 / 2012 0.667  16.516  17.183   162     0    0/0       62680      2534     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3200  Unsuccessful constraint checks 43140 
Level 5 Number 23 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2)
                             (SAME-VARIABLE (E6 E5) (ID6-1 ID5-1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E9) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E1))
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E2) ID9-1))),
Result length is 162!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     24.333334 2529  3191    117 / 129  0.633   1.617   2.25     12      0    0/0       14398      524      T/0.0       RANDOM   RANDOM

Successful constraint checks: 405  Unsuccessful constraint checks 2786 
Level 5 Number 24 Template (test-9-11
                            ((E1 (ASSIGN ID1-1 ID1-2))
                             (E2 (ASSIGN ID2-1 ID2-2)) (E3 (LOOP))
                             (E4 (LESS ID4-1 ID4-2 ID4-3))
                             (E5 (INDEX ID5-1 ID5-2 ID5-3))
                             (E6 (INDEX ID6-1 ID6-2 ID6-3))
                             (E7 (MULT ID7-1 ID7-2 ID7-3))
                             (E8 (PLUSASSIGN ID8-1 ID8-2))
                             (E9 (PREINC ID9-1)))
                            ((POSSIBLE-DATA-DEPENDENCY (E4 E2) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E8) ID8-1)
                             (GUARANTEED-DATA-DEPENDENCY (E7 E6) ID7-1)
                             (POSSIBLE-DATA-DEPENDENCY (E6 E2) ID6-2)
                             (POSSIBLE-DATA-DEPENDENCY (E4 E9) ID4-1)
                             (POSSIBLE-DATA-DEPENDENCY (E8 E1) ID8-1)
                             (CONTROL-DATA-DEPENDENCY (E3 E2))
                             (POSSIBLE-DATA-DEPENDENCY (E5 E9) ID5-2)
                             (POSSIBLE-DATA-DEPENDENCY (E9 E9) ID9-1)
                             (POSSIBLE-DATA-DEPENDENCY (E5 E2) ID5-2)
                             (GUARANTEED-DATA-DEPENDENCY (E8 E7) ID8-2))),
Result length is 12!
Level 5, average constraint checks is 12701.0!

NIL
USER(6):  :exit
; Exiting Lisp
> exit

exit

script done on Mon Nov 11 00:10:30 1996

script done on Mon Nov 11 00:10:30 1996
