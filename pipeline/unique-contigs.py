#! /usr/bin/env python
import screed
import sys
import itertools

# first, load in the names of the sequences we want to extract
keep_names = set()
fout =open(sys.argv[1], 'a+')
for filename in sys.argv[2:]:
    for record in screed.open(filename):
	name = record.name.split('/')[0]
	if name in keep_names:
		continue
	keep_names.add(name)
  	print >>fout, '>'+name
	print >>fout, record.sequence

print 'loaded', len(keep_names), 'names'
