#include <cmath>
#include <iostream>
#include <iomanip>

int
main() {
    double a = 0, b = 0, n, c = 0;
    while (std::cin >> n) {
        a += n;
        b += n * n;
        c++;
    }
    if (c > 0) {
        a /= c;
        b = sqrt(b / c - a * a);
    }
    std::cout << std::setprecision(10) << a << std::endl << b << std::endl;
}