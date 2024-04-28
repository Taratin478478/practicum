#include <iostream>

class S {
public:
    int n{};
    bool b{true}, first{false};

    S() : first{true} {
        std::cin >> n;
        b = !std::cin.eof();
    }

    ~S() {
        if (!b && !first) {
            std::cout << n << std::endl;
        }
    }

    S(const S &other) = default;

    S(S &&other) noexcept: n{other.n} {
        int m;
        std::cin >> m;
        b = !std::cin.eof();
        n += m;
    }

    operator bool() {
        return b;
    }
};
