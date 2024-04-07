#include <vector>
#include <algorithm>
#include <iostream>

void
process(const std::vector<int> &v1, std::vector<int> &v2) {
    std::vector<int> v3{v1};
    std::sort(v3.begin(), v3.end());
    auto ie = std::unique(v3.begin(), v3.end());
    v3.erase(ie, v3.end());
    auto i = v3.rbegin();
    while (i != v3.rend()) {
        if (*i >= 0 && *i < int(v2.size())) {
            v2.erase(v2.begin() + *i);
        }
        ++i;
    }
}