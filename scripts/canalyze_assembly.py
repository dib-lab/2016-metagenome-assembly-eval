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


def load_assembly(assembly): 
    d = {}
    s = {}
    for record in screed.open(assembly):
 	       d[record.name.split()[0] ] = len(record.sequence)
               s[record.name.split()[0] ] = record.sequence
    return d, s 
  
class GenomeIntervalsContainer(object):
    def __init__(self, refsizes, assemblysize, assembly):
        self.names = refsizes.keys()
        self.refsizes = refsizes
        self.contigs = assemblysize.keys()
        self.assemsizes =assemblysize
        self.sequences = assembly
        covered = {}
        aligned = {} 
        
        overlaps_s1 = {} 
        overlaps_e1 = {} 
        overlaps_s2 = {} 
        overlaps_e2 = {} 
        overlaps_identity = {} 
        contigs_overlaps = {} 
 
        for k in self.names:
            covered[k] = numpy.zeros(refsizes[k])
            
        self.covered = covered
        for k in self.contigs:
            aligned[k] = numpy.zeros(assemblysize[k])
            overlaps_s1[k] = 0 
            overlaps_s2[k] = 0 
            overlaps_e1[k] = 0
            overlaps_e2[k] = 0 
            overlaps_identity[k] = 0       
            contigs_overlaps[k] = 0
        
        self.overlaps_s1 = overlaps_s1
        self.overlaps_s2 = overlaps_s2 
        self.overlaps_e1 = overlaps_e1
        self.overlaps_e2 = overlaps_e2 
        self.overlaps_identity = overlaps_identity
        self.contigs_overlaps = contigs_overlaps  
 
 
        self.aligned = aligned
      
           
   
    def load_coords(self, filename,  min_ident, min_length=100):
        covered = self.covered
        aligned = self.aligned 
        
        for s1, e1, s2, e2, ident, name1, name2 in _load_coords(filename):
            if name1 in covered and name2 in aligned:
                cov = covered[name1]
                align = aligned[name2]
                if self.contigs_overlaps[name2] ==0 : 
			self.contigs_overlaps[name2] +=1 
                if self.overlaps_identity[name2] < ident: 
		     self.overlaps_s1[name2] = s1 
                     self.overlaps_e1[name2] = e1 
		     self.overlaps_s2[name2] = s2
		     self.overlaps_e2[name2] = e2 
		     self.overlaps_identity[name2] = ident
	             self.contigs_overlaps[name2] +=1  
               
                if e1 - s1 + 1 >= min_length and ident >= min_ident:
                    for i in range(s1 -1, e1): 
			cov[i] += 1
                    for j in range(s2-1, e2):
			align[j] +=1 
                    
                    
                    #cov[s1 - 1:e1] = numpy.ones(e1 - s1 + 1)
                    #align[s2 - 1:e2] = numpy.ones(e2 - s2 + 1)
                               
                    
    def calc_uncov(self):
        uncov_d = {}
        for name in self.refsizes:
	    cov = 0 
            length = self.refsizes[name]
            for i in self.covered[name]: 
		if i > 0: 
		    cov +=1  
            uncov = length - cov
            uncov_d[name] = uncov
        return uncov_d

    def calc_unalignments(self, out1, out2): 
       ftotal = open(out1, 'w+') 
       fpartial = open(out2, 'w+') 
       unaligned = {} 
       totally_aligned_contigs = 0
       for name in self.assemsizes:
            align = 0 
            length = self.assemsizes[name]
            for i in self.aligned[name]: 
		if i > 0: 
		   align += 1 

            if align == length:
                totally_aligned_contigs +=1
                print >>ftotal, ">"+name
	 	print >>ftotal, self.sequences[name] 
            else: 
		print >>fpartial, ">"+name 
		print >>fpartial, self.sequences[name] 		
                unalign = length - align
                unaligned[name] = unalign
       return unaligned,  totally_aligned_contigs 

    def calc_duplication_ratio(self): 
          x = 0 
          y = 0
          
          for name1 in self.aligned:
               for i in self.aligned[name1]: 
		   if i > 1: 
			x += 1 
	  for name2 in self.covered: 
              for j in self.covered[name2]: 
        	  if j > 1:
		       y += 1
          cdr = y
          adr = x 
          return cdr, adr
    
    
    def subtract(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        ocovered = other.covered
        
        for name in self.refsizes:
            ttree = self.covered[name]
            otree = ocovered[name]
            newtree = ttree - numpy.logical_and(ttree, otree)
            new_gic.covered[name] = newtree

        return new_gic

    def union(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        ocovered = other.covered
        
        for name in self.refsizes:
            ttree = self.covered[name]
            otree = ocovered[name]
            newtree = numpy.logical_or(ttree, otree)
            new_gic.covered[name] = newtree

        return new_gic
    
    def intersect(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        ocovered = other.covered
        
        for name in self.refsizes:
            ttree = self.covered[name]
            otree = ocovered[name]
            newtree = numpy.logical_and(ttree, otree)
            new_gic.covered[name] = newtree

        return new_gic

    def write_contigs(self, outfile, assembly, code): 
	fout = open(outfile, 'a') 
	for k in self.aligned:
                 line ="" 
                 for j in xrange(0, len(self.aligned[k])):
                     if self.aligned[k][j] == code:
                        #fout.write(assembly[k][j])
                        line +=assembly[k][j] 
                 if line!="":
                      print >> fout, ">"+k
                      print >> fout, line
 
    def write_bases(self, other1, other2, outfile, reference): 
        fout = open(outfile, 'w+') 
        for k in self.covered:
             for j in xrange(0, len(self.covered[k])):
                  if j ==0: 
			 print >>fout , ">"+k
                  if (self.covered[k][j] == 0) and (other1.covered[k][j] ==0) and (other2.covered[k][j] ==0):
                         fout.write(str(j))
                         fout.write(',')
             fout.write('\n')
	fout.close()
    
    def common_uncov(self,sqc, mqc, outfile): 
	fout = open(outfile, 'w+') 
        for k in self.covered: 
	   n =">"+k
           print >>fout , n 
           for j in xrange(0, len(self.covered[k])):
 		if self.covered[k][j] == sqc.covered[k][j] ==mqc.covered[k][j] ==0 :
                       fout.write(str (j) )
                       fout.write(',') 
           fout.write('\n')
            
    def count_common_uncov(self, other1, other2, outfile):
        fout = open(outfile, 'w+')
        total_uncov =0
        for k in self.covered:
           n =">"+k
           count =0
           for j in xrange(0, len(self.covered[k])):
                if (self.covered[k][j] ==0) and (other1.covered[k][j] ==0) and (other2.covered[k][j] ==0) :
                    count+=1  
           print >>fout, n, count
           total_uncov+=count
        return total_uncov  

     
    def count_diff_uncov(self, other1, other2, outfile): 
	fout =open(outfile, 'w+')  
        diff_uncov =0
        for k in self.covered:
           n =">"+k
           count =0
           for j in xrange(0, len(self.covered[k])):
                if (self.covered[k][j] ==0) and (other1.covered[k][j] >0 ) and (other2.covered[k][j] > 0) :
                    count+=1
           print >>fout, n, count
           diff_uncov+=count
        return diff_uncov


    def distribution_alignment(self, s,  outfile): 
        dist = {}
        dist = numpy.zeros(s)
        fout = open(outfile, 'w+')  
	for name in self.aligned: 
	    for i in self.aligned[name]:
		dist[i] +=1 
        for i in range(0, len(dist)) :
            if dist[i] == 0:
                break
	    print >>fout,  i, dist[i]
    def distribution_coverage(self, s, outfile): 
	dist = {} 
        dist = numpy.zeros(s)
        fout = open(outfile, 'w+')
        for name in self.covered:
            for i in self.covered[name]:
                dist[i] +=1
        for i in range(0, len(dist)) :
            if dist[i] == 0:
                break
            print >>fout,  i, dist[i]


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
    gic_a.load_coords(args.coords1, float(args.minident) )
 
    gic_b = GenomeIntervalsContainer(refsizes, b, bseq)
    gic_b.load_coords(args.coords2, float(args.minident) ) 

    gic_c = GenomeIntervalsContainer(refsizes, c, cseq)
    gic_c.load_coords(args.coords3, float(args.minident) )
     
    ref_total_length = sum(refsizes.values()) 
    a_total_bases = sum(gic_a.assemsizes.values())
    b_total_bases = sum(gic_b.assemsizes.values())
    c_total_bases = sum(gic_c.assemsizes.values())

    a_dist_align = prefix1 +'.align.dist' + args.minident  
    b_dist_align = prefix2 +'.align.dist' + args.minident 
    c_dist_align = prefix3 +'.align.dist' + args.minident
   
    a_dist_cov = prefix1 +'.cov.dist' + args.minident 
    b_dist_cov = prefix2 +'.cov.dist' + args.minident   
    c_dist_cov = prefix3 +'.cov.dist' + args.minident   


    gic_a.distribution_alignment(a_total_bases, a_dist_align)
    gic_b.distribution_alignment(b_total_bases, b_dist_align) 
    gic_c.distribution_alignment(c_total_bases, c_dist_align)


    gic_a.distribution_coverage(ref_total_length, a_dist_cov)
    gic_b.distribution_coverage(ref_total_length, b_dist_cov)
    gic_c.distribution_coverage(ref_total_length, c_dist_cov)

    """ 

    #------------------------------------
    #Open output file 
    fout = open('assemblies.stats.'+args.treatment, 'w+')

    print >>fout, 'Min ident used is:' , args.minident 
    #Printing some general analysis: 
    print >>fout, "Total bases in Reference is: ", ref_total_length 
    print >>fout, "Total bases in", prefix1, str(args.treatment) , "is" , a_total_bases, "with", len(a) ,"contigs"
    print >>fout, "Total bases in", prefix2, str(args.treatment) , "is" , b_total_bases, "with", len(b) ,"contigs" 
    print >>fout, "Total bases in", prefix3, str(args.treatment) , "is" , c_total_bases, "with", len(c) ,"contigs" 
    
    #----------------------------------------------------------------------------------------------------------------------------------------------------
    #Analysis of unalignments 
    #-----------------------------
    alignoutfile1 = prefix1 + '.' + args.treatment +'.aligned'
    alignoutfile2 = prefix2 + '.' + args.treatment +'.aligned'
    alignoutfile3 = prefix3 + '.' + args.treatment +'.aligned' 
     
    print >>fout,  "Analysis of unalignments" 
    print >>fout,  "========================="
   
    a_unaligned, a_totally_aligned_contigs  = gic_a.calc_unalignments(alignoutfile1, alignoutfile1 + '.partial')
    a_total_unaligned = sum(a_unaligned.values())

    b_unaligned, b_totally_aligned_contigs = gic_b.calc_unalignments(alignoutfile2, alignoutfile2 + '.partial')
    b_total_unaligned = sum(b_unaligned.values())
    
    c_unaligned, c_totally_aligned_contigs = gic_c.calc_unalignments(alignoutfile3, alignoutfile3 + '.partial')
    c_total_unaligned = sum(c_unaligned.values()) 

    a_aligned = a_total_bases - a_total_unaligned 
    b_aligned = b_total_bases - b_total_unaligned 
    c_aligned = c_total_bases - c_total_unaligned 
   
    print >>fout, 'QC \t  Total Bases \t Total Aligned \t Percentage to Assembly \t Total Unaligned \t Percentage to Assembly'
    print >>fout, prefix1, args.treatment, a_total_bases, '\t', a_aligned, '\t', float(a_aligned)/a_total_bases * 100, '\t', a_total_unaligned, '\t', float(a_total_unaligned)/a_total_bases *100  
    print >>fout, prefix2, args.treatment, b_total_bases, '\t', b_aligned, '\t', float(b_aligned)/b_total_bases * 100, '\t', b_total_unaligned, '\t', float(b_total_unaligned)/b_total_bases *100
    print >>fout, prefix3, args.treatment, c_total_bases, '\t', c_aligned, '\t', float(c_aligned)/c_total_bases * 100, '\t', c_total_unaligned, '\t', float(c_total_unaligned)/c_total_bases *100
  


    print >>fout, prefix1, args.treatment, "has",  a_totally_aligned_contigs, "totally aligned contigs ~", float(a_totally_aligned_contigs)/len(a) * 100
    print >>fout, prefix2, args.treatment, "has",  b_totally_aligned_contigs, "totally aligned contigs ~", float(b_totally_aligned_contigs)/len(b) * 100
    print >>fout, prefix3, args.treatment, "has",  c_totally_aligned_contigs, "totally aligned contigs ~", float(c_totally_aligned_contigs)/len(c) * 100
    

    #---------------------------------------------------------------------------------------------------------------------------------------------------
    #Analysis of uncovered regions
    #------------------------------ 

    a_uncov_d = gic_a.calc_uncov()
    b_uncov_d = gic_b.calc_uncov()
    c_uncov_d = gic_c.calc_uncov()
    
    a_total_uncov = sum(a_uncov_d.values())
    b_total_uncov = sum(b_uncov_d.values())
    c_total_uncov = sum(c_uncov_d.values())
 
    a_uncov_per = float(a_total_uncov)/ref_total_length*100
    b_uncov_per = float(b_total_uncov)/ref_total_length*100
    c_uncov_per = float(c_total_uncov)/ref_total_length*100

    a_cov_per = float(ref_total_length - a_total_uncov) /ref_total_length * 100
    b_cov_per = float(ref_total_length - b_total_uncov) /ref_total_length * 100
    c_cov_per = float(ref_total_length - c_total_uncov) /ref_total_length * 100


    xa, ya  = gic_a.calc_duplication_ratio()
    xb, yb  = gic_b.calc_duplication_ratio()
    xc, yc = gic_c.calc_duplication_ratio()

    print >>fout, 'Assembler \t ', 'In Reference \t' , 'In Alignments \t Percentages '
    print >>fout, prefix1, "duplication ratio:", xa, ya, float(xa)/(ref_total_length - a_total_uncov) *100, float(ya)/(a_aligned) *100
    print >>fout, prefix2, "duplication ratio:", xb, yb, float(xb)/(ref_total_length - b_total_uncov) *100, float(yb)/(b_aligned) *100
    print >>fout, prefix3, "duplication ratio:", xc, yc, float(xc)/(ref_total_length - c_total_uncov) *100, float(yc)/(c_aligned)*100  


    print >>fout,'Uncovered regions analysis'
    print >>fout,  '=========================='
    print >>fout, 'QC \t  Total base pairs \t Percentage of Covered  \t Percentage of uncovered' 
    print >>fout, prefix1, args.treatment, ref_total_length, '\t', a_cov_per, '\t', a_uncov_per  
    print >>fout, prefix2, args.treatment, ref_total_length, '\t', b_cov_per, '\t', b_uncov_per   
    print >>fout, prefix3, args.treatment, ref_total_length, '\t', c_cov_per, '\t', c_uncov_per   

   
   


 
    #--------------------------------------------------------------------------------------------------------------------------------------------------- 
    #More analysis of Uncovered regions 
    #------------------------------------
    uncoveredoutfile = args.treatment + '.' + 'uncovered'
    uncovoutfile1 = prefix1 + '.' + args.treatment + '.count.uncovered' 
    uncovoutfile2 = prefix2 + '.' + args.treatment + '.count.uncovered'
    uncovoutfile3 = prefix3 + '.' + args.treatment + '.count.uncovered'
    
    gic_a.common_uncov(gic_b, gic_c, uncoveredoutfile)
    total_common_uncov =gic_a.count_common_uncov(gic_b, gic_c, uncoveredoutfile)
    unique_uncov_a = gic_a.count_diff_uncov(gic_b, gic_c, uncovoutfile1)
    unique_uncov_b = gic_b.count_diff_uncov(gic_a, gic_c, uncovoutfile2)
    unique_uncov_c = gic_c.count_diff_uncov(gic_b, gic_a, uncovoutfile3)
    print >>fout, "Common uncovered bases among", prefix1, prefix2, prefix3 , "using", args.treatment, "is: ",total_common_uncov
    print >>fout, "Bases that are uncovered by", prefix1, args.treatment, "only: ", unique_uncov_a, "~", float(unique_uncov_a)/ref_total_length *100, "%"
    print >>fout, "Bases that are uncovered by", prefix2, args.treatment, "only: ", unique_uncov_b, "~", float(unique_uncov_b)/ref_total_length *100, "%"
    print >>fout, "Bases that are uncovered by", prefix3, args.treatment, "only: ", unique_uncov_c, "~", float(unique_uncov_c)/ref_total_length *100, "%"

        
    #---------------------------------------------------------------------------------------------------------------------------------------------------------
    #Printing uncovered bases to a file
    #------------------------------------

    uncoveredoutfile = args.treatment + '.uncovered.bases'                 

    gic_a.write_bases(gic_b, gic_c, uncoveredoutfile, args.reference) 

    #---------------------------------------------------------------------------------------------------------------------------------------------------------
    #Analysis of unaligned contigs 
    #-----------------------------
    #Printing unaligned contigs for each assembly 
    gic_a.write_contigs(prefix1 + '.' + args.treatment + '. aligned', aseq, 0.0)
    gic_b.write_contigs(prefix2 + '.' + args.treatment + '. aligned', bseq, 0.0)
    gic_c.write_contigs(prefix3 + '.' + args.treatment + '. aligned', cseq, 0.0) 
    #printing detailed unalignments per genome 
    #for name in a_unaligned:
        #print name, a_unaligned[name]
   
    """ 

if __name__ == '__main__':
    main()
