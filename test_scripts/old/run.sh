#!/usr/bin/env bash

#-------------------------------------------------------------------------------



#-------------------------------------------------------------------------------

source "vars.sh"
source "benchs.sh"
source "comp.sh"

#----------------------------cleaning temp files--------------------------------
if [[ -n $CLEAN && $CLEAN -eq 1 ]]; then
  echo "REMOVING ALL TEMP FILES!"
  for suite in "${SUITES[@]}"; do
    cd $BENCHSDIR
    echo "Removing from $suite"
    cd $suite
    $suite
    echo ""
  done
  exit 0
fi


#-----------walking through benchmark directories and compiling them------------

# if one or more suites were specified:
if [[ "$#" -ne 0 ]]; then
  # check if the input is a file
  if [[ -f "$@" ]]; then
    echo "Reading input file..."
    # dump content into benchs array
    IFS=$'\n' read -d '' -r -a SUITES < "$@"
  else
    SUITES=( "$@" )
  fi
  #walk "${SUITES[@]}"




  if [[ $# == 0 ]] && [[ ! -f "$SUITES[@]" ]]; then
    echo "Error, you must specify the directories this script must compile"
    echo "Check benchs.sh for examples"
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
    compile  # //
    unset_vars
    echo "------------------------------------------------------------"
    cd "$parent_dir"
  done

#-------------------------------------------------------------------------------

# else, compile all the benchmarks from all suites
else
  for suite in "${SUITES[@]}"; do
    cd $BENCHSDIR
    echo "Starting $suite"
    cd $suite
    $suite
  done
fi

cd $BASEDIR

#-------------------------------------------------------------------------------