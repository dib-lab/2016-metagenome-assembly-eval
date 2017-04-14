#! /usr/bin/env python
from __future__ import print_function
import screed
import sys

names = set([ x.strip() for x in open(sys.argv[1])])
for record in screed.open(sys.argv[2]):
    if record.name in names:
        names.remove(record.name)
        continue
    print('>%s\n%s' % (record.name, record.sequence))

if names:
    print("didn't find:", names, file=sys.stderr)
