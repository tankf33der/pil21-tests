all: n
	pil21 tests.l
m: n
	pil21 minima.l
n:
	gcc -fPIC -Wall -Wextra -c native.c -o native.o
	gcc -shared -Wl,-soname,native.so -o native.so native.o -lc
r: c n
	gcc native.c && ./a.out
c:
	rm -rf *.o *.so
b:
	pil21 bench.l +
