
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
adventof2017: f18-2
```

```
add permrep.l (coroutine)
```

```
add flood tests
```

```
add md5 and adventofcode2015 after @lib/math, sinus
```
