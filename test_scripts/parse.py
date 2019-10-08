import sys
import csv
import json
from pprint import pprint

suitedelim = '>>> SUITE: '
benchdelim = '>>> BENCHMARK: '
statsdelim = \
'===-------------------------------------------------------------------------===\n' + \
'                          ... Statistics Collected ...\n' + \
'===-------------------------------------------------------------------------===\n\n'


if __name__ == '__main__':

	if len(sys.argv) < 2:
		print('Usage: {}, "/path/to/stats/file" "output"'.format(sys.argv[0]))
		exit(1)

	infile = sys.argv[1]
	outfile = sys.argv[2]

	with open(infile, 'r') as finput, open(outfile, 'w') as foutput:
		
		s = json.load(finput)
		pprint(s)
		