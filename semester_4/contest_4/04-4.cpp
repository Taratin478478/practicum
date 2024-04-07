#include <vector>
#include <algorithm>
#include <iostream>

class Avg {
    double s = 0;
    int n = 0;
public:
    void operator()(double d) {
        s += d;
        n++;
    }
    double get() {
        return s / n;
    }
};

int main() {
    std::vector<double> v{};
    double d;
    while (std::cin >> d) {
        v.push_back(d);
    }
    auto ib = v.begin() + v.size() / 10;
    auto ie = v.end() - v.size() / 10;
    std::sort(ib, ie);
    auto off = (ie - ib) / 10;
    ib += off;
    ie -= off;
    Avg a{};
    std::cout << std::for_each(ib, ie, a).get() << std::endl;
}