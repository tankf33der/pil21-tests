# 27oct12 Software Lab. Alexander Burger
# Use: time bin/picolisp misc/bench.l

(de fibo (N)
   (if (>= 2 N)
      1
      (+ (fibo (dec N)) (fibo (- N 2))) ) )

(bench
   (test
      24157817
      (fibo 37) ) )
(msg 'ok)
(bye)
