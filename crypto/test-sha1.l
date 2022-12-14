(load "sha1.l")

(de "hex2L" (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )
(de createL (Lst)
   (let Lst (split Lst "\*" "\,")
      (conc
         (need (setq @ (format (car Lst))) 0)
         (cons (hex (caddr Lst)))
         (need (abs (- @ 63)) 0) ) ) )
(use (K C)
   (in "vectors/Sha-1-160.test-vectors"
      (until (eof)
         (and
            (from "string: ")
            (setq K (createL (clip (line))))
            (from "hash=")
            (setq C ("hex2L" (line T)))
            #(println K C)
            (test C (sha1 K)) ) ) ) )
(msg 'sha1-OK)
