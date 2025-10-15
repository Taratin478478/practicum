// B. Поход

#include <iostream>
#include <vector>

int main() 
{
    char c, last;
    std::vector<long long> l, r;
    l.push_back(0);
    r.push_back(1);
    int i = 0;
    while (std::cin >> c) {
        if (c == 'L') {
            l.push_back(std::min(l[i] + 1, r[i] + 1));
            r.push_back(std::min(l[i] + 2, r[i]));
        } else if (c == 'R') {
            l.push_back(std::min(l[i], r[i] + 2));
            r.push_back(std::min(l[i] + 1, r[i] + 1));
        } else if (c == 'B') {
            l.push_back(std::min(l[i] + 1, r[i] + 2));
            r.push_back(std::min(l[i] + 2, r[i] + 1));
        }
        ++i;
    }
    std::cout << r.back();
	return 0;
}
