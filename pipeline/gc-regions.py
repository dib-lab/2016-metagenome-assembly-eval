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
    parser.add_argument('uncov') 
    parser.add_argument('output')

    args = parser.parse_args()
    fp =open(args.output, 'a+') 
    dist = {}
    genome_dict = {}
    uncov= {}
    arr = []
    n_rec =0
    uncov_count =0 
  
    for record in screed.open(args.genome):
        genome_dict[record.name] = record.sequence
        n_rec+=len(record.sequence)
        #print genome_dict[record.name][0]

    for line in open(args.uncov):
        if line.startswith('>'):
	     line.strip()  
             line.split('>')
             name = line[:-1]
             name = name[1:]
        else:
             indeces = line.split(',') 
             #print len(indeces)
	     indeces = indeces[:-1] 
	     uncov_count += len(indeces) 
	     indeces = [int(i) for i in indeces] 
             uncov[name] = indeces
             #print >>fp, '>', name 
    gc_count = 0  
    for name in uncov: 
	if name in genome_dict: 
                for i in range(0, len(uncov[name])-1):      
                     x = uncov[name][i]
		     y = uncov[name][i+1]
		     if genome_dict[name][x].lower() + genome_dict[name][y].lower() =="gc":
			if (y-x) == 1 : 
			    gc_count +=1 
	   
    print >>fp, gc_count, uncov_count, float(uncov_count/2) 

if __name__ == '__main__':
    main() 
