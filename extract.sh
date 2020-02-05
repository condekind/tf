#!/bin/bash

DEBUG=1

:: () {
  [[ $DEBUG -eq 1 ]] && echo "$1"
}


sint () {
  [[ -n "$all_buffer" ]] && echo "$all_buffer" >> "$OUTFILE"
  exit 1
}


setvars() {

  # variables specific to each benchmark, set on /suite/.../bench/.../info.sh
  [[ -f info.sh ]]         &&
    source info.sh         &&
    [[ -n $source_files ]] &&
    for ((i=0;i<${#source_files[@]};i++)); do source_files[i]="$(readlink -f "${source_files[i]}")"; done

  # benchrp: bench relative path to suite without the starting /
  benchrp="${bench##"$suite"}"
  benchrp="${benchrp#/}"
  benchname="${benchrp//\//-}"  # benchrp valid file name (subst. / by -)
  extra_flags="${EXTRA_FLAGS:-""}"

  # These will only be set if they're not defined in an info.sh file
  : "${source_files:=$(find "$(pwd)" -name '*.c' -printf '%p\n' | sort -u )}"
  : "${COMPILE_FLAGS:=" -I. "}"

  # removes math library linking flag, which isn't used with clang's -c param
  compile_flags="${COMPILE_FLAGS/\-lm/}"

  # sometimes we need to use clang++
  : "${COMPILER:="clang"}"
  # We can specify STDIN to something other than /dev/stdin
  : "${STDIN:=/dev/null}"
  # And STDOUT default is /dev/null. 
  : "${STDOUT:=/dev/null}"

  # info required by specific benchmarks
  # csmith: requires compiling csmith, then copying the runtime folder to $SUITESDIR/csmith-suite-name
  [[ ${suite##*/} == "csmith_kernels_largest_10k" ]] && extra_flags=" -I../runtime -Wno-everything "
  # cpu2006 might provide the bytecodes already, no need to compile it again
  [[ $(pwd) =~ "cpu2006" ]] && CPU2006=1 && rbc_name="$bench_name.$LIBSUFFIX"

  return 0
}

cleanup() {
  rm -f *{.bc,.rbc,.txt}
  [[ -n $ibc ]] && rm -f *.$ibc
  [[ -n $lbc ]] && rm -f *.$lbc
}


compile() {
  [[ -n $source_files ]] || return 2
  # ---------------------------- source to bytecode ----------------------------
  if [[ -n $CPU2006 && $CPU2006 -eq 1 ]]; then $LLVM_PATH/opt -S $rbc_name -o $benchname.$lbc
  else
    parallel --tty --jobs=$JOBS $LLVM_PATH/$COMPILER $compile_flags $extra_flags -Xclang \
    -disable-O0-optnone -S -c -emit-llvm {} -o {.}.$ibc ::: "${source_files[@]}"

    # Merge all the individual bytecodes into a big linked one:
    $LLVM_PATH/llvm-link -S *.$ibc -o $benchname.$lbc
  fi
  return 0
}


bcstats() {
  # ---------------------------- bytecode to stats -----------------------------
  unset tmp_buffer
  tmp_buffer="header://:${suite##*/}://:${benchrp}://:${source_files[@]}://:endheader"
  tmp_buffer="${tmp_buffer}${br}"$("$LLVM_PATH"/opt           \
                                  -mem2reg                    \
                                  -O0                         \
                                  ${user_passes[@]}           \
                                  -instcount                  \
                                  -stats                      \
                                  -S                          \
                                  $benchname.$lbc             \
                                  -disable-output 2>&1)""
  if [[ $? -eq 0 ]]; then
    STTY=$(stty -g) 
    stty intr undef
    all_buffer="${all_buffer}${br}${br}${tmp_buffer}"
    stty ${STTY}
	else
    STTY=$(stty -g) 
    stty intr undef
    echo "$tmp_buffer" >> "$ERRFILE"
    stty ${STTY}
  fi
  unset tmp_buffer
  return 0
}


delvars() {
  unset {COMPILER,STDIN,STDOUT,COMPILE_FLAGS,CPU2006,SRC_FILES,BENCH_NAME}
  unset {benchrp,benchname,compile_flags,source_files,extra_flags}
}


#---------------------------------- Variables ----------------------------------

# Parallel *execution* (not compilation)
: "${JOBS:=8}"

# Set the lib LIBSUFFIX according to OS
[[ $(uname -s) == "Linux" ]] && LIBSUFFIX="so" || LIBSUFFIX="dylib"

: "${BASEDIR:="$(pwd)"}"
: "${SUITESDIR:="$BASEDIR/suites/"}"

# Output from passes ran in comp.sh
: "${OUTFILE:="$(pwd)/output/stats.txt"}"

# Error from passes ran in comp.sh
: "${ERRFILE:="$(pwd)/output/error.txt"}"

# Custom user passes file
: "${PASSFILE:="$(pwd)/info/passes.txt"}"

# Custom user passes array
[[ -n $user_passes ]]  || readarray -t user_passes < $PASSFILE

# LLVM_PATH  => The place where I have all the LLVM tools
: "${LLVM_PATH:="/home/condekind/LLVM/10/build/bin"}"
[[ -d $LLVM_PATH ]]   || echo "invalid LLVM_PATH: $LLVM_PATH"

br=$'\n' # line break
ibc=ibc  # individual bytecoode extension
lbc=lbc  # linked llvm bytecoode extension
: "${all_buffer:=""}"

#-------------------------------------------------------------------------------

echo "--------------------------------------"
echo "JOBS        is set to $JOBS"
echo "LIBSUFFIX   is set to $LIBSUFFIX"
echo "BASEDIR     is set to $BASEDIR"
echo "SUITESDIR   is set to $SUITESDIR"
echo "LLVM_PATH   is set to $LLVM_PATH"
echo "user_passes is set to ${user_passes[@]}"
echo "--------------------------------------"

#-------------------------------- Main Loop ------------------------------------

trap sint INT

[[ -n $SUITES ]]  || SUITES=($( find "${SUITESDIR}" -mindepth 1 -maxdepth 1 -type d ))
echo "suites: ${SUITES[@]}"
for suite in "${SUITES[@]}"; do
  cd $suite
  BENCHS=($( find "$(pwd)" -name '*.c' -printf '%h\n' | sort -u ))
  echo "benchs: ${BENCHS[@]}"
  for bench in "${BENCHS[@]}"; do
    cd $bench && echo "Starting $bench"
    setvars || ( delvars; continue )
    cleanup
    compile || ( delvars; continue )
    bcstats
    delvars
  done
done
cd $BASEDIR

echo "$all_buffer" >> "$OUTFILE"

#-------------------------------------------------------------------------------
