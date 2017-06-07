#! /usr/bin/env python
from __future__ import print_function
from analyze_assembly import _load_coords
import argparse
from collections import defaultdict
import screed

def main():
    p = argparse.ArgumentParser()
    p.add_argument('--min-ident', type=float, default=99.0)
    p.add_argument('--min-length', type=int, default=500)
    p.add_argument('coords_file')
    p.add_argument('contigs_files', nargs='*')
    a = p.parse_args()

    min_ident = a.min_ident
    min_length = a.min_length

    include_only = set()
    if a.contigs_files:
        for filename in a.contigs_files:
            for record in screed.open(filename):
                include_only.add(record.name.split()[0])

    matches = defaultdict(int)

    for s1, e1, s2, e2, ident, name1, name2 in _load_coords(a.coords_file):
        length = (e1 - s1 + 1)
        if length >= min_length and ident >= min_ident:
            if not include_only or name1 in include_only:
                matches[name1] += length

    matches_list = list(matches.items())
    matches_list.sort(key=lambda x: -x[1])

    sum_total = 0.
    for k, v in matches_list:
        print('{},{}'.format(k, v))
        sum_total += v

    print('TOTAL,{}'.format(sum_total))


if __name__ == '__main__':
    main()
