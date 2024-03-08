class C
{
public:
    C(int n1, int n2) {}
    C func1(const C &v1, int v2);
    void func2(const C *p1, double p2);
    int operator~ () const {
        return 0;
    }
    C(double d) {}
    C operator++ () {
        return *this;
    }
    int operator* (C c[2]) {
        return 0;
    }
    C() {}
    C(const C *c) {}
};

int operator+ (int v2, const C v1) {
    return 0;
}