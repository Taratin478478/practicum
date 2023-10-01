#include <stdio.h>

enum
{
    MY_MAX_INT = (int) (((unsigned) ~0) >> -(~0)),
    MY_MIN_INT = ~MY_MAX_INT
};

int
satsum(int v1, int v2)
{
    if (v1 > 0 && MY_MAX_INT - v1 < v2) {
        return MY_MAX_INT;
    } else if (v1 < 0 && MY_MIN_INT - v1 > v2) {
        return MY_MIN_INT;
    } else {
        return v1 + v2;
    }
}