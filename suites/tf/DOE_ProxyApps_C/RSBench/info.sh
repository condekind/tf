BENCH_NAME="RSBench"
SRC_FILES=( "glibc_compat_rand.c" "init.c" "io.c" "main.c" "material.c" "utils.c" "xs_kernel.c" )
COMPILE_FLAGS=" -lm -std=gnu99 "
RUN_OPTIONS=" -s small -l 100000 -p 1000 -w 1000 "
