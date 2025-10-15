// H. Разрезанная строка

#include <iostream>
#include <map>
#include <string>
#include <vector>

int main() 
{
    char c;
    int n, m, maxl = 0, len;
    std::cin >> n >> m;
    std::string str, cur;
    std::map<int, std::map<std::string, std::vector<int>>> subs;
    std::getline(std::cin, str);
    std::getline(std::cin, str);
    for (int i = 0; i < m; ++i) {
        std::getline(std::cin, cur);
        len = cur.length();
        if (!subs.contains(len) || !subs[len].contains(cur)) {
            subs[len][cur] = {i};
        } else {
            subs[len][cur].push_back(i);
        }
        if (len > maxl) {
            maxl = len;
        }
    }
    len = maxl;
    int i = 0;
    while (i < n) {
        cur = str.substr(i, len);
        if (subs[len].contains(cur) && subs[len][cur].size() > 0) {
            std::cout << subs[len][cur].back() + 1 << ' ';
            subs[len][cur].pop_back();
            i += len;
            len = maxl;
        } else {
            --len;
            if (len == 0) {
                std::cout << ":(" << std::endl;
                return 0;
            }
        }
    }
	return 0;
}
