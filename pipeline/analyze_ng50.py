#! /usr/bin/env python
import sys
import argparse
from collections import defaultdict
import pprint
import screed
from nicenames import nicenames

def load_reference(filename):
    d = {}
    for record in screed.open(filename):
        d[record.name.split()[0]] = len(record.sequence)
    return d

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
    parser.add_argument('ref')
    parser.add_argument('-p', '--percent-identity', type=float, default=0.99)
    parser.add_argument('-l', '--min-length', type=int, default=100)
    parser.add_argument('--latex', type=bool, default=False)
    args = parser.parse_args()

    ref = load_reference(args.ref)
    lengthlist = defaultdict(list)

    matches = defaultdict(set)
    for (s1, e1, s2, e2, ident, gname, cname) in _load_coords(args.coords):
        if ident >= args.percent_identity and e2 - s2 + 1 >= args.min_length:
            assert gname in ref
            lengthlist[gname].append(e2 - s2 + 1)

    # compute ng50 of aligned stuff
    ng50s = []
    ng90s = defaultdict(int)
    for gname, lengths in lengthlist.items():
        lengths.sort(reverse=True)
        total = ref[gname]
        t50 = total / 2.
        t90 = total * .9

        # aligned ng50
        sofar = 0.
        for x in lengths:
            sofar += x
            if sofar > t50:
                ng50s.append((x, gname))
                break

        # aligned ng90
        sofar = 0.
        for x in lengths:
            sofar += x
            if sofar > t90:
                ng90s[gname] = x
                break

    # output

    num50_5000 = 0
    num90_5000 = 0
    ng50s.sort()
    for x, gname in ng50s:
        ng50 = float(x)
        ng90 = float(ng90s[gname])
        
        if ng50 >= 5000:
            num50_5000 += 1
        if ng90 >= 5000:
            num90_5000 += 1

        if not args.latex:
            print('{},{},{}'.format(ng50, ng90, gname))
        else:
            ng50 = ng50 / 1000
            ng90 = ng90 / 1000

            s = '{:.1f}kb'.format(ng50)
            s2 = '{:.1f}kb'.format(ng90)
            name = '{{\\tiny {} }}'.format(nicenames[gname])
            print('''{} & {} & {} \\\\ \hline'''.format(s, s2, name))

    print(len(ng50s), num50_5000, num90_5000, file=sys.stderr)

if __name__ == '__main__':
    main()
