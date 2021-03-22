all: n
	pil tests.l
m: n
	pil minima.l
n:
	gcc -std=c99 -fPIC -Wall -Wextra -c native.c -o native.o
	gcc -shared -Wl,-soname,native.so -o native.so native.o -lc
r: c n
	gcc native.c && ./a.out
c:
	rm -rf *.o *.so
b:
	pil bench.l +
