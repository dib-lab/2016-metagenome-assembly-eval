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
    parser.add_argument('uncov') 
    parser.add_argument('outfile')

    args = parser.parse_args()
    fp =open(args.outfile, 'w') # @CTB changed from an 'at'

    genome_dict1 = {}
    genome_uncov = {}
    for record in screed.open(args.genome):
        name = record.name.split(' ')[0]
        genome_dict1[name] = [0] * len(record.sequence)  
    
    c = 0
    for line in open(args.uncov):
        line = line.strip()
	if line.startswith('>'): 
	     name = line[1:] 
	else:
             indeces = line.split(',')
             indeces = [int(i) for i in indeces if i]
             genome_uncov[name] = indeces 
	     c += len(indeces) 

    print 'done reading %s - %d uncov total.' % (args.uncov, c)


    for samline in ignore_at(open(args.samfile1)):
        #n += 1
        #if n % 1000000 == 0:
        #    print >>sys.stderr, '...1', n
        readname, flags, refname, refpos, _, _, _, _, _, seq = \
                  samline.split('\t')[:10]
        #if refname == '*' or refpos == '*':
            # (don't count these as skipped)
        #    continue
       
        refpos = int(refpos)
        if refname in genome_dict1:
                 ref = genome_dict1[refname]
    	else : 
                assert refname == '*', refname # make sure not real alignment
		continue
     
        for i in range(refpos - 1, min(refpos + len(seq) - 1, len(ref))):
                ref[i] += 1

    print>>sys.stderr, "done reading SAM file"
    
   
    count =[0]*200
    for name in genome_uncov: 
	if name in genome_dict1: 
            coverages = genome_dict1[name]
	    for position in genome_uncov[name]:
                cov = coverages[position]
                if cov < 200:
                        count[cov] += 1
   	else: 
	     print >>fp, name 

    for itr in range(0,200): 
    	print >>fp, itr, count[itr]
    #fp.close()
 
if __name__ == '__main__':
    main()
