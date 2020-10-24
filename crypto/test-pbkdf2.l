(load "sha1.l")
(load "sha256.l")
(load "pbkdf2.l")

# RFC6070
(setq "L"
   (pbkdf2
      'sha1
      (mapcar char (chop "password"))
      (mapcar char (chop "salt"))
      1
      20 ) )
(test
   T
   (and (= `(hex "0C") (car "L")) (= `(hex "A6") (last "L"))) )
(msg 'pbkdf2-OK)
