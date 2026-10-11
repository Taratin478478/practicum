#include <vector>
#include <string>
#include <iostream>

int main() {
    

    std::string s = "abacabadabacaba";
    std::string ss = "aba";
    std::string t = ss + "$" + s;
    std::cout << t << std::endl;
    auto n = s.length(), m = ss.length();
    std::vector<int> z(n + m + 1);
    int l = 0, r = 0;

    std::cout << "0";
    for (int i = 1; i < n + m + 1; ++i) {
        if (i < r) {
            z[i] = std::min(z[i - l], r - i);
        }
        while (z[i] + i < n + m + 1 && t[z[i]] == t[z[i] + i]) {
            z[i]++;
        }
        if (i + z[i] > r) {
            l = i;
            r = i + z[i];
        }
        std::cout << z[i];
    }
    std::cout << std::endl;
    for (int i = m; i < n + m + 1; ++i) {
        if (z[i] == m) {
            std::cout << i - m - 1 << " ";
        }
    }
}