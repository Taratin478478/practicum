#include <stdlib.h>
#include <stdio.h>

void
print_perm(int n, int layer, int *available, char *buf)
{
    if (layer == n) {
        printf("%s\n", buf);
        return;
    }
    for (int i = 0; i < n; i++) {
        if (available[i]) {
            buf[layer] = (char) i + '1';
            available[i] = 0;
            print_perm(n, layer + 1, available, buf);
            available[i] = 1;
        }
    }
}

int
main(void)
{
    int i, n, *available;
    char *buf;
    scanf("%d", &n);
    available = calloc(n, sizeof(int));
    for (i = 0; i < n ; ++i) {
        available[i] = 1;
    }
    buf = calloc(n + 1, sizeof(char));
    buf[n] = 0;
    print_perm(n, 0, available, buf);
    free(available);
    free(buf);
    return 0;
}