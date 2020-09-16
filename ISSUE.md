Requirements to this file and repo are:
Requirements to this file and repo are:
* TODO
* Raw list of appended found and not fixed yet issue(s), file should be empty
* find . -name "*.l" | xargs grep -ci "xxx" - should returns all zeroes

```
# ???
# Second argument to 'name' (i.e. renaming) is removed
(setq X (box))
(name X "xxx")
(test "xxx" (name X))
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
add atomic.l task (requires DB)
```

```
add and readline via pkg-config, otherwise failed on FreeBSD 12
```

```
add flood tests
```

```
1244
1245
!? ((N) (recurse (println (inc N))))
Stack overflow
? (stack)
-> (a T . 64)
?
:
```

```
# pil21 +
: (load "mapping.l")
mapping-OK
-> mapping-OK
: (stack0
   )
!? (stack0)
stack0 -- Undefined
? (stack)
-> 64
? (load "minima.l")
pi-OK
cartesian-OK
Segmentation fault
```
