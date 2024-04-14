#include <string>
#include <iostream>
#include <utility>

class E {
public:
    std::string s;
    E(std::string s): s{std::move(s)} {}
    ~E() {
        if (!s.empty()) {
            std::cout << s << std::endl;
        }
    }
};

void rec() {
    std::string new_s;
    std::cin >> new_s;
    try {
        if (!new_s.empty()) {
            rec();
        } else {
            throw E("");
        }
    } catch(E &e) {
        throw E(new_s);
    }
    std::cout << "REJECTED" << std::endl;
}

int main() {
    try {
        rec();
    } catch(E &e) {}
}