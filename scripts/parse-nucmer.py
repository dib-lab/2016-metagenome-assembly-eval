#! /usr/bin/env python
import sys
import random
import numpy 

mis = sys.argv[1]
misindex =set()
cutoff = 1000 

from collections import defaultdict
dic = defaultdict(list)
cont = defaultdict(list)
ref = {}

i = 0
for line in open(mis): 	
     if line.startswith(' ') or line.startswith('='): 	
		continue 
     x = line.split(' ')
     s1 = x[0]
     e1 = x[1]
     s2 = x[3] 
     e2 = x[4] 
     qd = x[6] 
     rd = x[7]
     contig = x[12] 
     cont[contig].append(x[11]) 	
     dic[contig].append(s1) 
     dic[contig].append(e1)  

for x in dic.keys():
        l = len(dic[x])
        if l > 3: 
	        i = 0
		while i < l-2:
			if len(cont[x]) > 1:	
				print "inversion: %s, %s, %s" %(x, dic[x][i], dic[x][i+1])
			#d = abs( int(dic[x][i+2]) - int(dic[x][i+1]) ) #ignore abs to ignore negative gap
 			d = int(dic[x][i+2]) - int(dic[x][i+1]) 
			if d > cutoff: 
				print "Relocation: %s, %s, %s" %(x, dic[x][i+1], dic[x][i+2]) 	
			if (dic[x][i]< dic[x][i+3]) and  (dic[x][i+2]<dic[x][i]): 
				print "Inversion: %s, %s, %s" %(x, dic[x][i], dic[x][i+2])
            	        #if ( int(dic[x][i+2]) > int(dic[x][i+3]) ) and (int(dic[x][i+1]) >int(dic[x][i]) ):
                               #print "case trans2: %s, %s, %s" %(x,dic[x][i+2], dic[x][i+3])
			i +=2 
