// G. Пять подряд

#include <iostream>
#include <vector>

int main() 
{
    char curr, next;
    int n, m;
    int count;
    std::cin >> n >> m;
    std::vector<std::string> chars(n);
    std::getline(std::cin, chars[0]);
    for (int i = 0; i < n; ++i) {
        std::getline(std::cin, chars[i]);
    }
    for (int i = 0; i < n; ++i) {
        curr = chars[i][0];
        count = 1;
        for (int j = 1; j < m; ++j) {
            next = chars[i][j];
            if (curr == 'X' && next == 'X') {
                ++count;
            } else if (curr == 'O' && next == 'O') {
                ++count;
            } else {
                curr = next;
                count = 1;
            }
            if (count == 5) {
                std::cout << "Yes" << std::endl;
                return 0;
            }
        }
    }
    for (int i = 0; i < m; ++i) {
        curr = chars[0][i];
        count = 1;
        for (int j = 1; j < n; ++j) {
            next = chars[j][i];
            if (curr == 'X' && next == 'X') {
                ++count;
            } else if (curr == 'O' && next == 'O') {
                ++count;
            } else {
                curr = next;
                count = 1;
            }
            if (count == 5) {
                std::cout << "Yes" << std::endl;
                return 0;
            }
        }
    }
    int r, c;
    for (int i = 0; i < m + n - 1; ++i) {
        r = i < m ? 0 : i - m + 1;
        c = i < m ? m - i - 1 : 0;
        curr = chars[r][c];
        count = 1;
        ++r;
        ++c;
        while (r < n && c < m) {
            next = chars[r][c];
            if (curr == 'X' && next == 'X') {
                ++count;
            } else if (curr == 'O' && next == 'O') {
                ++count;
            } else {
                curr = next;
                count = 1;
            }
            if (count == 5) {
                std::cout << "Yes" << std::endl;
                return 0;
            }
            ++r;
            ++c;
        }
    }
    for (int i = 0; i < m + n - 1; ++i) {
        r = i < n ? i : n - 1;
        c = i < n ? 0 : i - n + 1;
        curr = chars[r][c];
        count = 1;
        --r;
        ++c;
        while (r >= 0 && c < m) {
            next = chars[r][c];
            if (curr == 'X' && next == 'X') {
                ++count;
            } else if (curr == 'O' && next == 'O') {
                ++count;
            } else {
                curr = next;
                count = 1;
            }
            if (count == 5) {
                std::cout << "Yes" << std::endl;
                return 0;
            }
            --r;
            ++c;
        }
    }
    std::cout << "No" << std::endl;
	return 0;
}
