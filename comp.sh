#!/bin/bash

# this is left as an example 
function compile() {
  
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then
    # rbc -> lnk
    $LLVM_PATH/opt -S $rbc_name -o $lnk_name
  else
    # source_files is the variable with all the files we're gonna compile
    parallel --tty --jobs=${JOBS} $LLVM_PATH/$COMPILER $COMPILE_FLAGS \
      -Xclang -disable-O0-optnone \
      -S -c -emit-llvm {} -o {.}.bc ::: "${source_files[@]}" 
    [[ $? -ne 0 ]] && echo "Error compiling ${source_files[@]} into ${lnk_name/\.rbc/\.bc}" >> $ERRFILE
    
    parallel --tty --jobs=${JOBS} $LLVM_PATH/opt -S {.}.bc -o {.}.rbc ::: "${source_files[@]}"
    [[ $? -ne 0 ]] && echo "Error converting .bc's into .rbc's for ${lnk_name/\.rbc/}" >> $ERRFILE
  
    #Generate all the bcs into a big bc:
    $LLVM_PATH/llvm-link -S *.rbc -o $lnk_name
  fi

  OUTBUFFER=".__OUTPUTBUFFER.tmp"

  echo ">>> SUITE: ${bench}" >> $OUTBUFFER
  echo ">>> BENCHMARK: ${bench_name}" >> $OUTBUFFER
  $LLVM_PATH/opt -mem2reg -O0 -instcount $USER_PASSES -stats -S $lnk_name -disable-output 2>>$OUTBUFFER && cat $OUTBUFFER >> $OUTFILE

  [[ $? -ne 0 ]] && cat $OUTBUFFER >> $ERRFILE

  rm $OUTBUFFER
  unset OUTBUFFER

  
#  # optimizations
#  $LLVM_PATH/opt -S ${OPT} $lnk_name -o $prf_name
#  # Compile our instrumented file, in IR format, to x86:
#  $LLVM_PATH/llc -filetype=obj $prf_name -o $obj_name ;
#  # Compile everything now, producing a final executable file:
#  $LLVM_PATH/$COMPILER -lm $obj_name -o $exe_name ;
  
}
