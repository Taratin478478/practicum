#include "cmc_complex.h"
#include "cmc_complex_stack.h"
#include "cmc_complex_eval.h"
#include <numbers>

constexpr int COMPLEX_ARGN = 1, REAL_ARGN = 2, INT_ARGN = 3, RPN_ARGN = 4;

int main(int argc, char **argv)
{
    numbers::complex c{argv[COMPLEX_ARGN]};
    double r = std::stod(argv[REAL_ARGN]);
    int n = std::stoi(argv[INT_ARGN]), i;
    std::vector<std::string> v{};
    for (i = RPN_ARGN; i < argc; ++i) {
        v.emplace_back(argv[i]);
    }
    double angle_step = 2 * std::numbers::pi / n, angle = 0;
    numbers::complex integral{0, 0};
    numbers::complex cur{c.re() + r * cos(0), c.im() + r * sin(0)}, next{};
    for (i = 0; i < n; ++i) {
        angle += angle_step;
        next = {c.re() + r * cos(angle), c.im() + r * sin(angle)};
        integral += numbers::eval(v, cur) * (next - cur);
        cur = next;
    }
    std::cout << integral.to_string() << std::endl;
}