#include <chrono>
#include <iostream>
#include <cstdio>

int main() {
    std::chrono::system_clock::time_point tp1, tp2;
    int year;
    unsigned month, day;
    scanf("%d-%u-%u", &year, &month, &day);
    std::chrono::year_month_day ymd1{std::chrono::year{year}, std::chrono::month{month}, std::chrono::day{day}};
    tp1 = std::chrono::sys_days(ymd1);
    long long sum = 0;
    while (scanf("%d-%u-%u", &year, &month, &day) == 3) {
        std::chrono::year_month_day ymd{std::chrono::year{year}, std::chrono::month{month}, std::chrono::day{day}};
        tp2 = std::chrono::sys_days(ymd);
        sum += std::abs(std::chrono::duration_cast<std::chrono::days>(tp1 - tp2).count());
        tp1 = tp2;
    }
    std::cout << sum << std::endl;
}