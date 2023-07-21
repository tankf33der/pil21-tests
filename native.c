#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <inttypes.h>

#define UNUSED(x) (void)(x)


// testing return
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

int64_t * return64(void) {
    static int64_t r = 1594802526;
    return &r;
}

uint8_t * returnbytes(void) {
    static uint8_t r[10];
    size_t i;
    for (i = 0; i < 10; i++) {
        r[i] = i;
    }
    return r;
}

int * returnints(void) {
    static int r[10];
    size_t i;
    for (i = 0; i < 10; i++) {
        r[i] = 1234567890;
    }
    return r;
}

uint64_t * returnlongs(void) {
    static uint64_t r[10];
    size_t i;
    for (i = 0; i < 10; i++) {
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
    size_t i;
    for (i = 0; i < 4; i++) {
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
    size_t i;
    for (i = 0; i < 4; i++) {
        R.c[i] = 7;
    }
    return &R;
}


double returndouble(void) {
    static double r = 123.455;
    return r;
}

float returnfloat(void) {
    static float r = 123.455;
    return r;
}

char * returnstr(void) {
    static char *r = "mikeiscool";
    return r;
}

// testing arguments
char * argB(uint8_t n) {
    static char r[128];
    sprintf(r, "%d", n);
    return r;
}

char * argI(int n) {
    static char r[128];
    sprintf(r, "%d", n);
    return r;
}

char * argN(uint64_t n) {
    static char r[128];
    sprintf(r, "%" PRIu64, n);
    return r;
}

char * argLB (const uint8_t *x, size_t size) {
    static char r[BUFSIZ];
    size_t n = 0;
    size_t i;

    for(i = 0; i < size; i++)
        n += sprintf(r+n, "%d", x[i]);
    return r;
}

struct argSS {
    int i;
};

void argS (const struct argSS *x) {
    UNUSED(x);
}

struct arg1s {
    uint8_t  u8;
    uint32_t u32;
    uint64_t u64;
};

char *arg1(const struct arg1s *s) {
    static char r[BUFSIZ];

    memset(r, 0, BUFSIZ);
    sprintf(r, "%" PRIu8 "%" PRIu32 "%" PRIu64, s->u8, s->u32, s->u64);
    return r;
}

struct arg2s {
    uint32_t u32;
    uint8_t   u8;
    uint64_t u64;
};

char *arg2(const struct arg2s *s) {
    static char r[BUFSIZ];

    memset(r, 0, BUFSIZ);
    sprintf(r, "%" PRIu32 "%" PRIu8 "%" PRIu64, s->u32, s->u8, s->u64);
    return r;
}

struct arg3s {
    uint32_t u32;
    uint64_t u64;
    uint8_t  u8;
};

char *arg3(const struct arg3s *s) {
    static char r[BUFSIZ];

    memset(r, 0, BUFSIZ);
    sprintf(r, "%" PRIu32 "%" PRIu64 "%" PRIu8, s->u32, s->u64, s->u8);
    return r;
}

typedef struct  {
	uint32_t algorithm;  // Argon2d, Argon2i, Argon2id
	uint32_t nb_blocks;  // memory hardness, >= 8 * nb_lanes
	uint32_t nb_passes;  // CPU hardness, >= 1 (>= 3 recommended for Argon2i)
	uint32_t nb_lanes;   // parallelism level (single threaded anyway)
} crypto_argon2_config;

typedef struct {
	const uint8_t *pass;
	const uint8_t *salt;
	uint32_t pass_size;
	uint32_t salt_size;  // 16 bytes recommended
} crypto_argon2_inputs;

typedef struct {
	const uint8_t *key; // may be NULL if no key
	const uint8_t *ad;  // may be NULL if no additional data
	uint32_t key_size;  // 0 if no key (32 bytes recommended otherwise)
	uint32_t ad_size;   // 0 if no additional data
} crypto_argon2_extras;

int mono(crypto_argon2_config *config) {
	printf("%d -> algo\n", config->algorithm);
	return 123;
}

int main(void) {
    struct arg3s s;
    s.u8  = 123;
    s.u32 = 1234567;
    s.u64 = 1234567890123456789;
    printf("%lu\n", sizeof(s));
    printf("%p,%p,%p\n", &s.u32, &s.u64, &s.u8);
    printf("%s\n", arg3(&s));

    return 0;
}
