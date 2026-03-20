Do files: (testdata/dmax9c.component testdata/dmax9c.control
           testdata/dmax9c.stats)!
Processing DMAX now!
Computing dependency in  DMAX now!
Modifying dependency in  DMAX now!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    70221   425 / 434  5.517   26.9    32.417   9       0    0/0       112260     2209     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3494  Unsuccessful constraint checks 66727 
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
Result length is 9!
Level 0, average constraint checks is 70221.0!

> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    65905   425 / 434  5.317   25.316  30.633   9       0    0/0       112518     2209     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3224  Unsuccessful constraint checks 62681 
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
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    155673  977 / 1127 5.35    56.45   61.8     150     0    0/0       224708     4360     T/0.0       RANDOM   RANDOM

Successful constraint checks: 5309  Unsuccessful constraint checks 150364 
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
Result length is 150!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    70105   425 / 434  5.333   25.95   31.283   9       0    0/0       112275     2209     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3378  Unsuccessful constraint checks 66727 
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
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    74406   572 / 599  5.383   28.0    33.383   27      0    0/0       123625     2461     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4073  Unsuccessful constraint checks 70333 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    46592   425 / 434  5.367   20.033  25.4     9       0    0/0       114920     2209     T/0.0       RANDOM   RANDOM

Successful constraint checks: 2475  Unsuccessful constraint checks 44117 
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
Result length is 9!
Level 1, average constraint checks is 82536.2!

> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    46798   663 / 672  5.317   23.183  28.5     9       0    0/0       163969     3399     T/0.0       RANDOM   RANDOM

Successful constraint checks: 2681  Unsuccessful constraint checks 44117 
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
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    73265   441 / 450  5.317   32.15   37.467   9       0    0/0       176101     2259     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3221  Unsuccessful constraint checks 70044 
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
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    65905   425 / 434  5.3     24.467  29.767   9       0    0/0       112518     2209     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3224  Unsuccessful constraint checks 62681 
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
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    76442   600 / 618  5.333   28.3    33.633   18      0    0/0       125310     2365     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3435  Unsuccessful constraint checks 73007 
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
Result length is 18!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    22914   425 / 434  5.35    13.8    19.15    9       0    0/0       117614     2209     T/0.0       RANDOM   RANDOM

Successful constraint checks: 1407  Unsuccessful constraint checks 21507 
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
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    46716   425 / 452  5.333   19.933  25.283   27      0    0/0       115392     2209     T/0.017     RANDOM   RANDOM

Successful constraint checks: 2619  Unsuccessful constraint checks 44097 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    76532   441 / 468  5.35    33.2    38.55    27      0    0/0       175757     2259     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3338  Unsuccessful constraint checks 73194 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    74406   572 / 599  5.317   27.55   32.867   27      0    0/0       123625     2461     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4073  Unsuccessful constraint checks 70333 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    70090   572 / 599  5.4     26.433  31.833   27      0    0/0       123883     2461     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3803  Unsuccessful constraint checks 66287 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    125056  977 / 1127 5.333   47.733  53.066   150     0    0/0       227746     4360     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4986  Unsuccessful constraint checks 120070 
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
Result length is 150!
Level 2, average constraint checks is 67812.4!

> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    73265   441 / 468  5.267   31.583  36.85    27      0    0/0       176137     2259     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3239  Unsuccessful constraint checks 70026 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     60.75   6712    71663   432 / 441  4.733   25.25   29.983   9       0    0/0       102332     1827     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3140  Unsuccessful constraint checks 68523 
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
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    157928  936 / 1422 5.35    59.617  64.967   486     0    0/0       261869     2277     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4274  Unsuccessful constraint checks 153654 
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
Result length is 486!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    125056  977 / 1127 5.35    47.417  52.767   150     0    0/0       227746     4360     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4986  Unsuccessful constraint checks 120070 
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
Result length is 150!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    158337  2091 / 2100 5.3    67.017  72.317   9       0    0/0       386521     7564     T/0.0       RANDOM   RANDOM

Successful constraint checks: 7865  Unsuccessful constraint checks 150472 
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
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    46716   425 / 452  5.333   19.584  24.917   27      0    0/0       115392     2209     T/0.0       RANDOM   RANDOM

Successful constraint checks: 2619  Unsuccessful constraint checks 44097 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    70090   572 / 599  5.35    26.1    31.45    27      0    0/0       123883     2461     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3803  Unsuccessful constraint checks 66287 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    55265   441 / 450  5.35    28.217  33.567   9       0    0/0       188015     2259     T/0.0       RANDOM   RANDOM

Successful constraint checks: 5518  Unsuccessful constraint checks 49747 
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
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    74374   572 / 599  5.35    27.3    32.65    27      0    0/0       123625     2461     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4041  Unsuccessful constraint checks 70333 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    33399   600 / 618  5.317   17.15   22.467   18      0    0/0       130406     2365     T/0.0       RANDOM   RANDOM

Successful constraint checks: 1566  Unsuccessful constraint checks 31833 
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
Result length is 18!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    52448   679 / 688  5.366   32.384  37.75    9       0    0/0       263569     3449     T/0.0       RANDOM   RANDOM

Successful constraint checks: 2422  Unsuccessful constraint checks 50026 
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
Result length is 9!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    216029  2905 / 3013 5.35   75.2    80.55    108     0    0/0       270536     4753     T/0.0       RANDOM   RANDOM

Successful constraint checks: 5485  Unsuccessful constraint checks 210544 
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
Result length is 108!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    127381  1363 / 1390 5.367  49.717  55.084   27      0    0/0       231004     7004     T/0.0       RANDOM   RANDOM

Successful constraint checks: 6466  Unsuccessful constraint checks 120915 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    76532   441 / 468  5.333   32.667  38.0     27      0    0/0       175757     2259     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3338  Unsuccessful constraint checks 73194 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    132167  991 / 1441 5.3     49.65   54.95    450     0    0/0       227682     4360     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4461  Unsuccessful constraint checks 127706 
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
Result length is 450!
Level 3, average constraint checks is 98043.336!

> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    61957   866 / 920  5.35    24.817  30.167   54      0    0/0       133052     2379     T/0.0       RANDOM   RANDOM

Successful constraint checks: 2776  Unsuccessful constraint checks 59181 
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
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    54186   721 / 748  5.35    32.884  38.234   27      0    0/0       273407     3521     T/0.0       RANDOM   RANDOM

Successful constraint checks: 2538  Unsuccessful constraint checks 51648 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     60.75   6712    71492   432 / 594  4.733   24.983  29.716   162     0    0/0       102485     1827     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3122  Unsuccessful constraint checks 68370 
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
Result length is 162!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    198321  1363 / 1390 5.35   75.284  80.634   27      0    0/0       327456     7004     T/0.0       RANDOM   RANDOM

Successful constraint checks: 52045  Unsuccessful constraint checks 146276 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     60.75   6712    74822   450 / 936  4.766   26.134  30.9     486     0    0/0       102429     1827     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3302  Unsuccessful constraint checks 71520 
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
Result length is 486!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    284644  1720 / 1747 5.333  102.3   107.633  27      0    0/0       443773     8075     T/0.0       RANDOM   RANDOM

Successful constraint checks: 8052  Unsuccessful constraint checks 276592 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    234066  4856 / 4883 5.3    92.517  97.817   27      0    0/0       496098     12100    T/0.0       RANDOM   RANDOM

Successful constraint checks: 18234  Unsuccessful constraint checks 215832 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    46600   425 / 452  5.367   19.25   24.617   27      0    0/0       115407     2209     T/0.0       RANDOM   RANDOM

Successful constraint checks: 2503  Unsuccessful constraint checks 44097 
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
Result length is 27!
> Initializing a new case 
 
> Checkpoint ...  < 900 > 
0        bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    2575027 43140 / 44598 5.35 894.684 900.034  1458    0    0/0       2902169    49084    T/0.0       RANDOM   RANDOM
0        bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    2766930 46302 / 47760 5.35 961.1   966.45   1458    0    0/0       3116638    52750    T/0.0       RANDOM   RANDOM

Successful constraint checks: 45447  Unsuccessful constraint checks 2721483 
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
Result length is 1458!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    361391  2673 / 2988 5.333  131.534 136.867  315     0    0/0       556583     5472     T/0.0       RANDOM   RANDOM

Successful constraint checks: 9289  Unsuccessful constraint checks 352102 
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
Result length is 315!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    153608  936 / 1422 5.367   58.416  63.783   486     0    0/0       262107     2277     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4000  Unsuccessful constraint checks 149608 
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
Result length is 486!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    698432  4950 / 6408 5.333  240.567 245.9    1458    0    0/0       838978     5472     T/0.0       RANDOM   RANDOM

Successful constraint checks: 10745  Unsuccessful constraint checks 687687 
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
Result length is 1458!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     79.875  6712    98469   801 / 1287 4.733   37.283  42.016   486     0    0/0       165852     837      T/0.0       RANDOM   RANDOM

Successful constraint checks: 2214  Unsuccessful constraint checks 96255 
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
Result length is 486!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    162027  1327 / 1813 5.366  67.4    72.766   486     0    0/0       360474     3773     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4917  Unsuccessful constraint checks 157110 
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
Result length is 486!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     79.875  6712    20493   342 / 369  4.7     11.833  16.533   27      0    0/0       87822      837      T/0.0       RANDOM   RANDOM

Successful constraint checks: 1350  Unsuccessful constraint checks 19143 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    123981  1363 / 1399 5.35   45.784  51.134   36      0    0/0       231115     7004     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4076  Unsuccessful constraint checks 119905 
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
Result length is 36!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    39583   910 / 964  5.366   19.184  24.55    54      0    0/0       137860     2379     T/0.0       RANDOM   RANDOM

Successful constraint checks: 1760  Unsuccessful constraint checks 37823 
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
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    46922   663 / 690  5.384   22.083  27.467   27      0    0/0       164441     3399     T/0.0       RANDOM   RANDOM

Successful constraint checks: 2825  Unsuccessful constraint checks 44097 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    32823   600 / 618  5.35    16.583  21.933   18      0    0/0       130474     2365     T/0.0       RANDOM   RANDOM

Successful constraint checks: 1530  Unsuccessful constraint checks 31293 
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
Result length is 18!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    126567  991 / 1441 5.35    47.3    52.65    450     0    0/0       228226     4360     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4369  Unsuccessful constraint checks 122198 
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
Result length is 450!
Level 4, average constraint checks is 282865.7!

> Initializing a new case 
 
5002096 bytes have been tenured, next gc will be global.
See the documentation for variable *GLOBAL-GC-BEHAVIOR* for more information.
> Checkpoint ...  < 900 > 
0        bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    2562809 58350 / 84890 5.35 894.667 900.017  26540   0    0/0       2868526    9652     T/0.0       RANDOM   RANDOM
5004152 bytes have been tenured, next gc will be global.
See the documentation for variable *GLOBAL-GC-BEHAVIOR* for more information.
> Time limit bound exceeded  < 1800 > 
0        bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    5101749 116469 / 179705 5.35 1794.667 1800.017 63236 0   0/0       5732140    20382    T/0.0       RANDOM   RANDOM

Successful constraint checks: 159618  Unsuccessful constraint checks 4942131 
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
Result length is 63236!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     79.875  6712    98469   801 / 1287 4.9     36.65   41.55    486     0    0/0       165852     837      T/0.0       RANDOM   RANDOM

Successful constraint checks: 2214  Unsuccessful constraint checks 96255 
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
Result length is 486!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    284644  1720 / 1747 5.384  101.266 106.65   27      0    0/0       443773     8075     T/0.0       RANDOM   RANDOM

Successful constraint checks: 8052  Unsuccessful constraint checks 276592 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     66.85714 5873   10791   144 / 306  4.15    4.016   8.166    162     0    0/0       19287      369      T/0.0       RANDOM   RANDOM

Successful constraint checks: 684  Unsuccessful constraint checks 10107 
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
Result length is 162!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    114899  1089 / 1575 5.433  49.634  55.067   486     0    0/0       300556     2583     T/0.0       RANDOM   RANDOM

Successful constraint checks: 2433  Unsuccessful constraint checks 112466 
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
Result length is 486!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    361017  2911 / 3226 5.433  134.9   140.333  315     0    0/0       641771     6662     T/0.0       RANDOM   RANDOM

Successful constraint checks: 9491  Unsuccessful constraint checks 351526 
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
Result length is 315!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    54545   594 / 756  5.333   27.883  33.216   162     0    0/0       206133     2259     T/0.0       RANDOM   RANDOM

Successful constraint checks: 1425  Unsuccessful constraint checks 53120 
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
Result length is 162!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    39007   910 / 964  5.35    18.3    23.65    54      0    0/0       137928     2379     T/0.0       RANDOM   RANDOM

Successful constraint checks: 1724  Unsuccessful constraint checks 37283 
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
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    110107  1655 / 1691 5.334  42.4    47.734   36      0    0/0       249949     7864     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4447  Unsuccessful constraint checks 105660 
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
Result length is 36!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     79.875  6712    133829  1389 / 1839 4.75   49.45   54.2     450     0    0/0       240836     4047     T/0.0       RANDOM   RANDOM

Successful constraint checks: 5161  Unsuccessful constraint checks 128668 
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
Result length is 450!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    281363  1720 / 1756 5.35   100.317 105.684  36      0    0/0       444241     8075     T/0.0       RANDOM   RANDOM

Successful constraint checks: 5781  Unsuccessful constraint checks 275582 
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
Result length is 36!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    99647   1363 / 1399 5.333  45.7    51.033   36      0    0/0       328127     7004     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3024  Unsuccessful constraint checks 96623 
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
Result length is 36!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    192201  3143 / 3251 5.35   70.883  76.233   108     0    0/0       322279     5943     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4537  Unsuccessful constraint checks 187664 
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
Result length is 108!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    60597   607 / 1723 5.45    25.4    30.867   1116    0    0/0       144754     2484     T/0.017     RANDOM   RANDOM

Successful constraint checks: 7340  Unsuccessful constraint checks 53257 
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
Result length is 1116!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    39245   1148 / 1202 5.35   22.5    27.85    54      0    0/0       209587     3569     T/0.0       RANDOM   RANDOM

Successful constraint checks: 1962  Unsuccessful constraint checks 37283 
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
Result length is 54!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    126567  991 / 1441 5.333   46.5    51.833   450     0    0/0       228226     4360     T/0.0       RANDOM   RANDOM

Successful constraint checks: 4369  Unsuccessful constraint checks 122198 
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
Result length is 450!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    132894  1396 / 9496 5.367  53.383  58.75    8100    0    0/0       236499     4374     T/0.0       RANDOM   RANDOM

Successful constraint checks: 11104  Unsuccessful constraint checks 121790 
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
Result length is 8100!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    43157   1075 / 1147 5.334  19.716  25.05    72      0    0/0       141960     2386     T/0.0       RANDOM   RANDOM

Successful constraint checks: 1606  Unsuccessful constraint checks 41551 
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
Result length is 72!
> Initializing a new case 
 
5002720 bytes have been tenured, next gc will be global.
See the documentation for variable *GLOBAL-GC-BEHAVIOR* for more information.
0        bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    198321  1363 / 1390 5.366  76.5    81.866   27      0    0/0       327456     7004     T/0.0       RANDOM   RANDOM

Successful constraint checks: 52045  Unsuccessful constraint checks 146276 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    230786  4856 / 4883 5.317  91.783  97.1     27      0    0/0       520038     12100    T/0.0       RANDOM   RANDOM

Successful constraint checks: 14954  Unsuccessful constraint checks 215832 
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
Result length is 27!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     60.75   6712    71510   450 / 936  4.784   24.783  29.567   486     0    0/0       102809     1827     T/0.0       RANDOM   RANDOM

Successful constraint checks: 3158  Unsuccessful constraint checks 68352 
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
Result length is 486!
> Initializing a new case 
 0       bt/ T/ NIL/ T/ T    DEFAULT     73.0    7551    698432  4950 / 6408 5.35   235.1   240.45   1458    0    0/0       838978     5472     T/0.0       RANDOM   RANDOM

Successful constraint checks: 10745  Unsuccessful constraint checks 687687 
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
Result length is 1458!
> Initializing a new case 
 ^C
Error: Received signal number 2 (Keyboard interrupt)
  [condition type: INTERRUPT-SIGNAL]

Restart actions (select using :continue):
 0: continue computation at break level 2
 1: Try calling EXPLORE again.
 2: Return a value instead of calling EXPLORE.
 3: Try calling a function other than EXPLORE.
 4: Setf the symbol-function of EXPLORE and call it again.
 5: continue computation
[3c] USER(8): :exit
; Exiting Lisp
> exit

exit

script done on Tue Nov 12 21:37:23 1996

script done on Tue Nov 12 21:37:23 1996
