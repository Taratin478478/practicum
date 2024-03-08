#include <iostream>

class A {
    int s = 0;
    bool f;
public:
    A(): f(false) {
        std::cin >> s;
    }

    ~A() {
        if (f) {
            std::cout << s << std::endl;
        }
    }

    A(const A &a): f(true) {
        std::cin >> s;
        s += a.s;
    }
};