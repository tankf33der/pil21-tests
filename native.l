(test
   (cons (+ 3 4) (* 3 4))
   (%@ "_cons" T '(T cons (+ 3 4) (* 3 4))) )

# return values
############################################################
(test
   NIL
   (native "./native.so" "returnvoid") )
(test
   255
   (native "./native.so" "returnbyte" 'B) )
(test
   1234567890
   (native "./native.so" "returnint" 'I) )
(test
   1234567890123456789
   (native "./native.so" "returnlong" 'N) )
(test
   (94 193 14 95 0 0 0 0)
   (native "./native.so" "return64" '(B . 8)) )
(test
   (range 0 9)
   (native "./native.so" "returnbytes" '(B . 10)) )
(test
   (need 10 1234567890)
   (native "./native.so" "returnints" '(I . 10)) )
(test
   (need 10 1234567890123456789)
   (native "./native.so" "returnlongs" '(N . 10)) )
(test
   (list 123456789 987654321)
   (native "./native.so" "returnS1" '(I I)) )
(test
   '(7777 (7 7 7 7))
   (native "./native.so" "returnS2" '(I (B . 4))) )
(test
   '(7777 (0 0 0 0) (7 7 7 7))
   (native "./native.so" "returnS3" '(I (B . 4) (N . 4))) )
(scl 3)
(test
   123455
   (native "./native.so" "returndouble" 1.0) )
(test
   123455
   (native "./native.so" "returnfloat" -1.0) )
(scl 0)
(test
   "mikeiscool"
   (native "./native.so" "returnstr" 'S) )

# arguments
################################################################

# numbers
(test
   "123"
   (native "./native.so" "argB" 'S 123) )
(test
   "1234"
   (native "./native.so" "argI" 'S 1234) )
(test
   "1234567890123456789"
   (native "./native.so" "argN" 'S 1234567890123456789) )

# arrays
(test
   (pack (need -6 (1 2 3) 0))
   (native "./native.so" "argLB" 'S '(NIL (6) 1 2 3 . 0) 6) )
(let L (range 11 17)
   (test
      (pack (range 11 17))
      (native "./native.so" "argLB" 'S (cons NIL (cons 7) L) 7) ) )

################################################################
# native doc
(test
   T
   (bool (native "@" "getenv" 'S "TERM")) )
(use (Tim R)
   (native "@" "time" NIL '(Tim (8 B . 8)))
   (setq R (native "@" "localtime" '(I . 9) (cons NIL (8) Tim)))
   (test
      T
      (and
         (= 9 (length R))
         (full '((N) (> 255 N)) R) ) ) )
(test
   (129 254 139 254 135 87 108 62 203 34 66 111 142 87 132 115 130 145 122 207)
   (native "libcrypto.so" "SHA1" '(B . 20) "abcd" 4 0) )
(use M
   (native "./native.so" "argS" NIL '(M (8 B . 8) 1 2 3 4 5 6 7 8))
   (test (range 1 8) M) )

(setq P (native "@" "malloc" 'N 32))
# b i l
(struct P 'N 222 (0 . 3) (1234567 . 4) (1234567890123456789 . 8))
(test
   "22212345671234567890123456789"
   (native "./native.so" "arg1" 'S P) )
# i b l
(struct P 'N (1234567 . 4) 222 (0 . 3) (1234567890123456789 . 8))
(test
   "12345672221234567890123456789"
   (native "./native.so" "arg2" 'S P) )
# i l b
(struct P 'N (1234567 . 4) (0 . 4) (1234567890123456789 . 8) 222 (0 . 3))
(test
   "12345671234567890123456789222"
   (native "./native.so" "arg3" 'S P) )
(native "@" "free" NIL P)


# adr example from doc
(test (1 2) (struct (adr (1 . 2)) '(T T)))
(test (18 34) (struct (adr (1 . 2)) '(P P)))

(let P (native "@" "malloc" 'N 8)
   (byte P (char "A"))
   (byte (+ P 1) (char "B"))
   (byte (+ P 2) (char "B"))
   (byte (+ P 3) (char "A"))
   (byte (+ P 4) 0)
   (test
      "ABBA"
      (native "@" "strdup" 'S P) )
   (native "@" "free" 'N P) )

(msg 'native-OK)
