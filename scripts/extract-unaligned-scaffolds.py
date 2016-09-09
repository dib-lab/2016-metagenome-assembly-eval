#! /usr/bin/env python
import sys
import screed

unaligned = sys.argv[1]
assembly = sys.argv[2]

un = set()
for line in open(unaligned):
    x = line.split('_', 1)[1]
    x = x.split('.')[0]
    x = x.split('_')[:4]
    x = "_".join(x)
    un.add(x)
#print un    
for record in screed.open(assembly):
    d = record.description
    d = d.split('_')[:4]
    d = "_".join(d)
    d=d+'\n'
    if d in un:
        print '>%s %s\n%s' % (record.name, record.description, record.sequence)
