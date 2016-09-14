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
    parser.add_argument('outfile') 

    args = parser.parse_args()
   
    fp = open(args.outfile, 'a+')  

    #from collections import defaultdict
    #dist = defaultdict(int)
    dist = {}
    genome_dict1 = {}
    arr = []
    n_rec =0 
    for record in screed.open(args.genome):
	name = (record.name).split('|')
	name =name[0]
	name.strip()
        genome_dict1[name] = [0] * len(record.sequence)
        print name
	n_rec+=len(record.sequence) 
    arr =[0]*n_rec    
    n = 0
    n_skipped = 0

    for samline in ignore_at(open(args.samfile1)):
        n += 1
        #if n % 100000 == 0:
          #  print >>sys.stderr, '...1', n

        readname, flags, refname, refpos, _, _, _, _, _, seq = \
                  samline.split('\t')[:10]
        if refname == '*' or refpos == '*':
            # (don't count these as skipped)
            continue
        
        refpos = int(refpos)
        #try:
	refname.strip()
        print refname
	if refname == name: 
		print 'true'
	else: 
		print 'false' 
        if refname in genome_dict1:
               ref = genome_dict1[refname]
        #except KeyError:
        #    print >>sys.stderr, "unknown refname: %s; ignoring (read %s)" % (refname, readname)
        #    n_skipped += 1
        else: 
                print 'not found'
		continue


        for i in range(refpos - 1, refpos + len(seq) - 1):
	    print i 
            if i < len(ref):
                ref[i] += 1
                print ref[i]   
    cov =0. 
    total =0.      
    for name in genome_dict1: 
       ref = genome_dict1[name]
       total += len(genome_dict1[name]) 
       for j in range (len(genome_dict1[name])):
             arr[ref[j]]+=1
	     if ref[j] >0:
		 cov +=1 
	   
  #  for i in range(len(arr)): 
#	print >>fp, i, arr[i]
    for name in genome_dict1:
	ref = genome_dict1[name] 
	for i in ref: 
		print >>fp, ref[i]

    #if n_skipped / float(n) > .01:
    #    raise Exception, "Error: too many reads ignored! %d of %d" % \
    #          (n_skipped, n)


    
    print >>fp, args.samfile1, float(cov) / float(total), cov, total

    #print 'lost: %f' % (1.0 - float(cov2) / float(cov1),)
#    print 'lost: %d of %d' % (cov1 - cov2, total)

if __name__ == '__main__':
    main()
