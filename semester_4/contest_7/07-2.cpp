#include <string>
#include <cstdio>
#include <cmath>

//это максимум что можно сделать на c++92

class Rectangle: public Figure {
    double a_, b_;
public:
    Rectangle(double a, double b) {
        a_ = a;
        b_ = b;
    }
    double get_square() const {
        return a_ * b_;
    }
    static Rectangle* make(const std::string& s) {
        double a, b;
        sscanf(s.c_str(), "%lf %lf", &a, &b);
        return new Rectangle(a, b);
    }
};

class Square: public Figure {
    double a_;
public:
    Square(double a = 0) {
        a_ = a;
    }
    double get_square() const {
        return a_ * a_;
    }
    static Square* make(const std::string& s) {
        double a;
        sscanf(s.c_str(), "%lf", &a);
        return new Square(a);
    }
};

class Circle: public Figure {
    double r_;
public:
    Circle(double r) {
        r_ = r;
    };
    double get_square() const {
        return M_PI * r_ * r_;
    }
    static Circle* make(const std::string& s) {
        double r;
        sscanf(s.c_str(), "%lf", &r);
        return new Circle(r);
    }
};