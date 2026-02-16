

(defun mapcsp ( situation template )
  (

  ;; 0a. Preprocess program plan library, extracting indices 
         (or start with library pre-indexed)
  ;; ob. Preprocess given source, generating a series  

  ;; 1. Determine which of the plans at level I are indexed
  ;; 2. Resolve level I indexes to partial/possible level I solutions
  ;; 3. Resolve level I partial solutions as possible, giving a set of
  ;;  level I matches M(I)
  ;; 4. If there is no higher level I+1, we are done, else
  ;;  increment I and goto 1.


;; (defun determine-index ( plan-library  input-legacy-source )

;; (defun layered ( plan-library  input-legacy-source )

