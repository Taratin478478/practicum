// G. Лесенки

#include <iostream>
#include <vector>

void print_dp(auto const &dp, long long n) {
    for (int i = n; i >= 0; --i) {
        for (int j = 0; j < n+1; ++j) {
            std::cout << dp[i][j] << ' ';
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;
}

int main() {
    long long n, s = 3, b = 2;
    std::cin >> n;
    std::vector<std::vector<int>> dp(n+1, std::vector<int>(n+1));
    for (int i = 0; i < n+1; ++i) {
        dp[i][0] = 1;
    }
    for (int j = 1; j < n+1; ++j) {
        for (int i = 1; i < n+1; ++i) {
            if (j - i >= 0) {
                dp[i][j] = dp[i - 1][j] + dp[i - 1][j - i];
            } else {
                dp[i][j] = dp[i - 1][j];
            }
            //std::cout << i << ' ' << j << std::endl;
            //print_dp(dp, n);
        }
    }

    std::cout << dp[n][n] << std::endl;
    return 0;
}