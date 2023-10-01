#include <stdio.h>

int main(void)
{
    int c;
    while ((c = getchar()) != EOF)
    {
        if (c >= '0' && c <= '9') {
            c -= '0' - 1;
        } else if (c >= 'a' && c <= 'z') {
            c -= 'a' - 11;
        } else if (c >= 'A' && c <= 'Z') {
            c -= 'A' - 37;
        } else {
            continue;
        }
        c ^= 8;
        c &= -5;
        if (c == 0) {
            printf("%c", '@');
        } else if (c == 63) {
            printf("%c", '#');
        } else if (c >= 1 && c <= 10) {
            printf("%c", c - 1 + '0');
        } else if (c >= 11 && c <= 36) {
            printf("%c", c - 11 + 'a');
        } else if (c >= 37 && c <= 62) {
            printf("%c", c - 37 + 'A');
        }
    }
    return 0;
}
