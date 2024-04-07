#include <functional>
#include <iostream>

template<typename T, typename C = std::less<typename T::value_type>>
constexpr void selection_sort(T first, T last, C comp = {}) {
    for (auto i = first; i != last; ++i) {
        auto min = i;
        for (auto j = i; j != last; ++j) {
            if (comp(*j, *min)) {
                min = j;
            }
        }
        std::swap(*min, *i);
    }
}
