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

    genome_dict1 = {}
    genome_uncov = {}
    for record in screed.open(args.genome):
        genome_dict1[record.name] = [0] * len(record.sequence)  
    
    c = 0
    for line in open(args.uncov):
	if line.startswith('>'): 
             line.split('>') 
             name = line[:-1]
	     name = name[1:] 
	else:
             indeces = line.split(',')
             indeces = indeces[:-1]
             indeces = [int(i) for i in indeces]
             genome_uncov[name] = indeces 
	     c += len(indeces) 


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
		continue
     
        for i in range(refpos - 1, refpos + len(seq) - 1):
	       if i < len(ref): 
                          ref[i] += 1
    
   
    count5 = 0 
    count5plus = 0 
    for name in genome_uncov: 
	if name in genome_dict1: 
	    for i in range(0, len(genome_uncov[name]) ): 
		index = genome_uncov[name][i] 
		#for itr in range(0, 50): 
	 		#if  genome_dict1[name][index]  <itr  : 
				#count[itr]  +=1
		if genome_dict1[name][index]  <5: 
			count5 +=1 
		else:
		       count5plus +=1 
   	else: 
	     print >>fp, name 
    print >>fp, "coverage less than 5, coverage greater than/equal 5:" 
    print >>fp,  count5, count5plus
 
    #for itr in range(0,50): 
    	#print 'Total bases with coverage less than ',itr, 'is',  count[itr], 'out of', c  
    #fp.close() 
if __name__ == '__main__':
    main()
