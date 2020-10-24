(load "blake2.l")

(de "hex2L" (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(use (D K)
   (in "vectors/blake2b-kat.txt"
      (until (eof)
         (and
            (from "in:")
            (char)
            (setq D ("hex2L" (line)))
            (from "key:")
            (char)
            (setq K ("hex2L" (line)))
            (from "hash:")
            (char)
            (test ("hex2L" (line)) (blake2b D K)) ) ) ) )
(msg 'blake2b-OK)
