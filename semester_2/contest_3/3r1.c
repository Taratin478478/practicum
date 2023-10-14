#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int main(void) {
    int n, f1 = 0, f2 = 1, f3;
    scanf("%d", &n);
    for (;n>0; --n) {
        f3 = f1 + f2;
        f1 = f2;
        f2 = f3;
    }
    printf("%d", f1);
    return 0;
}