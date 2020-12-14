(setq P (native "@" "malloc" 'N 128))

(struct P 'N -1 (1234 . 4) -1)
(test
   (1 210 4 0 0 1)
   (struct P '(I B B B B I)) )

(native "@" "free" NIL P)

(off A)
(wipe 'A)
(setq A '(a b c))
(put 'A 'a 1)
(test '(a b c) (struct (adr 'A) T))
(test '((1 . a) . 65) (struct (- (adr 'A) 8) T))
(test
   '(((1 . a) . 65) (a b c))
   (struct (- (adr 'A) 8) '(T T)) )

(msg 'struct-OK)
