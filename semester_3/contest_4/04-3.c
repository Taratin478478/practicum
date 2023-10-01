#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <limits.h>

int
main(int argc, char **argv)
{
    if (argc < 2) {
        fprintf(stderr, "not enough command line arguments\n");
        exit(1);
    }
    char *fn = argv[1];
    int fd = open(fn, O_RDWR);
    if (fd == -1) {
        fprintf(stderr, "unable to open input file\n");
        exit(1);
    }
    long long n, min;
    ssize_t n_rw;
    off_t min_offset = 0;
    if (read(fd, &min, sizeof(min)) != sizeof(min)) {
        return 0;
    }
    while ((n_rw = read(fd, &n, sizeof(n)))) {
        if (n_rw == -1) {
            fprintf(stderr, "file reading error\n");
            exit(1);
        }
        if (n < min) {
            min = n;
            min_offset = lseek(fd, 0, SEEK_CUR) - (off_t) sizeof(min);
        }
    }
    if (min != LLONG_MIN) {
        lseek(fd, min_offset, SEEK_SET);
        min = -min;
        if (write(fd, &min, sizeof(min)) == -1) {
            fprintf(stderr, "file writing error\n");
            exit(1);
        }
    }
    close(fd);
    return 0;
}