(load "rc5.l")

(de "hex2L" (H)
   (make
      (for (L (chop H) L (cddr L))
         (link (hex (pack (car L) (cadr L)))) ) ) )

(use (K P C )
   (in "vectors/Rc5-128-64.verified.test-vectors"
      (until (eof)
         (and
            (from "Set ")
            (setq @@ (line))
            (>= 4 (format (car @@)) 1)
            (from "key=")
            (setq K ("hex2L" (line T)))
            (from "plain=")
            (setq P ("hex2L" (line T)))
            (from "cipher=")
            (setq C ("hex2L" (line T)))
            #(println K P C)
            (test C (rc5 P K)) ) ) ) )
(msg 'rc5-OK)

