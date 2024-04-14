#include <iostream>

class Result {
public:
    long long res{};
    Result() = default;
    Result(long long res): res{res} {}
    void set(long long res_) {
        res = res_;
    }

};

//Функция Аккермана
void func(long long a, long long b, long long k) {
    Result res;
    if (k == 0) {
        res.set(a + b);
        throw res;
    } else if (k > 0 && b == 1) {
        res.set(a);
        throw res;
    } else if (k > 0 && b > 0) {
        try {
            func(a, b - 1, k);
        } catch(Result &res) {
            func(a, res.res, k - 1);
        }
    }
    std::cout << "IGNORED" << std::endl;
}

int main() {
    long long a, b, k;
    while(std::cin >> a >> b >> k) {
        try {
            func(a, b, k);
        } catch (Result &res) {
            std::cout << res.res << std::endl;
        }
    }
}