#!/usr/bin/zsh

CFILES=($( find $1 -name "*.c" ))
for file in ${CFILES[@]}; do
	folder=${file##*/}
	folder=${file%\.c}
	mkdir $folder
	mv $file $folder
done
