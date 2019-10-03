bench_name="namd" ;

# source_files=($(ls *.c)) ;
# CXXFLAGS=" -lm " ;
COMPILER=clang++
RUN_OPTIONS=" --input ../data/all/input/namd.input --iterations 38 --output namd.out " ;
