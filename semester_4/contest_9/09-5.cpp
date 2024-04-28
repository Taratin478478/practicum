#include <string>
#include <iostream>

int main() {
    std::string left, right;
    bool has_starting = false, has_capital, is_non_shortening = true, is_context_free = true, has_starting_in_right = false, has_eps_in_starting = false;
    int size = 0;
    while (std::cin >> left >> right) {
        has_capital = false;
        for (auto c: left) {
            if (std::isupper(c)) {
                has_capital = true;
                break;
            }
        }
        for (auto c: right) {
            if (c == 'S') {
                has_starting_in_right = true;
            }
        }
        if (!has_capital) {
            std::cout << -1 << std::endl;
            return 0;
        }
        if (left.length() == 1 && left[0] == 'S') {
            has_starting = true;
            if (right.length() == 1 && right[0] == '_') {
                has_eps_in_starting = true;
            }
        } else if (right.length() == 1 && right[0] == '_') {
            is_non_shortening = false;
        }
        if (!(left.length() == 1 && std::isupper(left[0]))) {
            is_context_free = false;
        }
        if (right.length() < left.length()) {
            is_non_shortening = false;
        }
        ++size;
    }
    if (has_eps_in_starting && has_starting_in_right) {
        is_non_shortening = false;
    }
    if (size == 0 || !has_starting) {
        std::cout << -1 << std::endl;
    } else if (!is_context_free) {
        std::cout << 10 << std::endl;
    } else if (!is_non_shortening) {
        std::cout << 2 << std::endl;
    } else {
        std::cout << 23 << std::endl;
    }
}