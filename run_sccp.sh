opt-15 -load-pass-plugin=./build/libUnitProject.so \
 -passes="unit-sccp" \
  ./mp5_testcases_ll/"$1".ll -S -o ./sccp_output/"$1".ll