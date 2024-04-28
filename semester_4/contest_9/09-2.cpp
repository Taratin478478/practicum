#include <iostream>
#include <cctype>

class Parser {
    int n0 = 0, n1 = 0, c = 0;
public:
    bool parse_first() {
        c = std::cin.get();
        while (std::isspace(c)) {
            c = std::cin.get();
        }
        while (c == '0') {
            ++n0;
            c = std::cin.get();
        }
        while (c == '1') {
            ++n1;
            c = std::cin.get();
        }
        if (n0 == 0 && n1 == 0 && !(std::isspace(c) || std::cin.eof())) {
            n0 = -1;
            c = std::cin.get();
            return false;
        }
        return (n0 > 0 && n1 > 0 && (c == '0' || std::isspace(c) || std::cin.eof()));
    }

    bool parse_block() {
        int m0 = 0, m1 = 0;
        while (c == '0') {
            ++m0;
            c = std::cin.get();
        }
        while (c == '1') {
            ++m1;
            c = std::cin.get();
        }
        if (m0 == 0 && m1 == 0 && !(std::isspace(c) || std::cin.eof())) {
            n0 = -1;
            c = std::cin.get();
            return false;
        }
        return (n0 == m0 && n1 == m1 && (c == '0' || std::isspace(c) || std::cin.eof()));
    }

    int parse() {
        int res = 1;
        if (!parse_first()) {
            res = 0;
        }
        while (!(std::isspace(c) || std::cin.eof())) {
            if (!parse_block()) {
                res = 0;
            }
        }
        if (n0 == 0 && n1 == 0) {
            res = 2;
        }
        return res;
    }

    void reset() {
        n0 = 0;
        n1 = 0;
    }
};

int main() {
    Parser prsr;
    int res;
    while (!std::cin.eof()) {
        res = prsr.parse();
        if (res <= 1) {
            std::cout << res << std::endl;
        }
        prsr.reset();
    }
}
