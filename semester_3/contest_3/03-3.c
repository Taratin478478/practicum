#include <stdio.h>
#include <stdlib.h>
#include <math.h>

enum
{
    PRECISION_MULTIPLIER = 10000,
    FULL_PERCENT = 100
};

int
main(int argc, char **argv)
{
    if (argc <= 1) {
        fprintf(stderr, "not enough command line arguments\n");
        exit(1);
    }
    double currency, change;
    if (sscanf(argv[1], "%lf", &currency) != 1) {
        fprintf(stderr, "unable to convert input to double\n");
        exit(1);
    }
    currency *= PRECISION_MULTIPLIER;
    for (int i = 2; i < argc; i++) {
        if (sscanf(argv[i], "%lf", &change) != 1) {
            fprintf(stderr, "unable to convert input to double\n");
            exit(1);
        }
        currency *= 1.0 + change / FULL_PERCENT;
        currency = round(currency);
    }
    printf("%.4lf\n", currency / PRECISION_MULTIPLIER);
    return 0;
}