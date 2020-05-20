Requirements to this file and repo are:
* Raw list of appended found and not fixed yet issue(s), file should be empty
* find . -name "*.l" | xargs grep -ci "xxx" - should returns all zeroes

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

XXX, it can be trigger easier way:
$ pil
(co 'd (cons))
(gc) <- hang
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
# ???
# Second argument to 'name' (i.e. renaming) is removed
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
if call fifo with *single* argument it would insert and fetch in correct order
```

```
# putl+get - wrong
(putl 'X '((123 . a) flg ("Hello" . b)))
(get 'X 'a) -> NIL
(getl 'X) -> NIL
```

```
putl can hang too
: (let (A (box) B (box A) C (cons (cons A B))) (putl C 0))
```


```
# if you replace println with test equal lists would fail testing
(de f (A B)
   (g (inc A) (dec B)) )
(de g (X Y)
    (trail T) )
(println
    '((f 3 4) A 3 B 4 (g (inc A) (dec B)) X 4 Y 3)
    (f 3 4) )
```

```
# crashes
(fully num? (cons 1 2))
(mapcar num? (cons 1 2))
```
