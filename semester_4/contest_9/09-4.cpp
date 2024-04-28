/*
грамматика:
 S->aAd
 A->aAd|bBc
 B->bBc|eps
 */

#include <iostream>

void S(int, int);
void A(int, int);
void B(int);

void S(int k, int n) {
    std::cout << 'a';
    A(k - 2, n - 2);
    std::cout << 'd';
}

void A(int k, int n) {
    if (n >= 2) {
        std::cout << 'a';
        A(k - 2, n - 2);
        std::cout << 'd';
    } else {
        std::cout << 'b';
        B(k - 2);
        std::cout << 'c';
    }
}

void B(int k) {
    if (k >= 2) {
        std::cout << 'b';
        B(k - 2);
        std::cout << 'c';
    }
}

void rec(int k, int n) {
    if (n >= 2) {
        S(k, n);
        std::cout << std::endl;
        rec(k, n - 2);
    }
}

int main() {
    int k;
    std::cin >> k;
    if (k % 2 == 0) {
        rec(k, k - 2);
    }
}