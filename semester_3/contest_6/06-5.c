#include <stdio.h>
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
    int visited;
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
    ino_t prev_ino = 0;
    dev_t prev_dev = 0;
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
        visited = 0;
        while ((de = readdir(cur_dir))) { // searching for prev dir to get the name
            if (!strcmp(de->d_name, BACK_PATH)) {
                stat(de->d_name, &new_stat);
                prev_ino = new_stat.st_ino;
                prev_dev = new_stat.st_dev;
                visited++;
                if (visited == 2) {
                    break;
                } else {
                    continue;
                }
            }
            if (lstat(de->d_name, &new_stat) == -1) {
                return -1;
            }
            if (S_ISDIR(new_stat.st_mode) && new_stat.st_ino == cur_stat.st_ino && strcmp(de->d_name, ZERO_PATH) &&
                new_stat.st_dev == cur_stat.st_dev) {
                name_len = strlen(de->d_name);
                cur_pos -= name_len;
                memmove(&res[cur_pos], de->d_name, name_len);
                cur_pos--;
                len += name_len + 1;
                res[cur_pos] = '/';
                visited++;
                if (visited == 2) {
                    break;
                }
            }
        }
        if (cur_stat.st_ino == prev_ino && cur_stat.st_dev == prev_dev) { // it means we are in root dir
            if (closedir(cur_dir) == -1) {
                return -1;
            }
            if (fchdir(start_fd) == -1) {
                return -1;
            }
            if (closedir(start_dir) == -1) {
                return -1;
            }
            if (res[PATH_MAX - 1] == 0) {
                len = 1;
            }
            if (!size) {
                return (ssize_t) len;
            }
            if (res[PATH_MAX - 1] == 0 && size > 1) {
                buf[0] = '/';
                buf[1] = 0;
            } else {
                size_t res_size = len < size ? len : size - 1;
                buf[0] = 0;
                memmove(buf, &res[cur_pos], res_size);
                buf[res_size] = 0;
            }
            return (ssize_t) len;
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
        i++;
    }
}
