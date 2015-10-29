#! /usr/bin/env python
import sys
import argparse
import screed
import math

def ignore_at(iter):
    for item in iter:
        if item.startswith('@'):
            continue
        yield item

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('genome')
    parser.add_argument('samfile1')

    args = parser.parse_args()
    #from collections import defaultdict
    #dist = defaultdict(int)
    dist = {}
    genome_dict1 = {}
    arr = []
    n_rec =0 
    for record in screed.open(args.genome):
        genome_dict1[record.name] = [0] * len(record.sequence)

	n_rec+=len(record.sequence) 
    arr =[0]*n_rec    
    n = 0
    n_skipped = 0

    for samline in ignore_at(open(args.samfile1)):
        n += 1
        if n % 100000 == 0:
            print >>sys.stderr, '...1', n

        readname, flags, refname, refpos, _, _, _, _, _, seq = \
                  samline.split('\t')[:10]
        if refname == '*' or refpos == '*':
            # (don't count these as skipped)
            continue
        
        refpos = int(refpos)
        try:
            ref = genome_dict1[refname]
        except KeyError:
            print >>sys.stderr, "unknown refname: %s; ignoring (read %s)" % (refname, readname)
            n_skipped += 1
            continue


        for i in range(refpos - 1, refpos + len(seq) - 1):
	     if i < len(ref):
                ref[i] += 1
		#sys.stdout.write(str(ref[i]))
		#sys.stdout.write(",")
   # import pdb; pdb.set_trace() 
    for name in genome_dict1: 
       ref = genome_dict1[name]
       for j in range (len(genome_dict1[name])):
             arr[ref[j]]+=1  
 	     #print arr[ref[j]], ref[j]             	
    #import pdb; pdb.set_trace()
    for i in range(len(arr)): 
	print i, arr[i]

    if n_skipped / float(n) > .01:
        raise Exception, "Error: too many reads ignored! %d of %d" % \
              (n_skipped, n)

    total = 0.
    cov1 = 0.
    cov2 = 0.

    for name in genome_dict1:
        total += len(genome_dict1[name])
        cov1 += sum(genome_dict1[name])

    print args.samfile1, float(cov1) / float(total), cov1, total
    #print 'lost: %f' % (1.0 - float(cov2) / float(cov1),)
#    print 'lost: %d of %d' % (cov1 - cov2, total)

if __name__ == '__main__':
    main()
