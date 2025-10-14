// I. Цепочка в таблице*

#include <iostream>
#include <vector>

struct num {
    int val;
    int i;
    int j;
    auto operator<=>(const num&) const = default;
};

int main() 
{
    int n, m, val, left;
    std::cin >> n >> m;
    left = n * m;
    std::vector<num> nums;
    std::vector<std::vector<int>> v(n, std::vector<int>(m)), dp(n, std::vector<int>(m));
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            std::cin >> val;
            nums.emplace_back(val, i, j);
            v[i][j] = val;
        }
    }
    std::sort(nums.begin(), nums.end());
    int di[] = {-1, 1, 0, 0};
    int dj[] = {0, 0, -1, 1};
    int i, j, res = 0;
    for (const auto &num: nums) {
        for (int k = 0; k < 4; ++k) {
            i = num.i + di[k];
            j = num.j + dj[k];
            if (i >= 0 && i < n && j >= 0 && j < m && v[i][j] == v[num.i][num.j] - 1) {
                dp[num.i][num.j] = std::max(dp[num.i][num.j], dp[i][j] + 1);
            }
        }
        if (dp[num.i][num.j] == 0) {
            dp[num.i][num.j] = 1;
        }
        res = std::max(res, dp[num.i][num.j]);
    }
    std::cout << res;
}
