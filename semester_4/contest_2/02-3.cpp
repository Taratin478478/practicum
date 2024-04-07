#include <cmath>
#include <iostream>
#include <iomanip>

using std::cin, std::cout;

constexpr int COMPR_STR_SIZE = 4;

void print_chars(int c, int n) {
    if (n <= 0) {
        return;
    }
    if (n <= COMPR_STR_SIZE && c != '#') {
        for (int i = 0; i < n; ++i) {
            cout << static_cast<char>(c);
        }
    } else {
        cout << '#' << static_cast<char>(c) << std::hex << n << '#';
    }
}

int main() {
    int c, last = 0, count = 0;
    bool first = true;
    while ((c = cin.get()) != EOF) {
        if (first) {
            count = 1;
            first = false;
        } else {
            if (c == last) {
                ++count;
            } else {
                print_chars(last, count);
                count = 1;
            }
        }
        last = c;
    }
    print_chars(last, count);
}