#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int main(void) {
    unsigned int n, d;
    scanf("%u", &n);
    for (d = 1;d * 2 != 0 && !(n % (d * 2)); d *= 2);
    printf("%u", d);
    return 0;
}