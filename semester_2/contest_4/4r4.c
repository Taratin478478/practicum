#include <stdio.h>
#include <stdlib.h>
#include <math.h>

unsigned hash(char *s) {
    int n;
    char r[4096];
    for (int i = 0; i < 256; ++i) {
        n = i;
        for (int j = 0; j < 8; ++j) {
            if (n == 1) {
                n = (n >> 1) ^ -306674912;
            } else {
                n >>= 1;
            }
        }
    }
}

int main(void) {
    char s[4096];
    scanf("%s", s);

    printf("%x", hash(s));
    return 0;
}