opt-15 -load-pass-plugin=./build/libUnitProject.so \
 -passes="unit-licm" \
 ./mp5_testcases_ll/"$1".ll -S -o ./"$1".ll
#  ./tests/"$1".ll -S -o ./"$1".ll