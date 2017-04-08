#! /usr/bin/env python
import sys
import argparse
from collections import defaultdict

# re-use some functions
import analyze_assembly

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('reference')
    parser.add_argument('assem')
    parser.add_argument('coords')
    args = parser.parse_args()

    refsizes, reference = analyze_assembly.load_reference(args.reference)

    print 'Loading Coords'
 
    prefix1 = args.coords.split('.')[0]
  
    a, aseq = analyze_assembly.load_assembly(args.assem)
    
    #------------------------------------------------------------------------------------------------------------------------------
    #Building Containers 
    #---------------------
 
    gic_a = analyze_assembly.GenomeIntervalsContainer(refsizes, a, aseq)

    gic_a.load_contigs_foo(args.coords, 99.0)

    #for k, v in aseq.items():
    #    pass


if __name__ == '__main__':
    main()
