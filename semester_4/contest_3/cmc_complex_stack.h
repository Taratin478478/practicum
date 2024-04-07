#include <array>
#include <string>
#include <cstring>
#include <cmath>
#include <sstream>
#include <iomanip>


namespace numbers
{

constexpr size_t DEFAULT_STACK_SIZE = 32;

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
}
