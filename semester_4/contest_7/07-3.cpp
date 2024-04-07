#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <sstream>

struct Comp {
    bool operator() (Figure *a, Figure *b) {
        return a->get_square() < b->get_square();
    }
};

int main() {
    std::string s, params;
    char type;
    std::vector<Figure*> v;
    while (std::getline(std::cin, s)) {
        std::istringstream ss(s);
        ss >> type;
        std::getline(ss, params);
        switch (type) {
            case 'R':
                v.push_back(Rectangle::make(params));
                break;
            case 'S':
                v.push_back(Square::make(params));
                break;
            case 'C':
                v.push_back(Circle::make(params));
                break;
        }
    }
    std::stable_sort(v.begin(), v.end(), Comp());
    for (std::vector<Figure*>::iterator it = v.begin(); it != v.end(); ++it) {
        std::cout << (*it)->to_string() << std::endl;
        delete *it;
    }
}