#include <iostream>
#include <cstdint>
#include <climits>

using std::cin, std::cout, std::endl;

int
main() {
    const uint32_t LINE_SIZE = 16;
    uint32_t count, n = 0, b;
    cin >> std::hex;
    while (cin >> b) {
        count = 0;
        while ((count < LINE_SIZE) && (cin >> b)) {
            n <<= CHAR_BIT;
            n |= b;
            count++;
            if (count % sizeof(n) == 0) {
                cout << n << endl;
                n = 0;
            }
        }
    }
}