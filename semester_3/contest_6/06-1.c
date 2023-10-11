#include <stdio.h>
#include <dirent.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>

const char BACK_PATH[] = "..", ZERO_PATH[] = ".", SUFFIX[] = ".exe";

enum
{
    SUFFIX_LEN = sizeof(SUFFIX) - 1,
};

int
main(int argc, char **argv)
{
    if (argc < 2) {
        fprintf(stderr, "invalid input\n");
        exit(1);
    }
    DIR *dir = opendir(argv[1]);
    if (dir == NULL) {
        fprintf(stderr, "dir opening error\n");
        exit(1);
    }
    int res = 0, n_rw;
    struct dirent *de;
    while ((de = readdir(dir))) {
        if (strcmp(de->d_name, BACK_PATH) && strcmp(de->d_name, ZERO_PATH)) {
            struct stat buf;
            char path[PATH_MAX];
            n_rw = snprintf(path, sizeof(path), "%s/%s", argv[1], de->d_name);
            if (n_rw < 0 || n_rw >= sizeof(path)) {
                fprintf(stderr, "converting path to string error\n");
                exit(1);
            }
            int len = strlen(path);
            if (stat(path, &buf) != -1 && S_ISREG(buf.st_mode) && !access(path, X_OK) &&
                !strcmp(path + (len - SUFFIX_LEN), SUFFIX)) {
                res++;
            }
        }
    }
    if (closedir(dir) == -1) {
        fprintf(stderr, "dir closing error\n");
        exit(1);
    }
    printf("%d\n", res);
    return 0;
}
