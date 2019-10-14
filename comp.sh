#!/bin/bash

# this is left as an example 
function compile() {
  
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then
    # rbc -> lnk
    $LLVM_PATH/opt -S $rbc_name -o $lnk_name
  else
    # SRC_FILES is the variable with all the files we're gonna compile
    parallel --tty --jobs=${JOBS} $LLVM_PATH/$COMPILER $COMPILE_FLAGS -Xclang \
    -disable-O0-optnone -S -c -emit-llvm {} -o {.}.bc \
    ::: "${SRC_FILES[@]}" 2>>$ERRFILE
    
    parallel --tty --jobs=${JOBS} $LLVM_PATH/opt -S {.}.bc -o {.}.rbc \
    ::: "${SRC_FILES[@]}" 2>>$ERRFILE
  
    #Generate all the bcs into a big bc:
    $LLVM_PATH/llvm-link -S *.rbc -o $lnk_name
  fi

  OUTBUFFER=".__OUTPUTBUFFER.tmp"

  echo "  {"                                  >> "${OUTBUFFER}"
  echo "    \"suitename\":\"${suite}\","      >> "${OUTBUFFER}"
  echo "    \"benchname\":\"${BENCH_NAME}\"," >> "${OUTBUFFER}"
  echo "    \"benchdata\":"                   >> "${OUTBUFFER}"
  echo "    {"                                >> "${OUTBUFFER}"

  $LLVM_PATH/opt                                      \
        -mem2reg                                      \
        -O0                                           \
        -instcount                                    \
        ${USERPASSES[@]}                              \
        -stats                                        \
        -S                                            \
        ${lnk_name}                                   \
        -disable-output  2> >(tee)                    |
    sed -e "/^===-*===$/d"                            \
        -e "/ *\.\.\. Stat*/d"                        \
        -e "/^$/d"                                    \
        -e "s/ *- */::/g"                             \
        -e "s/ \+/ /g"                                \
        -e "s/^ //g"                                  \
        -e "s/ \+/_/g"                                \
        -e "s/_/ /1"                                  \
        -e "s/\([0-9]\+\) \(.\+\)/\"\2\" : \1,/g"     \
        -e "s/^\(^$\)*/      \1/g"                    |
    sed -z -e "s/,\([^,]\)*$/\1/1"  >> "${OUTBUFFER}" &&
    cat "${OUTBUFFER}"              >> "${OUTFILE}"

  if [[ $? -ne 0 ]]; then
    cat   "${OUTBUFFER}"            >> "${ERRFILE}"
  else
    echo "    }"                    >> "${OUTFILE}"
    echo "  },"                     >> "${OUTFILE}"
  fi

  rm   $OUTBUFFER
  unset OUTBUFFER
  
}
