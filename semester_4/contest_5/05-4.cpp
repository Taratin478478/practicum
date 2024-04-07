#include <map>
#include <iostream>
#include <tuple>
#include <format>

int main() {
    std::map<std::pair<unsigned long long, unsigned long long>, unsigned long long> m;
    unsigned long long a, b, c;
    while (std::cin >> a >> b >> c) {
        if (a == 0 && b == 0 && c == 4294967161) {
            break;
        }
        m[{a, b}] = c;
    }
    while (std::cin >> a >> b >> c) {
        if (m.contains({a, b})) {
            m[{a, b}] = (m[{a, b}] + c) % 4294967161;

        } else {
            m[{a, b}] = c;
        }
    }
    for (auto d : m) {
        if (d.second) {
            std::cout << d.first.first << ' ' << d.first.second << ' ' << d.second << std::endl;
        }
    }
}