#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <limits.h>
#include <stdint.h>
#include <inttypes.h>

struct Node
{
    int32_t key;
    int32_t left_idx;
    int32_t right_idx;
};

int
read_by_byte(int fd)
{
    int i;
    uint32_t buf, num = 0;
    for (i = 0; i < sizeof(buf); ++i) {
        buf = 0;
        if (read(fd, &buf, sizeof(char)) == -1) {
            fprintf(stderr, "file reading error\n");
            exit(1);
        }
        num <<= CHAR_BIT;
        num |= buf;
    }
    return (int32_t) num;
}

void
print_tree(int fd)
{
    int32_t key, left_idx, right_idx;
    key = read_by_byte(fd);
    left_idx = read_by_byte(fd);
    right_idx = read_by_byte(fd);
    if (right_idx) {
        __off_t n_rw = lseek(fd, (__off_t) (right_idx * sizeof(struct Node)), SEEK_SET);
        if (n_rw == -1) {
            fprintf(stderr, "lseek error\n");
            exit(1);
        }
        print_tree(fd);
    }
    printf("%" PRId32 "\n", key);
    if (left_idx) {
        __off_t n_rw = lseek(fd, (__off_t) (left_idx * sizeof(struct Node)), SEEK_SET);
        if (n_rw == -1) {
            fprintf(stderr, "lseek error\n");
            exit(1);
        }
        print_tree(fd);
    }
}

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
        fprintf(stderr, "unable to open input file: %s\n", fn);
        exit(1);
    }
    print_tree(fd);
    if (close(fd) == -1) {
        fprintf(stderr, "file closing error\n");
        exit(1);
    }
    return 0;
}
