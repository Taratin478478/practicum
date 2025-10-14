// J. Маскарад

#include <iostream>
#include <sstream>
#include <string>
#include <map>
#include <vector>
#include <numeric>

int main() 
{
    int n, l;
    std::cin >> n >> l;
    std::vector<int> p(n), r(n), q(n), f(n);
    for (int i = 0; i < n; ++i) {
        std::cin >> p[i] >> r[i] >> q[i] >> f[i];
    }
    int total = std::accumulate(f.begin(), f.end(), 0);
    if (total < l) {
        std::cout << -1 << std::endl;
        return 0;
    }
    std::vector<std::vector<int>> dp(n, std::vector<int>(total)), ans(n, std::vector<int>(total));
    for (int j = 0; j < total && j + 1 <= f[0]; ++j) {
        if (j + 1 < r[0]) {
            dp[0][j] = p[0] * (j + 1);
        } else {
            dp[0][j] = q[0] * (j + 1);
        }
        ans[0][j] = j + 1;
    }
    int next;
    for (int i = 1; i < n; ++i) { // сколько максимум магазинов используем
        for (int j = 0; j < total && !(j - f[i] >= 0 && !dp[i-1][j - f[i]]); ++j) { // сколько метров ткани покупаем - 1
            if (j + 1 <= f[i]) {
                dp[i][j] = j + 1 < r[i] ? p[i] * (j + 1) : q[i] * (j + 1);
                ans[i][j] = j + 1;
            } else {
                dp[i][j] = dp[i - 1][j - f[i]] + (f[i] < r[i] ? p[i] * f[i] : q[i] * f[i]);
                ans[i][j] = f[i];
            }
            for (int k = std::max(1, j - f[i] + 1); k <= j + 1 && dp[i - 1][k-1]; ++k) { // сколько метров берем из предыдущих i-1 магазинов 
                next = dp[i - 1][k - 1] + (j + 1 - k < r[i] ? p[i] * (j + 1 - k) : q[i] * (j + 1 - k));
                if (next < dp[i][j]) {
                    dp[i][j] = next;
                    ans[i][j] = j + 1 - k;
                }

            }
        }
    }
    int tl = l;
    for (int j = l + 1; j < total; ++j) {
        if (dp[n - 1][j - 1] < dp[n - 1][tl - 1]) {
            tl = j;
        }
    }
    std::cout << dp[n-1][tl-1] << std::endl;
    std::vector<int> res;
    for (int i = n - 1; i >= 0; --i) {
        res.push_back(ans[i][tl - 1]);
        tl -= ans[i][tl - 1];
    }
    for (int i = n - 1; i >= 0; --i) {
        std::cout << res[i] << ' ';
    }
    std::cout << std::endl;
    return 0;
}
