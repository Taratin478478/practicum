// B. Красивая строка

#include <iostream>
#include <string>
#include <algorithm>

int bin_search_l() {
    
}

void split(int l, int r, int d) {
    int m = (l + r) / 2;
    int d1, d2, x;
    std::cout << "1 " << l << ' ' << m << std::endl;
    std::cin >> x;
    std::cout << "2 " << l << ' ' << m << std::endl;
    std::cin >> d1;
    d1 -= x;
    std::cout << "1 " << m + 1 << ' ' << r << std::endl;
    std::cin >> x;
    std::cout << "2 " << m + 1 << ' ' << r << std::endl;
    std::cin >> d2;
    d2 -= x;
    if (d1 == 0) {
        split(m + 1, r, d2);
    } else if (d2 == 0) {
        split(l, m, d1);
    } else {
        std::cout << bin_search_l();
    }
}

void solve() {
    int n, d;
    std::cin >> n;
    std::cout << "1 1 " << n << std::endl;
    std::cin >> d;
    d -= n*(n + 1)/2;
    split(0, n - 1, d);
}

int main() {
    int n;
    std::cin >> n;
    for (int i = 0; i < n; ++i) {
        solve();
    }
}
