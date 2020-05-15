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
(gc 256)
fibonacci coroutine generator
(gc 0)
```
