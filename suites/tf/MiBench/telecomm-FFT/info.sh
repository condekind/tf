BENCH_NAME="telecomm-FFT"

SRC_FILES=( "fftmisc.c" "fourierf.c" "main.c" )
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=" 8 32768 -i "
