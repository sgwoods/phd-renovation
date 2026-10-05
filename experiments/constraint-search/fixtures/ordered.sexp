(:schema-version 1 :id "ordered" :provenance "new-synthetic"
 :variables (("source" ("a" "b")) ("target" ("a" "b")))
 :constraints ((:id "edge" :kind :table :scope ("source" "target") :tuples (("a" "b")))
               (:id "injective" :kind :all-different :scope ("source" "target"))))
