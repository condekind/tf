BENCH_NAME="security-sha"

SRC_FILES=( "sha.c" "sha_driver.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" input_large.asc "
