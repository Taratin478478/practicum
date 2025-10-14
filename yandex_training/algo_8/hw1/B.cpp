// B. Мамины поручения

#include <iostream>
#include <algorithm>

int main() 
{
    double AB, AC, BC, v0, v1, v2, ans;
    std::cin >> AB >> AC >> BC >> v0 >> v1 >> v2;
    AB = std::min(AB, AC + BC);
    AC = std::min(AC, AB + BC);
    BC = std::min(BC, AB + AC);
    // std::cout << AB << ' ' << AC << ' ' << BC <<std::endl;
    // std::cout << AB / v0 + BC / v1 + AC / v2 << ' ' <<  AC / v0 + BC / v1 + AB / v2 << ' ' <<  AB / v0 + AB / v1 + AC / v0 + AC / v1;
    std::cout << std::min({AB / v0 + BC / v1 + AC / v2, AC / v0 + BC / v1 + AB / v2, AB / v0 + AB / v1 + AC / v0 + AC / v1});
	return 0;
}
