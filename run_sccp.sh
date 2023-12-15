opt-15 -load-pass-plugin=./build/libUnitProject.so \
 -passes="unit-sccp" \
  ./tests/"$1".ll -S -o ./tests/"$1".ll