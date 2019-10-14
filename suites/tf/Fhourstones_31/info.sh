BENCH_NAME="Fhourstones_31"

SRC_FILES=( "SearchGame.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=""

if [[ $LARGE_PROBLEM_SIZE ]]; then
  STDIN=" inputs_large "
else
  STDIN=" inputs "
fi
