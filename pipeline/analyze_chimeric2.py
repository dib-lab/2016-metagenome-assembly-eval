#! /usr/bin/env python
from __future__ import print_function
import sys
import argparse
from collections import defaultdict
import os.path

# re-use some functions
import analyze_assembly

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('reference')
    parser.add_argument('assem')
    parser.add_argument('coords')
    args = parser.parse_args()

    refsizes, reference = analyze_assembly.load_reference(args.reference)

    print('Loading Coords')
 
    prefix1 = args.coords.split('.')[0]
  
    a, aseq = analyze_assembly.load_assembly(args.assem)
    
    gic_a = analyze_assembly.GenomeIntervalsContainer(refsizes, a, aseq)
    keep = gic_a.load_contigs_foo(args.coords, 99.0)

    matches = defaultdict(set)
    for (s1, e1, s2, e2, ident, name1, name2) in keep:
        if ident >= args.percent_identity and e2 - s2 + 1 >= args.min_length:
            matches[name2].add(name1)

    n = 0
    m = 0
    namecounts = defaultdict(int)
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
                #print(k, matches[k])
                m += 1
                for j in matches[k]:
                    namecounts[j] += 1
#                    if 'scf_1099451320477' in j:
#                        print('A', k)
#                    if 'scf_1099451318008' in j:
#                        print('B', k)

    print(n, m, float(m) / n)
    pprint.pprint(sorted(namecounts.items(), key=lambda x: x[1]))


if __name__ == '__main__':
    main()
