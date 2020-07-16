(setq P (native "@" "malloc" 'N 128))

(struct P 'N -1 (1234 . 4) -1)
(println (struct P '(I B B B B I)))

(native "@" "free" NIL P)


(msg 'struct-OK)
(bye)
