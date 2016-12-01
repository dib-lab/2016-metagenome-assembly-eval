#! /usr/bin/env python
import argparse

import numpy
import screed
import sys
from collections import defaultdict


def load_tbl(filename, outfile):
	 fp = open(outfile, 'w')   
	 lines = [ x.strip() for x in (open(filename)) ]  
	 for i in range (0, len(lines)-2 ):
	     line0 = lines[i].split() 
	     if line0[0] == '>Feature':  
		name = line0[1]      
  	     line1 = lines[i].split()
 	     line2 = lines[i+1].split()
	     line3 = lines[i+2].split() 

	     if len(line1) == 3 and len(line2) == 2: 
	        if line1[2] == 'CDS':
                    if line2[0] == 'gene' or line3[0] =='gene': 
			start = line1[0]
			end = line1[1]
			#print name, line0[0], line0[1] ,start, end, line1[0], line1[1], line1[2], line2[0], line3[0]  
                        if start > end: 
				print>> fp, name, end, start 
		        else: 
			        print>>fp, name, start, end

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('testasm')
    parser.add_argument('outfile')
    args = parser.parse_args() 
    load_tbl(args.testasm ,args.outfile) 





if __name__ == '__main__':
    main() 

