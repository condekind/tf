BENCH_NAME="netbench-url"

SRC_FILES=( "packet.c" "search.c" "url.c" "utils.c" )
COMPILE_FLAGS=" "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="medium_inputs 1400"
elif [[ -n $SMALL_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="medium_inputs 100"
else
  RUN_OPTIONS="medium_inputs 900"
fi
