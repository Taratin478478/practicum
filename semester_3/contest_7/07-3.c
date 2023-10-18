#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>

const char BACK_PATH[] = "..", ZERO_PATH[] = ".";

enum
{
    DIR1_ARG = 1,
    DIR2_ARG = 2,
};

int
main(int argc, char **argv)
{
    char *path1 = argv[DIR1_ARG], *path2 = argv[DIR2_ARG];
    DIR *dir1 = opendir(path1);
    if (dir1 == NULL) {
        fprintf(stderr, "invalid dir1 name\n");
        exit(1);
    }
    struct dirent *de;
    int n_rw;
    struct stat buf1, buf2;
    char fpath1[PATH_MAX], fpath2[PATH_MAX];
    unsigned long long res = 0;
    while ((de = readdir(dir1))) {
        n_rw = snprintf(fpath1, sizeof(fpath1), "%s/%s", path1, de->d_name);
        if (n_rw < 0 || n_rw >= sizeof(fpath1)) {
            fprintf(stderr, "converting path to string error\n");
            exit(1);
        }
        n_rw = snprintf(fpath2, sizeof(fpath2), "%s/%s", path2, de->d_name);
        if (n_rw < 0 || n_rw >= sizeof(fpath2)) {
            fprintf(stderr, "converting path to string error\n");
            exit(1);
        }
        if (lstat(fpath1, &buf1) != -1 && S_ISREG(buf1.st_mode) && !S_ISLNK(buf1.st_mode) && !access(fpath1, W_OK)) {
            if (stat(fpath2, &buf2) != -1 && buf1.st_ino == buf2.st_ino && buf1.st_dev == buf2.st_dev) {
                res += buf1.st_size;
            }
        }
    }
    printf("%llu\n", res);
    return 0;
}