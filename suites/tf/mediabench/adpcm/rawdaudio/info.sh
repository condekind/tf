BENCH_NAME="adpcm-rawdaudio"

SRC_FILES=("rawdaudio.c" "adpcm.c")
COMPILE_FLAGS=" -lm "
RUN_OPTIONS=""
STDIN=" ../data/clinton.adpcm "
