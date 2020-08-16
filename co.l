(load "cartesian.l")

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

(de 11permute (N Lst)
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
(11permute 3 (range 1 4))               # set iterator
(test (1 1 1) (11permute 'next))        # first
(do 32 (11permute 'next))               # skip a few
(test (2 1 3) (11permute 'next))        # next after skip

(msg 8)

(for N 64
   (co (intern (pack 'ring N))
      (let (N N  Send (intern (pack 'ring (if (= 64 N) 1 (inc N)))))
         (for (I (yield)  (gt0 (yield (dec I) Send))  @))
         N ) ) )
(test 9 (yield 5000 'ring1))

(msg 9)

(de product (Lst)
   (co 'cartesian
      (let
         (Lst Lst
            Z (need (length Lst) 1)
            Lens (mapcar length Lst)
            N (apply * Lens)
            Flg )
         (yield 'ready)
         (while (ge0 (dec 'N))
            (yield (mapcar get Lst Z))
            (off Flg)
            (let (A Z  B Lens)
               (until Flg
                  (inc A)
                  (ifn (> (car A) (car B))
                     (on Flg)
                     (set A 1)
                     (++ A)
                     (++ B) ) ) ) ) ) ) )
(de cartesian-sum (Lst)
   (let
      (Z (need (length Lst) 1)
         Lens (mapcar length Lst)
         N (apply * Lens)
         S 0
         Flg )
      (while (ge0 (dec 'N))
         (inc
            'S
            (sum prog (mapcar get Lst Z)) )
         (off Flg)
         (let (A Z  B Lens)
            (until Flg
               (inc A)
               (ifn (> (car A) (car B))
                  (on Flg)
                  (set A 1)
                  (++ A)
                  (++ B) ) ) ) )
      S ) )
(de cartesian-maxi (Lst)
   (let
      (Z (need (length Lst) 1)
         Lens (mapcar length Lst)
         N (apply * Lens)
         Max NIL
         Flg )
      (while (ge0 (dec 'N))
         (and
            (>
               (setq @@ (sum prog (mapcar get Lst Z)))
               Max )
            (setq Max @@) )
         (off Flg)
         (let (A Z  B Lens)
            (until Flg
               (inc A)
               (ifn (> (car A) (car B))
                  (on Flg)
                  (set A 1)
                  (++ A)
                  (++ B) ) ) ) )
      Max ) )

(msg 10)

(setq L
   (list
      (range 1 10)
      (range 10 20)
      (range 1 30)
      (range 1 40) ) )
(product L)
(zero S)
(while (product 'cartesian)   # sum over every list
   (inc 'S (sum prog @)) )
(test
   S
   (sum '((L) (sum prog L)) (apply cartesian L)) )

(msg 11)


# prev iter finished.
(setq L '((1 2) (3 4 5)))
(product L)                   # set new iter on smaller lists.
(test
   (1 3)
   (product 'cartesian) )     # take one number
(co 'cartesian)               # oops, i need bigger list, stop it

(msg 12)

(setq L '((1 2) (3 4 5) (100 111)))
(product L)                   # define bigger list, start again
(zero S)
(while (product 'cartesian)   # sum over every list
   (inc 'S (sum prog @)) )
(test
   S
   (sum '((L) (sum prog L)) (apply cartesian L)) )

(msg 13)

# sum over 4M items of product
(setq L (make (do 4 (link (range 1 21)))))
(product L)
(zero S)
(while (product 'cartesian)
   (inc 'S (sum prog @)) )
(test
   S
   (cartesian-sum L) )

(msg 14)

# adventofcode2015-day13
# Find max sum of items in cartesian product
(setq L '((-25 52 -81) (76 20 -70) (-2 -7 115) (39 87 34)))
(test
   330
   (cartesian-maxi L) )

(msg 'co-OK)
