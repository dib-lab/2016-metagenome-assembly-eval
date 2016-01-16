
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
    """ 

    iqc_uncov_d = gic_iqc.calc_uncov()
    #for name in iqc_uncov_d:
        #print name, iqc_uncov_d[name]
    iqc_total_bp = sum(gic_iqc.refsizes.values())
    iqc_total_uncov = sum(iqc_uncov_d.values())
    print "For IDBA QC:", iqc_total_bp, iqc_total_uncov, float(iqc_total_uncov) / iqc_total_bp 

    mqc_uncov_d = gic_mqc.calc_uncov()
    mqc_total_bp = sum(gic_mqc.refsizes.values())

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


    im_qc_union_cov = iqc_total_bp - sum(union_im_qc.calc_uncov().values())
    im_qc_intersect_cov = iqc_total_bp - sum(intersect_im_qc.calc_uncov().values()) 
    print 'intersect and union cov for iqc and mqc:', im_qc_intersect_cov, im_qc_union_cov
    print "Jaccard Similarity between IDBA QC and MEGAHIT QC: ", float(im_qc_intersect_cov)/float(im_qc_union_cov)

    is_qc_union_cov = iqc_total_bp - sum(union_is_qc.calc_uncov().values())
    is_qc_intersect_cov = iqc_total_bp - sum(intersect_is_qc.calc_uncov().values()) 
    print 'intersect and union cov for iqc and sqc', is_qc_intersect_cov, is_qc_union_cov
    print "Jaccard Similarity between IDBA QC and SPAdes QC: ", float(is_qc_intersect_cov)/float(is_qc_union_cov)

    
    
if __name__ == '__main__':
    main()
