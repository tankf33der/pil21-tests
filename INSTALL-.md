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
$ clang -D_OS='"Macos"' -D_CPU='"x86-64"' sysdefs.c && ./a.out > ../lib/sysdefs
$ ../pil
: (version)
21.0.0
-> (21 0 0)
: (bye)
$
```

### Solaris 11.4 (>= SRU 24, SPARC)
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
$ opt -O3   -o ext.bc ext.ll
$ llc ext.bc -relocation-model=pic -o ext.s
$ clang ext.s -o ../lib/ext.so -shared
$ opt -O3   -o ht.bc ht.ll
$ llc ht.bc -relocation-model=pic -o ht.s
$ clang ht.s -o ../lib/ht.so -shared
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

### FreeBSD 13.2 (x86_64)
```
: add -L/usr/local/lib to MAIN in Makefile
: compile
: pil @lib/test.l +
OK
:
```

### FreeBSD 14 (x86_64)
```
: add clang15 as CC
: add -L/usr/local/lib to MAIN in Makefile
: compile
: pil @lib/test.l +
OK
:
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

### OpenBSD 7.3 (x86_64)
```
## install OS, let it be user root
# syspatch -l
# reboot
# pkg_add vim git wget llvm gmake libffi
# wget https://ftp.gnu.org/gnu/readline/readline-8.2.tar.gz
# tar zxf readline-8.2.tar.gz
# cd readline-8.2
# ./configure && make && make install
# cd
# git clone https://github.com/picolisp/pil21
# export PATH=$PATH:/root/pil21
# cd pil21/src
# touch *.ll
# apply patch
===
--- Makefile    Tue Aug  8 12:43:19 2023
+++ Makefile.openbsd    Tue Aug  8 12:44:25 2023
@@ -1,13 +1,12 @@
 # 28jul23 Software Lab. Alexander Burger

-.SILENT:

 CC = clang
 PIL = ../pil  # pil
 ASM = opt -O3  # llvm-as
 LLC = llc
 LINK = llvm-link
-MAIN = -rdynamic -lc -lutil -lm -ldl -lreadline -lffi
+MAIN = -rdynamic -lc -lutil -lm -lreadline -lffi -L/usr/local/lib  -lncursesw
 SHARED = -shared
 STRIP = strip
===
# gmake
# pil +
: (version)
23.7.28
-> (23 7 28)
: (call 'uname '-a)
OpenBSD openbsd.localdomain 7.3 GENERIC#1072 amd64
-> T
: (** 2 222)
-> 6739986666787659948666753771754907668409286105635143120275902562304
: (bye)
#

FAILS:

((let P (port 0 "ListenPort") (unless (fork) (close P) (until (connect "localhost" "ListenPort") (wait 80)) (out @ (pr '(a b c))) (bye)) (prog1 (in (listen P) (rd)) (close P))))
[../test/src/net.l:4] (a b c) -- 'test' failed

HANG:

(test (3 . 4)
   (let (*Run NIL  *A NIL  *B NIL)
      (task -10 0 (setq *A 3))
      (task (port T 0 "TaskPort") (eval (udp @)))
      (udp "localhost" "TaskPort" '(setq *B 4))
      (wait NIL (and *A *B))
      (cons *A *B) ) )
```
