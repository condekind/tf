#!/usr/bin/env bash

#-------------------------------------------------------------------------------

function cleanup() {
  rm -f *.rbc  # raw bytecode
  rm -f *.cbc  # clang output bytecode
  rm -f *.obc  # opt output bytecode
  rm -f *.o
}

function unset_vars() {
  unset COMPILER
  unset STDIN
  unset STDOUT
  unset RUN_OPTIONS
  unset CPU2006
}

function set_vars() {

  source info.sh
  # Let's set the variables that are unset

  # sometimes we need to use clang++
  [[ -n $COMPILER ]] || COMPILER=clang
  # We can specify STDIN to something other than /dev/stdin
  [[ -n $STDIN ]] || STDIN=/dev/null
  # And STDOUT default is /dev/null. 
  [[ -n $STDOUT ]] || STDOUT=/dev/null
  # But if we set DEBUG=1, than we ignore the previous definition of STDOUT
  if [[ $DEBUG == 1 ]]; then
    STDOUT=/dev/stdout
  fi

  if [[ $(pwd) =~ "cpu2006" ]]; then
    echo "Setting CPU2006=1"
    CPU2006=1
  fi

  # Common files used by comp.sh
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then
    if [[ $(uname -s) == "Linux" ]]; then
      rbc_name="$bench_name.linux"
    else
      rbc_name="$bench_name.llvm"
    fi
  fi
  lnk_name="$bench_name.rbc"
  cln_name="$bench_name.cbc"
  opt_name="$bench_name.obc"

}

#-------------------------------------------------------------------------------

function walk() {

  if [[ $# == 0 ]]; then
    echo "Error, you must specify the directories this script must compile"
    echo "Check benchs.sh or try something like: walk \$( ls -d */ )"
    exit
  else
    dirs=("$@")
  fi

  parent_dir=$(pwd)
  for dir in "${dirs[@]}"; do
    cd "$parent_dir"/"$dir"
    echo "Sourcing info.sh from $(pwd)"
    set_vars
    cleanup
    compile
    unset_vars
    echo "------------------------------------------------------------"
    cd "$parent_dir"
  done
}

#-------------------------------------------------------------------------------

source "vars.sh"
source "benchs.sh"
source "comp.sh"

## cleaning temp files
if [[ -n $CLEAN && $CLEAN -eq 1 ]]; then
  echo "REMOVING ALL TEMP FILES!"
  for bench in "${benchs[@]}"; do
    cd $BENCHSDIR
    echo "Removing from $bench"
    cd $bench
    $bench
    echo ""
  done
  exit 0
fi

## walking through benchmark directories and compiling them
if [[ "$#" -ne 0 ]]; then
  # check if the input is a file
  if [[ -f "$@" ]]; then
    echo "Reading input file..."
    # dump content into benchs array
    IFS=$'\n' read -d '' -r -a benchs < "$@"
  else
    benchs=( "$@" )
  fi
  walk "${benchs[@]}"
else
  for bench in "${benchs[@]}"; do
    cd $BENCHSDIR
    echo "Starting $bench"
    cd $bench
    $bench
  done
fi

cd $BASEDIR

#-------------------------------------------------------------------------------