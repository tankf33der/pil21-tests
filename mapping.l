#http://rosettacode.org/wiki/Matrix_transposition#PicoLisp
(de matTrans (Mat)
   (apply mapcar Mat list) )
#http://rosettacode.org/wiki/Matrix_multiplication#PicoLisp
(de matMul (Mat1 Mat2)
   (mapcar
      '((Row)
         (apply mapcar Mat2
            '(@ (sum * Row (rest))) ) )
      Mat1 ) )
(test
   '((1 4) (2 5) (3 6))
   (matTrans '((1 2 3) (4 5 6))) )
(test
   '((12 -6) (39 -12))
   (matMul
      '((1 2 3) (4 5 6))
      '((6 -1) (3 2) (0 -3)) ) )



# Original test code below
# copy-paste
### apply ###
(test 6 (apply + (1 2 3)))
(test 360 (apply * (5 6) 3 4))
(test 27 (apply '((X Y Z) (* X (+ Y Z))) (3 4 5)))
(test (5 7 9) (apply mapcar '((1 2 3) (4 5 6)) +))

### pass ###
(test 24 ((quote (N . @) (* N (pass + 6))) 2 1 2 3))



### maps ###
(let L '((1 . a) (2 . b) flg)
   (test L (let X (box) (putl X (reverse L)) (make (maps link X)))) )


### map ###
(test '((1 2 3) (2 3) (3)) (make (map link (1 2 3))))


### mapc ###
(test (1 2 3) (make (mapc link (1 2 3))))


### maplist ###
(test '(((1 2 3) A B C) ((2 3) B C) ((3) C)) (maplist cons (1 2 3) '(A B C)))


### mapcar ###
(test (5 7 9) (mapcar + (1 2 3) (4 5 6)))
(test (26 38 52 68) (mapcar '((X Y) (+ X (* Y Y))) (1 2 3 4) (5 6 7 8)))

### mapcon ###
(test (1 2 3 4 5 2 3 4 5 3 4 5 4 5 5) (mapcon copy (1 2 3 4 5)))

### mapcan ###
(test '(c b a f e d i h g) (mapcan reverse '((a b c) (d e f) (g h i))))


### filter ###
(test (1 2 3) (filter num? (1 A 2 (B) 3 CDE)))

### extract ###
(let (A NIL  B 1  C NIL  D 2  E NIL  F 3)
   (test (1 2 3)
      (extract val '(A B C D E F)) )
   (test (1 2 3)
      (extract val '(B D E F)) ) )



### seek ###
(test (12 19 22) (seek '((X) (> (car X) 9)) (1 5 8 12 19 22)))
(let (A -1  B 2  C 3)
   (test '(B C) (seek '((L) (gt0 (val (car L)))) '(A B C)))
   (test 2 @@) )


### find ###
(test '(B) (find pair (1 A 2 (B) 3 CDE)))
(test 4 (find > (1 2 3 4 5 6) (6 5 4 3 2 1)))
(test 4 (find '((A B) (> A B)) (1 2 3 4 5 6) (6 5 4 3 2 1)))
(let (A -1  B 2  C 3)
   (test 'B (find '((X) (gt0 (val X))) '(A B C)))
   (test 2 @@) )


### pick ###
(test "Hello"
   (pick '((X) (get X 'str))
      (list (box) (prog1 (box) (put @ 'str "Hello")) (box)) ) )


### fully ###
(test T (fully gt0 (1 2 3)))
(test NIL (fully gt0 (1 -2 3)))


### cnt ###
(test 2 (cnt cdr '((1 . T) (2) (3 4) (5))))

### maxi mini ###
(let (A 1 B 2 C 3)
   (test 'C (maxi val '(A B C)))
   (test 3 @@)
   (test 'A (mini val '(A B C)))
   (test 1 @@)
   (test '(A B C) (by val sort '(C A B))) )


### by ###
(test '(A B C)
   (let (A 1 B 2 C 3)
      (by val sort '(C A B)) ) )
(test '((3 11 9 5 7 1) (6 2 4 10 12 8))
   (by '((N) (bit? 1 N))
      group
      (3 11 6 2 9 5 4 10 12 7 8 1) ) )
(test '(("x" "x" "x") ("y") ("z" "z"))
   (by name group '("x" "x" "y" "z" "x" "z")) )
(test '((123 "xyz") ((1 2) "XY") ("abcd" (1 2 3 4)))
   (by length group '(123 (1 2) "abcd" "xyz" (1 2 3 4) "XY")) )


### sum ###
(test 6 (sum val (list (box 1) (box) (box 2) (box 'a) (box 3))))


### fish ###
(test (1 2 3)
   (fish gt0 '(a -2 (1 b (-3 c 2)) 3 d -1)) )
(test '(a b c d)
   (fish sym? '(a -2 (1 b (-3 c 2)) 3 d -1)) )

(msg 'mapping-OK)
