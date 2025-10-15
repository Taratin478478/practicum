// A. Мячик на лесенке

#include <iostream>
#include <vector>

int main() 
{
    int N;
    std::cin >> N;
    std::vector<long long> dp(N);
    dp[0] = 1;
    if (N >= 2) {
        dp[1] = 2;
    }
    if (N >= 3) {
        dp[2] = 4;
    }
    for (int i = 3; i < N; ++i) {
        dp[i] = dp[i - 1] + dp[i - 2] + dp[i - 3];
    }
    std::cout << dp.back();
	return 0;
}
