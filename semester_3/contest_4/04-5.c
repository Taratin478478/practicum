#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <limits.h>
#include <errno.h>

enum
{
    INPUT_FILE_ARG_POS = 1,
    OUTPUT_FILE_ARG_POS = 2,
    MOD_ARG_POS = 3,
    ARG_NUM = 4,
};

void
write_int(int fd, int n)
{
    if (write(fd, &n, sizeof(n)) == -1) {
        fprintf(stderr, "file writing error\n");
        exit(1);
    }
}

int
main(int argc, char **argv)
{
    if (argc < ARG_NUM) {
        fprintf(stderr, "not enough command line arguments\n");
        exit(0);
    }
    int in = open(argv[INPUT_FILE_ARG_POS], O_RDONLY);
    if (in == -1) {
        fprintf(stderr, "unable to open input file: %s\n", argv[INPUT_FILE_ARG_POS]);
        exit(0);
    }
    int out = open(argv[OUTPUT_FILE_ARG_POS], O_WRONLY | O_CREAT | O_TRUNC, 0700);
    if (out == -1) {
        fprintf(stderr, "unable to open output file: %s\n", argv[OUTPUT_FILE_ARG_POS]);
        exit(0);
    }
    int mod;
    if (sscanf(argv[MOD_ARG_POS], "%d", &mod) == 0) {
        fprintf(stderr, "unable to convert to int: %s\n", argv[MOD_ARG_POS]);
        exit(0);
    }
    ssize_t n_rw;
    unsigned char buf;
    long long square_sum = 0, n = 1, i;
    while ((n_rw = read(in, &buf, sizeof(buf)))) {
        if (n_rw == -1) {
            fprintf(stderr, "file reading error\n");
            exit(errno);
        }
        for (i = 0; i < CHAR_BIT; ++i) {
            square_sum += n * n;
            square_sum %= mod;
            if (buf & 1) {
                write_int(out, (int) square_sum);
            }
            buf >>= 1;
            n++;
        }
    }
    if (close(in) == -1) {
        fprintf(stderr, "file closing error\n");
        exit(errno);
    }
    if (close(out) == -1) {
        fprintf(stderr, "file closing error\n");
        exit(errno);
    }
    return 0;
}
