#include <vector>
#include <iostream>
#include <cstdint>

void process(std::vector<uint64_t> &v, uint32_t s) {
    uint64_t sum = 0, count = 0, parts = v.size() / s, size = v.size();
    if (parts == 0) {
        return;
    }
    v.resize(size + parts);
    auto it1 = v.begin() + parts * (s + 1);
    if (size % s == 0) {
        --it1;
    }
    uint64_t left = size % s;
    auto it2 = v.begin() + size - 1;
    while (parts) {
        for (uint64_t i = 0; i < left; ++i) {
            *it1 = *it2;
            --it1;
            --it2;
        }
        left = s;
        --it1;
        --parts;
    }
    for (it1 = v.begin(); it1 != v.end(); ++it1) {
        if (count == s) {
            *it1 = sum;
            count = 0;
        } else {
            sum += *it1;
            ++count;
        }
    }
}