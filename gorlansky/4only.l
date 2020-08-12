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
(de gcd (A B)
   (until (=0 B)
      (let M (% A B)
         (setq A B B M) ) )
   (abs A) )
(de lcm (A B)
   (abs (*/ A B (gcd A B))) )
(de _reduce ("Fun" "Lst")
   (let "A" (car "Lst")
      (for "N" (cdr "Lst")
         (setq "A" ("Fun" "A" "N")) )
      "A" ) )
(de f3-125 (L)
   (_reduce gcd L) )
(de numNm (N)
   (cond
      ((=0 N))
      ((> 14 N)
         (cons
            (get
               '(one two three four five six seven
                  eight nine ten eleven twelve thirteen )
               N ) ) )
      ((= 15 N) (cons 'fifteen))
      ((= 18 N) (cons 'eighteen))
      ((> 20 N)
         (cons (intern (pack (numNm (% N 10)) "teen"))) )
      ((> 100 N)
         (cons
            (intern
               (pack
                  (get
                     '("twen" "thir" "for" "fif" "six" "seven" "eigh" "nine")
                     (dec (/ N 10)) )
                  "ty"
                  (and
                     (gt0 (% N 10))
                     (pack "-" (numNm @)) ) ) ) ) )
      ((rank
         N
         '((100 . (hundred)) (1000 . (thousand))
            (1000000 . (million)) (1000000000 . (billion)) ) )
         (append
            (numNm (/ N (car @)))
            (cdr @)
            (numNm (% N (car @))) ) ) ) )
(de f5-16 (A B N)
   (default N 0)
   (if (< A B)
      (cons N A)
      (f5-16 (- A B) B (inc N)) ) )
(de randN ()
   (make
      (do 4096
         (link (rand 1 4096)) ) ) )


(load "@lib/simul.l")
(load "@lib/frac.l")

#(load "4-list-list.l")
#(load "5-atom-atom-atom.l")
(load "6-atom-atom-list.l")
#(load "7-list-atom-atom.l")
#(load "8-list-atom-list.l")
#(load "9-list-list-atom.l")
#(load "10-list-list-list.l")
#(load "11-atom-atom-atom-atom.l")
#(load "12-atom-atom-atom-list.l")
#(load "13-list-atom-atom-atom.l")
#(load "14-list-atom-atom-list.l")
#(load "15-list-list-atom-atom.l")
#(load "16-list-list-atom-list.l")
#(load "17-list-list-list-list.l")
#(load "18-list-list-atom-atom-list.l")

(msg 'ok)

