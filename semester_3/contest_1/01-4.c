#include <stdlib.h>

int
comp_even(const void *arg1, const void *arg2)
{
    int a = *(int *) arg1;
    int b = *(int *) arg2;
    if (a > b) {
        return 1;
    } else if (a == b) {
        return 0;
    } else {
        return -1;
    }
}

int
comp_odd(const void *arg1, const void *arg2)
{
    int a = *(int *) arg1;
    int b = *(int *) arg2;
    if (a > b) {
        return -1;
    } else if (a == b) {
        return 0;
    } else {
        return 1;
    }
}


void
sort_even_odd(size_t count, int *data)
{
    if (count <= 0) {
        return;
    }
    size_t left = 0, right = count - 1;
    int temp;
    while (left < right) {
        if (data[left] % 2 != 0) {
            temp = data[left];
            data[left] = data[right];
            data[right] = temp;
            right--;
        } else {
            left++;
        }
    }
    while (left < count && data[left] % 2 == 0) {
        left++;
    }
    qsort(data, left, sizeof(int), comp_even);
    qsort(data + left, count - left, sizeof(int), comp_odd);
}