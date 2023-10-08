#include <string.h>
#include <malloc.h>
#include <stdlib.h>

const char BACK_PATH[] = "/..", BASE_PATH[] = ".", ZERO_PATH[] = "/.";

enum
{
    BACK_PATH_LEN = sizeof(BACK_PATH) - 1,
    ZERO_PATH_LEN = sizeof(ZERO_PATH) - 1,
};

char *
simplify_path(const char *path)
{
    char *res;
    if ((res = calloc(strlen(path) + 1, sizeof(char))) == 0) {
        fprintf(stderr, "calloc error\n");
        exit(1);
    }
    strcpy(res, path);
    int len = strlen(res), cur = 0, end;
    cur = 0;
    while (cur <= len - ZERO_PATH_LEN) {
        if (!memcmp(&res[cur], ZERO_PATH, ZERO_PATH_LEN) &&
            (res[cur + ZERO_PATH_LEN] == '/' || res[cur + ZERO_PATH_LEN] == 0)) {
            len -= ZERO_PATH_LEN;
            memmove(&res[cur], &res[cur + ZERO_PATH_LEN], len - cur + 1); // + 1 because of 0 at the end
        } else {
            cur++;
        }
    }
    cur = 0;
    while (cur <= len - BACK_PATH_LEN) {
        if (!memcmp(&res[cur], BACK_PATH, BACK_PATH_LEN) &&
            (res[cur + BACK_PATH_LEN] == '/' || res[cur + BACK_PATH_LEN] == 0)) {
            end = cur + BACK_PATH_LEN;
            if (cur > 0) {
                cur--;
                while (res[cur] != '/') {
                    cur--;
                }
            }
            len -= end - cur;
            memmove(&res[cur], &res[end], len - cur + 1); // + 1 because of 0 at the end
        } else {
            cur++;
        }
    }
    if (!strcmp(res, "/")) {
        res[0] = 0;
    }
    if ((res = realloc(res, strlen(res) + 1)) == 0) {
        fprintf(stderr, "realloc error\n");
        exit(1);
    }
    return res;
}

char *
relativize_path(const char *path1, const char *path2)
{
    char *temp1, *temp2, *res;
    if (path1 == NULL || path2 == NULL) {
        return NULL;
    }
    int len1 = strlen(path1), len2 = strlen(path2), cur;
    if ((res = calloc(3 * (len1 + len2), sizeof(char))) == 0) {
        fprintf(stderr, "calloc error\n");
        exit(1);
    }
    temp1 = simplify_path(path1);
    temp2 = simplify_path(path2);

    // going back to dir of file1
    len1 = strlen(temp1);
    len2 = strlen(temp2);
    if (temp1[0] != 0) {
        len1--;
        while (temp1[len1] != '/') {
            len1--;
        }
        temp1[len1] = 0;
    }

    // going backwards in path2 until finding common dir
    int part_2_start = len2;
    if (part_2_start && !strstr(temp1, temp2)) {
        while (part_2_start >= 0) {
            if (temp2[part_2_start] == '/') {
                temp2[part_2_start] = 0;
                if (strstr(temp1, temp2)) {
                    temp2[part_2_start] = '/';
                    break;
                }
                temp2[part_2_start] = '/';
            }
            part_2_start--;
        }
    }

    // going backwards in path1 and adding corresponding path to res
    cur = 0;
    for (int i = len1 - 1; i >= part_2_start; i--) {
        if (temp1[i] == '/') {
            strcpy(&res[cur], BACK_PATH);
            cur += BACK_PATH_LEN;
        }
    }
    strcpy(&res[cur], &temp2[part_2_start]); // adding second part
    len1 = strlen(res + 1);
    memmove(res, res + 1, len1 + 1);
    if (res[0] == 0) {
        strcpy(res, BASE_PATH); // making empty string a base path
        len1 = 1;
    } else if (res[len1 - 1] == '/') {
        res[len1 - 1] = 0;
    }
    if ((res = realloc(res, len1 + 1)) == 0) {
        fprintf(stderr, "realloc error\n");
        exit(1);
    }
    free(temp1);
    free(temp2);
    return res;
}
