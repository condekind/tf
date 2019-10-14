BENCH_NAME="PAQ8p"

SRC_FILES=($(ls *.cpp))
COMPILE_FLAGS=" -DNOASM -DLLVM -lstdc++ -lm "
COMPILER=clang++

if [[ $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS=" -4 file1.in "
else
  RUN_OPTIONS=" -1 small.in "
fi
