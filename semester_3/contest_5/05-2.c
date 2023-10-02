#include <stdio.h>
#include <string.h>

const char *TEMPLATE = "rwxrwxrwx";

int
main(int argc, char **argv)
{
    unsigned int i, j, rights, mask, len = strlen(TEMPLATE);
    char res[len + 1];
    for (i = 1; i < argc; i++) {
        if (sscanf(argv[i], "%o", &rights)) {
            strcpy(res, TEMPLATE);
            mask = 1 << (len - 1);
            for (j = 0; j < len; j++) {
                if (!(rights & mask)) {
                    res[j] = '-';
                }
                mask >>= 1;
            }
        }
        printf("%s\n", res);
    }
    return 0;
}
