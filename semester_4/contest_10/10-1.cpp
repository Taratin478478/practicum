#include <string>
#include <iostream>

int main() {
    std::string left, right;
    bool is_non_shortening = true, has_starting_in_right = false, has_eps_in_starting = false,
            has_automatic_exception = false, automatic = true, regular = true,
            right_regular = true, left_regular = true;
    while (std::cin >> left >> right) {
        if ((regular && std::isupper(right.front()))) {
            for (auto it = right.begin() + 1; it != right.end(); ++it) {
                if (std::isupper(*it)) {
                    regular = false;
                }
            }
            if (right.length() > 1) {
                right_regular = false;
                if (!left_regular) {
                    regular = false;
                }
            }
            if (regular && automatic) {
                if (right.length() == 1 && left.length() == 1 && left.front() == 'S') {
                    has_automatic_exception = true;
                } else if (right.length() != 2) {
                    automatic = false;
                }
            }
        } else if (regular && (std::isupper(right.back()))) {
            for (auto it = right.rbegin() + 1; it != right.rend(); ++it) {
                if (std::isupper(*it)) {
                    regular = false;
                }
            }
            if (right.length() > 1) {
                left_regular = false;
                if (!right_regular) {
                    regular = false;
                }
            }
            if (regular && automatic) {
                if (right.length() == 1 && left.length() == 1 && left.front() == 'S') {
                    has_automatic_exception = true;
                } else if (right.length() != 2) {
                    automatic = false;
                }
            }
        } else if (regular) {
            for (auto c:right) {
                if (std::isupper(c)) {
                    regular = false;
                    break;
                }
            }
            if (regular && automatic) {
                if (left.length() == 1 && left.front() == 'S' && right.length() == 1 && right.front() == '_') {
                    has_automatic_exception = true;
                } else if (right.length() != 1 || right.front() == '_') {
                    automatic = false;
                }
            }

        }
        for (auto c: right) {
            if (c == 'S') {
                has_starting_in_right = true;
            }
        }
        if (left.length() == 1 && left[0] == 'S') {
            if (right.length() == 1 && right[0] == '_') {
                has_eps_in_starting = true;
            }
        } else if (right.length() == 1 && right[0] == '_') {
            is_non_shortening = false;
        }
        if (right.length() < left.length()) {
            is_non_shortening = false;
        }
    }
    if (has_eps_in_starting && has_starting_in_right) {
        is_non_shortening = false;
    }
    if (has_starting_in_right && has_automatic_exception) {
        automatic = false;
    }
    if (!regular) {
        if (!is_non_shortening) {
            std::cout << 2 << std::endl;
        } else {
            std::cout << 21 << std::endl;
        }
    } else if (!automatic) {
        if (left_regular) {
            std::cout << 31 << std::endl;
        } else {
            std::cout << 32 << std::endl;
        }
    } else {
        if (left_regular) {
            std::cout << 311 << std::endl;
        } else {
            std::cout << 321 << std::endl;
        }
    }
}