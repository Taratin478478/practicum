#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

enum
{
    ARGC = 2,
    FILENAME_ARGN = 1,
};

void
modify_bit(int fd, long long n, int value)
{
    unsigned char bit_buf;
    if (lseek(fd, (n - 1) / CHAR_BIT, SEEK_SET) == -1) {
        fprintf(stderr, "lseek error\n");
        exit(errno);
    }
    if (read(fd, &bit_buf, sizeof(bit_buf)) == -1) {
        fprintf(stderr, "read error\n");
        exit(errno);
    }
    if (value == 0) {
        bit_buf &= ~((unsigned char) (1 << ((n - 1) % CHAR_BIT)));
    } else if (value == 1) {
        bit_buf |= (unsigned char) (1 << ((n - 1) % CHAR_BIT));
    } else {
        fprintf(stderr, "invalid value\n");
        exit(1);
    }
    if (lseek(fd, -1, SEEK_CUR) == -1) {
        fprintf(stderr, "lseek error\n");
        exit(errno);
    }
    if (write(fd, &bit_buf, 1) == -1) {
        fprintf(stderr, "write error\n");
        exit(errno);
    }
}

int
main(int argc, char **argv)
{
    if (argc < ARGC) {
        fprintf(stderr, "not enough command line arguments");
        exit(1);
    }
    int fd = open(argv[FILENAME_ARGN], O_RDWR);
    if (fd == -1) {
        fprintf(stderr, "unable to open input file");
        exit(1);
    }
    long long n, len = lseek(fd, 0, SEEK_END) * CHAR_BIT;
    while (scanf("%lld", &n) == 1) {
        if (n > 0 && n <= len) {
            modify_bit(fd, n, 1);
        } else if (n < 0 && -n <= len) {
            modify_bit(fd, -n, 0);
        }
    }
    if (close(fd) == -1) {
        fprintf(stderr, "unable to close input file");
        exit(1);
    }
    return 0;
}
