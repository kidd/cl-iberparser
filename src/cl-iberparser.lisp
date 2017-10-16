(in-package :cl-user)
(defpackage cl-iberparser
  (:use :cl :clss :plump :drakma))
(in-package :cl-iberparser)


(defun parse-euros (txt)
  (handler-case
      (parse-float:parse-float
       (ppcre:regex-replace "^.*EUR (.*) *$"
        (substitute #\Space #\NewLine (plump:text txt))
        "\\1")
       :decimal-character #\,)
    (error () 0)))

(defun price-for-book (book-url)
  (or
   (loop
     with web = (plump:parse (drakma:http-request book-url))
     for price-txt across (clss:select
                           "div.result-pricing > div.item-price span.price" web)
     for price = (parse-euros price-txt)
     for shipping-txt across (clss:select "div.result-pricing div.shipping" web)
     for shipping = (parse-euros shipping-txt)
     collect (+ price shipping))
   (list 100000)) ;; Superhack.works for now
  )

(defun prices-for-lines-in (file)
  (let ((content-lines (ppcre::split "\\n"
                                     (alexandria:read-file-into-string file))))
    (loop for line in content-lines
          for (book-url max-price) = (ppcre:split " " line)
          when (<= (first (price-for-book book-url))
                   (parse-float:parse-float (or max-price 100000)))
            collect book-url)))
