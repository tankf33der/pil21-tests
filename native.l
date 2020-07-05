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
