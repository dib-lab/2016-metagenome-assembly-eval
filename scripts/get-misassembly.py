#! /usr/bin/env python
import sys
import random
import numpy 

from collections import defaultdict
mis = sys.argv[1]

max =205000000

genome =defaultdict(list)
positions =defaultdict(list)

for line in open(mis): 
	x = line.split(' ')
	if x[2] != 'Extensive':
		genome[x[14]].append(float(x[3])) 
		genome[x[14]].append(float(x[4]))
		

