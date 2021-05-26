
int main () {
    int i = 0354;
    int j = 1561;
    int k = -542;
    i = -(j + k * j + j - k / j * j) * (k - j * k / k);
    printf(i);

    int a = 1;
    int b = 2;
    int c = 3;
    int res = 0;
    if (a == b){
        printf(a);
    }
    if (c == a + b){
        c = 1;
        a = 3;
        printf(a);
        if (!c != 0){
            res = 42;
        }
        if (c > c || a == !b) {
            res = 1515;
        }
    }
    printf(res);

}
