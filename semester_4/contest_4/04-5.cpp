#include <list>
#include <iostream>

auto get_iter(auto &cont, size_t n) {
    auto it = cont.begin();
    for (size_t i = 0; i < n && i < cont.size(); ++i) {
        ++it;
    }
    return it;
}

int main() {
    int n, m;
    std::list<int> l;
    while ((std::cin >> n) && n) {
        l.push_back(n);
    }
    while (std::cin >> n) {
        if (n < 0) {
            if (static_cast<size_t>(-n) <= l.size()) {
                auto it = get_iter(l, -n - 1);
                l.erase(it);
            }
        } else {
            std::cin >> m;
            auto it = get_iter(l, n - 1);
            l.insert(it, m);
        }
    }
    for (auto &x: l) {
        std::cout << x << std::endl;
    }
}