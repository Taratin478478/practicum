#include <vector>


void
process(std::vector<long int> &a, long int n) {
    auto ia = a.rbegin();
    long int i = 0;
    while (ia != a.rend()) {
        if (*ia >= n) {
            a.push_back(*ia);
            ++i;
        }
        ia = a.rbegin() + ++i;
    }
}