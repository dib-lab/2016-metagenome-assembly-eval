#! /usr/bin/env python
from __future__ import print_function
from analyze_assembly import _load_coords
import argparse
from collections import defaultdict
import screed
import numpy

def main():
    p = argparse.ArgumentParser()
    p.add_argument('--min-ident', type=float, default=99.0)
    p.add_argument('--min-length', type=int, default=500)
    p.add_argument('coords_file')
    p.add_argument('contigs_file')
    a = p.parse_args()

    min_ident = a.min_ident
    min_length = a.min_length

    contig_array = {}
    for record in screed.open(a.contigs_file):
        contig_name = record.name.split(' ')[0]
        contig_array[contig_name] = numpy.zeros(len(record.sequence))

    for s1, e1, s2, e2, ident, name1, name2 in _load_coords(a.coords_file):
        length = (e1 - s1 + 1)
        if length >= min_length and ident >= min_ident:
            if name1 in contig_array:
                arr = contig_array[name1]
                for i in range(s1, e1):
                    arr[i] = 1

    sum_total = 0.
    cov_total = 0.
    for k, v in contig_array.items():
        sum_total += len(v)
        cov_total += sum(v)

    print(a.contigs_file, cov_total, sum_total, cov_total / sum_total)


if __name__ == '__main__':
    main()
