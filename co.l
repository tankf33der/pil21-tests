(test 7 (co 'aa (yield 7)))

(msg 1)

(de powers (M)
   (co (intern (pack 'powers M))
      (for (I 0 (inc 'I))
         (yield (** I M)) ) ) )

(de filtered (N M)
   (co 'filtered
      (let (V (powers N)  F (powers M))
         (loop
            (if (> V F)
               (setq F (powers M))
               (and (> F V) (yield V))
               (setq V (powers N)) ) ) ) ) )
(test
   (4 9 16 25 36 49 81 100)
   (make (do 8 (link (filtered 2 3)))) )

(msg 2)

(de pythag (N)
   (co 'pythag
      (for X N
         (for Y (range X N)
            (for Z (range Y N)
               (when (= (+ (* X X) (* Y Y)) (* Z Z))
                  (yield (list X Y Z)) ) ) ) ) ) )
(test
   '((3 4 5) (5 12 13) (6 8 10) (8 15 17) (9 12 15) (12 16 20))
   (make (while (pythag 20) (link @))) )

(msg 3)

(de nuggets1 (M)
   (let Lst (range 0 M)
      (for A (range 0 M 6)
         (for B (range A M 9)
            (for C (range B M 20)
               (set (nth Lst (inc C))) ) ) )
      (apply max Lst) ) )
(de nugg (M)
   (co 'nugget
      (for A (range 0 M 6)
         (for B (range A M 9)
            (for C (range B M 20)
               (yield (inc C)) ) ) ) ) )
(de nuggets2 (M)
   (let Lst (range 0 M)
      (while (nugg 100)
         (set (nth Lst @)) )
      (apply max Lst) ) )
(test
   T
   (=
      43
      (nuggets1 100)
      (nuggets2 100) ) )

(msg 4)

(co 'fibo
   (let (A 0  B 1)
      (yield 'ready)
      (while
         (yield
            (swap 'B (+ (swap 'A B) B)) ) ) ) )
(test
   (1 1 2 3 5 8 13 21)
   (make (do 8 (link (yield 'next 'fibo)))) )
(yield NIL 'fibo) # stop generator

(msg 5)

(de numbers NIL
   (co 'numbers
      (let N 7
         (for P N
            (for S N
               (for F N
                  (yield (list P S F)) ) ) ) ) ) )
(test
   343
   (length
      (make (while (numbers) (link @))) ) )

(msg 6)

(de foo ()
   (co "html"
      (catch "err"
         (yield)
         (throw "err") ) ) )
(foo)
(do 1 (foo))

(msg 7)

(de permute (N Lst)
   (co 'next
      (let
         (Lst Lst
            N N
            Y (need N 1)
            Z (length Lst) )
         (yield 'ready)
         (do (** Z N)
            (yield (mapcar '((I) (get Lst I)) Y))
            (let (A Y  Flg)
               (until Flg
                  (inc A)
                  (ifn (> (car A) Z)
                     (on Flg)
                     (set A 1)
                     (++ A) ) ) ) )
         NIL ) ) )
(permute 3 (range 1 4))               # set iterator
(test (1 1 1) (permute 'next))        # first
(do 32 (permute 'next))               # skip a few
(test (2 1 3) (permute 'next))        # next after skip

(msg 8)

(for N 64
   (co (intern (pack 'ring N))
      (let (N N  Send (intern (pack 'ring (if (= 64 N) 1 (inc N)))))
         (for (I (yield)  (gt0 (yield (dec I) Send))  @))
         N ) ) )
(test 9 (yield 5000 'ring1))


(msg 'co-OK)
(bye)
