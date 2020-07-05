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
