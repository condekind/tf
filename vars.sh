#!/bin/bash

BASEDIR="$(pwd)"
BENCHSDIR="$BASEDIR/src_benchmarks/"

#-------------------------------------------------------------------------------

# Output from passes in comp.sh
[[ -n $OUTFILE ]]   || OUTFILE="$(pwd)/output/stats.txt"

# Error from passes in comp.sh
[[ -n $ERRFILE ]]   || ERRFILE="$(pwd)/output/error.txt"

[[ -n $PASSFILE ]]  || PASSFILE="$(pwd)/info/passes.txt"

# Output from passes in comp.sh
[[ -n $USERPASSES ]] || readarray -t USERPASSES < $PASSFILE

# LLVM_PATH  => The place where I have all the LLVM tools
echo "LLVM_PATH is set to: <${LLVM_PATH}>"
[[ -n $LLVM_PATH ]] || LLVM_PATH="/home/condekind/LLVM/9.0.0/build/bin"
[[ -d "${LLVM_PATH}" ]] || {
  echo "One must define LLVM_PATH before running tf"
  exit 1
}

#-------------------------------------------------------------------------------

# JOBS
[[ -n $JOBS ]] || JOBS=1

# Remove all temp files
[[ -n CLEAN ]] || CLEAN=0

# Set the lib SUFFIX.
SUFFIX="dylib"
if [[ $(uname -s) == "Linux" ]]; then
  SUFFIX="so"
fi

#---------------------------------Functions-------------------------------------

function cleanup() {
  rm -f *.bc
  rm -f *.rbc
  rm -f *.txt
}

function unset_vars() {
  unset COMPILER
  unset STDIN
  unset STDOUT
  unset RUN_OPTIONS
  unset source_files

  unset CPU2006
}

function set_vars() {

  # variables specific to each benchmark, set on /suite/.../bench/.../info.sh
  echo "Sourcing info.sh from $(pwd)"
  source info.sh

  # bench_name comes from info.sh
  lnk_name="$bench_name.rbc"
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then
    if [[ $(uname -s) == "Linux" ]]; then
      rbc_name="$bench_name.linux"
    else
      rbc_name="$bench_name.llvm"
    fi
  fi

  # cpu specific stuff
  [[ ${parent_dir} =~ "cpu2006" ]] && CPU2006=1
  # sometimes we need to use clang++
  [[ -n $COMPILER   ]] || COMPILER=clang
  # We can specify STDIN to something other than /dev/stdin
  [[ -n $STDIN      ]] || STDIN=/dev/null
  # And STDOUT default is /dev/null. 
  [[ -n $STDOUT     ]] || STDOUT=/dev/null
  # removes math library linking flag, which isn't used with clang's -c param
  COMPILE_FLAGS="${COMPILE_FLAGS/\-lm/}"
}

function walk() {

  [[ $# == 0 ]] && echo "Error: no directory to walk on" && exit
  
  dirs=("$@")
  parent_dir=$(pwd)

  for dir in "${dirs[@]}"; do
    [[ -d "$parent_dir"/"$dir" ]] || continue
    cd    "$parent_dir"/"$dir"
    set_vars
    cleanup
    compile
    unset_vars
    cd    "$parent_dir"
    echo $'\n'"--------------------------------------"$'\n'
  done
}

#-------------------------------------------------------------------------------

echo "--------------------------------------"
echo "CLEAN       is set to $CLEAN"
echo "SUFFIX      is set to $SUFFIX"
echo "BASEDIR     is set to $BASEDIR"
echo "BENCHSDIR   is set to $BENCHSDIR"
echo "USERPASSES  is set to $USERPASSES"
echo "--------------------------------------"
