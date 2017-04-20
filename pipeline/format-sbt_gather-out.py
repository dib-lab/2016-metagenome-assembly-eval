#! /usr/bin/env python
from __future__ import print_function
import csv
import sys
import argparse

import nicenames

def main():
    p = argparse.ArgumentParser()
    p.add_argument('--latex', action='store_true')
    p.add_argument('gather_csv')
    a = p.parse_args()

    r = csv.DictReader(open(a.gather_csv))
    output = []
    for d in r:
        f_orig_query = float(d['f_orig_query'])
        f_found_genome = float(d['f_found_genome'])
        name = nicenames.nicenames[d['name']]

        if f_orig_query < 0.01:
            continue

        output.append((f_orig_query, name))

    output.sort(reverse=True)

    total = 0.
    for f_orig_query, name in output:
        total += f_orig_query
        if a.latex:
            name = name.replace('_', '\\_')
            print('{:.1f}\\% & {{\small {}}} \\\\'.format(f_orig_query*100, name))
            print('\\hline')
        else:
            print('{:.1f}% {}'.format(f_orig_query*100, name))

    print('total:', total)
    
if __name__ == '__main__':
    main()
