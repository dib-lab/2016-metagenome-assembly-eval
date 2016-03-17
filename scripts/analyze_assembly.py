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
        mis = {} 
        for i in self.contigs:
	   mis[i] = 0
        self.mis = mis 
 	     
        
        bad = {}
        covered = {}
        aligned = {}
        for k in self.names:
            covered[k] = numpy.zeros(refsizes[k])
            bad[k] = numpy.zeros(refsizes[k])
            
        self.covered = covered
        for k in self.contigs:
            aligned[k] = numpy.zeros(assemblysize[k])
        self.lcontigs = assemblysize
        self.aligned = aligned
        self.bad = bad        

    def load_coords(self, filename, cutoff, min_length=100, min_ident=99.0):
        covered = self.covered
        aligned = self.aligned 
        mis_count = 0
        for s1, e1, s2, e2, ident, name1, name2 in _load_coords(filename):
            if name1 in covered and name2 in aligned:
                cov = covered[name1]
                align = aligned[name2]
                
                if e1 - s1 + 1 >= min_length and ident >= min_ident:
                    cov[s1 - 1:e1] = numpy.ones(e1 - s1 + 1)
                    align[s2 - 1:e2] = numpy.ones(e2 - s2 + 1)
                    x = int(self.lcontigs[name2])
                    y = int(e2-s2)
                    if abs(x-y) > cutoff:
                         mis_count+=1
                         self.mis[name2] =1 
                         self.bad[name1][s1-1:e1] = numpy.ones(e1 - s1 + 1) 
        mis_contigs_count = 0
        for i in self.mis: 
	      if self.mis[i] ==1: 
                     mis_contigs_count +=1 
        return mis_count, mis_contigs_count       
                               
                    
    def calc_uncov(self):
        uncov_d = {}
        for name in self.refsizes:
            length = self.refsizes[name]
            cov = sum(self.covered[name])

            uncov = length - cov
            uncov_d[name] = uncov
        return uncov_d

    def calc_unalignments(self, out1, out2): 
       ftotal = open(out1, 'w+') 
       fpartial = open(out2, 'w+') 
       unaligned = {}
       for name in self.assemsizes:
            length = self.assemsizes[name]
            align = sum(self.aligned[name])
            if align == length:
                print >>ftotal, ">"+name
	 	print >>ftotal, self.sequences[name] 
            else: 
		print >>fpartial, ">"+name 
		print >>fpartial, self.sequences[name] 		
                unalign = length - align
                unaligned[name] = unalign
       return unaligned

			
 		       
 

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

    def write_genomes(self, outfile, reference, code):

        fout = open(outfile, 'a')
        print len(reference)
        for k in self.covered:
             n =">"+k
             print >>fout , n
             for j in xrange(0, len(self.covered[k])):
                  if self.covered[k][j] == code:
                         fout.write(reference[k][j])
             fout.write('\n')


        fout.close()

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
                  if (self.covered[k][j] == 0) and (other1.covered[k][j] ==1) and (other2.covered[k][j] ==1):
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
                if (self.covered[k][j] ==0) and (other1.covered[k][j] ==1) and (other2.covered[k][j] ==1) :
                    count+=1
           print >>fout, n, count
           diff_uncov+=count
        return diff_uncov
   
    
    def count_common_mis(self, other1, other2, outfile):
        fout = open(outfile, 'w+')
        total_mis = 0 
        for k in self.bad:
           n =">"+k
           count =0
           for j in xrange(0, len(self.bad[k])):
                if (self.bad[k][j] ==1) and (other1.bad[k][j] ==1) and (other2.bad[k][j] ==1) :
                    count+=1
           print >>fout, n, count
           total_mis+=count
        return total_mis 


          
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
    parser.add_argument('cutoff') 
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
    a_mis, a_mis_contigs_count = gic_a.load_coords(args.coords1, int(args.cutoff) )
 
    gic_b = GenomeIntervalsContainer(refsizes, b, bseq)
    b_mis, b_mis_contigs_count = gic_b.load_coords(args.coords2, int(args.cutoff) )

    gic_c = GenomeIntervalsContainer(refsizes, c, cseq)
    c_mis, c_mis_contigs_count = gic_c.load_coords(args.coords3, int(args.cutoff) )
     
    ref_total_length = sum(refsizes.values()) 
    a_total_bases = sum(gic_a.assemsizes.values())
    b_total_bases = sum(gic_b.assemsizes.values())
    c_total_bases = sum(gic_c.assemsizes.values())



    #------------------------------------
    #Open output file 
    fout = open('assemblies.stats.'+args.treatment, 'w+')
    #Printing some general analysis: 
    print >>fout, "Total bases in Reference is: ", ref_total_length 
    print >>fout, "Total bases in", prefix1, str(args.treatment) , "is" , a_total_bases, "with", len(a) ,"contigs"
    print >>fout, "Total bases in", prefix2, str(args.treatment) , "is" , b_total_bases, "with", len(b) ,"contigs" 
    print >>fout, "Total bases in", prefix3, str(args.treatment) , "is" , c_total_bases, "with", len(c) ,"contigs" 
    
    #----------------------------------------------------------------------------------------------------------------------------------------------------
    #Analysis of misassemblies
    #--------------------------------
    misoutfile = args.treatment + '.misassemblies'
    total_mis = gic_a.count_common_mis(gic_b, gic_c, misoutfile)
    
    print >> fout, "Analysis of misassemblies with cutoff =", args.cutoff
    print >> fout, "------------------------------------"
    print >> fout, "Total no. of common misassemblies:", total_mis
    print >> fout, "No. of misassemblies cases in", prefix1, args.treatment, "is", a_mis
    print >> fout,  "with" , a_mis_contigs_count, "contigs with at least one msiassembly case"  
    print >> fout, "No. of misassemblies cases in", prefix2, args.treatment, "is", b_mis
    print >> fout,  "with", b_mis_contigs_count, "contigs with at least one msiassembly case"   
    print >> fout, "No. of misassemblies cases in", prefix3, args.treatment, "is", c_mis
    print >> fout, "with", c_mis_contigs_count, "contigs with at least one msiassembly case" 

    
    #-----------------------------------------------------------------------------------------------------------------------------------------------------
    #Analysis of unalignments 
    #-----------------------------
    alignoutfile1 = prefix1 + '.' + args.treatment +'.aligned'
    alignoutfile2 = prefix2 + '.' + args.treatment +'.aligned'
    alignoutfile3 = prefix3 + '.' + args.treatment +'.aligned' 
     
    print >>fout,  "Analysis of unalignments" 
    print >>fout,  "========================="
   
    a_unaligned = gic_a.calc_unalignments(alignoutfile1, alignoutfile1 + '.partial')
    a_total_unaligned = sum(a_unaligned.values())

    b_unaligned = gic_b.calc_unalignments(alignoutfile2, alignoutfile2 + '.partial')
    b_total_unaligned = sum(b_unaligned.values())
    
    c_unaligned = gic_c.calc_unalignments(alignoutfile3, alignoutfile3 + '.partial')
    c_total_unaligned = sum(c_unaligned.values()) 

    print >>fout, 'QC \t  Total Bases \t Total Unaligned \t Percentage to Assembly'
    print >>fout, prefix1, args.treatment, a_total_bases, '\t', a_total_unaligned, '\t', float(a_total_unaligned)/a_total_bases *100  
    print >>fout, prefix2, args.treatment, b_total_bases, '\t', b_total_unaligned, '\t', float(a_total_unaligned)/b_total_bases *100
    print >>fout, prefix3, args.treatment, c_total_bases, '\t', c_total_unaligned, '\t', float(a_total_unaligned)/c_total_bases *100

    #---------------------------------------------------------------------------------------------------------------------------------------------------
    #Analysis of uncovered regions
    #------------------------------ 

    a_uncov_d = gic_a.calc_uncov()
    b_uncov_d = gic_b.calc_uncov()
    c_uncov_d = gic_c.calc_uncov()
    
    a_total_uncov = sum(a_uncov_d.values())
    b_total_uncov = sum(b_uncov_d.values())
    c_total_uncov = sum(c_uncov_d.values())
  
    print >>fout,'Uncovered regions analysis'
    print >>fout,  '=========================='
    print >>fout, 'QC \t  Total base pairs \t Total uncovered \t Percentage of uncovered' 
    print >>fout, prefix1, args.treatment, ref_total_length, '\t', a_total_uncov, '\t', float(a_total_uncov)/ref_total_length*100 
    print >>fout, prefix2, args.treatment, ref_total_length, '\t', b_total_uncov, '\t', float(b_total_uncov)/ref_total_length*100  
    print >>fout, prefix3, args.treatment, ref_total_length, '\t', c_total_uncov, '\t', float(c_total_uncov)/ref_total_length*100  
    
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
    unique_uncov_c = gic_c.count_diff_uncov(gic_b, gic_c, uncovoutfile3)
    print >>fout, "Common uncovered bases among", prefix1, prefix2, prefix3 , "using", args.treatment, "is: ",total_common_uncov
    print >>fout, "Bases that are uncovered by", prefix1, args.treatment, "only: ", unique_uncov_a
    print >>fout, "Bases that are uncovered by", prefix2, args.treatment, "only: ", unique_uncov_b
    print >>fout, "Bases that are uncovered by", prefix3, args.treatment, "only: ", unique_uncov_c
    
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
    #---------------------------------------------------------------------------------------------------------------------------------------------------------
    #Printing uncovered bases to a file
    #------------------------------------

    uncoveredoutfile1 = prefix1 + '.' + args.treatment + '.uncovered.bases' 
    uncoveredoutfile2 = prefix2 + '.' + args.treatment + '.uncovered.bases' 
    uncoveredoutfile3 = prefix3 + '.' + args.treatment + '.uncovered.bases' 
    
    gic_a.write_bases(gic_b, gic_c, uncoveredoutfile1, args.reference) 
    gic_b.write_bases(gic_a, gic_c, uncoveredoutfile2, args.reference) 
    gic_c.write_bases(gic_a, gic_b, uncoveredoutfile3, args.reference) 
    
    #Printing /Covered/Uncovered regions in the reference for each assembly based on code=1.0 or 0.0
    covoutfile1 = prefix1 + '.' + args.treatment + '.cov'
    covoutfile2 = prefix2 + '.' + args.treatment + '.cov'
    covoutfile3 = prefix3 + '.' + args.treatment + '.cov'

    gic_a.write_genomes(covoutfile1, args.reference,1.0)
    gic_b.write_genomes(covoutfile2, args.reference,1.0)
    gic_c.write_genomes(covoutfile3, args.reference,1.0)
    

    """ 
    

if __name__ == '__main__':
    main()
