#! /usr/bin/env python
import sys
import screed
import random
import numpy 

file =sys.argv[1]
file1  = sys.argv[2]
file2  = sys.argv[3]


fp1 = open(file1,'w')
fp2 = open(file2,'w')

i=1

for r1 in screed.open(file):
	if i % 2 ==0: 
		print>>fp2, '@%s %s \n%s\n+\n%s' %(r1.name, r1.annotations,r1.sequence,r1.quality)
	else:
		print>>fp1, '@%s %s \n%s\n+\n%s' %(r1.name, r1.annotations,r1.sequence,r1.quality) 
	i+=1
	
