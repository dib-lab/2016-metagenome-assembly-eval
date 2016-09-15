#! /usr/bin/env python
import screed
import sys
import itertools

# first, load in the names of the sequences we want to extract
keep_names = set()
for filename in sys.argv[1:]:
    for record in screed.open(filename):
	name = record.name.split('/')[0]
	keep_names.add(name)

print 'loaded', len(keep_names), 'names'

# now, iterate over the larger FASTQ files and pull out all sequences
# with names in 'keep_names' and save them somewhere.

fp = open(sys.argv[1] + '.extract.fq', 'w')

n = 0
for r1, r2 in itertools.izip(screed.open('SRR606249_1.fastq.gz'),
                             screed.open('SRR606249_1.fastq.gz')):
    n += 1
    if n % 10000 == 0:
        print '...', n

    name = r1.name.split('/')[0]
    if name in keep_names:
        print 'found', name
        print >>fp, "@%s/1\n%s\n+\n%s" % (r1.name, r1.sequence,
                                          r1.accuracy)
        print >>fp, "@%s/2\n%s\n+\n%s" % (r2.name, r2.sequence,
                                          r2.accuracy)
