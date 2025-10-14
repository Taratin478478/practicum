// C. Кибербезопасность

#include <iostream>
#include <vector>

int main() 
{
    long long ans{1};
    std::vector<long long> v(26, 0);
    char c;
    while (std::cin.get(c)) {
        if (c >= 'a' && c <= 'z') {
        ++v[c - 'a'];
        }
    }
    for (int i = 0; i < 26; ++i) {
        for (int j = i + 1; j < 26; ++j) {
            ans += v[i] * v[j];
        }
    }
    std::cout << ans;
	return 0;
}
