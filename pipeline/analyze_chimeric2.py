#! /usr/bin/env python
from __future__ import print_function
import sys
import argparse
from collections import defaultdict, Counter
import os.path
import pprint
import screed

# re-use some functions
import analyze_assembly

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('reference')
    parser.add_argument('assem')
    parser.add_argument('coords')
    parser.add_argument('-p', '--percent-identity', type=float, default=99)
    parser.add_argument('-l', '--min-length', type=int, default=100)
    parser.add_argument('--eliminate-prefix', type=int, default=None)
    parser.add_argument('--save-contigs', type=argparse.FileType('w'))
    args = parser.parse_args()

    refsizes, reference = analyze_assembly.load_reference(args.reference)
    ref_names = dict([ (r.name.split(' ')[0], r.name) for r in screed.open(args.reference) ])

    print('Loading Coords')
 
    a, aseq = analyze_assembly.load_assembly(args.assem)
    
    gic_a = analyze_assembly.GenomeIntervalsContainer(refsizes, a, aseq)
    keep = gic_a.load_contigs_uniq(args.coords, 99.0)

    matches = defaultdict(set)
    for (s1, e1, s2, e2, ident, name1, name2) in keep:
        if ident >= args.percent_identity and e2 - s2 + 1 >= args.min_length:
            n1 = ref_names[name1]
            n1 = n1.split(',')[0]
            n1 = " ".join(n1.split(' ')[1:4])
            matches[name2].add(n1)

    n = 0
    m = 0
    namecounts = defaultdict(int)
    coll_counts = Counter()
    contigs = set()
    for k in matches:
        n += 1

        if len(matches[k]) > 1:
            contigs.add(k)
            # prefix matching
            if args.eliminate_prefix:
                s2 = set([ n[:args.eliminate_prefix] for n in matches[k] ])
                if len(s2) > 1:
                    #print(k, matches[k], len(s2))
                    for j in matches[k]:
                        namecounts[j] += 1
                    m += 1
            else:
                #print(k, matches[k])
                coll = list(matches[k])
                coll.sort()
                coll_counts[tuple(coll)] += 1
                m += 1
                for j in matches[k]:
                     namecounts[j] += 1
#                    if 'scf_1099451320477' in j:
#                        print('A', k)
#                    if 'scf_1099451318008' in j:
#                        print('B', k)

    print(n, m, float(m) / n)
#    pprint.pprint(sorted(namecounts.items(), key=lambda x: x[1]))

    for tup, count in coll_counts.most_common():
        print(tup, count)
#    pprint.pprint(coll_counts)

    if args.save_contigs:
        for r in screed.open(args.assem):
            first = r.name.split(' ')[0]
            if first in contigs:
                args.save_contigs.write('>{}\n{}\n'.format(r.name, r.sequence))

if __name__ == '__main__':
    main()
