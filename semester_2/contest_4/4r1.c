#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int main(void) {
    unsigned int n, r = 1, i;
    scanf("%u", &n);
    for (i = 0; i < n; ++i) {
        r *= 3;
    }
    printf("%u", r);
    return 0;
}