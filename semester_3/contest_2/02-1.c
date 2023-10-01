#include <stdio.h>

int main()
{
    char s1[130], s2[130], s3[130];
    if (scanf("%s%s%s", s1, s2, s3) < 3) {
        return 1;
    }
    printf("[Host:%s,Login:%s,Password:%s]\n", s1, s2, s3);
    return 0;
}