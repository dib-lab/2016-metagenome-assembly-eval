
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

def load_refsizes(filename):
    d = {}
    for record in screed.open(filename):
        d[record.name.split()[0]] = len(record.sequence)
    return d

def load_sequence(filename): 
    d = {}
    for record in screed.open(filename): 
	d[record.name.split()[0]] = record.sequence
    return d

def compare(infile1, infile2, outfile): 
           
           fout =open(outfile, 'a')
           refsizes = load_refsizes('mircea.fa')
           gic1 = GenomeIntervalsContainer(refsizes)
           gic1.load_coords(infile1)

           gic2 = GenomeIntervalsContainer(refsizes)
           gic2.load_coords(infile2)

           gic1_uncov_d = gic1.calc_uncov()
           gic1_total_bp = sum(gic1.refsizes.values())
           gic1_total_uncov = sum(gic1_uncov_d.values())
           print >>fout, infile1, gic1_total_bp,  float(gic1_total_uncov) / gic1_total_bp


           gic2_uncov_d = gic2.calc_uncov()
           gic2_total_bp = sum(gic2.refsizes.values())
           gic2_total_uncov = sum(gic2_uncov_d.values())
           print >>fout, infile2, gic2_total_bp,  float(gic2_total_uncov) / gic2_total_bp

           intersect_gic12 = gic1.intersect(gic2)
           print >>fout, 'intersect', gic1_total_bp, gic2_total_bp, sum(intersect_gic12.calc_uncov().values())

           union_gic12 = gic1.union(gic2)
           print >>fout, 'union', gic1_total_bp, gic2_total_bp, sum(union_gic12.calc_uncov().values())
 
           jaccard_sim12= float(sum(intersect_gic12.calc_uncov().values())) / float (sum(union_gic12.calc_uncov().values()))

           print >>fout, 'Jaccard Similarity between', infile1, 'and',infile2, 'is:', jaccard_sim12

	   fout.close()	   

class GenomeIntervalsContainer(object):
    def __init__(self, refsizes):
        self.names = refsizes.keys()
        self.refsizes = refsizes
        trees = {}
        for k in self.names:
            trees[k] = numpy.zeros(refsizes[k])
        self.trees = trees

    def load_coords(self, filename, min_length=100, min_ident=99.0):
        trees = self.trees
        for s1, e1, s2, e2, ident, name1, name2 in _load_coords(filename):
            if name1 in trees:
                tree = trees[name1]
                if e1 - s1 + 1 >= min_length and ident >= min_ident:
                    tree[s1 - 1:e1] = numpy.ones(e1 - s1 + 1)

    def calc_uncov(self):
        uncov_d = {}
        for name in self.refsizes:
            length = self.refsizes[name]
            cov = sum(self.trees[name])

            uncov = length - cov
            uncov_d[name] = uncov
        return uncov_d

    def subtract(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        otrees = other.trees
        
        for name in self.refsizes:
            ttree = self.trees[name]
            otree = otrees[name]
            newtree = ttree - numpy.logical_and(ttree, otree)
            new_gic.trees[name] = newtree

        return new_gic

    def union(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        otrees = other.trees
        
        for name in self.refsizes:
            ttree = self.trees[name]
            otree = otrees[name]
            newtree = numpy.logical_or(ttree, otree)
            new_gic.trees[name] = newtree

        return new_gic
    
    def intersect(self, other):
        assert self.refsizes.keys() == other.refsizes.keys()
        new_gic = GenomeIntervalsContainer(self.refsizes)
        otrees = other.trees
        
        for name in self.refsizes:
            ttree = self.trees[name]
            otree = otrees[name]
            newtree = numpy.logical_and(ttree, otree)
            new_gic.trees[name] = newtree

        return new_gic

    def write_genomes(self, outfile, reference, code):

        fout = open(outfile, 'a')
        print len(reference)
        for k in self.trees:
             n =">"+k
             print >>fout , n
             for j in xrange(0, len(self.trees[k])):
                  if self.trees[k][j] ==code:
                         fout.write(reference[k][j])
             fout.write('\n')


        fout.close()

    def window_slide(self, other, win,  cutoff,n):
	total_regions1 ={}
 	total_regions2 ={}
	for i in xrange(0,n):
		total_regions1[i]=0
		total_regions2[i]=0
	window=win
        i =0
        sum1 =0
        sum2 =0 
        index1 =0 
        index2 =0
     	for k in self.trees:
	   while i < len(self.trees[k]):
		for j in xrange(i,window):
 			if self.trees[k][j] ==1.0:
				sum1+=1 
                        if other.trees[k][j] ==1.0:
                                sum2+=1
		i+=window
                window +=win
		if sum1 >= cutoff: 
			total_regions1[index1]=1.0
                        index1+=1
			sum1 =0
                if sum2 >=cutoff: 
			total_regions2[index2]=1.0
			index2+=1 
			sum2 =0
        commons =0
	diff =0
	for i in xrange (0,len(total_regions1)):
		print total_regions1[i], total_regions2[i]
		if total_regions1[i]+total_regions2[i] ==2: 
			commons+=1
		elif total_regions1[i]+total_regions2[i] ==1:  
			 diff+=1

	return commons, diff
		
def main():
    print 'loading refsizes'
    refsizes = load_refsizes('mircea.fa')

    refsizes2 = {}
    refsizes2['Thermoanaerobacter_pseudethanolicus_ATCC_33223'] = \
       refsizes['Thermoanaerobacter_pseudethanolicus_ATCC_33223']
    #refsizes = refsizes2
    
    print 'loading coords'
    
    reference =load_sequence('mircea.fa')

    gic_iqc = GenomeIntervalsContainer(refsizes)
    gic_iqc.load_coords('iqc.coords')
	
    gic_mqc = GenomeIntervalsContainer(refsizes)
    gic_mqc.load_coords('mqc.coords')

    gic_sqc = GenomeIntervalsContainer(refsizes)
    gic_sqc.load_coords('sqc.coords')
  
    """ 
    gic_iqc.write_genomes('iqc.cov',reference,1.0)
    gic_iqc.write_genomes('iqc.uncov',reference,0.0)

    gic_mqc.write_genomes('mqc.cov', reference,1.0) 
    gic_mqc.write_genomes('mqc.uncov', reference,0.0)
	
    gic_sqc.write_genomes('sqc.cov', reference,1.0) 
    gic_sqc.write_genomes('sqc.uncov', reference,0.0)

     

    iqc_uncov_d = gic_iqc.calc_uncov()
    for name in iqc_uncov_d:
        print name, iqc_uncov_d[name]
    iqc_total_bp = sum(gic_iqc.refsizes.values())
    iqc_total_uncov = sum(iqc_uncov_d.values())
    print "For IDBA QC:", iqc_total_bp, iqc_total_uncov, float(iqc_total_uncov) / iqc_total_bp 

    sqc_uncov_d = gic_sqc.calc_uncov()
    sqc_total_bp = sum(gic_sqc.refsizes.values())
    
    sub_im_qc = gic_iqc.subtract(gic_mqc)
    print 'subtract', iqc_total_bp,mqc_total_bp, sum(sub_im_qc.calc_uncov().values())
    
    union_im_qc = gic_iqc.union(gic_mqc)
    print 'union', iqc_total_bp,mqc_total_bp, sum(union_im_qc.calc_uncov().values())
    
    intersect_im_qc = gic_iqc.intersect(gic_mqc)
    print 'intersect', iqc_total_bp,mqc_total_bp, sum(intersect_im_qc.calc_uncov().values())

    union_is_qc = gic_iqc.union(gic_sqc)
    print 'union', iqc_total_bp,sqc_total_bp, sum(union_is_qc.calc_uncov().values())

    intersect_is_qc = gic_iqc.intersect(gic_sqc)
    print 'intersect', iqc_total_bp,sqc_total_bp, sum(intersect_is_qc.calc_uncov().values())

    """ 

    #compare('mqc.coords', 'mdigi.coords', 'megahit-qc-digi')
    #compare('mqc.coords', 'mpart.coords', 'megahit-digi-part') 
    
    commons,diff= gic_iqc.window_slide(gic_mqc, 100, 90,len(reference) ) 
    print "Jaccard Similarity =",commons, diff,  float(diff+0.01)/float(commons+0.01)

   
if __name__ == '__main__':
    main()
