#include <iostream>
#include <cctype>

int main(void) {
    std::ios_base::sync_with_stdio(0);
    std::cin.tie(0);
    std::cout.tie(0);
    int c;
    bool f = false, v = true, nz = false;
    while ((c = std::cin.get()) != EOF) {
        if (c == '1' || c == '2') {
            f = true;
            nz = true;
        } else if (c == '3' || c == '4') {
            if (f) {
                v = false;
            }
            nz = true;
        } else if (std::isspace(c)) {
            f = false;
            if (nz) {
                if (v) {
                    std::cout << '1' << std::endl;
                } else {
                    std::cout << '0' << std::endl;
                }
            }
            v = true;
            nz = false;
        } else {
            v = false;
            nz = true;
        }
    }
    if (nz) {
        if (v) {
            std::cout << '1' << std::endl;
        } else {
            std::cout << '0' << std::endl;
        }
    }
    return 0;
}