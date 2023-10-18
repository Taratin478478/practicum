#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>

enum
{
    WEDNESDAY = 4,
};

int
main(void)
{
    int year;
    if (scanf("%d", &year) != 1) {
        fprintf(stderr, "invalid input\n");
        exit(1);
    }
    struct tm timestruct;
    memset(&timestruct, 0, sizeof(timestruct));
    timestruct.tm_mday = 1;
    timestruct.tm_isdst = -1;
    timestruct.tm_year = year - 1900;
    mktime(&timestruct);
    int wednesday_count = 0, last_month = -1;
    while (timestruct.tm_year == year - 1900) {
        if (timestruct.tm_mon != last_month) {
            wednesday_count = 0;
            last_month = timestruct.tm_mon;
        }
        if (timestruct.tm_wday == WEDNESDAY) {
            wednesday_count++;
            if ((wednesday_count == 2 || wednesday_count == 4) && timestruct.tm_mday % 3 != 0) {
                printf("%d %d\n", timestruct.tm_mon + 1, timestruct.tm_mday);
            }
        }
        timestruct.tm_mday++;
        timestruct.tm_isdst = -1;
        mktime(&timestruct);
    }
    return 0;
}
