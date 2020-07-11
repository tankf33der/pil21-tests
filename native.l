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
(msg 'return-OK)

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
(msg 'args-num-OK)

# arrays
(test
   (pack (need -6 (1 2 3) 0))
   (native "./native.so" "argLB" 'S '(NIL (6) 1 2 3 . 0) 6) )
(let L (range 11 17)
   (test
      (pack (range 11 17))
      (native "./native.so" "argLB" 'S (cons NIL (cons 7) L) 7) ) )
(msg 'args-OK)

################################################################
# native doc
(msg 0)
(test
   T
   (bool (native "@" "getenv" 'S "TERM")) )
(msg 1)
(test
   11
   (native "@" "printf" 'I "abc%d%s-OK^J" (+ 3 4) (pack "X" "Y" "Z")) )
(msg 2)
# XXX, not implemented
#(println
#   (native "@" "printf" 'I "This is %.3f^J" (123456 . 1000)) )
# (use Tim
   # (native "@" "time" NIL '(Tim (8 B . 8)))
   # (native "@" "localtime" '(I . 9) (cons NIL (8) Tim)) )
# (native "libcrypto.so" "SHA1" '(B . 20) "abcd" 4 0)



# adr example from doc
(test
   "12"
   (hex (byte (>> -4 (adr (1))))) )
(test
   "22"
   (hex (byte (>> -4 (adr (2))))) )
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
(bye)
