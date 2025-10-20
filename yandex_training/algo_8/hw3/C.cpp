// C. Рекламное объявление

#include <iostream>
#include <cmath>
#include <vector>
#include <utility>
#include <iomanip>

bool check(double k, const auto &words, double w, double h) {
    int i = 0, n = words.size();
    double curw, curh;
    while (i < n) {
        if (words[i].first * k > w || words[i].second * k > h) {
            return false;
        }
        curw = w - words[i].first * k;
        curh = words[i].second * k;
        h -= curh;
        ++i;
        while (i < n && words[i].first * k <= curw && words[i].second * k == curh) {
            curw -= words[i].first * k;
            ++i;
        }
    }
    return true;
}

double bin_search(double l, double r, const auto &words, double w, double h) {
    double eps = 1e-7;
    while (std::abs(l - r) >= eps) {
        double m = (l + r) / 2;
        if (check(m, words, w, h)) {
            l = m;
        } else {
            r = m;
        }
    }
    return (l + r) / 2;
}

int main() {
    int n;
    double w, h;
    std::cin >> n >> w >> h;
    std::vector<std::pair<double, double>> words(n);
    for (int i = 0; i < n; ++i) {
        std::cin >> words[i].first >> words[i].second;
    }
    std::cout << std::fixed;
    std::cout << bin_search(0, (w + h) / std::min(words[0].first, words[0].second), words, w, h) << std::endl;

    return 0;
}