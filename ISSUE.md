Requirements to this file and repo are:
Requirements to this file and repo are:
* TODO
* Raw list of appended found and not fixed yet issue(s), file should be empty
* find . -name "*.l" | xargs grep -ci "xxx" - should returns all zeroes

```
# failed
(test '"foo>"
   (dm "foo>" (X Y)
      (* X (+ X Y)) ) )
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
# will fail test
(de w (N)
   (co (intern (pack 'i N))
      (let (N N  G)
         (setq G (yield))
         (cons N G) ) ) )
(w 1)
(test (1 . 2) (yield 2 'i1))

# Mike, when above will be fixed checkout this error and crash again:
#
$ pil21 tankf33der/co-ring.l
loop NIL Rnd 8 Got 10 C 1
[co-ring.l:30] !? (yield (inc 'Rnd Got) Send)
i71 -- Reentrant coroutine
? (bye)
Segmentation fault
```

```
# XXX
add coroutine ring(s) for testings
```

```
not equal to pil64 output
(in "data.txt"
    (while (line NIL 2 0)
        (println @) ) )
```

```
name dont support additional arguments
$ pil +
: (read "_" "#")
#3dddd
abc
-> abc

$ pil21 +
: (read "_" "#")
-> NIL
```

```
pythag coroutine code crash-hang in math.l
```

```
add tankf33der/cartesian.l (coroutine)
```

```
1.
(later)
2.
(prog1
   (mapcan '((N) (later (cons) (* N N))) (1 2 3 4))
      (wait NIL (full @)) )
3.
(key)
# press arrow up
```

```
add atomic.l task (requires DB)
```

```
add and readline via pkg-config, otherwise failed on FreeBSD 12
```

```
adventofcode: 2017, 2019: XXX, coroutines
```

```
add permrep.l (coroutine)
```

```
add flood tests
```

```
trail the same unwind non-implementation as coroutine
```

```
aug.2020, fails in gc+
#4.48
(de f4-48 (Lst)
   (let A (range (car Lst) (cadr Lst))
      (for (L (cddr Lst) L (cddr L))
         (setq A
            (sect A (range (car L) (cadr L))) ) )
      (and A (list (car A) (last A))) ) )
(test
   (12 15)
   (f4-48 '(2 15 10 20 12 25)) )

#4.91
(de f4-91 (L1 L2)
   (diff (fish atom L1) (fish atom L2)) )
(test
   '(a b)
   (f4-91 '(a b (c) d) '((c d) e)) )

#4.152, 4.177, 6.1, 18.3, 18.4
```
