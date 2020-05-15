
# Original test code from PicoLisp
# copy-paste

### quote ###
(test (1 2 3) (quote 1 2 3))


### as ###
(test NIL (as (= 3 4) A B C))
(test '(A B C) (as (= 3 3) A B C))


### lit ###
(test 123 (lit 123))
(test NIL (lit NIL))
(test T (lit T))
(test (1) (lit '(1)))
(test ''"abc" (lit "abc"))
(test ''a (lit 'a))
(test (1 2 3) (lit '(1 2 3)))
(test ''(a b c) (lit '(a b c)))


### eval ###
(test 6 (eval (list '+ 1 2 3)))
(let (X 'Y  Y 7)
   (test 7 (eval X)) )
(let N 1
   ((quote (N)
         ((quote (N)
               (test 3 N)
               # XXX
               #(test 2 (eval 'N 1))
               #(test 2 (eval 'N 1 '(X)))
               #(test 3 (eval 'N 1 '(N)))
               #(test 1 (eval 'N 2))
               #(test 3 (eval 'N 2 '(N)))
          )
            3 ) )
      2 ) )


### run ###
(test 6 (run (list (list '+ 1 2 3))))
# XXX
#{
(test 2
   (let N 1
      ((quote (N) (run '((+ N N)) 1)) 2) ) )
}#


### def ###
(test '"a"
   (def '"a" '((X Y) (* X (+ X Y)))) )
# XXX
#(test '((X Y) (* X (+ X Y)))
#   "a" )


### de ###
(test '"b"
   (de "b" (X Y) (* X (+ X Y))) )
# XXX
#(test '((X Y) (* X (+ X Y)))
#   "b" )


### dm ###
(off "+Cls" "+A")
(class "+Cls" "+A")
# XXX
#(test '"foo>"
#   (dm "foo>" (X Y)
#      (* X (+ X Y)) ) )
#(test '"foo>"
#   (dm ("foo>" . "+Cls") (X Y)
#      (* X (+ X Y)) ) )
#(test '(("foo>" (X Y) (* X (+ X Y))) "+A")
#   "+Cls" )

