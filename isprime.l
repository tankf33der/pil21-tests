(seed (in "/dev/urandom" (rd 8)))
(de **Mod (X Y N)
   (let M 1
      (loop
         (when (bit? 1 Y)
            (setq M (% (* M X) N)) )
         (T (=0 (setq Y (>> 1 Y))) M)
         (setq X (% (* X X) N)) ) ) )
(de isprime (N P)
   (default P 16)
   (or
      (== N 2)
      (and
         (> N 1)
         (bit? 1 N)
         (let (Q (dec N)  N1 (dec N)  K 0  X)
            (until (bit? 1 Q)
               (setq Q (>> 1 Q)  K (inc K)) )
            (do P
               (setq X
                  (**Mod (rand 2 (min (dec N) 1000000000000)) Q N) )
               (NIL
                  (or
                     (=1 X)
                     (= X N1)
                     (do K
                        (setq X (**Mod X 2 N))
                        (T (= X N1) T) ) ) )
               T ) ) ) ) )
(test
   T
   (isprime 531137992816767098689588206552468627329593117727031923199444138200403559860852242739162502265229285668889329486246501015346579337652707239409519978766587351943831270835393219031728127) )

(msg 'isprime-OK)
