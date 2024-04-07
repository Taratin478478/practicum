#include <string>
#include <iomanip>
#include <vector>
#include <map>
#include <functional>


namespace numbers
{

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
