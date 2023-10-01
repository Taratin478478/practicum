#include <stdio.h>
#include <stdlib.h>

int
main(int argc, char **argv)
{
    long long positive_sum = 0, negative_sum = 0, cur_number;
    for (int i = 1; i < argc; i++) {
        if (sscanf(argv[i], "%lld", &cur_number) != 1) {
            fprintf(stderr, "unable to convert input to int\n");
            exit(1);
        }
        if (cur_number >= 0) {
            positive_sum += cur_number;
        } else {
            negative_sum += cur_number;
        }
    }
    printf("%lld\n%lld\n", positive_sum, negative_sum);
    return 0;
}