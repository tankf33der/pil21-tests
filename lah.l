# rosettacode.org/wiki/Lah_numbers
(de fact (N)
   (if (=0 N)
      1
      (* N (fact (dec N))) ) )
(de lah (N K)
   (cond
      ((=1 K) (fact N))
      ((= N K) 1)
      ((> K N) 0)
      ((or (> 1 N) (> 1 K)) 0)
      (T
         (/
            (* (fact N) (fact (dec N)))
            (* (fact K) (fact (dec K)))
            (fact (- N K)) ) ) ) )
(maxi '((N) (lah 100 N)) (range 0 100))
(test
   44519005448993144810881324947684737529186447692709328597242209638906324913313742508392928375354932241404408343800007105650554669129521241784320000000000000000000000
   @@ )
(msg 'lah-OK)
