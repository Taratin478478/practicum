#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int
main(int argc, char **argv)
{
    unsigned b1 = 0, b2, i, perm[8];
    for (i = 0; i < CHAR_BIT; ++i) {
        sscanf(argv[i + 1], "%u", &perm[i]);
    }
    while (scanf("%u", &b1) == 1) {
        b2 = 0;
        for (i = 0; i < CHAR_BIT; ++i) {
            b2 |= (((b1 & (1 << perm[i])) >> perm[i]) << i);
        }
        printf("%u\n", b2);
    }
    return 0;
}