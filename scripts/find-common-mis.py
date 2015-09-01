#! /usr/bin/env python
import sys
import random
import numpy 

from collections import defaultdict
filename = sys.argv[1]

genome =defaultdict(list)
count =defaultdict(list)

def boundary(s1, e1, s2 ,e2):
	if s1 <s2 and e2 <e1 :
		summary="region 2 lie in region 1"
	elif s2<s1 and e1 <e2:	
		summary= "region 1 lie in region 2"
	elif s2 <e1 and e2>e1 :
		summary= "overlaps"
	elif s1 <e2 and e1>e2:
       		summary ="overlaps"
	else:
 		summary="No"
  	return summary
		
for filename in sys.argv[1:]:
	for line in open(filename):
	 	line =line.split(',')
		#genome[line[0]].append(float(line[1]))
		#genome[line[0]].append(float(line[2]))
		#un comment if you have more points not only the min and max 
		l =len(line)
		i =1 
		while i < l:	
			genome[line[0]].append((line[i]))
			i +=1 
for g in genome.keys():
	 l =len(genome[g])
	 i =0 
	 while i <l/2:
		#j = i+1 
		#while j <l-2:
				summary = boundary(genome[g][i], genome[g][i+1], genome[g][l-i-2], genome[g][l-i-1]) 		
				if summary !="No":
					summary = summary + '['+str(genome[g][i])+','+str(genome[g][i+1])+']'+'['+str(genome[g][l-i-2])+','+str(genome[g][l-i-1])+']'
					count[g].append(summary)			
				#j +=2
				i +=2 		
		#i +=2
for c in count.keys():
	#sys.stdout.write(c)
	#sys.stdout.write(',')
	print c , len(count[c])
	i =0 
	"""
	while i < len(count[c]):
		sys.stdout.write(count[c][i])
		sys.stdout.write(',')
		i+=1
	print ('\n')
	"""
