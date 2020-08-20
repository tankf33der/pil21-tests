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
enable co.l in tests and minima.l
```
