all:
	pil21 tests.l
n:
	gcc -fPIC -Wall -Wextra -c native.c -o native.o
	gcc -shared -Wl,-soname,native.so -o native.so native.o -lc
c:
	rm -rf *.o *.so
