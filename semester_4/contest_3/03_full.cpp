#include <array>
#include <string>
#include <cstring>
#include <cmath>
#include <sstream>
#include <iomanip>
#include <vector>
#include <map>
#include <functional>
#include <iostream>


namespace numbers
{

constexpr size_t DEFAULT_STACK_SIZE = 32;

class complex
{
    double real, imag;

public:
    complex(const double a = 0.0, const double b = 0.0): real(a), imag(b)
    {
    }

    explicit
    complex(const char *const s): real(0), imag(0)
    {
        sscanf(s, "(%lf,%lf)", &real, &imag);
    }

    double
    re() const
    {
        return real;
    }

    double
    im() const
    {
        return imag;
    }

    double
    abs2() const
    {
        return real * real + imag * imag;
    }

    double
    abs() const
    {
        return sqrt(abs2());
    }

    std::string
    to_string() const
    {
        std::stringstream ss;
        ss << std::setprecision(10) << "(" << real << "," << imag << ")";
        return ss.str();

    }

    complex &
    operator +=(const complex &c)
    {
        real += c.re();
        imag += c.im();
        return *this;
    }

    complex &
    operator -=(const complex &c)
    {
        real -= c.re();
        imag -= c.im();
        return *this;
    }

    complex &
    operator *=(const complex &c)
    {
        double tmp = real * c.re() - imag * c.im();
        imag = imag * c.re() + real * c.im();
        real = tmp;
        return *this;
    }

    complex &
    operator /=(const complex &c)
    {
        double tmp = (real * c.re() + imag * c.im()) / c.abs2();
        imag = (imag * c.re() - real * c.im()) / c.abs2();
        real = tmp;
        return *this;
    }

    friend complex
    operator +(const complex &c1, const complex &c2)
    {
        complex z;
        z += c1;
        z += c2;
        return z;
    }

    friend complex
    operator -(const complex &c1, const complex &c2)
    {
        complex z;
        z += c1;
        z -= c2;
        return z;
    }

    friend complex
    operator *(const complex &c1, const complex &c2)
    {
        complex z;
        z += c1;
        z *= c2;
        return z;
    }

    friend complex
    operator /(const complex &c1, const complex &c2)
    {
        complex z;
        z += c1;
        z /= c2;
        return z;
    }

    complex
    operator ~() const
    {
        return {real, -imag};
    }

    complex
    operator -() const
    {
        return {-real, -imag};
    }
};

class complex_stack
{
    size_t size_ = 0;
    size_t capacity_;
    complex *array_ = nullptr;

public:
    explicit
    complex_stack(size_t capacity = DEFAULT_STACK_SIZE): capacity_{capacity}
    {
        array_ = new complex[capacity_];
    }

    complex_stack(const complex_stack &that): size_{that.size_}, capacity_{that.capacity_}
    {
        array_ = new complex[capacity_];
        std::memcpy(array_, that.array_, capacity_ * sizeof(*array_));
    }

    complex_stack(complex_stack &&that) noexcept: size_{that.size_}, capacity_{that.capacity_}, array_(that.array_)
    {
        that.array_ = nullptr;
    }

    friend void
    swap(complex_stack &a, complex_stack &b) noexcept
    {
        std::swap(a.size_, b.size_);
        std::swap(a.capacity_, b.capacity_);
        std::swap(a.array_, b.array_);
    }

    complex_stack &
    operator=(complex_stack that)
    {
        swap(*this, that);
        return *this;
    }

    ~complex_stack()
    {
        delete []array_;
    }

    size_t
    size() const
    {
        return size_;
    }

    const complex &
    operator[](int n) const
    {
        return array_[n];
    }

    friend complex_stack
    operator<<(complex_stack stack, const complex z)
    {
        if (stack.size_ == stack.capacity_) {
            stack.capacity_ *= 2;
            auto *tmp = new complex[stack.capacity_];
            std::memcpy(tmp, stack.array_, stack.size_ * sizeof(*stack.array_));
            delete []stack.array_;
            stack.array_ = tmp;
        }
        stack.array_[stack.size_++] = z;
        return stack;
    }

    complex &
    operator+() const
    {
        return array_[size_ - 1];
    }

    complex_stack
    operator~() const
    {
        complex_stack stack{*this};
        --stack.size_;
        return stack;
    }
};

complex
eval(const std::vector<std::string> &args, const complex &z)
{
    complex_stack st{};
    const std::map<std::string, std::function<void()>> opmap{
        {"z", [&st, &z] { st = st << z; }},
        {"+", [&st] {
            const complex a{+st}, b{+(st = ~st)};
            st = ~st << b + a;
        }},
        {"-", [&st] {
            const complex a{+st}, b{+(st = ~st)};
            st = ~st << b - a;
        }},
        {"*", [&st] {
            const complex a{+st}, b{+(st = ~st)};
            st = ~st << b * a;
        }},
        {"/", [&st] {
            const complex a{+st}, b{+(st = ~st)};
            st = ~st << b / a;
        }},
        {"!", [&st] { st = st << +st; }},
        {";", [&st] { st = ~st; }},
        {"~", [&st] { st = ~st << ~+st; }},
        {"#", [&st] { st = ~st << -+st; }},
    };
    for (const auto &op : args) {
        if (opmap.contains(op)) {
            opmap.at(op)();
        } else {
            st = st << complex{op.c_str()};
        }
    }
    return +st;
}
}

int
main()
{
    std::cout << numbers::eval({"(2,2)", "(3,3)", "+"}, {1, 1}).to_string() << std::endl;
}
