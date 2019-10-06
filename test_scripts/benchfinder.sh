#!/bin/bash

# stores all the .c files with their full paths
IFS=$'\n' read -d '' -r -a all_c_files <<< $(find ** -name "*.c")

# parse them into a unique array of the folders containing the files
IFS=$'\n' read -d '' -r -a src_folders <<< $(
  for file in "${all_c_files[@]}"; do
    filedir="${file%\/*}";
    echo "${filedir##*\/}";
  done | sort -u )

for i in "${src_folders[@]}"; do
  echo $i
done;

function walk() {

  if [[ $# == 0 ]]; then echo "biziu"; exit; else dirs=("$@"); fi

  # current suite root
  parent_dir=$(pwd)
  for dir in "$@"; do
    cd "$parent_dir"/"$dir"
    echo "Sourcing info.sh from $(pwd)"
    set_vars
    cleanup
    compile  # //
    unset_vars
    echo "------------------------------------------------------------"
    cd "$parent_dir"
  done
}