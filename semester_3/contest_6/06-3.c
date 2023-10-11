#include <string.h>

struct s1
{
    char f1;
    long long f2;
    char f3;
};

struct s2
{
    long long f2;
    char f1;
    char f3;
};

enum
{
    S1_SIZE = sizeof(struct s1),
    S2_SIZE = sizeof(struct s2),
};

size_t
compactify(void *ptr, size_t size)
{
    if (size == 0) {
        return 0;
    }
    struct s1 temp1;
    struct s2 temp2;
    void *newptr = ptr;
    size_t i, res = 0;
    for (i = 0; i < size; i += S1_SIZE) {
        memcpy(&temp1, ptr, S1_SIZE);
        temp2.f1 = temp1.f1;
        temp2.f2 = temp1.f2;
        temp2.f3 = temp1.f3;
        memcpy(newptr, &temp2, S2_SIZE);
        ptr += S1_SIZE;
        newptr += S2_SIZE;
        res += S2_SIZE;
    }
    return res;
}
