#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int main(void) {
    unsigned int r = 4294967295, n;
    scanf("%u", &n);
    while (n != 0) {
        if (n < r) {
            r = n;
        }
        scanf("%u", &n);
    }
    printf("%u", r);
    return 0;
}