### macOS 10.15
```
$ brew install llvm libffi ncurses readline
$ cd pil21/src
$ opt -O3 -o base.bc base.ll
$ clang -c -O3 -D_OS='"Macos"' -D_CPU='"x86-64"' -I/usr/local/opt/libffi/include -emit-llvm lib.c -I/usr/local/opt/readline/include
$ llvm-link -o picolisp.bc base.bc lib.bc
$ mkdir -p ../bin ../lib
$ llc picolisp.bc -o picolisp.s
$ clang picolisp.s -o ../bin/picolisp -lm -ldl -lffi -lreadline -lncurses -L/usr/local/opt/readline/lib
$ gcc sysdefs.c && ./a.out > ../lib/sysdefs
$ ../pil
: (version)
21.0.0
-> (21 0 0)
: (bye)
$
```

### Solaris 11.4 (SPARC)
```
$ pkg install readline libffi llvm
$ export PKG_CONFIG_PATH=/usr/lib/64/pkgconfig
## port lib.c
diff --git a/src/lib.c b/src/lib.c
index 60d460b..7df7bbd 100644
--- a/src/lib.c
+++ b/src/lib.c
@@ -91,7 +91,7 @@ int32_t nonBlocking(int32_t fd) {

 void fcntlSetOwn(int32_t fd, int32_t pid) {
    fcntl(fd, F_SETOWN, pid);
-   fcntlSetFl(fd, fcntl(fd, F_GETFL, 0) | O_NONBLOCK|O_ASYNC);
+   fcntlSetFl(fd, fcntl(fd, F_GETFL, 0) | O_NONBLOCK);
 }

 char *getDir(char *nm) {
##
$ opt -O3 -o base.bc base.ll
$ clang -c -O3 -D_OS='"Solaris"' -D_CPU='"Sparc"' `pkg-config --cflags libffi` -emit-llvm lib.c
$ llvm-link -o picolisp.bc base.bc lib.bc
$ mkdir -p ../bin ../lib
$ llc picolisp.bc -o picolisp.s
$ clang picolisp.s -o ../bin/picolisp -lc -lm -ldl -lffi -lreadline -lncursesw
$ gcc sysdefs.c && ./a.out > ../lib/sysdefs
$ ../pil
: *OS
-> "Solaris"
: *CPU
-> "Sparc"
: (version)
21.0.0
-> (21 0 0)
: (bye)
$
```

### FreeBSD 12.1 (x86_64)
```
install somehow readline, libffi, llvm
$ opt -O3 -o base.bc base.ll
# XXX, readline include issue
$ clang -c -O3 -D_OS='"FreeBSD"' -D_CPU='"x86"' `pkg-config --cflags libffi` -I/usr/local/include -emit-llvm lib.c
$ llvm-link -o picolisp.bc base.bc lib.bc
$ llc picolisp.bc -o picolisp.s
$ clang picolisp.s -o ../bin/picolisp -lc -lm -ldl `pkg-config --libs libffi` `pkg-config --libs readline`
$ ../bin/picolisp
Bus error (core dumped)
```

### NetBSD 9 (x86_64)
```
$ pkgin install clang llvm readline bla-bla-bla
$ llvm-as -o base.bc base.ll
$ clang -c -O3 -D_OS='"NetBSD"' -D_CPU='"x86"' `pkg-config --cflags libffi` -emit-llvm lib.c
$ llvm-link -o picolisp.bc base.bc lib.bc
$ llc picolisp.bc -o picolisp.s
$ clang picolisp.s -o ../bin/picolisp -lm -lc `pkg-config --libs libffi` -L/usr/pkg/lib -Wl,-R/usr/pkg/lib -lreadline
/usr/bin/ld: /tmp/picolisp-4d1655.o: in function `_throw':
llvm-link:(.text+0xeecc): undefined reference to `longjmp'
/usr/bin/ld: /tmp/picolisp-4d1655.o: in function `_co':
llvm-link:(.text+0xf120): undefined reference to `setjmp'
/usr/bin/ld: llvm-link:(.text+0xf143): undefined reference to `longjmp'
/usr/bin/ld: llvm-link:(.text+0xf14f): undefined reference to `setjmp'
/usr/bin/ld: llvm-link:(.text+0xf311): undefined reference to `longjmp'
/usr/bin/ld: /tmp/picolisp-4d1655.o: in function `_yield':
llvm-link:(.text+0xf5b9): undefined reference to `setjmp'
/usr/bin/ld: llvm-link:(.text+0xf7ab): undefined reference to `longjmp'
/usr/bin/ld: /tmp/picolisp-4d1655.o: in function `err':
llvm-link:(.text+0x18ad6): undefined reference to `longjmp'
/usr/bin/ld: llvm-link:(.text+0x18cb4): undefined reference to `longjmp'
/usr/bin/ld: /tmp/picolisp-4d1655.o: in function `main':
llvm-link:(.text+0x265c5): undefined reference to `setjmp'
/usr/bin/ld: /tmp/picolisp-4d1655.o: in function `boxFloat':

```
