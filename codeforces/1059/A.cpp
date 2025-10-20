// A. Красивое среднее

#include <iostream>

int main() {
    int n, m, ans, x;
    std::cin >> n;
    for (int i = 0; i < n; ++i) {
        std::cin >> m;
        std::cin >> ans;
        for (int j = 1; j < m; ++j) {
            std::cin >> x;
            ans = std::max(ans, x);
        }
        std::cout << ans << std::endl;
    }
}