#include <stdio.h>
#include <limits.h>

enum
{
    BASE = 3,
};

int
main(void)
{
    int c, valid = 1, queued = 0;
    long long n = 0, d;
    while ((c = getchar()) != EOF) {
        switch (c) {
        case 'a':
            d = -1;
            break;
        case '0':
            d = 0;
            break;
        case '1':
            d = 1;
            break;
        default: // space symbols
            if (!valid) {
                n = 0;
                valid = 1;
            }
            if (queued) {
                printf("%lld\n", n);
                n = 0;
                queued = 0;
            }
            continue;
        }
        if (valid) {
            if (n <= (LLONG_MAX - BASE - d) / BASE + 1 && n >= (LLONG_MIN + BASE - d) / BASE - 1) {
                n = d + n + n + n;
                queued = 1;
            } else {
                printf("18446744073709551616\n");
                valid = 0;
                queued = 0;
            }
        }
    }
    if (queued) {
        printf("%lld\n", n);
    }
    return 0;
}
