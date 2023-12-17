## How to build

Assuming a build directory is present using the following commands:
```
mkdir build; cd build; cmake ..; make -j
```
simply run `python3 run.py all` to build:
1. Turns the given c files into IR files using mem2reg and loop-rotate pass.
2. Turns the given c files into executables (only programs that have main function).
3. Turns the tests IR files into optimized IR by running sccp and licm separately.
4. Turns the optimized IR files into executables (only programs that have main function).
5. Turns custom tests into IR files by running sccp and licm (doesn't compile to executable since our tests don't have main)

Run `python3 run.py clean` to delete all build artifacts.
