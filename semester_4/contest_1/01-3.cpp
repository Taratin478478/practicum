#include <cmath>
#include <iostream>
#include <iomanip>

using std::cin;
using std::cout;

int
main() {
    std::ios::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
    char c;
    bool isz = true, ln = false;
    while ((c = cin.get()) != EOF) {
        if (c >= '0' && c <= '9') {
            if (c != '0' || !isz) {
                isz = false;
                cout << c;
            }
            ln = true;
        } else {
            if (ln && isz) {
                cout << '0';
            }
            cout << c;
            isz = true;
            ln = false;
        }
    }
    if (ln && isz) {
        cout << '0';
    }
}