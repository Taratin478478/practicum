#include <string>
#include <cmath>
#include <sstream>
#include <iomanip>
#include <iostream>
#include <cstdio>

namespace numbers {
    class complex
    {
        double real, imag;
    public:
        complex(double a = 0.0, double b = 0.0): real(a), imag(b) {}
        explicit complex(const char *const s): real(0), imag(0) {
            sscanf(s, "(%lf,%lf)", &real, &imag);
        }
        double re() const {
            return real;
        }
        double im() const {
            return imag;
        }
        double abs2() const {
            return real * real + imag * imag;
        }
        double abs() const {
            return sqrt(abs2());
        }
        std::string to_string() const {
            std::stringstream ss;
            ss << std::setprecision(10) << "(" << real << "," << imag << ")";
            return ss.str();

        }
        complex &operator +=(const complex &c) {
            real += c.re();
            imag += c.im();
            return *this;
        }
        complex &operator -=(const complex &c) {
            real -= c.re();
            imag -= c.im();
            return *this;
        }
        complex &operator *=(const complex &c) {
            double tmp = real * c.re() - imag * c.im();
            imag = imag * c.re() + real * c.im();
            real = tmp;
            return *this;
        }
        complex &operator /=(const complex &c) {
            double tmp = (real * c.re() + imag * c.im()) / c.abs2();
            imag = (imag * c.re() - real * c.im()) / c.abs2();
            real = tmp;
            return *this;
        }
        friend complex operator +(const complex &c1, const complex &c2) {
            complex z;
            z += c1;
            z += c2;
            return z;
        }
        friend complex operator -(const complex &c1, const complex &c2) {
            complex z;
            z += c1;
            z -= c2;
            return z;
        }
        friend complex operator *(const complex &c1, const complex &c2) {
            complex z;
            z += c1;
            z *= c2;
            return z;
        }
        friend complex operator /(const complex &c1, const complex &c2) {
            complex z;
            z += c1;
            z /= c2;
            return z;
        }
        complex operator ~() const {
            return complex(real, -imag);
        }
        complex operator -() const {
            return complex(-real, -imag);
        }

    };

    class complex_stack {

    };
}
