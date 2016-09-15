#! /usr/bin/env python
import screed
import sys
import itertools

file1 =sys.argv[1]
file2 =sys.argv[2]



for r1, r2 in itertools.izip(screed.open(file1),
			     screed.open(file2)): 
	print "@%s %s\n%s\n+\n%s" % (r1.name, r1.annotations, r1.sequence, r1.accuracy) 
	print "@%s %s\n%s\n+\n%s" % (r2.name, r2.annotations, r2.sequence, r2.accuracy)

 #	print ">%s/2\n%s\n+\n%s%s" (r1.name, r1.annotations, r1.sequence, r1.accuracy) 
