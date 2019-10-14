BENCH_NAME="01-qbsort"

SRC_FILES=( "benchmark.c" "readlist.c" "sort.c" )
COMPILE_FLAGS=" -lm "

PROJ_SRC_DIR=$(pwd)
RUN_OPTIONS="1000"
STDIN="$PROJ_SRC_DIR/benchmark.in3"
