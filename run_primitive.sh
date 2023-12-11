opt-15 -load-pass-plugin=./build/libUnitProject.so \
 -passes="unit-licm" \
  ./tests/"$1".ll