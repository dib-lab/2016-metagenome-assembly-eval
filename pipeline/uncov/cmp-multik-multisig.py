#! /usr/bin/env python
"""
Do a multi-k Jaccard resemblance analysis between many genome
signatures and a single metagenome.

Usage:

  cmp-multik-multisig.py metagenome.sig query-1.sig [ query-2.sig ... ]

Construct signatures with:

  sourmash compute -k 21,31,41,51 --dna --scaled 10000 *.fa

"""
import sys
sys.path.insert(0, '/Users/t/dev/sourmash')
import sourmash_lib
from sourmash_lib.signature import load_signatures
from collections import defaultdict
import csv


KSIZES=[21,31,51]
SCALED=10000


def main():
    import argparse
    p = argparse.ArgumentParser()
    p.add_argument('against_sig')
    p.add_argument('query_sigs', nargs='+')
    args = p.parse_args()

    minhashdict = defaultdict(dict)
    signame_to_file = {}

    for sigfile in args.query_sigs:
        sigs = load_signatures(sigfile)
        for sig in sigs:
            ksize = sig.minhash.ksize
            minhashdict[sig.name()][ksize] = sig.minhash.downsample_scaled(SCALED)
        signame_to_file[sig.name()] = sigfile

    against_minhashes = {}
    against_name = None
    for against_sig in load_signatures(args.against_sig):
        ksize = against_sig.minhash.ksize
        against_minhashes[ksize] = against_sig.minhash.downsample_scaled(SCALED)
        against_name = against_sig.name()

    csvout = csv.writer(sys.stdout)
    for signame in minhashdict:
        results = []

        for K in KSIZES:
            against = against_minhashes[K]
            query = minhashdict[signame][K]
            match = query.contained_by(against)
            results.append(match)

        sigfile = signame_to_file[signame]
        results.insert(0, sigfile)
        results.insert(0, signame)
        results.insert(0, against_name)

        csvout.writerow(results)


if __name__ == '__main__':
    main()
