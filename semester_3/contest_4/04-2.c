#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

int
main(int argc, char **argv)
{
    if (argc < 3) {
        fprintf(stderr, "not enough command line arguments");
        exit(1);
    }
    char *fn = argv[1];
    int n;
    if (sscanf(argv[2], "%d", &n) != 1) {
        fprintf(stderr, "invalid input");
        exit(1);
    }
    if (n <= 1) {
        return 0;
    }
    int fd = open(fn, O_RDWR);
    if (fd == -1) {
        fprintf(stderr, "unable to open input file");
        exit(1);
    }
    double cur, prev;
    n--;
    read(fd, &prev, sizeof(prev));
    while (n && read(fd, &cur, sizeof(cur))) {
        lseek(fd, -((int) sizeof(cur)), SEEK_CUR);
        cur -= prev;
        write(fd, &cur, sizeof(cur));
        prev = cur;
        n--;
    }
    close(fd);
    return 0;
}