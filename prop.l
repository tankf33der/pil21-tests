### put get prop ; =: : :: putl getl ###
(let (A (box)  B (box A)  C (box (cons A B)))
   (put B 'a A)
   (put C 'b B)
   (put A 'x 1)
   (put B 'a 'y 2)
   (put C 0 -1 'a 'z 3)
   (test '(NIL . p) (prop 'A 'p))
   (test 1 (get A 'x))
   (test 1 (; A x))
   (test 2 (with A (: y)))
   (test 2 (get A 'y))
   (test 2 (; A y))
   (test 2 (with B (: 0 y)))
   (test 2 (get B 0 'y))
   (test 2 (; B 0 y))
   (test 3 (with C (: b a z)))
   (test 3 (with C (: 0 1 z)))
   (test 3 (with C (: 0 -1 a z)))
   (test 3 (get C 0 1 'z))
   (test 3 (get C 0 -1 'a 'z))
   (test 3 (; C 0 -1 a z))
   (test 1 (push (prop 'A 'p) 1))
   (test 1 (with 'A (pop (:: p))))
   (test NIL (get 'A 'p))
   (test (3 . z) (prop C 0 -1 'a 'z))
   (test 9 (with C (=: 0 -1 a z (* 3 3))))
   (test (9 . z) (with C (:: 0 -1 a z)))
   # XXX
   #(test (putl C 0 -1 'a '((1 . x) (2 . y))) (flip (getl C 'b 0)))
)

(test NIL (get (1 2 3) 0))
(test 1 (get (1 2 3) 1))
(test 3 (get (1 2 3) 3))
(test NIL (get (1 2 3) 4))
(test (3) (get (1 2 3) -2))
(test 1 (get '((a (b . 1) (c . 2)) (d (e . 3) (f . 4))) 'a 'b))
(test 4 (get '((a (b . 1) (c . 2)) (d (e . 3) (f . 4))) 'd 'f))

### wipe ###
(let X (box (1 2 3 4))
   (put X 'a 1)
   (put X 'b 2)
   (test (1 2 3 4) (val X))
   # XXX
   #(test '((2 . b) (1 . a)) (getl X))
   (wipe X)
   (test NIL (val X))
   (test NIL (getl X)) )


(setq "W" (1 2 3 4))
(put '"W" 'a 1)
(put '"W" 'b 2)
(test (1 2 3 4) "W")
# XXX
#(test '((2 . b) (1 . a)) (getl '"W"))
(wipe '"W")
(test NIL "W")
(test NIL (getl '"W"))

# XXX
#{
(set *DB (1 2 3 4))
(put *DB 'a 1)
(put *DB 'b 2)
(test (1 2 3 4) (val *DB))
#XXX
#(test '((2 . b) (1 . a)) (getl *DB))
(wipe *DB)
(test (1 2 3 4) (val *DB))
#XXX
#(test '((2 . b) (1 . a)) (getl *DB))
(rollback)
(test NIL "W")
(test NIL (getl '"W"))
}#

### meta ###
(let A '("B")
   (put '"B" 'a 123)
   (test 123 (meta 'A 'a)) )
