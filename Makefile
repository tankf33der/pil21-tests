all: native
	pil21 tests.l
native: native.c
	gcc -fPIC -c native.c -o native.o
	gcc -shared -Wl,-soname,native.so -o native.so native.o -lc
