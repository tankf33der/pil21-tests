(load "@lib/frac.l")

# GCD
(test 3 (frac~gcd 1234567890 777))

# Rationale
# http://rosettacode.org/wiki/Arithmetic/Rational
(off R)
(for (N 2  (> (** 2 15) N)  (inc N))
   (let (Sum (frac~f 1 N)  Lim (sqrt N))
      (for (F 2  (>= Lim F) (inc F))
         (when (=0 (% N F))
            (setq Sum
               (frac~f+ Sum
                  (frac~f+ (frac~f 1 F) (frac~f 1 (/ N F))) ) ) ) )
      (and
         (= 1 (cdr Sum))
         (push 'R N) ) ) )
(test 72450 (apply + R))

(msg 'frac-OK)
