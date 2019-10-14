#!/bin/zsh

if [[ $# -ne 3 ]]; then
	echo "failed substituting PATTERN on info.sh files"
	echo "usage: $0 PATTERN NEW_VALUE RELATIVE_PATH"
	exit 1
fi
echo "substituting occurrences of $1 by $2 on all info.sh files"
INFO_SH=($( ag bench_name $3 -l ))
for info in ${INFO_SH[@]}; do
	if [[ ${info##*\/} == "info.sh" ]]; then
		echo "substitution done on $info"
		sed -i "s/$1/$2/g" $info
	fi
done
