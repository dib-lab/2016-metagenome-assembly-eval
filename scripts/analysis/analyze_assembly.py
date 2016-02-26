import numpy
import screed
import sys

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
	d[record.name.split()[0]] = len(record.sequence)
        s[record.name.split()[0]] = record.sequence
    return d, s 
  
class GenomeIntervalsContainer(object):
    def __init__(self, refsizes, assembly):
        self.names = refsizes.keys()
        self.refsizes = refsizes
        self.contigs = assembly.keys()
        self.assemsizes =assembly
        covered = {}
        aligned = {}
        for k in self.names:
            covered[k] = numpy.zeros(refsizes[k])
        self.covered = covered
        for k in self.contigs: 
            aligned[k] = numpy.zeros(assembly[k])
        self.aligned = aligned

    def load_coords(self, filename, min_length=100, min_ident=99.0):
        covered = self.covered
        aligned = self.aligned 
        for s1, e1, s2, e2, ident, name1, name2 in _load_coords(filename):
            if name1 in covered and name2 in aligned:
                cov = covered[name1]
                align = aligned[name2]
                if e1 - s1 + 1 >= min_length and ident >= min_ident:
                    cov[s1 - 1:e1] = numpy.ones(e1 - s1 + 1)
                    align[s2 - 1:e2] = numpy.ones(e2 - s2 + 1)

    def calc_uncov(self):
        uncov_d = {}
        for name in self.refsizes:
            length = self.refsizes[name]
            cov = sum(self.covered[name])

            uncov = length - cov
            uncov_d[name] = uncov
        return uncov_d

    def calc_unalignments(self): 
       unaligned = {}
       for name in self.assemsizes:
            length = self.assemsizes[name]
            align = sum(self.aligned[name])
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
	fout = open(outfile, 'a+') 
	for k in self.aligned:
            if sum(self.aligned[k]) >= 1.0: 
		 print >>fout, ">"+k
                 for j in xrange(0, len(self.aligned[k])):
                     if self.aligned[k][j] == code:
                        fout.write(assembly[k][j]) 
	         fout.write('\n')
       
    def write_coords(self, outfile, reference, code): 
        fout = open(outfile, 'a+')
        for k in self.covered:
             n =">"+k
             print >>fout , n
             for j in xrange(0, len(self.covered[k])):
                  if self.covered[k][j] ==code:
                         fout.write(str(j))
                         fout.write(',')
             fout.write('\n')


        fout.close()
    
    def common_uncov(self,sqc, mqc, outfile): 
	fout = open(outfile, 'a+') 
        for k in self.covered: 
	   n =">"+k
           print >>fout , n 
           for j in xrange(0, len(self.covered[k])):
 		if self.covered[k][j] == sqc.covered[k][j] ==mqc.covered[k][j] ==0 :
                       fout.write(str (j) )
                       fout.write(',') 
           fout.write('\n')
            
    def count_common_uncov(self, other1, other2, outfile):
        fout = open(outfile, 'a+')
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
	fout =open(outfile, 'a+')  
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
   
              


	
def main():
    print 'loading refsizes'
    refsizes, reference = load_reference('mircea.fa')

    print 'Loading Coords'
 
    iqc, iqseq = load_assembly('idba-quality-assembly.fa')
    sqc, sqseq = load_assembly('spades-quality-assembly.fa') 
    mqc, mqseq= load_assembly('megahit-quality-assembly.fa') 
    
    #------------------------------------------------------------------------------------------------------------------------------
    #Building Containers 
    #---------------------
 
    gic_iqc = GenomeIntervalsContainer(refsizes, iqc)
    gic_iqc.load_coords('iqc.coords')
 
    gic_sqc = GenomeIntervalsContainer(refsizes, sqc)
    gic_sqc.load_coords('sqc.coords') 

    gic_mqc = GenomeIntervalsContainer(refsizes, mqc)
    gic_mqc.load_coords('mqc.coords')
     
    #------------------------------------
    #Open output file 
    fout = open('assemblies.stats', 'a+')
    #-------------------------------------
 
    """
    #-----------------------------------------------------------------------------------------------------------------------------------------------------
    #Analysis of unalignments 
    #-----------------------------
    print >>fout,  "Analysis of unalignments" 
    print >>fout,  "========================="
    iqc_unaligned = gic_iqc.calc_unalignments()
    iqc_total_aligned = sum(gic_iqc.assemsizes.values())
    iqc_total_unaligned = sum(iqc_unaligned.values())

    sqc_unaligned = gic_sqc.calc_unalignments()
    sqc_total_aligned = sum(gic_sqc.assemsizes.values())
    sqc_total_unaligned = sum(sqc_unaligned.values())

    
    mqc_unaligned = gic_mqc.calc_unalignments()
    mqc_total_aligned = sum(gic_mqc.assemsizes.values())
    mqc_total_unaligned = sum(mqc_unaligned.values()) 
    print >>fout, 'QC \t  total aligned \t total unaligned'
    print >>fout, 'IDBA \t', iqc_total_aligned, '\t', iqc_total_unaligned
    print >>fout, 'SPAdes \t', sqc_total_aligned, '\t', sqc_total_unaligned
    print >>fout, 'MEGAHIT \t', mqc_total_aligned, '\t', mqc_total_unaligned
    
    """ 
    #---------------------------------------------------------------------------------------------------------------------------------------------------
    #Analysis of uncovered regions
    #------------------------------ 

    iqc_uncov_d = gic_iqc.calc_uncov()
    sqc_uncov_d = gic_sqc.calc_uncov()
    mqc_uncov_d = gic_mqc.calc_uncov()
    iqc_total_bp = sum(gic_iqc.refsizes.values())
    iqc_total_uncov = sum(iqc_uncov_d.values())
 
    sqc_total_bp = sum(gic_sqc.refsizes.values())
    sqc_total_uncov = sum(sqc_uncov_d.values())

    mqc_total_bp = sum(gic_mqc.refsizes.values())
    mqc_total_uncov = sum(mqc_uncov_d.values())
  
    print >>fout,'Uncovered regions analysis'
    print >>fout,  '=========================='
    print >>fout, 'QC \t  Total base pairs \t Total uncovered \t Percentage of uncovered' 
    print >>fout, ' IDBA \t', iqc_total_bp,'\t', iqc_total_uncov, '\t', float(iqc_total_uncov) / iqc_total_bp 
    print >>fout, ' SPAdes \t ', sqc_total_bp, '\t',  sqc_total_uncov, '\t', float(sqc_total_uncov)/ sqc_total_bp 
    print >>fout, ' MEGAHIT \t', mqc_total_bp, '\t', mqc_total_uncov, '\t',float(mqc_total_uncov)/mqc_total_bp 
   

    #Printing /Covered/Uncovered regions in the reference for each assembly based on code=1.0 or 0.0 
    #gic_iqc.write_genomes('iqc.cov',reference,1.0)
    #gic_sqc.write_genomes('sqc.cov',reference,1.0)
    #gic_mqc.write_genomes('mqc.cov',reference,1.0) 
    
    #--------------------------------------------------------------------------------------------------------------------------------------------------- 
    #More analysis of Uncovered regions 
    #------------------------------------
    gic_iqc.common_uncov(gic_sqc, gic_mqc, 'uncovered.qc')
    total_common_uncov =gic_iqc.count_common_uncov(gic_sqc, gic_mqc, 'uncovered.count.qc')
    unique_uncov_iq = gic_iqc.count_diff_uncov(gic_sqc, gic_mqc, 'uncovered.count.iqc')
    unique_uncov_sq = gic_sqc.count_diff_uncov(gic_iqc, gic_mqc, 'uncovered.count.sqc')
    unique_uncov_mq = gic_mqc.count_diff_uncov(gic_sqc, gic_iqc, 'uncovered.count.mqc')
    print >>fout, "Common uncovered bases among IDBA, SPAdes, and Megahit using QC is: ",total_common_uncov
    print >>fout, "Bases that are uncovered by IDBA QC only: ", unique_uncov_iq
    print >>fout, "Bases that are uncovered by SPAdes QC only: ", unique_uncov_sq
    print >>fout, "Bases that are uncovered by Megahit QC only: ", unique_uncov_mq  
    
    """

    #---------------------------------------------------------------------------------------------------------------------------------------------------------
    #Analysis of unaligned contigs 
    #-----------------------------
    #Printing unaligned contigs for each assembly 
    gic_iqc.write_contigs('iqc.unaligned', iqseq, 0.0)
    gic_sqc.write_contigs('sqc.unaligned', sqseq, 0.0)
    gic_mqc.write_contigs('mqc.unaligned', mqseq, 0.0) 
    #printing detailed unalignments per genome 
    #for name in iqc_unaligned:
        #print name, iqc_unaligned[name]
    #for name in sqc_unaligned:
        #print name, sqc_unaligned[name]
    #for name in mqc_unaligned:
        #print name, mqc_unaligned[name]    

    #Printing coordinates of Covered/Uncovered regions based on code =1.0 or 0.0  
    #gic_iqc.write_coords('iqc.uncov', reference, 0.0)
    #gic_sqc.write_coords('sqc.uncov', reference, 0.0)
    #gic_mqc.write_coords('mqc.uncov', reference, 0.0)
    """ 
  
 


if __name__ == '__main__':
    main()
