#! /usr/bin/env python
import argparse

import numpy
import screed
import sys
from collections import defaultdict

def _load_coords(filename, only=None):
    lines = [ x.strip() for x in (open(filename)) ]
    assert lines[1].startswith('NUCMER'), lines[0]
    
    
    coords = []
    for line_no in range(5, len(lines)):
        line = lines[line_no].split()
        s1, e1 = int(line[0]), int(line[1])
        s2, e2 = int(line[3]), int(line[4])
        ident = float(line[9])
        name1, name2 = line[11], line[12]
        s1, e1 = min(s1, e1), max(s1, e1)
        s2, e2 = min(s2, e2), max(s2, e2)

        yield (s1, e1, s2, e2, ident, name1, name2)

def load_reference(filename):
    d = {}
    s = {}
    for record in screed.open(filename):
        d[record.name.split()[0]] = len(record.sequence) 
        s[record.name.split()[0]] = record.sequence
    return d, s 


def load_prokka(filename):
    e = {} 	 
    s = {}
    genomes = {} 
    tracks = {}
    i = 0  
    for line in open(filename): 
	line =line.split(' ') 
	genome = line[0]  
	start = line[1] 
	end = line[2] 
        genomes[i] = genome 
 	s[i] = start 
	e[i] = end 
	tracks[genome+start+end] = 0 
        i +=1 
    return genomes, s, e , tracks  

def load_assembly(assembly): 
    d = {}
    s = {}
    for record in screed.open(assembly):
 	       d[record.name.split()[0] ] = len(record.sequence)
               s[record.name.split()[0] ] = record.sequence
    return d, s 


def best_hit(a, b):
    return a >=  b

def no_overlaps(a, b):
    return a == b
  
class GenomeIntervalsContainer(object):
    def __init__(self, refsizes, assemblysize, assembly):
        self.names = refsizes.keys()
        self.refsizes = refsizes
        self.contigs = assemblysize.keys()
        self.assemsizes =assemblysize
        self.sequences = assembly
        covered = {}
        aligned = {} 
        regions = {} 
        overlaps_s1 = {} 
        overlaps_e1 = {} 
        overlaps_s2 = {} 
        overlaps_e2 = {} 
        overlaps_identity = {} 
        contigs_overlaps = {}
        overlaps_genome = {} 
        regions = {}
        for k in self.names:
            covered[k] = numpy.zeros(refsizes[k])
            regions[k] = numpy.zeros(refsizes[k])
        
        self.covered = covered
        for k in self.contigs:
            aligned[k] = numpy.zeros(assemblysize[k])
            overlaps_s1[k] = 0 
            overlaps_s2[k] = 0 
            overlaps_e1[k] = 0
            overlaps_e2[k] = 0 
            overlaps_identity[k] = 0       
            contigs_overlaps[k] = 0
            overlaps_genome[k] = "null"
        self.overlaps_s1 = overlaps_s1
        self.overlaps_s2 = overlaps_s2 
        self.overlaps_e1 = overlaps_e1
        self.overlaps_e2 = overlaps_e2 
        self.overlaps_identity = overlaps_identity
        self.contigs_overlaps = contigs_overlaps 
        self.overlaps_genome = overlaps_genome  
        self.regions = regions  
 
        self.aligned = aligned
      
           
   
    def load_overlaps(self, filename,  min_ident,prokka_file, comparison =best_hit, min_length=100):
      	fp = open('prokka-analysis.out', 'a+') 
	covered = self.covered
        aligned = self.aligned 
        counts = 0
	genomes, starts, ends, tracks   = load_prokka(prokka_file)
        for s1, e1, s2, e2, ident, name1, name2 in _load_coords(filename):
                       
           if name1 in covered and name2 in aligned  and self.contigs_overlaps[name2] ==0 :
                     self.overlaps_s1[name2] = s1
                     self.overlaps_e1[name2] = e1
                     self.overlaps_s2[name2] = s2
                     self.overlaps_e2[name2] = e2
                     self.overlaps_genome[name2] = name1
                     self.overlaps_identity[name2] = ident
                     self.contigs_overlaps[name2] +=1
 
		       
           elif name1 in covered and name2 in aligned  and self.contigs_overlaps[name2] > 0:
                if self.overlaps_identity[name2] < ident: 
		     self.overlaps_s1[name2] = s1 
                     self.overlaps_e1[name2] = e1 
		     self.overlaps_s2[name2] = s2
		     self.overlaps_e2[name2] = e2
                     self.overlaps_genome[name2] = name1  
		     self.overlaps_identity[name2] = ident
        	     self.contigs_overlaps[name2] +=1 	
		 
        for name2 in self.overlaps_s1  :
           name1 = self.overlaps_genome[name2]
            
           if (name1 in covered) and (name2 in aligned) and (name1 != "null") and comparison( self.contigs_overlaps[name2],1) :
                 cov = covered[name1]
                 align = aligned[name2]
                 s1 = self.overlaps_s1[name2] 
                 e1 = self.overlaps_e1[name2] 
                 s2 = self.overlaps_s2[name2]
                 e2 = self.overlaps_e2[name2] 
                 ident = self.overlaps_identity[name2]
                 if e1 - s1 + 1 >= min_length and ident >= min_ident:
                    for i in range(s1 -1, e1): 
			cov[i] += 1
                    for j in range(s2-1, e2):
			align[j] +=1
 		    for i in range(0, len(genomes)) :
                        if genomes[i] == name1:
                           s = int(starts[i])
                           e = int(ends[i])
                           if  s >=s1 and e <= e1:
                                counts +=1
                                tracks[genomes[i] + starts[i] +ends[i] ]+=1
                           elif s1 >=s and e1 <= e:
                                counts +=1
                                tracks[genomes[i] + starts[i] +ends[i] ] +=1
        c = 0
        for i in tracks:
                if tracks[i] >0:
                        c +=1
        print >>fp, 'Counts of genes found is:' , c, 'out of', counts 
    
    def load_coords(self, filename,  min_ident, prokka_file, min_length=100):
       	fp = open('prokka-analysis.out', 'a+') 
	covered = self.covered
        aligned = self.aligned
        counts = 0 
	genomes, starts, ends, tracks   = load_prokka(prokka_file) 
	for s1, e1, s2, e2, ident, name1, name2 in _load_coords(filename):
            if name1 in covered and name2 in aligned:
                cov = covered[name1]
                align = aligned[name2]

                if e1 - s1 + 1 >= min_length and ident >= min_ident:
                    for i in range(s1 -1, e1):
                        cov[i] += 1
                    for j in range(s2-1, e2):
                        align[j] +=1
		for i in range(0, len(genomes)) :
			if genomes[i] == name1: 
			   s = int(starts[i])
			   e = int(ends[i]) 	    
			   if  s >=s1 and e <= e1:
                                counts +=1
				tracks[genomes[i] + starts[i] +ends[i] ]+=1  
			   elif s1 >=s and e1 <= e: 
				counts +=1 
			        tracks[genomes[i] + starts[i] +ends[i] ] +=1 
	c = 0 
	for i in tracks: 
		if tracks[i] >0: 
			c +=1    
 	print >>fp, 'Counts of genes found is:' , c, 'out of', counts 

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('reference')
    parser.add_argument('assem1')
    parser.add_argument('assem2')
    parser.add_argument('assem3')
    parser.add_argument('coords1')
    parser.add_argument('coords2')
    parser.add_argument('coords3')
    parser.add_argument('treatment')
    parser.add_argument('minident')
    parser.add_argument('prokka_file')
    parser.add_argument('-a', '--ambiguity', dest='ambiguity', type=bool, default=False) 
    parser.add_argument('-b', '--best-hit', dest='besthit', type=bool, default=False)
    parser.add_argument('-c', '--nooverlap', dest='nooverlap', type=bool, default= False) 
    args = parser.parse_args()
    print 'loading refsizes'
    refsizes, reference = load_reference(args.reference)

    print 'Loading Coords'
 
    prefix1 = args.coords1.split('.')[0]
    prefix2 = args.coords2.split('.')[0]
    prefix3 = args.coords3.split('.')[0]  
  
    a, aseq = load_assembly(args.assem1)
    b, bseq = load_assembly(args.assem2) 
    c, cseq = load_assembly(args.assem3) 
    

    #------------------------------------------------------------------------------------------------------------------------------
    #Building Containers 
    #---------------------
      
    gic_a = GenomeIntervalsContainer(refsizes, a, aseq)
    gic_b = GenomeIntervalsContainer(refsizes, b, bseq)
    gic_c = GenomeIntervalsContainer(refsizes, c, cseq) 

    print args.ambiguity, args.besthit
    if (args.ambiguity is True):
                print '......Running ambigious analysis' 	
    		gic_a.load_coords(args.coords1, float(args.minident),args.prokka_file)
    	        gic_b.load_coords(args.coords2, float(args.minident),args.prokka_file) 
    		gic_c.load_coords(args.coords3, float(args.minident),args.prokka_file)
     
    elif (args.besthit is True): 
               print '.....Running best hit analysis'
               gic_a.load_overlaps(args.coords1, float(args.minident), args.prokka_file)
               gic_b.load_overlaps(args.coords2, float(args.minident), args.prokka_file)
               gic_c.load_overlaps(args.coords3, float(args.minident), args.prokka_file)
     
    elif (args.nooverlap is True):
	      print '.... Running no overlaps analysis'  
	      gic_a.load_overlaps(args.coords1, float(args.minident), args.prokka_file, no_overlaps)
              gic_b.load_overlaps(args.coords2, float(args.minident), args.prokka_file, no_overlaps)
              gic_c.load_overlaps(args.coords3, float(args.minident), args.prokka_file, no_overlaps)

  
     
if __name__ == '__main__':
    main()
