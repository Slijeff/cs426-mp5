int main() {
    int a = 0;
    int b = 1;
    int f;
    for (int i = 0; i < 10; i++) {
        int c = a + b;
        int d = 2 + 3;
        int e = c * d;
        for (int j = 0; j < 10; j++) {
            f = d * e * c;
        }
    }
    return f;
}