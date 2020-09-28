# Original code from PicoLisp

# The Shape base class
(class +Shape)
# x y

(dm T (X Y)
   (=: x X)
   (=: y Y) )

(dm move> (DX DY)
   (inc (:: x) DX)
   (inc (:: y) DY) )


# The Rectangle class
(class +Rectangle +Shape)
# dx dy

(dm T (X Y DX DY)
   (super X Y)
   (=: dx DX)
   (=: dy DY) )

(dm area> ()
   (* (: dx) (: dy)) )

(dm perimeter> ()
   (* 2 (+ (: dx) (: dy))) )

(dm draw> ()
   (drawRect (: x) (: y) (: dx) (: dy)) ) # Hypothetical function 'drawRect'


# The Circle class
(class +Circle +Shape)
# r

(dm T (X Y R)
   (super X Y)
   (=: r R) )

(dm area> ()
   (*/ (: r) (: r) 31415927 10000000) )

(dm perimeter> ()
   (*/ 2 (: r) 31415927 10000000) )

(dm draw> ()
   (drawCircle (: x) (: y) (: r)) )       # Hypothetical function 'drawCircle'


# The Fixed prefix class
(class +Fixed)

(dm move> (DX DY))  # A do-nothing method

# ^^^^ original code fin

(setq R (new '(+Rectangle) 0 0 30 20))
(test 600 (area> R))
(test 100 (perimeter> R))
(test 5 (move> R 10 5))

(setq C (new '(+Circle) 10 10 30))
(test 2827 (area> C))
(test 188 (perimeter> C))
(test 15 (move> C 10 5))

(test (600 2827) (mapcar 'area> (list R C)))
(mapc
   '((Shape) (move> Shape 10 10))
   (list R C) )
(test 20 (get R 'x))
(test 30 (get C 'x))

(setq R (new '(+Fixed +Rectangle) 0 0 30 20))
(move> R 10 5)
(test 0 (get R 'x))

(off R C)

(msg 'oop-OK)
