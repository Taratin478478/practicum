#include <vector>


void
process(const std::vector<unsigned long> &a, std::vector<unsigned long> &b, int step) {
    auto ia = a.begin();
    auto ib = b.rbegin();
    while (ia < a.end() && ib != b.rend()) {
        *ib += *ia;
        ++ib;
        ia += step;
    }
}