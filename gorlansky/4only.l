# Common part
(de prime? (N)
   (or
      (= N 2)
      (and
         (> N 1)
         (bit? 1 N)
         (let S (sqrt N)
            (for (D 3  T  (+ D 2))
               (T (> D S) T)
               (T (=0 (% N D)) NIL) ) ) ) ) )
(de evenp? (N)
   (not (bit? 1 N)) )
(de oddp? (N)
   (bit? 1 N) )

(load "@lib/simul.l")
(load "@lib/frac.l")

(load "4-list-list.l")
(msg 'ok)

