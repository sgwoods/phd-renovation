(in-package #:phd-qcsp-alex)
;;This test prgram is to dump the initial hash table for
;;all components, and the hash table after data dependency
;;computation for all components. 

;;(dump-setup-data :comp-file "~/Steve/cond3C.component"
;;                 :control-file "~/Steve/cond3C.control"
;;                 :stats-file "~/Steve/cond3C.stats"
;;                 :output-file "~/Steve/cond3C.sout")

(output-sit-hash :comp-file "~/thesis/CSP/qcsp-alex/testdata/data-y/dytk3c.component"
                 :control-file "~/thesis/CSP/qcsp-alex/testdata/data-y/dytk3c.control"
                 :stats-file "~/thesis/CSP/qcsp-alex/testdata/data-y/dytk3c.stats"
                 :output-file "~/thesis/CSP/qcsp-alex/testdata/data-y/dytk3c.hout")

