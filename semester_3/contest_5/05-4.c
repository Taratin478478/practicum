#include <stdio.h>
#include <string.h>
#include <sys/stat.h>

struct FILE_AND_NAME
{
    __ino_t inode;
    char *fn;
};

int
main(int argc, char **argv)
{
    unsigned int i, j, len = 0, is_new_file;
    struct FILE_AND_NAME files[argc];
    struct stat buf;
    for (i = 1; i < argc; i++) {
        if (stat(argv[i], &buf) == -1) {
            continue;
        }
        is_new_file = 1;
        for (j = 0; j < len; j++) {
            if (buf.st_ino == files[j].inode) {
                is_new_file = 0;
                if (strcmp(argv[i], files[j].fn) > 0) {
                    files[j].fn = argv[i];
                }
                break;
            }
        }
        if (is_new_file) {
            files[len].fn = argv[i];
            stat(argv[i], &buf);
            files[len].inode = buf.st_ino;
            len++;
        }
    }
    for (i = 0; i < len; ++i) {
        printf("%s\n", files[i].fn);
    }
    return 0;
}
