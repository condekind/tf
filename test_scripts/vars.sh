#-------------------------------------------------------------------------------

BASEDIR="$(pwd)"
BENCHSDIR="$BASEDIR/src_benchmarks/"
SUITES=($( find ${BENCHSDIR} -mindepth 1 -maxdepth 1 -type d ));


[[ -n $OUT_FILE ]] || OUT_FILE="output.stats"

# removes all temp files
[[ -n $CLEAN ]] || CLEAN=0

# legacy, should be removed
[[ -n $COMPILE ]] || COMPILE=1

# redirects output to {0: /dev/null, 1: stdout}
[[ -n $DEBUG ]] || DEBUG=0

# GNU parallel parameter
[[ -n $JOBS ]] || JOBS=8

# LLVM_PATH  => The place where I have all the LLVM tools
[[ -d "${LLVM_PATH}" ]] || {
  echo "One must define LLVM_PATH before running tf"
  exit 1
}

#-------------------------------------------------------------------------------

echo "#########################"
echo "BASEDIR is set to $BASEDIR"
echo "BENCHSDIR is set to $BENCHSDIR"
echo "CLEAN is set to $CLEAN"
echo "COMPILE is set to $COMPILE"
echo "DEBUG is set to $DEBUG"
echo "JOBS is set to $JOBS"
echo "LLVM_PATH is set to $LLVM_PATH"
echo "OUT_FILE is set to $OUT_FILE"
echo "#########################"

#-------------------------------------------------------------------------------

function cleanup() {
  rm -f *.rbc  # raw bytecode
  rm -f *.cbc  # clang output bytecode
  rm -f *.obc  # opt output bytecode
  rm -f *.o
}

function set_vars() {

  # fetch info on source files
  source info.sh

  ## change the line above to automatically get benchmark data from the files ##

  # sometimes we need to use clang++
  [[ -n $COMPILER ]] || COMPILER=clang
  # we can specify STDIN to something other than /dev/stdin
  [[ -n $STDIN ]] || STDIN=/dev/null
  # and STDOUT default is /dev/null. 
  [[ -n $STDOUT ]] || STDOUT=/dev/null
  # but if we set DEBUG=1, than we ignore the previous definition of STDOUT
  if [[ $DEBUG == 1 ]]; then STDOUT=/dev/stdout; fi

  rbc_name="$bench_name.linux"
  lnk_name="$bench_name.rbc"
  cln_name="$bench_name.cbc"
  opt_name="$bench_name.obc"


  # cpu2006 stuff, check if needed only for compiling
  if [[ $(pwd) =~ "cpu2006" ]]; then echo "Setting CPU2006=1"; CPU2006=1; fi
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]] && [[ ! $(uname -s) == "Linux" ]]; then
    rbc_name="$bench_name.llvm"
  fi
}

function unset_vars() {
  unset bench_name
  unset COMPILE_FLAGS
  unset COMPILER
  unset CPU2006
  unset HASH_PROGRAM_OUTPUT
  unset PROJ_SRC_DIR
  unset RUN_OPTIONS
  unset source_files
  unset STDIN
  unset STDOUT
}

#-------------------------------------------------------------------------------

# function walk() {

#   if [[ $# == 0 ]]; then
#     echo "Error, you must specify the directories this script must compile"
#     echo "Check benchs.sh for examples"
#     exit
#   else
#     dirs=("$@")
#   fi

#   parent_dir=$(pwd)
#   for dir in "${dirs[@]}"; do
#     cd "$parent_dir"/"$dir"
#     echo "Sourcing info.sh from $(pwd)"
#     set_vars
#     cleanup
#     compile  # //
#     unset_vars
#     echo "------------------------------------------------------------"
#     cd "$parent_dir"
#   done
# }
