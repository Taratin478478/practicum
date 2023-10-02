#include <string.h>

const char TEMPLATE[] = "rwxrwxrwx";

enum
{
    TEMP_LEN = sizeof(TEMPLATE) - 1,
};

int
parse_rwx_permissions(const char *str)
{
    if (str == NULL || strlen(str) != TEMP_LEN) {
        return -1;
    }
    int i, res = 0;
    for (i = 0; i < TEMP_LEN; i++) {
        res <<= 1;
        if (str[i] == TEMPLATE[i]) {
            res |= 1;
        } else if (str[i] != '-') {
            return -1;
        }
    }
    return res;
}