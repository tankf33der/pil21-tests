all: n
	pil21 tests.l +
n:
	gcc -fPIC -Wall -Wextra -c native.c -o native.o
	gcc -shared -Wl,-soname,native.so -o native.so native.o -lc
r: c n
	gcc native.c && ./a.out
c:
	rm -rf *.o *.so
