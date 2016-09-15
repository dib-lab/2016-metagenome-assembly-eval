#! /usr/bin/env python
import sys
import screed
import random
import numpy 

file1 = sys.argv[1]
r = sys.argv[2]

names1 = [ ] 
seqs1 = [ ]
accur1 =[ ] 
annot1 =[ ]

randi = [ ]
added = set()

i=0 
for record in screed.open(file1):
        names1.append(record.name)
	seqs1.append(record.sequence)
	annot1.append(record.annotations)
	accur1.append(record.accuracy)
size = len(names1)

r = int(r) 
rd =r*2
for i in range(rd):
    a = numpy.random.random_integers(0, rd)
    randi.append(a)

count = 0
for i in randi:
        if count  >= r :
		break
	if i not in added : #in case with no replacement
		if i % 2 ==0:
			added.add(i)
			added.add(i+1)
			print "@%s %s\n%s\n+\n%s" % (names1[i], annot1[i], seqs1[i], accur1[i])
			print "@%s %s\n%s\n+\n%s" % (names1[i+1], annot1[i+1], seqs1[i+1], accur1[i+1])	
		else: 
			added.add(i)
			added.add(i-1)
			print "@%s %s\n%s\n+\n%s" % (names1[i-1], annot1[i-1], seqs1[i-1], accur1[i-1])
			print "@%s %s\n%s\n+\n%s" % (names1[i], annot1[i], seqs1[i], accur1[i])
		count +=2 
