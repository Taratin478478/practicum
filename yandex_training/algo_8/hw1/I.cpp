// I. Новые ПДД*

#include <iostream>

int main() 
{
    char c;
    long long x1, y1, x2, y2, res;
    std::cin >> x1 >> y1 >> x2 >> y2;
    if (x1 == x2 && y1 == y2) {
        std::cout << 0 << std::endl;
        return 0;
    }
    res = (std::abs(x1 - x2) + std::abs(y1 - y2) - 1) * 3;
    if (x1 != x2 && y1 != y2) {
        res -= 2;
    }
    std::cout << res << std::endl;
	return 0;
}
