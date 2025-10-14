// E. Башня

#include <iostream>
#include <string>
#include <vector>
#include <set>
#include <utility>

long long compute_strength(const std::vector<long long> &a, int i, int k) {
    long long ans = 0, min = a[i - k];
    for (int j = i - k; j < i; ++j) {
        ans += a[j];
        if (a[j] < min) {
            min = a[j];
        }
    }
    ans *= min;
    return ans;
}

int main() {
    int n, k, q;
    std::cin >> n >> k;
    std::vector<long long> a(n);
    for (int i = 0; i < n; ++i) {
        std::cin >> a[i];
    }
    std::vector<long long> towers(n + 1);
    for (int i = k; i <= n; ++i) {
        towers[i] = compute_strength(a, i, k);
    }
    std::vector<long long> dp(n + 1), ind(n + 1);
    for (int i = k; i <= n; ++i) {
        dp[i] = std::max(dp[i - k] + towers[i], dp[i-1]);
        if (dp[i] == dp[i-1]) {
            ind[i] = ind[i-1];
        } else {
            ind[i] = i;
        }
    }
    int i = ind[n];
    std::vector<long long> ans;
    while (i > 0) {
        ans.push_back(i - k + 1);
        i = ind[i - k];
    }
    std::cout << ans.size() << std::endl;
    for (i = ans.size() - 1; i >= 0; --i) {
        std::cout << ans[i] << ' ';
    }
    std::cout << std::endl;
    int qwe;
}