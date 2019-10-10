#!/usr/bin/env bash

#-------------------------------------------------------------------------------

source "vars.sh"
source "benchs.sh"
source "comp.sh"

# When CLEAN is set, the program exits right after cleaning
if [[ -n $CLEAN && $CLEAN -eq 1 ]]; then
  echo "REMOVING ALL TEMP FILES!"
  for bench in "${benchs[@]}"; do
    cd $BENCHSDIR
    echo "Removing from $bench" ;
    cd $bench ;
    $bench ;
    echo "" ;
  done
  exit 0
fi

#----------------------------------Main Loop------------------------------------
echo "[" >> $OUTFILE
if [[ "$#" -ne 0 ]]; then
  # check if the input is a file
  if [[ -f "$@" ]]; then
    echo "Reading input file..."
    # Read the content into "${benchs[@]}" array
    IFS=$'\n' read -d '' -r -a benchs < "$@"
  else
    benchs=( "$@" )
  fi

  walk "${benchs[@]}" ;

else
  for bench in "${benchs[@]}"; do
    cd $BENCHSDIR
    echo "Starting $bench" ;
    cd $bench ;
    $bench ;
  done
fi

#-------------------------------------------------------------------------------

if [[ -f $OUTBUFFER ]]; then 
    rm $OUTBUFFER
  else
    OUTBUFFER=".__OUTPUTBUFFER.tmp"
fi

#cat $OUTFILE | tac | sed -z -e "s/,//1" | tac >> $OUTBUFFER
cat $OUTFILE | sed -z -e "s/,\([^,]\)*$/\1/1" >> $OUTBUFFER
echo "]" >> $OUTBUFFER
rm $OUTFILE
cat $OUTBUFFER >> $OUTFILE
rm $OUTBUFFER
cd $BASEDIR ;
