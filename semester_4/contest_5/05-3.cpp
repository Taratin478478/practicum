#include <string>
#include <map>
#include <iostream>
#include <tuple>
#include <cstdio>
#include <set>
#include <format>

class Date {
    int year{};
    int month{};
    int day{};
public:
    Date(const std::string &s) {
        std::sscanf(s.c_str(), "%d/%d/%d", &year, &month, &day);
    }
    friend std::ostream &operator<<(std::ostream &out, const Date &d) {
        out << std::format("{:}/{:02}/{:02}", d.year, d.month, d.day);
        return out;
    }
    friend bool operator<(const Date &a,const Date &b) {
        if (a.year == b.year) {
            if (a.month == b.month) {
                return a.day < b.day;
            }
            return a.month < b.month;
        }
        return a.year < b.year;
    }
};

int main() {
    std::set<std::string> names;
    std::set<Date> dates;
    std::map<std::pair<Date, std::string>, int> grades;
    std::string name, date_str;
    int grade;
    while (std::cin >> name >> date_str >> grade) {
        Date date{date_str};
        grades[{date, name}] = grade;
        names.insert(name);
        dates.insert(date);
    }
    std::cout << ".";
    for (auto &d: dates) {
        std::cout << ' ' << d;
    }
    std::cout << std::endl;
    for (auto &n: names) {
        std::cout << n;
        for (auto &d: dates) {
            if (grades.contains({d, n})) {
                std::cout << ' ' << grades[{d, n}];
            } else {
                std::cout << " .";
            }
        }
        std::cout << std::endl;
    }
}