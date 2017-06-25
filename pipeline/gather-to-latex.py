#! /usr/bin/env python
import argparse
import sys
import csv
import nicenames


def main():
    p = argparse.ArgumentParser()
    p.add_argument('gather_csv')
    a = p.parse_args()

    r = csv.DictReader(open(a.gather_csv))
    for row in r:
        f_unique_to_query = float(row['f_unique_to_query'])
        f_match = float(row['f_match'])
        name = row['name']
        nicename = nicenames.seq_to_nicename(name)
        if nicename.startswith('NZ_'):
            nicename = ' '.join(nicename.split(' ')[1:])
        nicename = nicename.replace('_', r'\_')
        print('{:.1f}\\% & {{\\em \\small {} }} \\\\'.format(f_match * 100, nicename))
        print(r'\hline')


if __name__ == '__main__':
    main()
