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

```
# make
opt -O3   -o base.bc base.ll
clang -fsanitize=memory -c -O3 -D_OS='"Linux"' -D_CPU='"x86_64"' `pkg-config --cflags libffi` -emit-llvm lib.c
llvm-link -o picolisp.bc base.bc lib.bc
mkdir -p ../bin ../lib
llc picolisp.bc -relocation-model=pic -o picolisp.s
clang -fsanitize=memory picolisp.s -o ../bin/picolisp -rdynamic -lc -lm -ldl -lffi -lreadline
../pil lib/llvm.l ext.l -bye > ext.ll
Uninitialized bytes in __interceptor_write at offset 0 inside [0x72100000140c, 4096)
==1468==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x4c67b4 in _putStdout (/root/pil21/bin/picolisp+0x4c67b4)
    #1 0x4d4961 in prin (/root/pil21/bin/picolisp+0x4d4961)
    #2 0x4af307 in _prinl (/root/pil21/bin/picolisp+0x4af307)
    #3 0x4b9136 in _with (/root/pil21/bin/picolisp+0x4b9136)
    #4 0x4b921a in _bind (/root/pil21/bin/picolisp+0x4b921a)
    #5 0x4cd118 in evExpr (/root/pil21/bin/picolisp+0x4cd118)
    #6 0x4cd118 in evExpr (/root/pil21/bin/picolisp+0x4cd118)
    #7 0x4c85bb in repl (/root/pil21/bin/picolisp+0x4c85bb)
    #8 0x4affda in _load (/root/pil21/bin/picolisp+0x4affda)
    #9 0x4b3dd2 in _pass (/root/pil21/bin/picolisp+0x4b3dd2)
    #10 0x4b9969 in _let (/root/pil21/bin/picolisp+0x4b9969)
    #11 0x4cd42f in evExpr (/root/pil21/bin/picolisp+0x4cd42f)
    #12 0x4c85bb in repl (/root/pil21/bin/picolisp+0x4c85bb)
    #13 0x4db407 in main (/root/pil21/bin/picolisp+0x4db407)
    #14 0x7f5f2a36ddea in __libc_start_main /builddir/glibc-2.30/csu/../csu/libc-start.c:308:16
    #15 0x42a519 in _start /builddir/glibc-2.30/csu/../sysdeps/x86_64/start.S:120

SUMMARY: MemorySanitizer: use-of-uninitialized-value (/root/pil21/bin/picolisp+0x4c67b4) in _putStdout
Exiting
make: *** [Makefile:52: ext.ll] Error 77

```
