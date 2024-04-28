/*
грамматика:
 S->aAB1
 aA->aaAA
 B1->BB11
 AB->BA
 BA->0b
 B0->00
 bA->bb
 */
#include <string>
#include <iostream>

int main() {
    int m, n, k;
    std::string s;

    while (std::cin >> s) {
        m = n = k = 0;
        auto it = s.begin();
        while (*it == 'a' && it != s.end()) {
            ++n;
            ++it;
        }
        while (*it == '0' && it != s.end()) {
            ++m;
            ++it;
        }
        while (*it == 'b' && it != s.end()) {
            ++k;
            ++it;
        }
        if (k != n) {
            std::cout << 0 << std::endl;
            continue;
        }
        k = 0;
        while (*it == '1' && it != s.end()) {
            ++k;
            ++it;
        }
        if (n == 0 || m == 0 || (k != m) || (it != s.end())) {
            std::cout << 0 << std::endl;
            continue;
        }
        std::cout << 1 << std::endl;
    }
}