#! /usr/bin/env python
import sys
import random
import numpy 

from collections import defaultdict
mis = sys.argv[1]

genome =defaultdict(list)

for line in open(mis): 
	x = line.split(' ')
	if x[2] != 'Extensive':
		genome[x[14]].append(float(x[3])) 
		genome[x[14]].append(float(x[4]))


for g in genome.keys():
	 l = len(genome[g])
	 i =0 
	 #print g,',', min(genome[g]),',', max(genome[g])
	 #uncomment if you need to print out each misassembly position in details 
	 sys.stdout.write(g)
	 sys.stdout.write(',')
	 while i <l:
		sys.stdout.write(str(genome[g][i]))
		sys.stdout.write(',')
		i +=1
	 sys.stdout.write('\n')
