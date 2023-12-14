int main() {
  int a = 1;
  long b = 2 + a;
  int c = a + b;
  if (c < 5) {
    c = 1;
  } else {
    c = 0;
  }
  return c;
}