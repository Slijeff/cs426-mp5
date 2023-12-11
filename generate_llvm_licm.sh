# we want to generate the LLVM IR with all the optimization applied prior
# to the specific pass

# for example, before our LICM pass, these optimizations are applied: 
# function(mem2reg,instcombine,simplifycfg,adce),inline,loop-simplify,globaldce,function(sroa,early-cse,unit-sccp,jump-threading,correlated-propagation,simplifycfg,instcombine,simplifycfg,reassociate)

# So we generate LLVM IR from a c file with those optimization applied, then
# we can run opt-15 again to test our program, without specifying those passes

# Another approach is to generate an unoptimized IR using clang-15 directly,
# and later specify those passes when running our optimization. But I'd like
# to look at the IR that our optimization takes as input, which helps debugging.

clang-15 ./tests/$1.c -c -O0 -Xclang -disable-O0-optnone -emit-llvm -S -o ./tests/$1.ll;
opt-15 -load-pass-plugin=./build/libUnitProject.so \
 -passes="mem2reg,loop-rotate,unit-sccp" \
  ./tests/$1.ll -S -o ./tests/$1.ll;