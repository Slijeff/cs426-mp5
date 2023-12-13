clang-15 ./tests/$1.c -c -O0 -Xclang -disable-O0-optnone -emit-llvm -S -o ./tests/$1.ll;
opt-15 -load-pass-plugin=./build/libUnitProject.so \
 -passes="mem2reg,loop-rotate" \
  ./tests/$1.ll -S -o ./tests/$1.ll;