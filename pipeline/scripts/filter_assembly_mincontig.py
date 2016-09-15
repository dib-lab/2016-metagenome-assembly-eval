#! /usr/bin/env python
import argparse

import numpy
import screed
import sys
from collections import defaultdict

def _load_coords(filename, only=None):
    lines = [ x.strip() for x in (open(filename)) ]
    assert lines[1].startswith('NUCMER'), lines[0]

    coords = []
    for line_no in range(5, len(lines)):
        line = lines[line_no].split()
        s1, e1 = int(line[0]), int(line[1])
        s2, e2 = int(line[3]), int(line[4])
        ident = float(line[9])
        name1, name2 = line[11], line[12]
        s1, e1 = min(s1, e1), max(s1, e1)
        s2, e2 = min(s2, e2), max(s2, e2)

        yield (s1, e1, s2, e2, ident, name1, name2)

def load_reference(filename):
    d = {}
    s = {}
    for record in screed.open(filename):
        d[record.name.split()[0]] = len(record.sequence) 
        s[record.name.split()[0]] = record.sequence
    return d, s 


def load_assembly(assembly, mincontig, outfile):
    fout = open(outfile, 'w+')  
    d = {}
    s = {}
    for record in screed.open(assembly):
       if len(record.sequence) >= int(mincontig):
 	       d[record.name.split()[0] ] = len(record.sequence)
               s[record.name.split()[0] ] = record.sequence
               print >>fout, ">"+record.name 
	       print >>fout, record.sequence 
    return d, s 
        




          
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('reference')
    parser.add_argument('assem')
    parser.add_argument('mincontig')
    args = parser.parse_args()

    filename = args.assem.split('.')[0] 
    filename += args.mincontig 
    filename += '.fa' 

    load_assembly(args.assem, args.mincontig, filename) 

if __name__ == '__main__':
    main()
