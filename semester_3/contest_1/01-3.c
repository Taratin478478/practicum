#include <stdlib.h>
#include <stdio.h>

int
mod_pow(int num, int pow, int mod)
{
    int res = 1;
    while (pow > 0) {
        if (pow % 2) {
            res = res * num % mod;
        }
        num = num * num % mod;
        pow /= 2;
    }
    return res;
}

int
main(void)
{
    int mod, i, j, *inverses;
    scanf("%d", &mod);
    inverses = calloc(mod, sizeof(int));
    for (i = 0; i < mod; i++) {
        inverses[i] = mod_pow(i, mod - 2, mod);
    }
    for (i = 0; i < mod; i++) {
        for (j = 1; j < mod; j++) {
            printf("%d ", i * inverses[j] % mod);
        }
        printf("\n");
    }
    free(inverses);
    return 0;
}