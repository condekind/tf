#!/bin/bash

setvars() {


  # variables specific to each benchmark, set on /suite/.../bench/.../info.sh
  [[ -f info.sh ]] && echo "Sourcing info.sh from $(pwd)" && source info.sh

  # These will be overwritten if they're defined in an info.sh file
  BENCH_NAME=${BENCH_NAME:-$(basename $(cd ..; pwd))}
  SRC_FILES=${SRC_FILES:-$(find $(pwd) -name '*.c' -printf '%p\n' | sort -u )}
  COMPILE_FLAGS=${COMPILE_FLAGS:-" -I. "}

  # BENCH_NAME comes either from provided info.sh or the 'else' block above
  lnk_name="$BENCH_NAME.rbc"
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then
    if [[ $(uname -s) == "Linux" ]]; then
      rbc_name="$BENCH_NAME.linux"
    else
      rbc_name="$BENCH_NAME.llvm"
    fi
  fi

  # cpu specific stuff
  [[ ${bench} =~ "cpu2006" ]] && CPU2006=1
  # sometimes we need to use clang++
  [[ -n $COMPILER   ]] || COMPILER="clang"
  # We can specify STDIN to something other than /dev/stdin
  [[ -n $STDIN      ]] || STDIN=/dev/null
  # And STDOUT default is /dev/null. 
  [[ -n $STDOUT     ]] || STDOUT=/dev/null
  # removes math library linking flag, which isn't used with clang's -c param
  COMPILE_FLAGS="${COMPILE_FLAGS/\-lm/}"

  echo "SRC_FILES: ${SRC_FILES[@]}"
  return 0
}


cleanup() { rm -f *{.bc,.rbc,.txt} ; }


compile() {

  # csmith requires extra args
  [[ ${suite##*/} == "csmith_kernels_largest_10k" ]] && EXTRA_FLAGS=" -I../runtime -Wno-everything "
  
  # ---------------------------- source to bytecode ----------------------------
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then $LLVM_PATH/opt -S $rbc_name -o $lnk_name
  else  # SRC_FILES is the variable with all the files we're gonna compile
    [[ -n $SRC_FILES ]] || return 2
    parallel --tty --jobs=${JOBS} $LLVM_PATH/$COMPILER $COMPILE_FLAGS $EXTRA_FLAGS -Xclang \
    -disable-O0-optnone -S -c -emit-llvm {} -o {.}.bc ::: "${SRC_FILES[@]}" # 2>>$ERRFILE
    
    parallel --tty --jobs=${JOBS} $LLVM_PATH/opt -S {.}.bc -o {.}.rbc ::: "${SRC_FILES[@]}" # 2>>$ERRFILE
  
    # Merge all the rbcs into a big rbc:
    $LLVM_PATH/llvm-link -S *.rbc -o ${lnk_name##*/}
  fi
  return 0
}


bcstats() {
  # ---------------------------- bytecode to stats -----------------------------
  OUTBUFFER="${BASEDIR}/.buffer.tmp"
  echo "header://${suite##*/};${BENCH_NAME}" >> "$OUTBUFFER"
  $LLVM_PATH/opt                    \
        -mem2reg                    \
        -O0                         \
        ${USERPASSES[@]}            \
        -instcount                  \
        -stats                      \
        -S                          \
        ${lnk_name}                 \
        -disable-output 2>> "$OUTBUFFER"
  if [[ $? -eq 0 ]]; then
    cat "$OUTBUFFER" >> "$OUTFILE"
	else
    cat "$OUTBUFFER" >> "$ERRFILE"
  fi
  rm $OUTBUFFER
  unset OUTBUFFER
  return 0
}


delvars() { unset {COMPILER,STDIN,STDOUT,RUN_OPTIONS,BENCH_NAME,SRC_FILES,COMPILE_FLAGS,CPU2006} ; }


#---------------------------------- Variables ----------------------------------

# Parallel *execution* (not compilation)
[[ -n $JOBS ]]        || JOBS=8

# Set the lib SUFFIX according to OS
[[ $(uname -s) == "Linux" ]] && SUFFIX="so" || SUFFIX="dylib"

[[ -n $BASEDIR ]]     || BASEDIR="$(pwd)"
[[ -n $SUITESDIR ]]   || SUITESDIR="$BASEDIR/suites/"

# Output from passes ran in comp.sh
[[ -n $OUTFILE ]]     || OUTFILE="$(pwd)/output/stats.txt"

# Error from passes ran in comp.sh
[[ -n $ERRFILE ]]     || ERRFILE="$(pwd)/output/error.txt"

# Custom user passes file
[[ -n $PASSFILE ]]    || PASSFILE="$(pwd)/info/passes.txt"

# Custom user passes array
[[ -n $USERPASSES ]]  || readarray -t USERPASSES < $PASSFILE

# LLVM_PATH  => The place where I have all the LLVM tools
[[ -n $LLVM_PATH ]]   || LLVM_PATH="/home/condekind/LLVM/10/build/bin"
[[ -d $LLVM_PATH ]]   || echo "invalid LLVM_PATH: $LLVM_PATH"

#-------------------------------------------------------------------------------

echo "--------------------------------------"
echo "JOBS        is set to $JOBS"
echo "SUFFIX      is set to $SUFFIX"
echo "BASEDIR     is set to $BASEDIR"
echo "SUITESDIR   is set to $SUITESDIR"
echo "LLVM_PATH   is set to $LLVM_PATH"
echo "USERPASSES  is set to ${USERPASSES[@]}"
echo "--------------------------------------"

#-------------------------------- Main Loop ------------------------------------

[[ -n $SUITES ]]      || SUITES=($( find ${SUITESDIR} -mindepth 1 -maxdepth 1 -type d ))
echo "suites: $SUITES"
for suite in "${SUITES[@]}"; do
  cd $suite
  BENCHS=($( find $(pwd) -name '*.c' -printf '%h\n' | sort -u ))
  echo "benchs: $BENCHS"
  for bench in "${BENCHS[@]}"; do
    cd $bench && echo "Starting $bench"
    setvars
    cleanup
    compile
    bcstats
    delvars
  done
done
cd $BASEDIR

#-------------------------------------------------------------------------------
