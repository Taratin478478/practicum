#include <sys/stat.h>
#include <stdio.h>

enum
{
    KIBIBYTE = 1024,
};

int
main(int argc, char **argv)
{
    int i;
    unsigned long long res = 0;
    struct stat buf;
    for (i = 1; i < argc; i++) {
        if (lstat(argv[i], &buf) != -1) {
            if (buf.st_size % KIBIBYTE == 0 && buf.st_nlink == 1) {
                if (S_ISREG(buf.st_mode) && !S_ISLNK(buf.st_mode)) {
                    res += buf.st_size;
                }
            }
        }
    }
    printf("%llu\n", res);
    return 0;
}
