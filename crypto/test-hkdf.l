(load "sha256.l")
(load "hmac.l")
(load "hkdf.l")

(de "hex2L" (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(test
   ("hex2L" "3cb25f25faacd57a90434f64d0362f2a2d2d0a90cf1a5a4c5db02d56ecc4c5bf34007208d5b887185865")
   (hkdf
      'sha256
      ("hex2L" "0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b")
      ("hex2L" "000102030405060708090a0b0c")
      ("hex2L" "f0f1f2f3f4f5f6f7f8f9")
      42 ) )
(test
   ("hex2L" "8da4e775a563c18f715f802a063c5a31b8a11f5c5ee1879ec3454e5f3c738d2d9d201395faa4b61a96c8")
   (hkdf
      'sha256
      ("hex2L" "0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b")
      NIL
      NIL
      42 ) )

(msg 'hkdf-OK)
