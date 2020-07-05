# returns
(test
   NIL
   (native "./native.so" "returnvoid") )
(println
   (native "./native.so" "returnbyte") )
(println
   (native "./native.so" "returnint") )
(println
   (native "./native.so" "returnlong") )

# native doc
(test
   T
   (bool (native "@" "getenv" 'S "TERM")) )
(test
   11
   (native "@" "printf" 'I "abc%d%s-OK^J" (+ 3 4) (pack "X" "Y" "Z")) )
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
