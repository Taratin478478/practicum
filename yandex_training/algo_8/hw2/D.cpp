// D. Словарь

#include <iostream>
#include <string>
#include <vector>
#include <set>
#include <utility>

int main() {
    std::string s, w;
    int n, m, k;
    std::vector<std::string> words;
    std::cin >> s >> n >> std::ws;
    m = s.size();
    std::vector<int> dp(m+1, -1), ind(m);
    dp[0] = 0;
    for (int i = 0; i < n; ++i) {
        std::getline(std::cin, w);
        words.push_back(w);
    }
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            k = words[j].size();
            if (k <= i + 1 && s.substr(i - k + 1, k) == words[j] && dp[i - k + 1] != -1) {
                dp[i + 1] = ind[i - k];
                ind[i] = j;
                break;
            }
        }
    }
    int i = m-1;
    std::vector<int> ans;
    while (i >= 0) {
        ans.push_back(ind[i]);
        i -= words[ind[i]].size();
    }
    for (int i = ans.size() - 1; i >= 0; --i) {
        std::cout << words[ans[i]] << ' ';
    }
    std::cout << std::endl;
    int asd;
}