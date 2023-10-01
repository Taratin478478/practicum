#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

enum
{
    MAX_INT_STR_LEN = 12
};

struct Elem
{
    struct Elem *next;
    char *str;
};

struct Elem *
dup_elem(struct Elem *head)
{
    struct Elem *prev = NULL, *curr = head, *new;
    long long num;
    char test, *buf;
    if (!(buf = calloc(MAX_INT_STR_LEN, sizeof(char)))) {
        fprintf(stderr, "memory allocation error\n");
        exit(1);
    }
    while (curr) {
        if (curr->str != NULL && sscanf(curr->str, "%lld%c", &num, &test) == 1) {
            sscanf(curr->str, " %c", &test);
            if (((test >= '0' && test <= '9') || test == '-' || test == '+') && num < INT_MAX && num >= INT_MIN) {
                new = calloc(1, sizeof(*curr));
                sprintf(buf, "%lld", num + 1);
                if (buf[MAX_INT_STR_LEN - 1] != 0) {
                    fprintf(stderr, "int to str conversion error (overflow)\n");
                    exit(1);
                }
                if (!(new->str = calloc(strlen(buf) + 1, sizeof(char)))) {
                    fprintf(stderr, "memory allocation error\n");
                    exit(1);
                }
                strcpy(new->str, buf);
                new->next = curr;
                if (prev) {
                    prev->next = new;
                } else {
                    head = new;
                }
            }
        }
        prev = curr;
        curr = prev->next;
    }
    free(buf);
    return head;
}