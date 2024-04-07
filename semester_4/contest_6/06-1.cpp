constexpr int elemn1 = 1, elemn2 = 3, elemn3 = 5;

template<typename T>
auto process(const T& cont) {
    typename T::value_type s{};
    auto iter = cont.rbegin();
    if (cont.size() >= elemn1) {
        s = *iter;
    }
    if (cont.size() >= elemn2) {
        ++++iter;
        s += *iter;
    }
    if (cont.size() >= elemn3) {
        ++++iter;
        s += *iter;
    }
    return s;
}