#! /usr/bin/env python
import sys
import argparse
from collections import defaultdict

# load a .coords file output by nucmer
def _load_coords(filename, only=None):
    lines = [ x.strip() for x in (open(filename)) ]
    assert lines[1].startswith('NUCMER'), lines[0]
    
    # process each line into (s1, e1, _, s2, e2, ..., % ident, _, name1, name2)
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


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('coords')
    parser.add_argument('-p', '--percent-identity', type=float, default=0.99)
    parser.add_argument('-l', '--min-length', type=int, default=100)
    args = parser.parse_args()

    matches = defaultdict(set)
    for (s1, e1, s2, e2, ident, name1, name2) in _load_coords(args.coords):
        if ident >= args.percent_identity and e2-s2 >= args.min_length:
            matches[name2].add(name1)

    n = 0
    m = 0
    for k in matches:
        n += 1

        if len(matches[k]) > 1:
            #print(k, matches[k])
            m += 1

    print(n, m)


if __name__ == '__main__':
    main()
