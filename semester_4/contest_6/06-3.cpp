#include <algorithm>
#include <vector>
#include <functional>
#include <iterator>

template<typename T, typename F>
void myapply(T beg, T end, F f) {
    for (auto i = beg; i != end; ++i) {
        f(*i);
    }
}

template<typename T, typename F>
auto myfilter2(T beg, T end, F f) {
    std::vector<std::reference_wrapper<typename std::iterator_traits<T>::value_type>> res{};
    for (auto i = beg; i != end; ++i) {
        if (f(*i)) {
            res.push_back(*i);
        }
    }
    return res;
}