CLANG = clang-15
OPT = opt-15

SRCS := $(wildcard *.c)

LICMOUTSUFFIX := -licm.ll
MAINPROGRAMS := almabench${LICMOUTSUFFIX} fannkuch${LICMOUTSUFFIX} ffbench${LICMOUTSUFFIX} n-body${LICMOUTSUFFIX} nsieve-bits${LICMOUTSUFFIX} partialsums${LICMOUTSUFFIX} PR491${LICMOUTSUFFIX} puzzle${LICMOUTSUFFIX} recursive${LICMOUTSUFFIX} spectral-norm${LICMOUTSUFFIX}

# Disable built-in rules and variables
.SUFFIXES:

.PRECIOUS: %.c %.ll %-licm.ll %.bin

default: test-all
test-all: licmll sccpll bin check
testcasesll: $(SRCS:%.c=%.ll)
licmll: $(SRCS:%.c=%-licm.ll)
bin: $(MAINPROGRAMS:%${LICMOUTSUFFIX}=%.bin)
sccpll: $(SRCS:%.ll=%-sccp.ll)
check: $(MAINPROGRAMS:%${LICMOUTSUFFIX}=%.out)

%.ll: %.c
	clang-15 $< -c -O0 -Xclang -disable-O0-optnone -emit-llvm -S -o $@

%-licm.ll: %.ll
	opt-15 -load-pass-plugin=../build/libUnitProject.so -passes="function(mem2reg,instcombine,simplifycfg,adce),inline,loop-simplify,globaldce,function(sroa,early-cse,unit-sccp,jump-threading,correlated-propagation,simplifycfg,instcombine,simplifycfg,reassociate,unit-licm,adce,simplifycfg,instcombine),globaldce"  $< -S -o $@

%.bin: %-licm.ll
	clang-15 -lm $< -o $@

%-sccp.ll: %.ll
	opt-15 -load-pass-plugin=../build/libUnitProject.so -passes="function(mem2reg,instcombine,simplifycfg,adce),inline,loop-simplify,globaldce,function(sroa,early-cse,unit-sccp,jump-threading,correlated-propagation,simplifycfg,instcombine,simplifycfg,reassociate,unit-licm,adce,simplifycfg,instcombine),globaldce"  $< -S -o $@

%.out: %.bin
	./$< > $@ || true

clean:
	rm -f *.bin *.ll *.out *.${LICMOUTSUFFIX}
