(in-package :cl-user)
(defpackage cl-iberparser
  (:use :cl))
(in-package :cl-iberparser)

(defun prices-for-lines-in (file)
  (let ((content-lines (ppcre::split "\\n"
                                     (alexandria:read-file-into-string file))))
    (loop for line in content-lines
          for (book-url max-price) = (ppcre:split " " line)
          when (<= (first (price-for-book book-url))
                   (parse-float:parse-float (or max-price 100000)))
            collect book-url)))

(defun price-for-book (book-url)
  (or
   (loop
     with web = (plump:parse (drakma:http-request book-url))
     for price-txt across (clss:select "div.result-pricing > div.item-price span.price"
                                       web)

     for price = (parse-float:parse-float (ppcre:regex-replace
                                           "EUR (.*)"
                                           (plump:text price-txt)
                                           "\\1")
                                          :decimal-character #\,)
     for shipping-txt across (clss:select "div.result-pricing div.shipping" web)
     for shipping = (handler-case
                        (parse-float:parse-float
                         (ppcre:regex-replace
                          "^.*EUR (.*) *$"
                          (substitute #\Space #\NewLine (plump:text shipping-txt))
                          "\\1")
                         :decimal-character #\,)
                      (error ()
                        0))
     collect (+ price shipping))
   (list 100000)) ;; Superhack.works for now
  )
;; blah blah blah.
