// C. Красивый XOR

#include <iostream>

unsigned get_nbits(unsigned x) {
    unsigned res = 0;
    while (x) {
        ++res;
        x >>= 1;
    }
    return res;
}

int main() {
    unsigned n, a, b, na, nb, x;
    std::cin >> n;
    for (int i = 0; i < n; ++i) {
        std::cin >> a >> b;
        if (a == 0) {
            if (b == 0) {
                std::cout << 0 << std::endl;
            } else {
                std::cout << -1 << std::endl;
            }
            continue;
        }
        na = get_nbits(a);
        nb = get_nbits(b);
        if (nb > na) {
            std::cout << -1 << std::endl;
            continue;
        }
        std::cout << 2 << std::endl;
        x = (1 << na) - 1;
        x ^= a;
        std::cout << x << ' ';
        a ^= x;
        x = b ^ a;
        std::cout << x << std::endl;
    }
}