// F. Плюсы, минусы и вопросы

#include <iostream>
#include <vector>

int main() 
{
    char c;
    unsigned long long n, m;
    std::cin >> n >> m;
    std::vector<int> rows(n), columns(m);
    std::vector<std::string> chars(n);
    std::getline(std::cin, chars[0]);
    for (int i = 0; i < n; ++i) {
        std::getline(std::cin, chars[i]);
    }
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            c = chars[i][j];
            if (c == '+') {
                ++rows[i];
                ++columns[j];
            } else if (c == '-') {
                --rows[i];
                --columns[j];
            } else {
                ++rows[i];
                --columns[j];
            }
        }
    }
    int max_diff, diff;
    max_diff = rows[0] - columns[0];
    if (chars[0][0] == '?') {
        max_diff -= 2;
    }
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            diff = rows[i] - columns[j];
            if (chars[i][j] == '?') {
                diff -= 2;
            }
            if (diff > max_diff) {
                max_diff = diff;
            }
        }
    }
    std::cout << max_diff;
	return 0;
}
