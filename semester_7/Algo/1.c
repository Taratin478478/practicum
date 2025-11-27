#include <stdio.h>

int main(void) {

    FILE *file = fopen("input.bin", "r");
    unsigned char buf[3];
    unsigned int answ;
    while ((fread(&buf, 1, 3, file) == 3)) {
        answ = (buf[0] << 24) | (buf[1] << 8) | buf[2];
        printf("%u ", answ);
    }

    fclose(file);
    return 0;
}