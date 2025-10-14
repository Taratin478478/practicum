// F. Сбор монеток

#include <iostream>
#include <string>
#include <vector>
#include <array>

int main() {
    std::string s;
    int n, res = 0;
    std::cin >> n >> std::ws;
    std::vector<std::array<int, 3>>dp(n + 1);
    dp[0] = {0, 0, 0};
    for(int i = 1; i <= n; ++i) {
        std::getline(std::cin, s);
        dp[i][0] = s[0] == 'W' || (dp[i-1][0] == -1 && dp[i-1][1] == -1) ? -1 : std::max(dp[i-1][0], dp[i-1][1]) + int(s[0] == 'C');
        dp[i][1] = s[1] == 'W' || (dp[i-1][0] == -1 && dp[i-1][1] == -1 && dp[i-1][2] == -1) ? -1 : std::max(dp[i-1][0], std::max(dp[i-1][1], dp[i-1][2])) + int(s[1] == 'C');
        dp[i][2] = s[2] == 'W' || (dp[i-1][1] == -1 && dp[i-1][2] == -1) ? -1 : std::max(dp[i-1][1], dp[i-1][2]) + int(s[2] == 'C');
        if (dp[i][0] == -1 && dp[i][1] == -1 && dp[i][2] == -1) {
            std::cout << res << std::endl;
            return 0;
        } else {
            res = std::max(dp[i][0], std::max(dp[i][1], dp[i][2]));
        }
    }
    std::cout << res << std::endl;
    return 0;
}