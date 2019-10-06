#!/bin/bash

function compile() {
  
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then
    # .linux or .llvm -> .rbc
    $LLVM_PATH/opt -S $rbc_name -o $lnk_name
  else

    parallel --jobs=${JOBS} $LLVM_PATH/$COMPILER $COMPILE_FLAGS  \
      -Xclang -disable-O0-optnone -S -c -emit-llvm {} -o {.}.cbc \
      ::: "${source_files[@]}"  # source_files is set by the current
      # benchmark's info.sh and contains all the files we're gonna compile
    
    parallel --jobs=${JOBS} $LLVM_PATH/opt -S {.}.cbc -o {.}.obc ::: "${source_files[@]}"    
  
    # merge all the obc's into a big rbc:
    $LLVM_PATH/llvm-link -S *.obc -o $lnk_name
  fi

  # cleans temporary files
  rm -rf *.cbc *.obc

  CURRDIR=$(pwd)
  CURRBEN=${CURRDIR#${BENCHSDIR}}
  ST_NAME=${CURRBEN/\/*/}

  echo "{\"suite\":\"${ST_NAME}\",\"file\":\"$(basename $lnk_name)\",\"stats\":\"__DATA_BEGIN__" >>$OUT_FILE
  $LLVM_PATH/opt -mem2reg -O0 -instcount -stats -S $lnk_name -disable-output 2>>$OUT_FILE
  echo -e "\n\"},"

  unset CURRDIR
  unset CURRBEN
  unset ST_NAME
  
}