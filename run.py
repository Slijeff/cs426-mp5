import os
import subprocess
import sys
from dataclasses import dataclass


# Writing this cuz idk how to do this in a Makefile
# Only use this to compile official tests, other functionality not working

@dataclass
class Config:
    official_ll_output_dir = "./mp5_testcases_ll"
    compile_to_ll_flags = "-c -O0 -Xclang -disable-O0-optnone -emit-llvm -S".split(" ")

    sccp_output_dir = "./sccp_output"


def compile_official(src_dir):
    if not os.path.exists(Config.official_ll_output_dir):
        os.mkdir(Config.official_ll_output_dir)
    c_files = [file for file in os.listdir(src_dir) if file.endswith('.c')]
    ll_files = [os.path.join(Config.official_ll_output_dir, os.path.splitext(file)[0] + '.ll') for file in c_files]

    # Compile each C file separately
    for c_file, ll_file in zip(c_files, ll_files):
        subprocess.run(['clang-15'] + Config.compile_to_ll_flags + [os.path.join(src_dir, c_file), '-o', ll_file],
                       check=True)
        subprocess.run(
            ['opt-15', '-load-pass-plugin=./build/libUnitProject.so', '-passes=mem2reg,loop-rotate', ll_file, '-S',
             '-o', ll_file])


def compile_sccp_official():
    if not os.path.exists(Config.sccp_output_dir):
        os.mkdir(Config.sccp_output_dir)
    unopt_files = [os.path.join(Config.official_ll_output_dir, file) for file in
                   os.listdir(Config.official_ll_output_dir) if file.endswith('.ll')]
    opt_files = [os.path.join(Config.sccp_output_dir, os.path.splitext(file)[0] + '_opt.ll') for file in
                 os.listdir(Config.official_ll_output_dir) if file.endswith('.ll')]

    exclude = ["partialsums", "recursive"]
    outfile = open(os.path.join(Config.sccp_output_dir, "output.txt"), "w")
    for fro, to in zip(unopt_files, opt_files):
        if any([excl in fro for excl in exclude]):
            continue
        subprocess.run(
            ['opt-15', '-load-pass-plugin=./build/libUnitProject.so', '-passes=unit-sccp', fro, '-S', '-o', to], stderr=outfile)
    outfile.close()


def main():
    if len(sys.argv) != 2:
        print("Usage: python3 run.py <function>")
        sys.exit(1)

    function_name = sys.argv[1]

    if function_name == 'compile-official':
        source_directory = "./mp5_testcases"
        compile_official(source_directory)
    if function_name == 'compile-sccp':
        compile_sccp_official()
    elif function_name == 'clean':
        subprocess.run(["rm -rf *.ll *.out ./sccp_output/*"], shell=True)
    else:
        print(f"Unknown function: {function_name}")


if __name__ == "__main__":
    main()
