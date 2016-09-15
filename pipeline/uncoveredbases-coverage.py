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
    fp =open(args.outfile, 'a+') 

    dist = {}
    genome_dict1 = {}
    genome_uncov = {}
    uncov_coverage = {}  
    arr = []
    n_rec =0
    for record in screed.open(args.genome):
        genome_dict1[record.name] = [0] * len(record.sequence)
	uncov_coverage[record.name] = [0] * len(record.sequence) 
	n_rec+=len(record.sequence)
    

    for line in open(args.uncov):
	if line.startswith('>'): 
             line.split('>') 
             name = line[:-1]
	     name = name[1:] 
	     #name = name.replace("\n", "")
             #print name
	else:
	     #indeces = line.split(',')
	     #genome_uncov[name] = indeces
     
             indeces = line.split(',')
             indeces = indeces[:-1]
             indeces = [int(i) for i in indeces]
             genome_uncov[name] = indeces 


    arr =[0]*n_rec    
    n = 0
    n_skipped = 0

    for samline in ignore_at(open(args.samfile1)):
        n += 1
        #if n % 1000000 == 0:
        #    print >>sys.stderr, '...1', n
        readname, flags, refname, refpos, _, _, _, _, _, seq = \
                  samline.split('\t')[:10]
        #if refname == '*' or refpos == '*':
            # (don't count these as skipped)
        #    continue
       
        refpos = int(refpos)
        if refname in genome_dict1 :#and  refname in genome_uncov:
             #try:
                 ref = genome_dict1[refname]
	         #uncref = genome_uncov[refname] 
            #except KeyError:
                 #print >>sys.stderr, "unknown refname: %s; ignoring (read %s)" % (refname, readname)
                 #n_skipped += 1
        else: 
	         continue
          
        
        for i in range(refpos - 1, refpos + len(seq) - 1):
	           if i < len(ref): #and i in uncref :
                          ref[i] += 1

    print 'Starting filling distribution' 
    #those needed for coverage of reads no common uncovered 
    for name in genome_uncov:
	     if name not in genome_dict1: 
			continue 
             ref = genome_dict1[name]
	     #print >>fp, name
	     for i in genome_uncov[name]:
				arr[ref[i]]+=1  
				#fp.write(str(ref[i]))
				#fp.write(',') 

    print 'Printing distribution'
    for i in range(0, len(arr)):
        if arr[i] == 0:
               break
        print >>fp, i, arr[i]


if __name__ == '__main__':
    main()
