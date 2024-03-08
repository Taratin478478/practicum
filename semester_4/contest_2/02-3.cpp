#include <cmath>
#include <iostream>
#include <iomanip>

using std::cin, std::cout;

void print_chars(int c, int n) {
    if (n <= 0) {
        return;
    }
    if (n <= 4 && c != '#') {
        for (int i = 0; i < n; ++i) {
            cout << char(c);
        }
    } else {
        cout << '#' << char(c) << std::hex << n << '#';
    }
}

int main() {
    int c, last = 0;
    int count = 0, first = 1;
    while ((c = cin.get()) != EOF) {
        if (first) {
            count = 1;
            first = 0;
        } else {
            if (c == last) {
                count++;
            } else {
                print_chars(last, count);
                count = 1;
            }
        }
        last = c;
    }
    print_chars(last, count);
}