template<typename T, typename F>
auto myfilter(const T& c, F f) {
    T res{};
    for (auto &x: c) {
        if (f(x)) {
            res.insert(res.end(), x);
        }
    }
    return res;
}