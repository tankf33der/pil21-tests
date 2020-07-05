#include <stdlib.h>
#include <stdint.h>

void returnvoid(void) {
}

uint8_t returnbyte(void) {
    return 255;
}

int returnint(void) {
    return 1234567890;
}

int64_t returnlong(void) {
    return 1234567890123456789;
}

uint8_t * returnbytes(void) {
    static uint8_t r[10];
    for (size_t i = 0; i < 10; i++) {
        r[i] = i;
    }
    return r;
}

int * returnints(void) {
    static int r[10];
    for (size_t i = 0; i < 10; i++) {
        r[i] = 1234567890;
    }
    return r;
}

uint64_t * returnlongs(void) {
    static uint64_t r[10];
    for (size_t i = 0; i < 10; i++) {
        r[i] = 1234567890123456789;
    }
    return r;
}

struct S1 {
    int x;
    int y;
};

struct S1 * returnS1(void) {
    static struct S1 R;
    R.x = 123456789;
    R.y = 987654321;
    return &R;
}

struct S2 {
    int i;
    unsigned char c[4];
};

struct S2 * returnS2(void) {
    static struct S2 R;
    R.i = 7777;
    for (size_t i = 0; i < 4; i++) {
        R.c[i] = 7;
    }
    return &R;
}

struct S3 {
    int i;
    long c[4];
};

struct S3 * returnS3(void) {
    static struct S3 R;
    R.i = 7777;
    for (size_t i = 0; i < 4; i++) {
        R.c[i] = 7;
    }
    return &R;
}
