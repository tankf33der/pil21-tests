(load "blake2s.l")

(de _hex2L (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(use (D K R)
   (in "vectors/blake2s-kat.txt"
      (until (eof)
         (and
            (from "in:")
            (char)
            (setq D (_hex2L (line)))
            (from "key:")
            (char)
            (setq K (_hex2L (line)))
            (from "hash:")
            (char)
            (test (_hex2L (line)) (blake2s D K)) ) ) ) )
(msg 'blake2s-OK)
