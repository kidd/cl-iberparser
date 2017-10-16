#|
  This file is a part of cl-iberparser project.
  Copyright (c) 2017 Raimon Grau (raimonster@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-iberparser-test-asd
  (:use :cl :asdf))
(in-package :cl-iberparser-test-asd)

(defsystem cl-iberparser-test
  :author "Raimon Grau"
  :license "LLGPL"
  :depends-on (:cl-iberparser
               :plump
               :alexandria
               :cl-ppcre
               :clss
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "cl-iberparser"))))
  :description "Test system for cl-iberparser"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
