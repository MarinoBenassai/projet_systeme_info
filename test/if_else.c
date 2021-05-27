int main() {
    int i ,j, k;
    i = 0;
    j = 1;
    k = 2;
    int res = 10;
    if (2 * j == k){
        res = res * 2;
        int res2 = 1;
        if ( i != j && k > j || k != k){
            res2 = res2 *2;        
        }
        else{
            res = 0;
            res2 = 0;
        }
        
        if (!(i!=2)){
            res = 0;
            res2 = 0;
        }
        else{
           res = res * 2;        
        }
        
        res = 2 * res2 + res;
    }
    printf(res);
}
