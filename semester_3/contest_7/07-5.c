#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>
#include <errno.h>

enum
{
    MONDAY = 1,
    TM_BASE_YEAR = 1900,
    TM_BASE_DST = -1,
    TM_MONTH_OFFSET = 1,
    TM_YDAY_OFFSET = 1,
    FULL_MOON_BASE_YEAR = 2021 - TM_BASE_YEAR,
    FULL_MOON_BASE_MONTH = 5 - TM_MONTH_OFFSET,
    FULL_MOON_BASE_DAY = 26,
    FULL_MOON_BASE_HOUR = 11,
    FULL_MOON_BASE_MINUTE = 14,
    FULL_MOON_LEN_DAYS = 29,
    FULL_MOON_LEN_HOURS = 12,
    FULL_MOON_LEN_MINUTES = 44,
    EVENT_MIN_DAY = 257 - TM_YDAY_OFFSET,
    EVENT_MONDAY_COUNT = 4,
};

void
timegm_check(struct tm *tm)
{
    errno = 0;
    timegm(tm);
    if (errno != 0) {
        fprintf(stderr, "Time conversion error\n");
        exit(errno);
    }
}

int
main(void)
{
    int year;
    if (scanf("%d", &year) != 1) {
        fprintf(stderr, "invalid input\n");
        exit(1);
    }
    struct tm full_moon;
    memset(&full_moon, 0, sizeof(full_moon));
    full_moon.tm_isdst = TM_BASE_DST;
    full_moon.tm_year = FULL_MOON_BASE_YEAR;
    full_moon.tm_mon = FULL_MOON_BASE_MONTH;
    full_moon.tm_mday = FULL_MOON_BASE_DAY;
    full_moon.tm_hour = FULL_MOON_BASE_HOUR;
    full_moon.tm_min = FULL_MOON_BASE_MINUTE;
    timegm_check(&full_moon);
    full_moon.tm_isdst = TM_BASE_DST;
    if (full_moon.tm_year < year - TM_BASE_YEAR ||
        (full_moon.tm_year == year - TM_BASE_YEAR && full_moon.tm_yday < EVENT_MIN_DAY)) {
        while (!(full_moon.tm_year == year - TM_BASE_YEAR && full_moon.tm_yday >= EVENT_MIN_DAY)) {
            full_moon.tm_mday += FULL_MOON_LEN_DAYS;
            full_moon.tm_hour += FULL_MOON_LEN_HOURS;
            full_moon.tm_min += FULL_MOON_LEN_MINUTES;
            timegm_check(&full_moon);
            full_moon.tm_isdst = TM_BASE_DST;
        }
    } else {
        while (!(full_moon.tm_year == year - TM_BASE_YEAR && full_moon.tm_yday < EVENT_MIN_DAY)) {
            full_moon.tm_mday -= FULL_MOON_LEN_DAYS;
            full_moon.tm_hour -= FULL_MOON_LEN_HOURS;
            full_moon.tm_min -= FULL_MOON_LEN_MINUTES;
            timegm_check(&full_moon);
            full_moon.tm_isdst = TM_BASE_DST;
        }
        full_moon.tm_mday += FULL_MOON_LEN_DAYS;
        full_moon.tm_hour += FULL_MOON_LEN_HOURS;
        full_moon.tm_min += FULL_MOON_LEN_MINUTES;
        timegm_check(&full_moon);
        full_moon.tm_isdst = TM_BASE_DST;
    }
    int monday_count = 0;
    while (monday_count != EVENT_MONDAY_COUNT) {
        full_moon.tm_mday++;
        timegm_check(&full_moon);
        full_moon.tm_isdst = TM_BASE_DST;
        if (full_moon.tm_wday == MONDAY) {
            monday_count++;
        }
    }
    printf("%04d-%02d-%02d\n", full_moon.tm_year + TM_BASE_YEAR, full_moon.tm_mon + TM_MONTH_OFFSET, full_moon.tm_mday);
    return 0;
}
