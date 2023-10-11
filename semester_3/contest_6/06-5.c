#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

const char BACK_PATH[] = "..", ZERO_PATH[] = ".";

ssize_t
getcwd2(int fd, char *buf, size_t size)
{
    char res[PATH_MAX + 1];
    size_t cur_pos = PATH_MAX, name_len, len = 0;
    DIR *start_dir = opendir(ZERO_PATH); // saving working dir
    if (start_dir == NULL) {
        return -1;
    }
    int start_fd = dirfd(start_dir);
    if (start_fd == -1) {
        return -1;
    }
    if (fchdir(fd) == -1) {
        return -1;
    }
    struct stat cur_stat, new_stat;
    struct dirent *de;
    DIR *cur_dir;
    int i = 0;
    if (fstat(fd, &cur_stat) == -1) {
        return -1;
    }
    while (1) {
        if (chdir(BACK_PATH) == -1) {
            return -1;
        }
        cur_dir = opendir(ZERO_PATH);
        if (cur_dir == NULL) {
            return -1;
        }
        errno = 0;
        while ((de = readdir(cur_dir))) { // searching for prev dir to get the name
            if (errno == EACCES) {
                continue;
            } else if (errno) {
                return -1;
            }
            fd = open(de->d_name, O_RDONLY);
            if (errno == EACCES) {
                continue;
            }
            if (fd == -1) {
                return -1;
            }
            if (fstat(fd, &new_stat) == -1) {
                return -1;
            }
            if (close(fd) == -1) {
                return -1;
            }
            if (S_ISDIR(new_stat.st_mode) && new_stat.st_ino == cur_stat.st_ino &&
                strcmp(de->d_name, ZERO_PATH) && new_stat.st_dev == cur_stat.st_dev) {
                if (!strcmp(de->d_name, BACK_PATH)) { // it means we are in root dir
                    if (closedir(cur_dir) == -1) {
                        return -1;
                    }
                    if (fchdir(start_fd) == -1) {
                        return -1;
                    }
                    if (closedir(start_dir) == -1) {
                        return -1;
                    }
                    if (!size) {
                        return (ssize_t) len;
                    }
                    size_t res_size = len < size ? len : size - 1;
                    if (res[0] == 0 && size > 1) {
                        buf[0] = '/';
                        buf[1] = 0;
                        return 1;
                    }
                    if (memmove(buf, &res[cur_pos], res_size) == NULL) {
                        return -1;
                    }
                    buf[res_size] = 0;
                    return (ssize_t) len;
                }
                name_len = strlen(de->d_name);
                cur_pos -= name_len;
                if (strcpy(&res[cur_pos], de->d_name) == NULL) {
                    return -1;
                }
                if (i != 0) {
                    res[cur_pos + name_len] = '/';
                }
                cur_pos--;
                len += name_len + 1;
                res[cur_pos] = '/';
                break;
            }
        }
        fd = dirfd(cur_dir);
        if (fd == -1) {
            return -1;
        }
        if (fstat(fd, &cur_stat) == -1) {
            return -1;
        }
        if (closedir(cur_dir) == -1) {
            return -1;
        }
        errno = 0;
        i++;
    }
}

int
main(int argc, char **argv)
{
    char res[PATH_MAX];
    size_t size = 2;
    DIR *dir = opendir("/");
    struct stat st;
    int tfd = open(ZERO_PATH, O_RDONLY);
    fstat(tfd, &st);
    int fd = dirfd(dir);
    struct stat cur_stat;
    fstat(fd, &cur_stat);
    int n = getcwd2(fd, res, size);
    printf("%s\n", res);
    tfd = open(ZERO_PATH, O_RDONLY);
    fstat(tfd, &st);
    return 0;
}
