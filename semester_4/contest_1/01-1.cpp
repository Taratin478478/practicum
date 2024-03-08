class Sum {
    int n1, n2;
public:
    Sum(int a, int b) : n1(a), n2(b) {}

    Sum(Sum s, int b) : n1(s.get()), n2(b) {}

    int get() const {
        return n1 + n2;
    }
};