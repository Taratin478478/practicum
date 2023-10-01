#include <stdio.h>

int main(void)
{
    double x, y;
    scanf("%lf %lf", &x, &y);
    if (x >= 2 && x <= 5 && y >= 1 && y <= 7 && y + 2 >= x)
    {
        printf("%d", 1);
    } else
    {
        printf("%d", 0);
    }
    return 0;
}
