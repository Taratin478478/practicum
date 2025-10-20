// A. Полка раздора

#include <iostream>
#include <cmath>

// (x - a) * (x - b) = s
// x^2 - (a + b) * x + ab - s = 0
// D = (a + b) ^ 2 - 4 * (ab - s)
int main() {
    long long a, b, S, D, sqrtD, x;
    std::cin >> a >> b >> S;
    D = (a + b) * (a + b) - 4 * (a * b - S);
    sqrtD = std::sqrt(D);
    if (D < 0 || D != sqrtD * sqrtD) {
        std::cout << -1 << std::endl;
    } else {
        x = ((a + b) + sqrtD) / 2;
        std::cout << x << std::endl;
    }
    return 0;
}