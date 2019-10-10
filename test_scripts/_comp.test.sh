#!/bin/bash
DELIM="===-------------------------------------------------------------------------==="$'\n'"                          ... Statistics Collected ..."$'\n'"===-------------------------------------------------------------------------==="$'\n'$'\n'

# this is left as an example 
function compile() {
  
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then
    # rbc -> lnk
    $LLVM_PATH/opt -S $rbc_name -o $lnk_name
  else
    # source_files is the variable with all the files we're gonna compile
    parallel --tty --jobs=${JOBS} $LLVM_PATH/$COMPILER $COMPILE_FLAGS -Xclang \
    -disable-O0-optnone -S -c -emit-llvm {} -o {.}.bc \
    ::: "${source_files[@]}" 2>>$ERRFILE
    
    parallel --tty --jobs=${JOBS} $LLVM_PATH/opt -S {.}.bc -o {.}.rbc \
    ::: "${source_files[@]}" 2>>$ERRFILE
  
    #Generate all the bcs into a big bc:
    $LLVM_PATH/llvm-link -S *.rbc -o $lnk_name
  fi

  OUTBUFFER=".__OUTPUTBUFFER.tmp"

  echo "{"                                >> $OUTBUFFER
  echo "\"suitename\":\"${bench}\","      >> $OUTBUFFER
  echo "\"benchname\":\"${bench_name},\"" >> $OUTBUFFER
  echo "\"benchdata\":"                   >> $OUTBUFFER
  echo "{"                                >> $OUTBUFFER

  $LLVM_PATH/opt  -mem2reg                                                    \
                  -O0                                                         \
                  -instcount                                                  \
                  $USER_PASSES                                                \
                  -stats                                                      \
                  -S                                                          \
                  $lnk_name                                                   \
                  -disable-output  2>                                         \
  >( tee ) | sed                                                              \
  -e "s/>>> SUITE: \(.*\)/{\n\"suite\": \"\1\"/g"                             \
  -e "s/>>> BENCHMARK: \(.*\)/\"benchmark\": \"\1\"\n\"benchdata:\n{/g"       \
  -e "/^===-*===$/d"                                                          \
  -e "/ *\.\.\. Statistics Collected \.\.\. */d"                              \
  -e "/^$/d"                                                                  \
  -e "s/ *- */::/g"                                                           \
  -e "s/ \+/ /g"                                                              \
  -e "s/ \+/ /g"                                                              \
  -e "s/^ //g"                                                                \
  -e "s/ \+/_/g"                                                              \
  -e "s/_/ /1"                                                                \
  -e "s/\([0-9]\+\) \(.\+\)/\"\2\" : \1,/g" >> OUTBUFFER &&                   \
                 cat "${OUTBUFFER/%,}"$'\n' >> $OUTFILE

  if [[ $? -ne 0 ]]; then
    cat $OUTBUFFER >> $ERRFILE
  else
    echo $'},\n'

  rm $OUTBUFFER
  unset OUTBUFFER

  
#  # optimizations
#  $LLVM_PATH/opt -S ${OPT} $lnk_name -o $prf_name
#  # Compile our instrumented file, in IR format, to x86:
#  $LLVM_PATH/llc -filetype=obj $prf_name -o $obj_name ;
#  # Compile everything now, producing a final executable file:
#  $LLVM_PATH/$COMPILER -lm $obj_name -o $exe_name ;
  
}
