#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int main(void) {
    int a, b;
    char c;
    scanf("%d%c%d", &a, &c, &b);
    if (c == '+') {
        printf("%d", a + b);
    } else if (c == '-') {
        printf("%d", a - b);
    } else if (c == '*') {
        printf("%d", a * b);
    } else if (c == '/') {
        printf("%d", a / b);
    }
    return 0;
}