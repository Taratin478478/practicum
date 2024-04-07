#include <iostream>
#include <vector>
#include <algorithm>

bool less(int a, int b) {
    unsigned ua = unsigned(a), ub = unsigned(b), ca = 0, cb = 0;
    while (ua) {
        ca += ua & 1u;
        ua >>= 1;
    }
    while (ub) {
        cb += ub & 1u;
        ub >>= 1;
    }
    return ca < cb;
}

int main() {
    int n;
    std::vector<int> v;
    while (std::cin >> n) {
        v.push_back(n);
    }
    std::stable_sort(v.begin(), v.end(), less);
    for (auto m: v) {
        std::cout << m << std::endl;
    }
}
