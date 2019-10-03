#-------------------------------------------------------------------------------

# if 0, redirect benchmark output to /dev/null
# if 1, print benchmark output to stdout
[[ -n $DEBUG ]] || DEBUG=0

# Compile
[[ -n $COMPILE ]] || COMPILE=1

# JOBS
[[ -n $JOBS ]] || JOBS=8

# Remove all temp files
[[ -n CLEAN ]] || CLEAN=0

# Set the lib suffix
suffix="dylib"
if [[ $(uname -s) == "Linux" ]]; then
  suffix="so"
fi


#-------------------------------------------------------------------------------

# LLVM_PATH  => The place where I have all the LLVM tools
[[ -d "${LLVM_PATH}" ]] || {
	echo "One must define LLVM_PATH before running tf"
	exit 1
}

#-------------------------------------------------------------------------------

BASEDIR="$(pwd)"
BENCHSDIR="$BASEDIR/src_benchmarks/"

[[ -n $OUT_FILE ]] || OUT_FILE="output.stats"

#-------------------------------------------------------------------------------

echo "#########################"
echo "DEBUG is set to $DEBUG"
echo "CLEAN is set to $CLEAN"
echo "COMPILE is set to $COMPILE"
echo "BASEDIR is set to $BASEDIR"
echo "BENCHSDIR is set to $BENCHSDIR"
echo "OUT_FILE is set to $OUT_FILE"
echo "#########################"
