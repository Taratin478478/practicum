#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <fcntl.h>
#include <unistd.h>

int
main(int argc, char **argv)
{
    long long n1, n2;
    scanf("%llx %llx", &n1, &n2);
    printf("%d\n", (((n1 > 0) & (n2 > 0)) | ((n1 < 0) & (n2 < 0))) | -(((n1 > 0) & (n2 < 0)) | ((n1 < 0) & (n2 > 0))));
    return 0;
}