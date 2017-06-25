#! /usr/bin/env python
import sys
import argparse
from collections import defaultdict
import pprint
from analyze_assembly import _load_coords


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('coords')
    parser.add_argument('-p', '--percent-identity', type=float, default=99)
    parser.add_argument('-l', '--min-length', type=int, default=100)
    parser.add_argument('--eliminate-prefix', type=int, default=None)
    args = parser.parse_args()

    matches = defaultdict(set)
    for (s1, e1, s2, e2, ident, name1, name2) in _load_coords(args.coords):
        if ident >= args.percent_identity and e2 - s2 + 1 >= args.min_length:
            matches[name2].add(name1)

    n = 0
    m = 0
    namecounts = defaultdict(int)
    pairs = set()
    for k in matches:
        n += 1

        if len(matches[k]) > 1:
            # prefix matching
            if args.eliminate_prefix:
                s2 = set([ n[:args.eliminate_prefix] for n in matches[k] ])
                if len(s2) > 1:
                    #print(k, matches[k], len(s2))
                    for j in matches[k]:
                        namecounts[j] += 1
                    m += 1
            else:
                v = list(matches[k])
                v.sort()
                pairs.update(set(v))
                #print(k, matches[k])
                m += 1
                for j in matches[k]:
                    namecounts[j] += 1
#                    if 'scf_1099451320477' in j:
#                        print('A', k)
#                    if 'scf_1099451318008' in j:
#                        print('B', k)

    print(n, m, float(m) / n)
    #pprint.pprint(sorted(namecounts.items(), key=lambda x: x[1]))

    pprint.pprint(pairs)

if __name__ == '__main__':
    main()
