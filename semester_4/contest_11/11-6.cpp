#include <iostream>

char c;

void S();
void A();
void B();

void gc() {
    std::cin >> c;
    if (std::cin.eof()) {
        c = 0;
    }
}

void S() {
    if (c == 'a') {
        gc();
        A();
        if (c == 'b') {
            gc();
        } else {
            throw c;
        }
    } else if (c == 'c') {
        gc();
        B();
    } else {
        throw c;
    }
}

void A() {
    if (c == 'c') {
        gc();
        A();
        if (c == 'd') {
            gc();
        } else {
            throw c;
        }
    } else if (c == 'e') {
        gc();
    } else {
        throw c;
    }
}

void B() {
    if (c == 'b') {
        gc();
        B();
    } else if (c == 'd') {
        gc();
    }
}

int main() {
    try {
        gc();
        S();
        if (std::cin.eof()) {
            std::cout << 1 << std::endl;
        } else {
            std::cout << 0 << std::endl;
        }
    } catch(char) {
        std::cout << 0 << std::endl;
    }
}