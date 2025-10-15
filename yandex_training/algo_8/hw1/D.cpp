// D. Отборочный контест

#include <iostream>
#include <map>
#include <vector>

int main() 
{
    int n, k, a;
    std::map<int, int> tasks;
    std::cin >> n >> k;
    while (std::cin >> a) {
        if (!tasks.contains(a)) {
            tasks[a] = 1;
        } else {
            ++tasks[a];
        }
    }
    for (auto& [theme, count] : tasks) {
        std::cout << theme << ' ';
        --count;
        --k;
        if (k == 0) {
            return 0;
        }
    } 
    for (auto& [theme, count] : tasks) {
        for (int i = 0; i < count; ++i) {
            std::cout << theme << ' ';
            --k;
            if (k == 0) {
                return 0;
            }
        }
    }
	return 0;
}
