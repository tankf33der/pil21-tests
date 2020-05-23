(load "@lib/simul.l")

# simple grid carousel
(de spiralSum NIL
   (let
      (G (simul~grid 9 9)
         This (get G 5 5)
         A 1
         Dir '(simul~north simul~west simul~south simul~east .) )
      (=: val A)
      (while (>= 265149 A)
         (setq This ((car Dir) This))
         (setq A
            (=:
               val
               (sum
                  '((D) (with (D This) (: val)))
                  (quote
                     simul~west simul~east
                     simul~south simul~north
                     ((X) (simul~south (simul~west X)))
                     ((X) (simul~north (simul~west X)))
                     ((X) (simul~south (simul~east X)))
                     ((X) (simul~north (simul~east X))) ) ) ) )
         (or
            (with ((car Dir) This) (: val))
            (with ((cadr Dir) This) (: val))
            (pop 'Dir) ) )
      A ) )
(test 266330 (spiralSum 9))
(msg 'grid-OK)
