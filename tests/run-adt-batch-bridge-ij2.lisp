;;;; run-adt-batch-bridge-ij2.lisp -- Execute one preserved ADT batch ij2 case
;;;;
;;;; Usage:
;;;;   PHD_ADT_BRIDGE_WORKDIR=/tmp/.../bridge/
;;;;   PHD_ADT_BRIDGE_OUTPUT=/tmp/.../ij2-050.1
;;;;   sbcl --non-interactive --load "tests/run-adt-batch-bridge-ij2.lisp"

(require :asdf)

(defun required-env (name)
  (or (uiop:getenv name)
      (error "Missing required environment variable: ~A" name)))

(let* ((project-root (make-pathname :directory (butlast (pathname-directory
                                                         (truename *load-pathname*)))
                                    :device (pathname-device (truename *load-pathname*))))
       (bridge-workdir (truename (required-env "PHD_ADT_BRIDGE_WORKDIR")))
       (output-file (required-env "PHD_ADT_BRIDGE_OUTPUT")))
  (pushnew project-root asdf:*central-registry* :test #'equal)
  (asdf:load-system :phd-research)

  (let ((*default-pathname-defaults* bridge-workdir))
    (ensure-directories-exist (merge-pathnames "ADT-Random/dummy"
                                               *default-pathname-defaults*))
    (funcall (intern "ADT" "PHD-CSP")
             :situation-id "adt-t2-1"
             :sit-noise 50
             :template-id "adt-t2"
             :forward-checking t
             :dynamic-rearrangement t
             :single-line-override t
             :random-ident "default"
             :output-file output-file)))
