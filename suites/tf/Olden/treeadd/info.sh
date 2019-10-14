BENCH_NAME="treeadd"

SRC_FILES=( "args.c" "node.c" "par-alloc.c" )
COMPILE_FLAGS=" -lm -DTORONTO "

if [[ -n $LARGE_PROBLEM_SIZE ]]; then
  RUN_OPTIONS="22"
else
  RUN_OPTIONS="20"
fi
