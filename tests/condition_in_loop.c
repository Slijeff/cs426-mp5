#include <stdlib.h>

int main() {
  int a = 0;
  int b = 1;
  int f;
  for (int i = 0; i < 10; i++) {
    int c = a + b;
    int d = 2 + 3;
    int e = c * d;
    if ((rand() % 100 + 1) > 50) {
      f = 10086;
    } else {
      f = 114514;
    }
  }
  return f;
}