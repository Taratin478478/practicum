// C. Расписание для взвешенных интервалов*

#include <iostream>
#include <vector>
#include <array>
#include <numeric>

int bin_search(const auto &v, int x) {
    int l = 0, r = x, m;
    while (l <= r) {
        m = (l + r + 1) / 2;
        if (v[m][1] > v[x][0]) {
            r = m - 1;
        } else {
            l = m + 1;
        }
    }
    return l;
}

int main() 
{
    int N;
    std::cin >> N;
    if (N == 0) {
        std::cout << 0 << std::endl;
        return 0;
    }
    std::vector<std::array<double, 3>> v(N);
    std::vector<double> dp(N+1);
    for (int i = 0; i < N; ++i) {
        std::cin >> v[i][0] >> v[i][1] >> v[i][2];
    }
    std::sort(v.begin(), v.end(), [](std::array<double, 3> a, std::array<double, 3> b){
        return a[1] < b[1];
    });
    int prev;
    dp[0] = 0;
    for (int i = 1; i < N+1; ++i) {
        prev = bin_search(v, i-1);
        dp[i] = std::max(dp[prev] + v[i-1][2], dp[i-1]);
    }
    std::cout << dp[N] << std::endl;
	return 0;
}
