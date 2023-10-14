#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int main(void) {
    unsigned int a, b, i, m1, m2, l = 1, mask[] = {0xffff, 0xff00ff, 0xf0f0f0f, 0x33333333, 0x55555555};
    scanf("%u", &a);
    for (i = 4; i < 100; --i) {
        m1 = mask[i];
        m2 = m1;
        m2 = ~m2;
        b = a;
        a = a & m1;
        b = b & m2;
        a = a << l;
        b = b >> l;
        a = a | b;
        l = l << 1;
    }
    printf("%u", a);

    return 0;
}