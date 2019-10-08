#echo "jow $BASHPID"   |
#	tee; echo $BASHPID    |
#tee; echo $BASHPID |
#              tee; echo $BASHPID

#ls \
# -x \
#-H\
#	--color="no"

cat $1 | sed \
	-e "s/>>> SUITE: \(.*\)/{\n\"suite\": \"\1\"/g" \
	-e "s/>>> BENCHMARK: \(.*\)/\"benchmark\": \"\1\"\n\"benchdata:\n{/g" \
	-e "/^===-*===$/d" \
	-e "/ *\.\.\. Statistics Collected \.\.\. */d" \
	-e "/^$/d" \
	-e "s/ *- */::/g" \
	-e "s/ \+/ /g" \
	-e "s/ \+/ /g" \
	-e "s/^ //g" \
	-e "s/ \+/_/g" \
	-e "s/_/ /1" \
	-e "s/\([0-9]\+\) \(.\+\)/\"\2\" : \1,/g"		|
									tee
	#-e "/^\n/d" 

#>&2 echo "ZIMBABWE" 2>&1 >/dev/null | tee
