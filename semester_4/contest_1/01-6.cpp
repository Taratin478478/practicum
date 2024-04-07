#include <iostream>
#include <iomanip>
#include <utility>
#include <limits>

using std::cin, std::cout, std::endl, std::pair, std::abs;

bool eps_equal(long double a, long double b) // almost equal relative
{
    long double diff = abs(a - b);
    a = abs(a);
    b = abs(b);
    long double largest = b > a ? b : a;
    if (diff <= largest * std::numeric_limits<long double>::epsilon()) {
        return true;
    }
    return false;
}

class Point {
    long double x, y;

    friend class Line;

public:
    explicit Point(long double x = 0, long double y = 0) : x(x), y(y) {}

    long double get_x() const { return x; }

    long double get_y() const { return y; }
};

class Line {
    Point p1, p2;

    friend pair<int, Point> line_intersection(Line &l1, Line &l2);

public:
    Line(Point p1, Point p2) : p1(p1), p2(p2) {}

    Line(long double x1, long double y1, long double x2, long double y2) : p1(Point(x1, y1)),
                                                                           p2(Point(x2, y2)) {}

    long double get_det() const {
        return p1.x * p2.y - p2.x * p1.y;
    };

    long double get_x_diff() const {
        return p1.x - p2.x;
    }

    long double get_y_diff() const {
        return p1.y - p2.y;
    }
};

pair<int, Point> line_intersection(Line &l1, Line &l2) {
    pair<int, Point> p;
    long double dif1x = l1.get_x_diff(), dif1y = l1.get_y_diff(), dif2x = l2.get_x_diff(), dif2y = l2.get_y_diff(),
            denominator = dif1x * dif2y - dif2x * dif1y, det1 = l1.get_det(), det2 = l2.get_det();
    if (eps_equal(denominator, 0)) {
        if (eps_equal(dif1y * (l2.p1.get_x() - l1.p1.get_x()), dif1x * (l2.p1.get_y() - l1.p1.get_y()))
            && eps_equal(dif1y * (l2.p2.get_x() - l1.p1.get_x()), dif1x * (l2.p2.get_y() - l1.p1.get_y()))) {
            p.first = 2;
        } else {
            p.first = 0;
        }
    } else {
        p.first = 1;
        p.second = Point((det1 * dif2x - det2 * dif1x) / denominator,
                         (det1 * dif2y - det2 * dif1y) / denominator);
    }
    return p;
}

int main() {
    int x1, x2, x3, x4, y1, y2, y3, y4;
    cin >> x1 >> y1 >> x2 >> y2 >> x3 >> y3 >> x4 >> y4;
    Line l1(x1, y1, x2, y2), l2(x3, y3, x4, y4);
    pair<int, Point> p = line_intersection(l1, l2);
    cout << p.first;
    if (p.first == 1) {
        cout << ' ' << std::setprecision(10) << p.second.get_x() << ' ' << p.second.get_y();
    }
    cout << endl;

}