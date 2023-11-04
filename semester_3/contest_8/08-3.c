#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <fcntl.h>
#include <unistd.h>

int
main(int argc, char **argv)
{
    int fd = open(argv[1], O_RDWR), j;
    off_t len = lseek(fd, 0, SEEK_END), i;
    if (len <= 0) {
        return 0;
    }
    unsigned char b1, b2, tmp, bit, mask;
    for (i = 0; i < len / 2; ++i) {
        lseek(fd, i, SEEK_SET);
        read(fd, &b1, sizeof(b1));
        mask = 1;
        tmp = 0;
        for (j = 0; j < CHAR_BIT; ++j) {
            bit = b1 && mask;
            bit >>= j;
            bit <<= (CHAR_BIT - j - 1);
            mask <<= 1;
            tmp |= bit;
        }
        lseek(fd, len - i - 1, SEEK_SET);
        read(fd, &b2, sizeof(b2));
        lseek(fd, -1, SEEK_CUR);
        write(fd, &tmp, sizeof(tmp));
        mask = 1;
        tmp = 0;
        for (j = 0; j < CHAR_BIT; ++j) {
            bit = b2 && mask;
            bit >>= j;
            bit <<= (CHAR_BIT - j - 1);
            mask <<= 1;
            tmp |= bit;
        }
        lseek(fd, i, SEEK_SET);
        write(fd, &tmp, sizeof(tmp));
    }
    if (len % 2 == 1) {
        lseek(fd, len / 2, SEEK_SET);
        mask = 1;
        tmp = 0;
        for (j = 0; j < CHAR_BIT; ++j) {
            bit = b2 && mask;
            bit >>= j;
            bit <<= (CHAR_BIT - j - 1);
            mask <<= 1;
            tmp |= bit;
        }
        lseek(fd, -1, SEEK_CUR);
        write(fd, &tmp, sizeof(tmp));
    }
    return 0;
}