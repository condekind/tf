#!/bin/bash

function compile() {

  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then
    # Convert the program to SSA form:
    if [[ $SSA -eq 1 ]]; then
      $LLVM_PATH/opt -mem2reg $rbc_name -o $prf_name
    else
      $LLVM_PATH/opt $rbc_name -o $prf_name
    fi
    
    return
  fi
  
  # source_files is the variable with all the files we're gonna compile
  parallel --halt-on-error now,fail=1 --tty --jobs=${JOBS} \
		$LLVM_PATH/$COMPILER $COMPILE_FLAGS -Xclang -disable-O0-optnone \
		-g -S -c -emit-llvm {} -o {.}.bc ::: "${source_files[@]}" ;
  
  if [[ $? -eq 1 ]]; then
    echo "Halting compilation for $bench_name due to some error"
    return
  fi

  # Generates an .rbc for each .bc file in the current benchmark
  parallel --halt-on-error now,fail=1 --tty --jobs=${JOBS} $LLVM_PATH/opt -S -mem2reg {.}.bc -o {.}.sbc ::: "${source_files[@]}" ;
  
  if [[ $? -eq 1 ]]; then
    echo "Halting compilation for $bench_name due to some error"
    return
  fi
  
  # Merges all the sbc's into a big rbc:
  $LLVM_PATH/llvm-link -S *.sbc -o $lnk_name

  rm *.bc *.sbc

  if [[ $SSA -eq 1 ]]; then
    $LLVM_PATH/opt -S -mem2reg $lnk_name -o $prf_name
  else
    $LLVM_PATH/opt -S $lnk_name -o $prf_name
  fi
  
}
