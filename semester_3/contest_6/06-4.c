#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

const char BACK_PATH[] = "..", ZERO_PATH[] = ".";

enum
{
    MAX_DEPTH = 4,
    ARG_N = 3,
    D_ARG = 1,
    Z_ARG = 2,
};

void
rec_print_dir(char *dir_name, char *rel_path, size_t rel_path_len, size_t max_size, int depth)
{
    if (depth > MAX_DEPTH) {
        return;
    }
    DIR *dir = opendir(dir_name);
    if (dir == NULL) {
        return;
    }
    struct dirent *de;
    size_t new_dir_name_len;
    int n_rw, first;
    while ((de = readdir(dir))) {
        if (strcmp(de->d_name, BACK_PATH) && strcmp(de->d_name, ZERO_PATH)) {
            struct stat buf;
            char path[PATH_MAX];
            n_rw = snprintf(path, sizeof(path), "%s/%s", dir_name, de->d_name);
            if (n_rw < 0 || n_rw >= sizeof(path)) {
                fprintf(stderr, "converting path to string error\n");
                exit(1);
            }
            if (lstat(path, &buf) != -1) {
                if (!S_ISLNK(buf.st_mode) && S_ISREG(buf.st_mode) && buf.st_size <= max_size && !access(path, R_OK)) {
                    if (depth == 1) {
                        printf("%s\n", de->d_name);
                    } else {
                        printf("%s/%s\n", rel_path, de->d_name);
                    }
                } else if (S_ISDIR(buf.st_mode)) {
                    first = (depth == 1);
                    if (!first) {
                        rel_path[rel_path_len] = '/';
                    }
                    new_dir_name_len = strlen(de->d_name);
                    strcpy(rel_path + (rel_path_len + !first), de->d_name);
                    rec_print_dir(path, rel_path, rel_path_len + new_dir_name_len + !first, max_size, depth + 1);
                    rel_path[rel_path_len] = 0;
                }
            }
        }
    }
    if (closedir(dir) == -1) {
        fprintf(stderr, "dir closing error\n");
        exit(1);
    }
}

int
main(int argc, char **argv)
{
    if (argc != ARG_N) {
        fprintf(stderr, "wrong argument number\n");
        exit(0);
    }
    size_t z;
    if (sscanf(argv[Z_ARG], "%zu", &z) != 1) {
        fprintf(stderr, "invalid max len number z: %s\n", argv[Z_ARG]);
        exit(0);
    }
    char rel_path[PATH_MAX + 1] = "";
    rec_print_dir(argv[D_ARG], rel_path, 0, z, 1);
    return 0;
}