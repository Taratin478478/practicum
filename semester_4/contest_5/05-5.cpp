#include <map>
#include <iostream>
#include <format>

constexpr unsigned long long MOD = 4294967161;

int main() {
    std::map<unsigned long long, std::map<unsigned long long, unsigned long long>> m1, m2;
    unsigned long long a, b, c;
    while ((std::cin >> a >> b >> c) && !(a == 0 && b == 0 && c == MOD)) {
        m1[b][a] = c;
    }
    while (std::cin >> a >> b >> c) {
        for (auto &m: m1[a]) {
            m2[m.first][b] += (m.second * c) % MOD;
        }
    }
    for (auto &d1: m2) {
        for (auto &d2: d1.second) {
            if (d2.second) {
                std::cout << d1.first << ' ' << d2.first << ' ' << d2.second % MOD << std::endl;
            }
        }
    }
}