BENCH_NAME="04-bisect"

SRC_FILES=( "allocvector.c" "bisect_test.c" "dbisect.c" )
COMPILE_FLAGS=" -lm "

PROJ_SRC_DIR=$(pwd)
STDIN="$PROJ_SRC_DIR/bisect_test.in"
