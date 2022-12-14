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

### FreeBSD 12.1 (x86_64)
TOOD: add and readline via pkg-config, otherwise failed on FreeBSD 12
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

Core was generated by `/root/pil21/bin/picolisp'.
Program terminated with signal SIGBUS, Bus error.
#0  0x0000000000219e51 in _open ()
(gdb) bt
#0  0x0000000000219e51 in _open ()
#1  0x000000080043fdde in __hash_open () from /lib/libc.so.7
#2  0x0000000800369281 in ?? () from /lib/libc.so.7
#3  0x00000008003690fe in cgetent () from /lib/libc.so.7
#4  0x0000000800756153 in _nc_read_termcap_entry () from /lib/libncursesw.so.8
#5  0x0000000800776eed in _nc_read_entry () from /lib/libncursesw.so.8
#6  0x00000008007733bc in _nc_setupterm () from /lib/libncursesw.so.8
#7  0x000000080074b35f in tgetent () from /lib/libncursesw.so.8
#8  0x00000008007091e0 in _rl_init_terminal_io ()
   from /usr/local/lib/libreadline.so.8
#9  0x00000008006ea2e4 in rl_initialize () from /usr/local/lib/libreadline.so.8
#10 0x00000008006ea19c in readline () from /usr/local/lib/libreadline.so.8
#11 0x0000000000231552 in _getStdin ()
#12 0x00000000002333e4 in repl ()
#13 0x0000000000245891 in main ()
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

### OpenBSD 6.8 (x86_64)
```
## install OS, let it be user root
# syspatch -l
# reboot
# pkg_add vim git wget llvm gmake libffi
# wget ftp://ftp.cwru.edu/pub/bash/readline-8.1.tar.gz
# tar zxf readline-8.1.tar.gz
# cd readline-8.1
# ./configure && make && make install
# cd
# git clone https://github.com/picolisp/pil21
# export PATH=$PATH:/root/pil21
# cd pil21/src
# touch *.ll
# apply patch
===
diff --git a/src/Makefile b/src/Makefile
index 80e69c3..fb709f1 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -2,10 +2,10 @@

 .SILENT:

-CC = clang
+CC = clang-10  # non local
 PIL = ../pil  # pil
 ASM = opt -O3  # llvm-as
-MAIN = -rdynamic -lc -lm -ldl -lreadline -lffi
+MAIN = -rdynamic -lc -lm -lreadline `pkg-config --libs libffi` -lncurses
 SHARED = -shared
 OS = $(shell uname)
 CPU = $(shell uname -m)
===
# gmake
# pil +
: (version)
21.3.10
-> (21 3 10)
: (call 'uname '-a)
OpenBSD otemp.localdomain 6.8 GENERIC#5 amd64
-> T
: (** 2 222)
-> 6739986666787659948666753771754907668409286105635143120275902562304
: (bye)
#
```
