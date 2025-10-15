// A. Делёж грибов
#include <iostream>

int main() 
{
    int n, a, a_min, a_max, hap;
    std::cin >> n >> a_min >> a_max;
    hap = a_min - a_max;
    for (int i = 2; i < n; ++i) {
        std::cin >> a;
        if (i % 2 == 0) {
            if (a < a_min) {
                a_min = a;
            }
            hap += a;
        } if (i % 2 == 1) {
            if (a > a_max) {
                a_max = a;
            }
            hap -= a;
        }
    }
    if (a_min < a_max) {
        hap += 2*(a_max - a_min);
    }
    std::cout << hap;
	return 0;
}
