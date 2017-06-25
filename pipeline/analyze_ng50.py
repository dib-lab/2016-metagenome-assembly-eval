#! /usr/bin/env python
import sys
import argparse
from collections import defaultdict
import pprint
import screed
from nicenames import seq_to_nicename
import analyze_assembly
from analyze_assembly import _load_coords, load_assembly, load_reference


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('coords')
    parser.add_argument('ref')
    parser.add_argument('assem')
    parser.add_argument('-p', '--percent-identity', type=float, default=0.99)
    parser.add_argument('-l', '--min-length', type=int, default=100)
    parser.add_argument('--latex', type=bool, default=False)
    args = parser.parse_args()

    refsizes, ref2 = load_reference(args.ref)

    ref = defaultdict(int)
    for k in ref2:
        nicename = seq_to_nicename(k)
        ref[nicename] += len(ref2[k])
        
    lengthlist = defaultdict(list)

    a, aseq = analyze_assembly.load_assembly(args.assem)
    gic_a = analyze_assembly.GenomeIntervalsContainer(refsizes, a, aseq)
    keep = gic_a.load_contigs_uniq(args.coords, args.percent_identity*100)

    matches = defaultdict(set)
    for (s1, e1, s2, e2, ident, gname, cname) in keep:
        if ident >= args.percent_identity and e2 - s2 + 1 >= args.min_length:
            assert gname in ref2, gname
            nicename = seq_to_nicename(gname)
            lengthlist[nicename].append(e2 - s2 + 1)

    # compute ng50 of aligned stuff
    ng50s = []
    ng90s = defaultdict(int)
    for gname, lengths in lengthlist.items():
        lengths.sort(reverse=True)
        total = ref[gname]
        t50 = total / 2.
        t90 = total * .9

        # aligned ng50
        did_set = False
        sofar = 0.
        for x in lengths:
            sofar += x
            if sofar > t50:
                ng50s.append((x, gname))
                did_set = True
                break

        if not did_set:
            ng50s.append((1000, gname))

        # aligned ng90
        sofar = 0.
        did_set = False
        for x in lengths:
            sofar += x
            if sofar > t90:
                ng90s[gname] = x
                did_set = True
                break
        if not did_set:
            ng90s[gname] = 1000

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
