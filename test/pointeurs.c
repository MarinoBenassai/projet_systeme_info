
int main () {
    int a, b = 0; 
    int c = &b;
    *(c - 1) = 1;
    *&b = 2;
    printf(a);
    printf(b);
}
