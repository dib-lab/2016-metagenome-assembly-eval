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
    parser.add_argument('uncovered')
    parser.add_argument('bases') 
    parser.add_argument('coverage') 
 
    args = parser.parse_args()
    
    fout1 = open(args.bases, 'w+') 
    fout2 = open(args.coverage, 'w+')    


    genome_dict1 = {}
    genome_covered = {}
    arr = []
    n_rec =0 
    for record in screed.open(args.genome):
        genome_dict1[record.name] = [0] * len(record.sequence)
	n_rec+=len(record.sequence)
        genome_covered[record.name] = [-1] * len(record.sequence) *4 #4 asseblers commons 

    for line in open(args.uncovered):
       if line.startswith('>'): 
             name =line
             continue
       else: 
	     bases =line.strip().split(",")
             for i in bases: 
		if i =='': 
 			break 
                else:
       			genome_covered[record.name][int(i)]=bases
   
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
    #covx = 0 
    for name in genome_dict1: 
       ref = genome_dict1[name]
       for j in range ( len(genome_dict1[name])):
             arr[ref[j]]+=1 
       #print sum(genome_dict1[name])
       #x =  sum(genome_dict1[name])
       #covx += float(x)


    #print covx

   
    print >>fout2, 'Bases Coverage Distribution'   
    for i in range(len(arr)): 
	print >>fout2,  i, arr[i]
    
    arr1 = []
    arr1 =[0]*n_rec  
    for name in genome_dict1:
        ref1 = genome_dict1[name]
        for i in range (len(genome_dict1[name])):
              x = genome_covered[name][i] 
	      y = genome_dict1[name][i]
              if (x > -1) : 
		  ref1[i] = x
 

    for j in range ( len(genome_dict1[name])):
            arr1[ref1[j]]+=1
     
    print >>fout1, 'Uncovered bases Coverage Distribution'  
    for i in range(len(arr1)):
        if arr1[i] >0:
            print >>fout1, i, arr1[i]

    #if n_skipped / float(n) > .01:
        #raise Exception, "Error: too many reads ignored! %d of %d" % \
              #(n_skipped, n)

    total = 0.
    cov1 = 0.

    for name in genome_dict1:
        total += len(genome_dict1[name])
        x =  sum(genome_dict1[name]) 
        cov1 += float(x)  
    print >> fout1, args.samfile1, float(cov1) / float(total), cov1, total

if __name__ == '__main__':
    main()
