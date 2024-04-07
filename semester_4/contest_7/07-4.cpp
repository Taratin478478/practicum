#include <iostream>
#include <cmath>

namespace Game {
    template<typename T>
    class Coord {
    public:
        using value_type = T;
        T row{}, col{};

        explicit Coord(T row = 0, T col = 0) : row{row}, col{col} {}

        Coord(std::initializer_list<T> l) {
            auto it = l.begin();
            if (l.size() > 0) {
                row = *it;
                if (l.size() > 1) {
                    ++it;
                    col = *it;
                }
            }
        }
    };

    template<typename T>
    auto dist(const T &size, const T &x1, const T &x2) {
        typename T::value_type drow{(x1.row - (x1.col + 1) / 2) - (x2.row - (x2.col + 1) / 2)}, dcol{x1.col - x2.col};
        return ((drow >= 0 && dcol >= 0) || (drow < 0 && dcol < 0)) ? abs(drow + dcol) : std::max(abs(drow), abs(dcol));
    }

}
