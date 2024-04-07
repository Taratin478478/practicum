#include <string>
#include <cstdio>
#include <numbers>

struct Figure {
    [[nodiscard]] virtual double get_square() const noexcept = 0;
    virtual ~Figure() = default;
};

class Rectangle: public Figure {
    double a_{0}, b_{0};
public:
    Rectangle() noexcept = default;
    Rectangle(double a, double b) noexcept: a_{a}, b_{b} {}
    [[nodiscard]] double get_square() const noexcept override {
        return a_ * b_;
    }
    static Rectangle* make(const std::string &s) {
        double a, b;
        sscanf(s.c_str(), "%lf %lf", &a, &b);
        return new Rectangle(a, b);
    }
};

class Square: public Figure {
    double a_{0};
public:
    Square() noexcept = default;
    explicit Square(double a) noexcept: a_{a} {}
    [[nodiscard]] double get_square() const noexcept override {
        return a_ * a_;
    }
    static Square* make(const std::string &s) {
        double a;
        sscanf(s.c_str(), "%lf", &a);
        return new Square(a);
    }
};

class Circle: public Figure {
    double r_{0};
public:
    Circle() noexcept = default;
    explicit Circle(double r) noexcept: r_{r} {}
    [[nodiscard]] double get_square() const noexcept override {
        return std::numbers::pi * r_ * r_;
    }
    static Circle* make(const std::string &s) {
        double r;
        sscanf(s.c_str(), "%lf", &r);
        return new Circle(r);
    }
};