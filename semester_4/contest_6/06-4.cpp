#include <algorithm>
#include <vector>
#include <functional>
#include <iterator>
#include <set>

template<typename N, typename V>
auto myremove(N beg_num, N end_num, V beg_elem, V end_elem) {
    auto size = std::distance(beg_elem, end_elem);
    std::vector<bool> to_remove(size, false);
    for (auto i = beg_num; i != end_num; ++i) {
        if (*i >= 0 && *i < size) {
            to_remove[*i] = true;
        }
    }
    auto last = beg_elem, cur = beg_elem;
    for (int i = 0; i < size; ++i) {
        if (!to_remove[i]) {
            std::swap(*last, *cur);
            ++last;
        }
        ++cur;
    }
    return last;
}