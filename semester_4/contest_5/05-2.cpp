#include <string>
#include <map>
#include <iostream>
#include <utility>

int main() {
    std::string name;
    int grade;
    std::map<std::string, std::pair<int, int>> m;
    while (std::cin >> name >> grade) {
        if (m.contains(name)) {
            m[name].first += grade;
            ++m[name].second;
        } else {
            m[name] = {grade, 1};
        }
    }
    for (auto &p: m) {
        std::cout << p.first << ' ' << double(p.second.first) / p.second.second << std::endl;
    }
}