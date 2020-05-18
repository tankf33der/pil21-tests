Requirements to this file and repo are:
* Raw list of appended found and not fixed yet issue(s), file should be empty
* find . -name "*.l" | xargs grep -ci "xxx" - should returns all zeroes

```
# hang, looks like the same issue or very close
: (test '((1)) '((1)))
$ pil
: (match '(1 (2) 3) '(1 (2) 3))
# ^^^ hang

$ pil
: (test T (match '(@X (d @Y) @Z) '((a b c) (d (e f) g)h i)))
-> NIL
: (test T (match '(@X (d @Y) @Z) '((a b c) (d (e f) g)h i)))
# XXX, hang

$ pil
: (match '(@X (d @Y) @Z) '((a b c) (d (e f) g) h i))
-> T
: (match '(@X (d @Y) @Z) '((a b c) (d (e f) g) h i))
# hang
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
# failed
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
# wrong
: (need 3 0)
-> (NIL NIL NIL)
```

```
# wrong
: (memq 'c '(a b . c)))
-> NIL
```

```
# hang
(memq 'd '(a b c .))
```

```
# wrong result
: (fill (1 ^ (list 'a 'b 'c) 9))
-> (1 c 9)
```

```
# test failed
(let X 2 (test (1 2 3) (fill (1 X 3) 'X)))
```

```
# bug
(setq X (box))
(name X "xxx")
(test "xxx" (name X))
```

```
(glue NIL 1)
should 1
```

```
(off X)
(fifo 'X 1)
(fifo 'X 2 3) -> returns 2, should 3
// inserted wrongly
ok
fetch will not work
(fifo 'X) -> 1 - ok
(fifo 'X) -> 2 - ok
(fifo 'X) -> 1 - not ok
so.
if call fifo with *one* arguments it would insert and fetch in correct order
```
