(setq P (native "@" "malloc" 'N 128))

(struct P 'N -1 (1234 . 4) -1)
(test
   (1 210 4 0 0 1)
   (struct P '(I B B B B I)) )

(native "@" "free" NIL P)

(msg 'struct-OK)
