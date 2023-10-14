#include <stdio.h>

unsigned f(unsigned n) {
    return n ? (n & 1) + f(n >> 1) : 0;
}

int main(void) {
    unsigned a;
    scanf("%u", &a);
    printf("%u", 32 - f(a));
    return 0;
}

