## How to build

Assuming a build directory is present using the following commands:
```
mkdir build; cd build; cmake ..; make -j
```
### Build with Makefile
`cd cs426-mp5/mp5_testcases` for mp5_testcases benchmark without the testcases in the fun/ directory or `cd cs426-mp5/tests` for unit tests
`make test-all`
1. Turns the given c files into input IR files.
2. Turns the tests IR files into optimized IR by running SCCP and LICM.
3. Turns the optimized IR files into executables (only programs that have main function).
4. Turns custom tests into IR files by running SCCP and LICM (doesn't compile to executable since our tests don't have main).

`make clean` to delete build artifacts.

### Build with python
From cs426-mp5/ directory,
simply run `python3 run.py all` to build:
1. Turns the given c files into IR files using mem2reg and loop-rotate pass.
2. Turns the given c files into executables (only programs that have main function).
3. Turns the tests IR files into optimized IR by running sccp and licm separately.
4. Turns the optimized IR files into executables (only programs that have main function).
5. Turns custom tests into IR files by running sccp and licm (doesn't compile to executable since our tests don't have main)

Run `python3 run.py clean` to delete all build artifacts.
