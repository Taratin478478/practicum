// B. Красивая строка

#include <iostream>
#include <string>
#include <algorithm>


int main() {
    int n, m, x, j;
    bool f = false;
    std::string s, ans;
    std::cin >> n;
    for (int i = 0; i < n; ++i) {
        std::cin >> m;
        std::cin >> s;
        x = std::count(s.begin(), s.end(), '0');
        std::cout << x << std::endl;
        if (x > 0) {
            for (int i = 0; i < m; ++i) {
                if (s[i] == '0') {
                    std::cout << i << ' ';
                }
            }
            std::cout << std::endl;
        }
    }
}
