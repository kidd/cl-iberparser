#|
  This file is a part of cl-iberparser project.
  Copyright (c) 2017 Raimon Grau (raimonster@gmail.com)
|#

#|
  Author: Raimon Grau (raimonster@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-iberparser-asd
  (:use :cl :asdf))
(in-package :cl-iberparser-asd)

(defsystem cl-iberparser
  :version "0.1"
  :author "Raimon Grau"
  :license "LLGPL"
  :depends-on (:drakma
               :plump
               :parse-float
               :alexandria
               :cl-ppcre
               :clss)
  :components ((:module "src"
                :components
                ((:file "cl-iberparser"))))
  :description ""
  :in-order-to ((test-op (test-op cl-iberparser-test))))
