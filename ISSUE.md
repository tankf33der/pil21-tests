Raw list of appended found and not fixed yet issue(s), should be empty.
```
# hang
: (test '((1)) '((1)))
```

```
: (setq A '(B))
-> (B)
: (put 'B 'a 123)
-> 123
: (meta 'A 'a)
-> NIL
   ^^^ should be 123
```

```
# eval
(let N 1
   ((quote (N)
      (test 1 (eval 'N 1)) )
      3 ) )
# and dipper too
(test 2 (eval 'N 1 '(X)))
```

```
# run cant change environment too
(let N 1
   ((quote (N)
      (test 2 (run '((+ N N)) 1)) )
      2 ) )

```

```
(test '"foo>"
   (dm "foo>" (X Y)
      (* X (+ X Y)) ) )
```

```
# finally, should not be NIL
(finally (prinl "Done!")
   (println 123)
   (quit)
   (println 456) )
```

```
# hangs
# fibonacci coroutine generator
(de coFibo ()
   (co 'fibo
      (let (A 0  B 1)
         (loop
            (yield
               (swap 'B (+ (swap 'A B) B)) ) ) ) ) )
# XXX
(prinl "start")
(setq L
   (make
      (do 100
         (link (coFibo)) ) ) )
(gc 0) # <- hang
```

```
: (need 3 0)
-> (NIL NIL NIL)
```

```
: (memq 'c '(a b . c)))
-> NIL
```

```
# hang
(memq 'd '(a b c .))
```

```
$ pil
: (test T (match '(@X (d @Y) @Z) '((a b c) (d (e f) g)h i)))
-> NIL
: (test T (match '(@X (d @Y) @Z) '((a b c) (d (e f) g)h i)))
# XXX, hang
```

```
: (fill (1 ^ (list 'a 'b 'c) 9))
-> (1 c 9)
```

```
(let X 2 (test (1 2 3) (fill (1 X 3) 'X)))
```
