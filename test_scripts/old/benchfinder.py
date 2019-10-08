import os
from pathlib import Path
import re

basedir   = Path.cwd()
benchsdir = basedir / 'src_benchmarks'
benchs = {}
suites = {}
cfiles = list(benchsdir.glob('**/*.c'))

for file in cfiles:
	if file.relative_to(benchsdir).parent not in benchs:
		benchs[file.relative_to(benchsdir).parent] = [file]
	else:
		benchs[file.relative_to(benchsdir).parent].append(file)

cnt=0
for suite in [d for d in benchsdir.iterdir() if d.is_dir()]:
	key = re.sub('({}\/.*?)\/.*'.format(str(benchsdir)), '\0', str(benchs.popitem()[0].absolute()))

#