#include <iostream>
#include <fstream>

class S {
public:
    int n{};
    bool b{true};
    S() {
        b = !std::cin.eof();
        std::cin >> n;
    }
    ~S() {
        if (!b) {
            std::cout << n << std::endl;
        }
    }
    S(const S &other): n{other.n}, b{other.b} {}
    S(S &&other): n{other.n} {
        int m;
        b = !std::cin.eof();
        std::cin >> m;
        n += m;
    }
    operator bool() {
        return b;
    }
};

void func(S v)
{
    if (v) {
        func(std::move(v));
    }
}

int main()
{
    //std::ifstream ifs("in.txt");
    //std::cin.rdbuf(ifs.rdbuf());
    func(S());
}