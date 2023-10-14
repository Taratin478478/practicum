#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int main(void) {
    unsigned int n, k, r = 1, d = 2;
    scanf("%u", &n);
    scanf("%u", &k);
    if (k == 0) {
        printf("1");
        return 0;
    }
    r = n--;
    for (;d <= k; d++, n--) {
        r *= n;
        r /= d;
    }

    printf("%u", r);
    return 0;
}