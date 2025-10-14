// E. Табло с инкрементом

#include <iostream>
#include <map>
#include <vector>


int main() 
{
    unsigned long long n, k;
    std::cin >> n >> k;
    if (k == 0) {
        std::cout << n;
        return 0;
    }
    if (n % 10 == 0) {
        std::cout << n;
    } else if (n % 10 == 5) {
        std::cout << n + 5;
    } else {
        if (!(n % 10 == 2 || n % 10 == 4 || n % 10 == 8 || n % 10 == 6)) {
            n += n % 10;
            --k;
        }
        if (k == 0) {
            std::cout << n;
            return 0;
        }
        n += 20 * (k / 4);
        k %= 4;
        while (k > 0) {
            n += n % 10;
            --k;
        }
        std::cout << n;
    }
	return 0;
}
