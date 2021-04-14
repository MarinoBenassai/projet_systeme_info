#include <stdio.h>

int main () {
    int i = 0354;
    int j = 1561;
    int k = -542;
    i = -(j + k * j + j - k / j * j) * (k - j * k / k);
    printf("%d",i);
}
