#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int main(void) {
    unsigned int n, i;
    int a, b, r = 0;
    scanf("%u", &n);
    if (n % 2) {
        printf("0");
        return 0;
    }
    n /= 2;
    for (i = 0; i < n; ++i) {
        scanf("%d %d", &a, &b);
        r += a * b;
    }

    printf("%d", r);

    return 0;
}