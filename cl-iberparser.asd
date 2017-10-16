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
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "cl-iberparser"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op cl-iberparser-test))))
