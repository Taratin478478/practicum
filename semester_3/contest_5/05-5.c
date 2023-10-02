#include <string.h>
#include <malloc.h>
#include <stdlib.h>

const char *BACK_PATH = "../", *BASE_PATH = "/";

char
*relativize_path(const char *path1, const char *path2)
{
    char *temp1, *temp2, *cur, *res;
    if ((temp1 = calloc(strlen(path1) + 1, sizeof(char))) == 0) {
        fprintf(stderr, "calloc error\n");
        exit(1);
    }
    if ((temp2 = calloc(strlen(path2) + 1, sizeof(char))) == 0) {
        fprintf(stderr, "calloc error\n");
        exit(1);
    }
    if ((res = calloc(3 * (strlen(path1) + strlen(path2)), sizeof(char))) == 0) {
        fprintf(stderr, "calloc error\n");
        exit(1);
    }

    // going back to dir of file1
    strcpy(temp1, path1);
    cur = temp1 + (strlen(temp1) - 1);
    while (cur[0] != '/') {
        cur--;
    }
    cur[0] = 0;

    // going backwards in path2 until finding common dir
    strcpy(temp2, path2);
    if (!strcmp(temp2, BASE_PATH)) {
        temp2[0] = 0; // making base path an empty string
    }
    int part_2_start = strlen(temp2);
    if (part_2_start && !strstr(temp1, temp2)) {
        while (part_2_start >= 0) {
            if (temp2[part_2_start] == '/') {
                temp2[part_2_start] = 0;
                if (strstr(temp1, temp2)) {
                    break;
                }
            }
            part_2_start--;
        }
    }

    // going backwards in path1 and adding corresponding path to res
    cur = res;
    for (int i = strlen(temp1) - 1; i >= part_2_start; i--) {
        if (temp1[i] == '/') {
            strcpy(cur, BACK_PATH);
            cur += strlen(BACK_PATH);
        }
    }

    if (cur != res && path2[part_2_start]) { // fixing double slash when adding 2 part
        part_2_start++;
    }
    strcpy(cur, &path2[part_2_start]); // adding 2 part
    if (res[0] == 0) {
        strcpy(res, BASE_PATH); // making empty string a base path
    }
    if ((res = realloc(res, strlen(res) + 1)) == 0) {
        fprintf(stderr, "realloc error\n");
        exit(1);
    }
    return res;
}

int
main(int argc, char **argv)
{
    printf("%s\n", relativize_path("/a/b/c/d", "/a/e/f"));
    printf("%s\n", relativize_path("/a/b", "/a/e/f"));
    printf("%s\n", relativize_path("/a", "/a/e/f"));
    printf("%s\n", relativize_path("/a/b/c/d", "/a"));
    printf("%s\n", relativize_path("/a/b/c/d", "/"));
    printf("%s\n", relativize_path("/a/b", "/a"));
    printf("%s\n", relativize_path("/a", "/a"));
    return 0;
}