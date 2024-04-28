#include <iostream>
#include <map>
#include <string>
#include <set>

int main() {
    std::multimap<char, std::string> m;
    char left;
    std::string right;
    while (std::cin >> left >> right) {
        m.insert(std::make_pair(left, right));
    }
    std::set<char> s1{}, s2{'S'};
    while (s1 != s2) {
        s1 = s2;
        for (auto c: s1) {
            auto pit = m.equal_range(c);
            for (auto it = pit.first; it != pit.second; ++it) {
                for (auto x: it->second) {
                    s2.insert(x);
                }
            }
        }
    }
    for (auto it = m.begin(); it != m.end();) {
        if (!s2.contains(it->first)) {
            it = m.erase(it);
        } else {
            bool deleted = false;
            for (auto x: it->second) {
                if (!s2.contains(x)) {
                    it = m.erase(it);
                    deleted = true;
                }
            }
            if (!deleted) {
                ++it;
            }
        }
    }
    for (auto &x: m) {
        std::cout << x.first << ' ' << x.second << std::endl;
    }
}