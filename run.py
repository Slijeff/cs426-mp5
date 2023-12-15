import os
import subprocess
import sys
from dataclasses import dataclass
from glob import glob


# Writing this cuz idk how to do this in a Makefile
# Only use this to compile official tests, other functionality not working

@dataclass
class Config:
    source_directory = "./mp5_testcases"
    custom_src_directory = "./tests"

    custom_test_output_dir = "./tests_ll"
    official_ll_output_dir = "./mp5_testcases_ll"
    official_bin_output_dir = "./mp5_testcases_bin"
    compile_to_ll_flags = "-c -O0 -Xclang -disable-O0-optnone -emit-llvm -S".split(" ")

    sccp_output_ll_dir = "./sccp_output_ll"
    sccp_output_bin_dir = "./sccp_output_bin"

    licm_output_ll_dir = "./licm_output_ll"
    licm_output_bin_dir = "./licm_output_bin"

    sccp_custom_tests_dir = "./sccp_custom_tests_ll"
    licm_custom_tests_dir = "./licm_custom_tests_ll"

    clean_opt_output = [
        official_bin_output_dir,
        official_ll_output_dir,
        sccp_output_bin_dir,
        sccp_output_ll_dir,
        licm_output_bin_dir,
        licm_output_ll_dir,
        custom_test_output_dir,
        sccp_custom_tests_dir,
        licm_custom_tests_dir
    ]


def compile_official_ll():
    print("Compiling official testcases to LLVM IR...")
    src_dir = Config.source_directory
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


def compile_sccp_official_ll():
    print("Running SCCP to generate optimized ll...")
    if not os.path.exists(Config.sccp_output_ll_dir):
        os.mkdir(Config.sccp_output_ll_dir)
    unopt_files = [os.path.join(Config.official_ll_output_dir, file) for file in
                   os.listdir(Config.official_ll_output_dir) if file.endswith('.ll')]
    opt_files = [os.path.join(Config.sccp_output_ll_dir, os.path.splitext(file)[0] + '_opt.ll') for file in
                 os.listdir(Config.official_ll_output_dir) if file.endswith('.ll')]

    exclude = ["partialsums", "recursive"]
    outfile = open(os.path.join(Config.sccp_output_ll_dir, "output.txt"), "w")
    for fro, to in zip(unopt_files, opt_files):
        if any([excl in fro for excl in exclude]):
            continue
        subprocess.run(
            ['opt-15', '-load-pass-plugin=./build/libUnitProject.so', '-passes=unit-sccp', fro, '-S', '-o', to],
            stderr=outfile)
    outfile.close()


def compile_official_bin():
    print("Compiling official testcases (with main) to executables...")
    src_files = glob("./mp5_testcases/*.c")
    if not os.path.exists(Config.official_bin_output_dir):
        os.mkdir(Config.official_bin_output_dir)
    # only compile to binary if the program has main function
    has_main = ["almabench", "fannkuch", "n-body", "nsieve-bits", "partialsums", "PR491", "puzzle", "recursive",
                "spectral-norm"]
    for sf in src_files:
        if not any([m in sf for m in has_main]): continue
        filename = os.path.split(sf)[1]
        filename = filename.replace(".c", ".out")
        subprocess.run(
            ["clang-15", "-lm", sf, "-o", os.path.join(Config.official_bin_output_dir, filename)])


def compile_sccp_official_bin():
    print("Compiling optimized ll to executables...")
    if not os.path.exists(Config.sccp_output_bin_dir):
        os.mkdir(Config.sccp_output_bin_dir)
    src_files = glob(os.path.join(Config.sccp_output_ll_dir, "*.ll"))
    # only compile to binary if the program has main function
    has_main = ["almabench", "fannkuch", "n-body", "nsieve-bits", "partialsums", "PR491", "puzzle", "recursive",
                "spectral-norm"]
    for sf in src_files:
        if not any([m in sf for m in has_main]): continue
        filename = os.path.split(sf)[1]
        filename = filename.replace(".ll", ".out")
        subprocess.run(
            ["clang-15", "-lm", sf, "-o", os.path.join(Config.sccp_output_bin_dir, filename)])

def compile_licm_ll():
    print("Running LICM to generate optimized ll...")
    if not os.path.exists(Config.licm_output_ll_dir):
        os.mkdir(Config.licm_output_ll_dir)
    unopt_files = [os.path.join(Config.official_ll_output_dir, file) for file in
                   os.listdir(Config.official_ll_output_dir) if file.endswith('.ll')]
    opt_files = [os.path.join(Config.licm_output_ll_dir, os.path.splitext(file)[0] + '_opt.ll') for file in
                 os.listdir(Config.official_ll_output_dir) if file.endswith('.ll')]

    outfile = open(os.path.join(Config.licm_output_ll_dir, "output.txt"), "w")
    for fro, to in zip(unopt_files, opt_files):
        subprocess.run(
            ['opt-15', '-load-pass-plugin=./build/libUnitProject.so', '-passes=unit-licm', fro, '-S', '-o', to],
            stderr=outfile)
    outfile.close()

def compile_licm_bin():
    print("Compiling optimized ll to executables...")
    if not os.path.exists(Config.licm_output_bin_dir):
        os.mkdir(Config.licm_output_bin_dir)
    src_files = glob(os.path.join(Config.licm_output_ll_dir, "*.ll"))
    # only compile to binary if the program has main function
    has_main = ["almabench", "fannkuch", "n-body", "nsieve-bits", "partialsums", "PR491", "puzzle", "recursive",
                "spectral-norm"]
    for sf in src_files:
        if not any([m in sf for m in has_main]): continue
        filename = os.path.split(sf)[1]
        filename = filename.replace(".ll", ".out")
        subprocess.run(
            ["clang-15", "-lm", sf, "-o", os.path.join(Config.licm_output_bin_dir, filename)])

def compile_custom_ll():
    print("Compiling custom testcases to LLVM IR...")
    src_dir = Config.custom_src_directory
    if not os.path.exists(Config.custom_test_output_dir):
        os.mkdir(Config.custom_test_output_dir)
    c_files = [file for file in os.listdir(src_dir) if file.endswith('.c')]
    ll_files = [os.path.join(Config.custom_test_output_dir, os.path.splitext(file)[0] + '.ll') for file in c_files]

    # Compile each C file separately
    for c_file, ll_file in zip(c_files, ll_files):
        subprocess.run(['clang-15'] + Config.compile_to_ll_flags + [os.path.join(src_dir, c_file), '-o', ll_file],
                       check=True)
        subprocess.run(
            ['opt-15', '-load-pass-plugin=./build/libUnitProject.so', '-passes=mem2reg,loop-rotate', ll_file, '-S',
             '-o', ll_file])
def compile_custom_sccp():
    print("Running SCCP to generate optimized ll...")
    if not os.path.exists(Config.sccp_custom_tests_dir):
        os.mkdir(Config.sccp_custom_tests_dir)
    unopt_files = [os.path.join(Config.custom_test_output_dir, file) for file in
                   os.listdir(Config.custom_test_output_dir) if file.endswith('.ll')]
    opt_files = [os.path.join(Config.sccp_custom_tests_dir, os.path.splitext(file)[0] + '_opt.ll') for file in
                 os.listdir(Config.custom_test_output_dir) if file.endswith('.ll')]

    outfile = open(os.path.join(Config.sccp_custom_tests_dir, "output.txt"), "w")
    for fro, to in zip(unopt_files, opt_files):
        subprocess.run(
            ['opt-15', '-load-pass-plugin=./build/libUnitProject.so', '-passes=unit-sccp', fro, '-S', '-o', to],
            stderr=outfile)
    outfile.close()

def compile_custom_licm():
    print("Running LICM to generate optimized ll...")
    if not os.path.exists(Config.licm_custom_tests_dir):
        os.mkdir(Config.licm_custom_tests_dir)
    unopt_files = [os.path.join(Config.custom_test_output_dir, file) for file in
                   os.listdir(Config.custom_test_output_dir) if file.endswith('.ll')]
    opt_files = [os.path.join(Config.licm_custom_tests_dir, os.path.splitext(file)[0] + '_opt.ll') for file in
                 os.listdir(Config.custom_test_output_dir) if file.endswith('.ll')]
    outfile = open(os.path.join(Config.licm_output_ll_dir, "output.txt"), "w")
    for fro, to in zip(unopt_files, opt_files):
        subprocess.run(
            ['opt-15', '-load-pass-plugin=./build/libUnitProject.so', '-passes=unit-licm', fro, '-S', '-o', to],
            stderr=outfile)
    outfile.close()

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 run.py <function>")
        sys.exit(1)

    function_name = sys.argv[1]

    if function_name == 'official-ll':
        compile_official_ll()
    elif function_name == 'sccp-ll':
        compile_sccp_official_ll()
    elif function_name == 'official-bin':
        compile_official_bin()
    elif function_name == 'sccp-bin':
        compile_sccp_official_bin()
    elif function_name == 'licm-ll':
        compile_licm_ll()
    elif function_name == 'licm-bin':
        compile_licm_bin()
    elif function_name == 'custom-ll':
        compile_custom_ll()
    elif function_name == 'sccp-custom':
        compile_custom_sccp()
    elif function_name == 'licm-custom':
        compile_custom_licm()
    elif function_name == 'all':
        compile_official_ll()
        compile_official_bin()
        compile_sccp_official_ll()
        compile_sccp_official_bin()
        compile_licm_ll()
        compile_licm_bin()
        compile_custom_ll()
        compile_custom_sccp()
        compile_custom_licm()
    elif function_name == 'clean':
        subprocess.run(["rm -rf " + " ".join(Config.clean_opt_output)], shell=True)
    else:
        print(f"Unknown function: {function_name}")


if __name__ == "__main__":
    main()
