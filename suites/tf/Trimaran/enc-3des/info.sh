BENCH_NAME="enc-3des"

SRC_FILES=( "des.c" )
COMPILE_FLAGS=" "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="200"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="10"
else
  RUN_OPTIONS="100"
fi
