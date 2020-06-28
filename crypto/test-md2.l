(load "md2.l")

(de "hex2L" (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(use (K C)
   (in "vectors/md2.vec"
      (until (eof)
         (and
            (from "In = ")
            (setq K ("hex2L" (line)))
            (from "Out = ")
            (setq C ("hex2L" (line)))
            #(println K C)
            (test C (md2 K )) ) ) ) )
(msg 'md2-OK)
